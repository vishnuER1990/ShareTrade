import { Component, OnInit,  ViewChild, TemplateRef } from '@angular/core';
import { Subscription } from 'rxjs';
import { Router } from '@angular/router';
import { ModalOptions, BsModalRef, BsModalService } from 'ngx-bootstrap/modal';
import { NgxSpinnerService } from "ngx-spinner";

import { UserVM } from '../Models/UserVM';
import { CredentialService  } from '../services/credential.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {
  
  @ViewChild('ErrorTemplate') errorTemplate : any;

  userName: string;
  userNamePopup: string;
  password: string;
  errorTemplateMsg: string;

  userDetails: UserVM
  userSubscription: Subscription;

  modalOption: ModalOptions = {};
  modalRef: BsModalRef;
  modalRefPassword: BsModalRef;

  constructor(private router: Router, private restServiceUser: CredentialService, private modalService: BsModalService , private spinner: NgxSpinnerService) { }

  ngOnInit(): void {
    this.spinner.hide();
  }

  login(userDetail, token){
    debugger;
    

    this.userSubscription = this.restServiceUser.ValidateUser(userDetail, token).subscribe(
      data =>
      {      
        if(data == 'Error')
        {
          this.openLoginErrorModal('Login unsuccessful. Please try again',this.errorTemplate);           
          sessionStorage.clear();
          localStorage.clear();
          this.spinner.hide();
        }
        else{
          if(data.body !== null){
              if(!data.body.IsAdminApproved) {
                this.openLoginErrorModal('Admin approval is pending. Please try again',this.errorTemplate); 
                sessionStorage.clear();
                localStorage.clear();

              } else{
                sessionStorage.setItem("Role",data.body.IsAdmin?'Admin':'NormalUser');
                sessionStorage.setItem("IsValidUser","true");
                sessionStorage.setItem("UserFullName",data.body.Full_Name);
                sessionStorage.setItem("UserId",data.body.UserId);
                sessionStorage.setItem("ShareCount",data.body.ShareCount);
                this.router.navigate(['dashboard']);
              }
          }
          else{
            this.openLoginErrorModal('An exception occured. Please contact Admin',this.errorTemplate);
          }        
          this.spinner.hide();

        }
      }
    );
  }

  checkCredentials(){
    sessionStorage.clear();
    localStorage.clear();
    this.spinner.show();
    debugger;
    this.userDetails = new UserVM();
    this.userDetails.Password = this.password;
    this.userDetails.UserName = this.userName;
    this.userSubscription = this.restServiceUser.GetToken(this.userDetails).subscribe(
      data =>
      {      
        if(data.error == 'error')
        {
          this.openLoginErrorModal(data.error_description,this.errorTemplate);  
          this.spinner.hide();
        }
        else
        {
          if(data.body.access_token !== null){          
              sessionStorage.setItem("access_token",data.body.access_token);
              this.login(this.userDetails, 'Bearer '+ data.body.access_token);
          }
          else{
            
            sessionStorage.clear();
            localStorage.clear();
            this.openLoginErrorModal('Username or Password entered is incorrect.',this.errorTemplate);
          }       

        } 
      }
    );
  }

  forgotPassword(template){
    debugger;
    this.spinner.show();

    if(this.userNamePopup =='' || this.userNamePopup == undefined)
    {
      this.openLoginErrorModal('Please enter a valid user name ',this.errorTemplate);
      this.spinner.hide();
    }
    else{
      this.userDetails = new UserVM();
      this.userDetails.UserName = this.userNamePopup;
      this.userSubscription = this.restServiceUser.forgotPassword(this.userDetails).subscribe(
        data =>
        {      
          if(data.body.status){
            this.openLoginErrorModal(data.body.exception =='' ?'Email has been sent to your registered email address.': data.body.exception,this.errorTemplate);
          }
          else{
            this.openLoginErrorModal(data.body.exception =='' ?'An exception occured. Please contact Admin': data.body.exception,this.errorTemplate);
          }
          
          this.spinner.hide();
        }
      );

    }
  }


  signup(){
    this.router.navigate(['SignUp']);
  }

  openLoginErrorModal(message,template: TemplateRef<any>){
    this.errorTemplateMsg = message;
    this.modalOption.keyboard = true;
    this.modalRef = this.modalService.show(template, this.modalOption);
  }
  
  openForgotPasswordModal(template){
    this.userNamePopup ='';
    this.modalOption.keyboard = true;
    this.modalOption.backdrop = 'static';
    this.modalRefPassword = this.modalService.show(template, this.modalOption);
  }
  closeForgotModal(){
    if (this.modalRefPassword !== undefined && this.modalRefPassword !== null) {
      this.modalRefPassword.hide();
    }
  }

}
