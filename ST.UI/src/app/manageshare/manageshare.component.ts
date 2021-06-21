import { Component, OnInit, Input, ViewChild, TemplateRef } from '@angular/core';
import { Subscription } from 'rxjs';
import { MatPaginator } from '@angular/material/paginator';
import { MatTableDataSource } from '@angular/material/table';
import { Observable,  } from 'rxjs';
import { map, startWith } from 'rxjs/operators';
import {FormControl, FormGroup, Validators} from '@angular/forms';
import { ModalOptions, BsModalRef, BsModalService } from 'ngx-bootstrap/modal';
import { NgxSpinnerService } from "ngx-spinner";

import { ShareService } from '../services/share.service';
import { ShareDetailsVM } from '../Models/ShareDetailsVM';
import { UserVM } from '../Models/UserVM';
import { QIDDetailsVM } from '../Models/QIDDetailsVM';
import { UserService } from '../services/user.service';
import { QidService } from '../services/qid.service';

@Component({
  selector: 'app-manageshare',
  templateUrl: './manageshare.component.html',
  styleUrls: ['./manageshare.component.css']
})
export class ManageshareComponent implements OnInit {

  ShareholderID: string;
  AvailableShares: string;
  AvailableSharesPopup: string;
  ShareholderIDPopup: string;
  editShareDetailsId: number;
  deleteShareDetailsId: number;
  successTemplateMessage: string;
  qidNgModel: string;
  qid: string;
  uniqueId: string;
  
  shareSubscription: Subscription;
  userSubscription: Subscription;
  
  shareList: ShareDetailsVM[];  
  qidDetailsList: QIDDetailsVM[];
  userList: UserVM[];
  shareDetails: ShareDetailsVM;
  userDetails: UserVM;
  qidDetails: QIDDetailsVM;
  
  formGroup: FormGroup;
  formGroupPopUp: FormGroup;
  myControl = new FormControl('', [ Validators.required]);
  myControlPopup = new FormControl();
  
  displayedColumns: string[] = [];
  displayedColumnsBid: string[] = [];
  dataSource: MatTableDataSource < any >;  
  filteredOptions: Observable<any[]>;

  modalOption: ModalOptions = {};
  modalRef: BsModalRef;
  modalSuccessRef: BsModalRef;

  @ViewChild(MatPaginator, {static: true}) paginator: MatPaginator; 
  @ViewChild('Successtemplate') successtemplate : any; 
  @ViewChild('qidSearch') qidSearch;  

  response: any;


  constructor(private restServiceShare: ShareService, private restServiceUser: UserService, 
    private modalService: BsModalService, private spinner: NgxSpinnerService, private restServiceQID: QidService) {    
    this.formGroup = new FormGroup({
      ShareholderIDFormControl: new FormControl('', [ Validators.required]),
      AvailableSharesFormControl: new FormControl('', [ Validators.required]),
   });
   this.formGroupPopUp= new FormGroup({  
    ShareholderIDPopupFC: new FormControl('', [ Validators.required]),
    AvailableSharesPopupFC: new FormControl('', [ Validators.required])
   });
   this.formGroup.addControl('myControl',this.myControl);
   }

  ngOnInit(): void {    
    this.spinner.show();
    this.qid ='';
    this.uniqueId='';
    this.qidNgModel = '';
    this.shareDetails = new  ShareDetailsVM();
    this.shareList = [];  
    this.getShareData(0);
  }


  getShareData(shareId: number){
    debugger;
    this.shareDetails = new ShareDetailsVM();
    this.shareDetails.ShareDetailsId = shareId;
    this.shareDetails.CreatedBy = Number(sessionStorage.getItem('UserId'));
    this.shareSubscription = this.restServiceShare.GetShareData(this.shareDetails).subscribe(
      data =>
      {      
        this.shareList = data;
        this.shareList.forEach((element) => {
          element.CreatedDt =new Date(element.CreatedDt)
        });

        this.filteredOptions = this.myControl.valueChanges
        .pipe(
          startWith(''),
          map(qidDetails => qidDetails ? this.filterQID(qidDetails.toString()) : this.shareList.slice())
        ); 

        this.getUserData(0);
        // this.getQIDData(0);
        this.initialize();
      }
    );
  }

