import { Component, OnInit, Input, ViewChild, TemplateRef } from '@angular/core';
import { Subscription } from 'rxjs';
import { Observable,  } from 'rxjs';
import { map, startWith } from 'rxjs/operators';
import {FormControl, FormGroup, Validators} from '@angular/forms';
import { ModalOptions, BsModalRef, BsModalService } from 'ngx-bootstrap/modal';
import { MatPaginator } from '@angular/material/paginator';
import { MatTableDataSource } from '@angular/material/table';
import { MatCheckbox } from '@angular/material/checkbox';
import { NgxSpinnerService } from "ngx-spinner";

import { UserVM } from '../Models/UserVM';
import { UserService } from '../services/user.service';


@Component({
  selector: 'app-user-profile',
  templateUrl: './user-profile.component.html',
  styleUrls: ['./user-profile.component.css']
})
export class UserProfileComponent implements OnInit {

  @ViewChild('Successtemplate') successtemplate : any; 
  // @ViewChild(MatPaginator, {static: true}) paginator: MatPaginator;  
  @ViewChild(MatPaginator) paginator: MatPaginator; 

  firstName: string;
  lastName: string;
  email: string;
  contactNumber: string;
  QID: string;
  shareHolderNumber: string;
  userName: string;
  password: string;
  successTemplateMessage: string;
  isAdmin: boolean;
  userId: number;

  userDetails: UserVM;  
  userList: UserVM[];
  displayedColumns: string[] = [];

  userSubscription: Subscription;
  formGroup: FormGroup;
  modalOption: ModalOptions = {};
  modalRef: BsModalRef;
  dataSource: MatTableDataSource < UserVM >;  

  constructor(private restServiceUser: UserService, 
    private modalService: BsModalService, private spinner: NgxSpinnerService) {
      this.formGroup = new FormGroup({
        firstNameFormControl: new FormControl('', [ Validators.required]),
        lastNameFormControl: new FormControl('', [ Validators.required]),
        emailFormControl: new FormControl('', [Validators.required]),
        contactNumberFormControl: new FormControl('', [ Validators.required, Validators.minLength(8), Validators.maxLength(8)]),        
        QIDFormControl: new FormControl('', [ Validators.required, Validators.minLength(11), Validators.maxLength(11)]),
        shareHolderNumberFormControl: new FormControl(),
        userNameFormControl: new FormControl('', [ Validators.required]),
        passwordFormControl: new FormControl('', [ Validators.required])
     });
     }

  ngOnInit() {
    this.spinner.show();
    this.isAdmin = sessionStorage.getItem('Role') == 'Admin';
    this.userId = Number(sessionStorage.getItem('UserId'));
    this.getUserData(this.userId);
  }

  getUserData(userId: number){
    debugger;
    
    this.userDetails = new UserVM();
    this.userDetails.UserId = userId;
    this.userSubscription = this.restServiceUser.GetUser(this.userDetails).subscribe(
      data =>
      {      
          this.firstName =  data[0].First_Name;    
          this.lastName =  data[0].Last_Name;        
          this.email =  data[0].Email_Address;    
          this.contactNumber =  data[0].Contact_Number;    
          this.QID =  data[0].QID_Number;        
          this.shareHolderNumber =  data[0].Shareholder_ID;      
          this.userName =  data[0].UserName;     
          this.password =  data[0].Password;      
          this.spinner.hide();
          if(sessionStorage.getItem("Role") =='Admin'){
             this.getUserDataForGrid(0)
          }
      }
    );
  } 
  getUserDataForGrid(userId: number){
    debugger;    
    this.userDetails = new UserVM();
    this.userDetails.UserId = 0;
    this.userSubscription = this.restServiceUser.GetUser(this.userDetails).subscribe(
      data =>
      {      
        this.userList = data;

        this.userList.forEach((element) => {
          element.CreatedDt =new Date(element.CreatedDt)
          element.UpdatedDt =new Date(element.UpdatedDt)
        });

        this.initialize();
      }
    );
  }

