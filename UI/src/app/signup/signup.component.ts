import {
  Component,
  OnInit,
  Input,
  ViewChild,
  TemplateRef
} from '@angular/core';
import {
  Router
} from '@angular/router';
import {
  Observable,
  Subscription
} from 'rxjs';
import {
  map,
  startWith
} from 'rxjs/operators';
import {
  FormControl,
  FormGroup,
  Validators,
  AbstractControl,
  ValidatorFn
} from '@angular/forms';
import {
  ModalOptions,
  BsModalRef,
  BsModalService
} from 'ngx-bootstrap/modal';
import {
  NgxSpinnerService
} from "ngx-spinner";

import {
  UserVM
} from '../Models/UserVM';
import {
  UserService
} from '../services/user.service';

@Component({
  selector: 'app-signup',
  templateUrl: './signup.component.html',
  styleUrls: ['./signup.component.css']
})
export class SignupComponent implements OnInit {

  @ViewChild('Successtemplate') successtemplate: any;
  @ViewChild('ErrorTemplate') errorTemplate: any;

  firstName: string;
  lastName: string;
  email: string;
  contactNumber: string;
  QID: string;
  shareHolderNumber: string;
  userName: string;
  password: string;
  repassword: string;
  successTemplateMessage: string;
  errorTemplateMsg: string;
  submitted: boolean = false;
  passwordNotMatch: boolean = false;
  registrationStatus: boolean;

  userDetails: UserVM;

  userSubscription: Subscription;
  formGroup: FormGroup;
  modalOption: ModalOptions = {};
  modalRef: BsModalRef;
  modalRefError: BsModalRef;

  constructor(private router: Router, private restServiceUser: UserService,
    private modalService: BsModalService, private spinner: NgxSpinnerService) {

    this.formGroup = new FormGroup({
      firstNameFormControl: new FormControl('', [Validators.required]),
      lastNameFormControl: new FormControl('', [Validators.required]),
      emailFormControl: new FormControl('', [
        Validators.required
      ]),
      contactNumberFormControl: new FormControl('', [Validators.required, Validators.minLength(8), Validators.maxLength(8)]),
      QIDFormControl: new FormControl('', [Validators.required, Validators.minLength(11), Validators.maxLength(11), this.QIDValidator()]),
      userNameFormControl: new FormControl('', [Validators.required]),
      passwordFormControl: new FormControl('', [Validators.required, this.passwordValidator()]),
      repasswordFormControl: new FormControl('', [Validators.required, this.passwordMatchValidator()])
    });
  }

  ngOnInit(): void {

    this.formGroup.markAsUntouched();
  }

  login() {
    this.router.navigate(['']);
  }


  register() {
    this.submitted = true;
    if (this.password != this.repassword) {
      this.passwordNotMatch = true;
    }
    if (!this.formGroup.invalid) {
      debugger;
      this.spinner.show();
      this.userDetails = new UserVM();
      this.userDetails.UserId = 0;
      this.userDetails.First_Name = this.firstName;
      this.userDetails.Last_Name = this.lastName;
      this.userDetails.Email_Address = this.email;
      this.userDetails.Contact_Number = this.contactNumber;
      this.userDetails.QID_Number = this.QID;
      // this.userDetails.Shareholder_ID = this.shareHolderNumber;    
      this.userDetails.UserName = this.userName;
      this.userDetails.Password = this.password;

      this.userSubscription = this.restServiceUser.AddNewUser(this.userDetails).subscribe(
        data => {
          this.spinner.hide();
          let msg = data.body.exception;
          if (data.body.status) {
            this.registrationStatus = true;
            this.openSuccessModal('Registartion successful.', this.successtemplate);
          } else {
            this.registrationStatus = false;
            this.openErrorModal(msg == '' ? 'Registration faied. Please contact admin.' : msg, this.errorTemplate)
          }
        }
      );
    }
  }

  openSuccessModal(message, template: TemplateRef < any > ) {
    this.successTemplateMessage = message;
    this.modalOption.backdrop = 'static';
    this.modalOption.keyboard = false;
    this.modalRef = this.modalService.show(template, this.modalOption);
  }

  openErrorModal(message, template: TemplateRef < any > ) {
    this.errorTemplateMsg = message;
    this.modalOption.backdrop = 'static';
    this.modalOption.keyboard = false;
    this.modalRefError = this.modalService.show(template, this.modalOption);
  }

  okay() {
    this.modalRef.hide();
    if (this.registrationStatus) {
      this.login();
    }
  }

  keyPress(event: any) {
    const pattern = /[0-9\+\-\ ]/;

    const inputChar = String.fromCharCode(event.charCode);
    if (event.key != 8 && !pattern.test(inputChar)) {
      event.preventDefault();
    }
  }
  keyPressQID(event: any) {
    const pattern = /[0-9\+\-\ ]/;

    const inputChar = String.fromCharCode(event.charCode);
    if (event.key != 8 && !pattern.test(inputChar)) {
      event.preventDefault();
    }
  }


  passwordValidator(): ValidatorFn {

    return (control: AbstractControl): { [key: string]: any  } | null => {

      let hasLower = false;
      let hasUpper = false;
      let hasNum = false;
      let hasSpecial = false;
      const password = control.value;

      const lowercaseRegex = new RegExp("(?=.*[a-z])"); // has at least one lower case letter
      if (lowercaseRegex.test(password)) {
        hasLower = true;
      }

      const uppercaseRegex = new RegExp("(?=.*[A-Z])"); //has at least one upper case letter
      if (uppercaseRegex.test(password)) {
        hasUpper = true;
      }

      const numRegex = new RegExp("(?=.*\\d)"); // has at least one number
      if (numRegex.test(password)) {
        hasNum = true;
      }

      const specialcharRegex = new RegExp("[!@#$%^&*(),.?\":{}|<>]");
      if (specialcharRegex.test(password)) {
        hasSpecial = true;
      }

      let counter = 0;
      let checks = [hasLower, hasUpper, hasNum, hasSpecial];
      for (let i = 0; i < checks.length; i++) {
        if (checks[i]) {
          counter += 1;
        }
      }
      if(password ==""){
        return null;

      } else if (counter < 4) {
        return {
          invalidPassword: true
        }
      } else {
        return null;
      }
    };
  }

  passwordMatchValidator(): ValidatorFn {
    
    return (control: AbstractControl): {[key: string]: any} | null => {
      const match = control.value == this.password;
    
      if(control.value =='' ){
        return {passwordMatch: null};
      }
      else
      return match ? null : {passwordMatch: {value: false}} ;
    };
  }

  QIDValidator(): ValidatorFn {
    
    return (control: AbstractControl): {[key: string]: any} | null => {

      if(control.value =='' || control.value == undefined){
        return null;
      }      
      else{
        
        const match = control.value.substring(3,7);

        if(match =='6340' ){
          return  null;
        }
        else
        return  {QIDMatch: {value: false}} ;

      }
    };
  }


}