  getUserData(userId: number){
    debugger;
    this.userDetails = new UserVM();
    this.userDetails.UserId = userId;
    this.userSubscription = this.restServiceUser.GetUser(this.userDetails).subscribe(
      data =>
      {      
      }
    );
  }

 /*  getQIDData(qid: number){
    debugger;
    this.qidDetails = new QIDDetailsVM();
    this.qidDetails.QID = qid;
    this.userSubscription = this.restServiceQID.GetQIDDetails(this.qidDetails, false).subscribe(
      data =>
      {      
        this.qidDetailsList = data;
        this.filteredOptions = this.myControl.valueChanges
        .pipe(
          startWith(''),
          map(qidDetails => qidDetails ? this.filterQID(qidDetails.toString()) : this.qidDetailsList.slice())
        ); 
      }filteredOptions
    );
  } */

  getAndSetShareDetailsEdit(ShareDetailsId: number, template){    
    debugger;
    this.shareDetails.ShareDetailsId = ShareDetailsId;
    this.shareDetails.CreatedBy = Number(sessionStorage.getItem('UserId'));
    this.shareSubscription = this.restServiceShare.GetShareData(this.shareDetails).subscribe(
      data =>
      { 
        this.qid = data.QID;
        this.uniqueId = data.UniqueID;      
        this.AvailableSharesPopup = data.AvailableShares.toString();
        this.ShareholderIDPopup = data.ShareholderID.toString();        
        this.modalRef = this.modalService.show(template, this.modalOption);
        this.spinner.hide();
      }
    );
  }
  

  initialize(){
    this.displayedColumns = ['ShareholderID','AssignedUser','AvailableShares', 'CreatedDt', 'Actions'];
    this.dataSource = new MatTableDataSource(this.shareList);
    this.dataSource.paginator = this.paginator;
    this.spinner.hide();
  }

  onSubmit(){
    if(!this.formGroup.invalid)
    {
      this.spinner.show();
      debugger;
      this.shareDetails.ShareDetailsId = 0;
      this.shareDetails.AvailableShares = Number(this.AvailableShares);
      this.shareDetails.ShareholderID = Number(this.ShareholderID);
      this.shareDetails.QID = (this.qidNgModel !='' || this.qidNgModel!=null)  ? this.qidNgModel: this.qid;
      this.shareDetails.UniqueID = this.uniqueId;
      this.shareDetails.CreatedBy = Number(sessionStorage.getItem('UserId'));
      this.shareSubscription = this.restServiceShare.AddNewShare(this.shareDetails).subscribe(
        data =>
        {      
          if(!data.body.status) 
          {            
            this.spinner.hide();
            this.openSuccessModal(data.body.exception, this.successtemplate);
            
          }
          else
          {
              this.response = data.body;
              this.AvailableShares = '';
              this.ShareholderID = '';
              this.qidNgModel = '';
              this.uniqueId='';
              this.getShareData(0);
              this.openSuccessModal('Share added successfully', this.successtemplate);
              this.formGroup.markAsUntouched();
          }
        }
      );
    }
    else
    {
      this.qidSearch.nativeElement.focus();
      this.qidSearch.nativeElement.blur();
      this.formGroup.markAllAsTouched();
    }
  }