  update(){
    if(!this.formGroup.invalid)
    {
      debugger;
      this.spinner.show();
      this.userDetails = new UserVM();    
      this.userDetails.UserId = this.userId;
      this.userDetails.First_Name = this.firstName;
      this.userDetails.Last_Name =  this.lastName;
      this.userDetails.Email_Address = this.email;
      this.userDetails.Contact_Number = this.contactNumber;
      this.userDetails.QID_Number = this.QID;        
      this.userDetails.Shareholder_ID = this.shareHolderNumber;      
      this.userDetails.UserName = this.userName;     
      this.userDetails.Password = this.password;    
      this.userDetails.UpdatedBy = Number(sessionStorage.getItem('UserId')); 
      this.userDetails.IsActive = true; 
      this.userDetails.IsAdmin = sessionStorage.getItem("Role") == 'Admin'; 
      this.userDetails.IsAdminApproved = true;
      
      this.userSubscription = this.restServiceUser.UpdateUser(this.userDetails).subscribe(
        data =>
        {     
          if(!data.body.status) 
          {            
            this.spinner.hide();
            this.openSuccessModal(data.body.exception, this.successtemplate);
            
          }
          else
          {     
            this.getUserData(this.userId);
            this.openSuccessModal('Update successful.',this.successtemplate);
          }
        }
      );
    }
    else if(this.formGroup.invalid){
      this.formGroup.markAllAsTouched();
    }
  }

  initialize(){
    this.displayedColumns = ['Full_Name','Email_Address','Contact_Number', 'QID_Number', 'Shareholder_ID', 'IsActive', 'IsAdmin','IsAdminApproved', 'Actions'];
    this.dataSource = new MatTableDataSource(this.userList);
    this.dataSource.paginator = this.paginator;
    this.spinner.hide();
  }

  OnChangeIsActive(element, event, template){
   debugger;
   this.spinner.show();
    this.userDetails = new UserVM();
    this.userDetails.UserId = element.UserId;
    this.userDetails.IsActive = event.checked;
    this.userDetails.IsAdmin = element.IsAdmin;
    this.userDetails.First_Name = element.First_Name;
    this.userDetails.Last_Name =  element.Last_Name;
    this.userDetails.Email_Address = element.Email_Address;
    this.userDetails.Contact_Number = element.Contact_Number;
    this.userDetails.QID_Number = element.QID_Number;        
    this.userDetails.Shareholder_ID = element.Shareholder_ID;      
    this.userDetails.UserName = element.UserName;     
    this.userDetails.Password = element.Password;     
    this.userDetails.UpdatedBy = this.userId;   
    this.userSubscription = this.restServiceUser.UpdateUser(this.userDetails).subscribe(
      data =>
      {      
        if(!data.body.status) 
          {            
            this.spinner.hide();
            this.openSuccessModal(data.body.exception, this.successtemplate);
            
          }
          else
          {     
              this.getUserDataForGrid(0);

              if(event.checked){
                this.successTemplateMessage = 'The user '+ element.Full_Name +' has been enabled';
              } else{
                this.successTemplateMessage = 'The user '+ element.Full_Name +' has been disabled';
              }
              this.modalOption.backdrop = 'static';
              this.modalOption.keyboard = false;    
              this.modalRef = this.modalService.show(template, this.modalOption);
          }
      }
    );
  }

  OnChangeIsAdmin(element, event, template){
    debugger;
    this.spinner.show();
     this.userDetails = new UserVM();
     this.userDetails.UserId = element.UserId;
     this.userDetails.IsActive = element.IsActive;
     this.userDetails.IsAdmin = event.checked;
     this.userDetails.First_Name = element.First_Name;
     this.userDetails.Last_Name =  element.Last_Name;
     this.userDetails.Email_Address = element.Email_Address;
     this.userDetails.Contact_Number = element.Contact_Number;
     this.userDetails.QID_Number = element.QID_Number;        
     this.userDetails.Shareholder_ID = element.Shareholder_ID;      
     this.userDetails.UserName = element.UserName;     
     this.userDetails.Password = element.Password;     
     this.userDetails.UpdatedBy = this.userId;   
     this.userSubscription = this.restServiceUser.UpdateUser(this.userDetails).subscribe(
       data =>
       {          
        if(!data.body.status) 
        {            
          this.spinner.hide();
          this.openSuccessModal(data.body.exception, this.successtemplate);
          
        }
        else
        { 

            if(event.checked){
              this.successTemplateMessage = 'The user '+ element.Full_Name +' has been granted admin role';
            } else{
              this.successTemplateMessage = 'The user '+ element.Full_Name +' has been removed from admin role';
            }
            this.modalOption.backdrop = 'static';
            this.modalOption.keyboard = false;    
            this.modalRef = this.modalService.show(template, this.modalOption);
          }
          this.getUserDataForGrid(0);
       }
     );
 
   }

   OnChangeApproveUser(element, event, template){
    debugger;
    this.spinner.show();
     this.userDetails = new UserVM();
     this.userDetails.UserId = element.UserId;
     this.userDetails.IsActive = element.IsActive;
     this.userDetails.IsAdmin = event.checked;
     this.userDetails.First_Name = element.First_Name;
     this.userDetails.Last_Name =  element.Last_Name;
     this.userDetails.Email_Address = element.Email_Address;
     this.userDetails.Contact_Number = element.Contact_Number;
     this.userDetails.QID_Number = element.QID_Number;        
     this.userDetails.Shareholder_ID = element.Shareholder_ID;      
     this.userDetails.UserName = element.UserName;     
     this.userDetails.Password = element.Password;     
     this.userDetails.UpdatedBy = this.userId;    
     this.userDetails.IsAdminApproved = event.checked;
     this.userSubscription = this.restServiceUser.UpdateUser(this.userDetails).subscribe(
       data =>
       {       
        if(!data.body.status) 
        {            
          this.spinner.hide();
          this.openSuccessModal(data.body.exception, this.successtemplate);
          
        }
        else
        { 
            if(event.checked){
              this.successTemplateMessage = 'The user '+ element.Full_Name +' has been enabled';
            } else{
              this.successTemplateMessage = 'The user '+ element.Full_Name +' has been disabled';
            }
            this.modalOption.backdrop = 'static';
            this.modalOption.keyboard = false;    
            this.modalRef = this.modalService.show(template, this.modalOption);
          }          
          this.getUserDataForGrid(0);
       }
     );
 
   }

   ApproveUser(element, event, template){
    debugger;
    this.spinner.show();
     this.userDetails = new UserVM();
     this.userDetails.UserId = element.UserId;
     this.userDetails.IsActive = element.IsActive;
     this.userDetails.IsAdmin = element.IsAdmin;
     this.userDetails.First_Name = element.First_Name;
     this.userDetails.Last_Name =  element.Last_Name;
     this.userDetails.Email_Address = element.Email_Address;
     this.userDetails.Contact_Number = element.Contact_Number;
     this.userDetails.QID_Number = element.QID_Number;        
     this.userDetails.Shareholder_ID = element.Shareholder_ID;      
     this.userDetails.UserName = element.UserName;     
     this.userDetails.Password = element.Password;     
     this.userDetails.IsAdminApproved = true;
     this.userDetails.UpdatedBy = this.userId;   
     this.userSubscription = this.restServiceUser.UpdateUser(this.userDetails).subscribe(
       data =>
       {           
        if(!data.body.status) 
        {            
          this.spinner.hide();
          this.openSuccessModal(data.body.exception, this.successtemplate);
          
        }
        else
        {
         this.getUserDataForGrid(0);
         this.successTemplateMessage = 'The user '+ element.Full_Name +' has been approved';

           this.modalOption.backdrop = 'static';
           this.modalOption.keyboard = false;    
           this.modalRef = this.modalService.show(template, this.modalOption);
        }
       }
     );
 
   }

   RejectUser(element, event, template){
    debugger;
    this.spinner.show();
     this.userDetails = new UserVM();
     this.userDetails.UserId = element.UserId;
     this.userDetails.IsActive = element.IsActive;
     this.userDetails.IsAdmin = element.IsAdmin;
     this.userDetails.First_Name = element.First_Name;
     this.userDetails.Last_Name =  element.Last_Name;
     this.userDetails.Email_Address = element.Email_Address;
     this.userDetails.Contact_Number = element.Contact_Number;
     this.userDetails.QID_Number = element.QID_Number;        
     this.userDetails.Shareholder_ID = element.Shareholder_ID;      
     this.userDetails.UserName = element.UserName;     
     this.userDetails.Password = element.Password;     
     this.userDetails.IsAdminApproved = false;
     this.userDetails.UpdatedBy = this.userId;   
     this.userSubscription = this.restServiceUser.UpdateUser(this.userDetails).subscribe(
       data =>
       {
        if(!data.body.status) 
        {            
          this.spinner.hide();
          this.openSuccessModal(data.body.exception, this.successtemplate);
          
        }
        else
        {
           this.getUserDataForGrid(0);         
           this.successTemplateMessage = 'The user '+ element.Full_Name +' has been rejected';
           this.modalOption.backdrop = 'static';
           this.modalOption.keyboard = false;    
           this.modalRef = this.modalService.show(template, this.modalOption);
        }
       }
     );
 
   }

  openSuccessModal(message,template: TemplateRef<any>){
    this.successTemplateMessage = message;
    this.modalOption.backdrop = 'static';
    this.modalOption.keyboard = false;    
    this.modalRef = this.modalService.show(template, this.modalOption);
  }

  keyPress(event: any) {
    const pattern = /[0-9\+\-\ ]/;

    const inputChar = String.fromCharCode(event.charCode);
    if (event.key != 8 && !pattern.test(inputChar)) {
      event.preventDefault();
    }
  }


}