  saveEdit(){
    if(!this.formGroupPopUp.invalid){
      this.spinner.show();
      this.shareDetails.ShareDetailsId = this.editShareDetailsId;
      this.shareDetails.AvailableShares = Number(this.AvailableSharesPopup);
      this.shareDetails.ShareholderID = Number(this.ShareholderIDPopup);
      this.shareDetails.QID = this.qid;
      this.shareDetails.UniqueID = this.uniqueId;
      this.shareDetails.UpdatedBy = Number(sessionStorage.getItem('UserId'));
      this.shareSubscription = this.restServiceShare.UpdateShare(this.shareDetails).subscribe(
        data =>
        {       
          if(!data.body.status) 
          {            
            this.spinner.hide();
            this.openSuccessModal(data.body.exception, this.successtemplate);
            
          }
          else
          {
            this.response = data.body;
            this.getShareData(0);
            this.openSuccessModal('Share details updated succssfully', this.successtemplate);
          }
        }
      )
    }
    else{
      this.formGroupPopUp.markAllAsTouched();
    }
  }

  deleteShare(shareDetailsId){
    this.spinner.show();
    this.shareDetails.ShareDetailsId = shareDetailsId;
    this.shareDetails.UpdatedBy = Number(sessionStorage.getItem('UserId'));
    this.shareSubscription = this.restServiceShare.DeleteShare(this.shareDetails).subscribe(
      data =>
      {   
        if(!data.status) 
          {            
            this.spinner.hide();
            this.openSuccessModal(data.exception, this.successtemplate);
            
          }
          else
          {    
            this.response = data.body;
            this.getShareData(0);
            this.openSuccessModal('Share removed succesfully.', this.successtemplate);
          }
      }
    )
  }

  onQIDSelectionChange(event){
    this.qid = '';
    this.qid = event.option.value;
    this.qidNgModel = event.option.value;
    // this.uniqueId = event.UniqueID;
   
    if(this.shareList.findIndex(x=> x.QID == this.qid) != -1){
      this.AvailableShares = this.shareList.find(x=> x.QID == this.qid).AvailableShares.toString();
      this.ShareholderID = this.shareList.find(x=> x.QID == this.qid).ShareholderID.toString();
    }
     /*  
    else
    {
      
    this.AvailableShares='';
    this.ShareholderID='';
    } */
    
  }
  openEditActionModal(data, template){
    this.modalOption.backdrop = 'static';
    this.modalOption.keyboard = false;    
    this.modalOption.class = "edit-model-sale";    
    this.editShareDetailsId = data.ShareDetailsId;
    this.getAndSetShareDetailsEdit(data.ShareDetailsId, template);
  }

  openDeleteActionModal(data, template){
    this.deleteShareDetailsId = data.ShareDetailsId;
    this.modalRef = this.modalService.show(template, this.modalOption);
  }

  
  openSuccessModal(message,template: TemplateRef<any>){
    this.successTemplateMessage = message;
    this.modalOption.backdrop = 'static';
    this.modalOption.keyboard = false;    
    this.modalSuccessRef = this.modalService.show(template, this.modalOption);
  }

  cancelEdit(): void {
    if (this.modalRef !== undefined && this.modalRef !== null) {
      this.modalRef.hide();
    }
  }
  confirmDelete(){    
    this.deleteShare(this.deleteShareDetailsId);
  }
  declineDelete(): void {
    if (this.modalRef !== undefined && this.modalRef !== null) {
      this.modalRef.hide();
    }
  }
  
  successOkay(): void {
    if (this.modalSuccessRef !== undefined && this.modalSuccessRef !== null) {
      this.modalSuccessRef.hide();
    }    
    if (this.modalRef !== undefined && this.modalRef !== null) {
      this.modalRef.hide();
    }
  }

  filterShares(fullName: string) {
    debugger;
    return this.userList.filter(user =>
      user.Full_Name.toLowerCase().indexOf(fullName.toLowerCase()) === 0);
  }

  filterQID(qidInput: string) {
    debugger;
    return this.shareList.filter(qid =>
      qid.QID.toString().toLowerCase().indexOf(qidInput.toLowerCase()) === 0);
  }

  resetAddNewShare(){
    this.qidNgModel ='';
    this.AvailableShares = ''
    this.ShareholderID='';
    this.formGroup.markAsUntouched();
    this.qidSearch.nativeElement.blur();
  }

}
