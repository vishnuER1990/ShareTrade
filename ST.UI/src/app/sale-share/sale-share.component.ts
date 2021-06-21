import { Component, OnInit, Input, ViewChild,ViewChildren, TemplateRef, QueryList  } from '@angular/core';
import { Subscription } from 'rxjs';
import { MatPaginator } from '@angular/material/paginator';
import { MatTableDataSource } from '@angular/material/table';
import { Observable,  } from 'rxjs';
import { map, startWith } from 'rxjs/operators';
import {FormControl, FormGroup, Validators, AbstractControl, ValidatorFn} from '@angular/forms';
import { ModalOptions, BsModalRef, BsModalService } from 'ngx-bootstrap/modal';
import { NgxSpinnerService } from "ngx-spinner";


import { SaleService } from '../services/sale.service';
import { ShareService } from '../services/share.service';
import { BidService } from '../services/bid.service';
import { SaleDetailsVM } from '../Models/SaleDetailsVM';
import { ShareDetailsVM } from '../Models/ShareDetailsVM';
import { ProposalDetailsVM } from '../Models/ProposalDetailsVM';

@Component({
  selector: 'app-sale-share',
  templateUrl: './sale-share.component.html',
  styleUrls: ['./sale-share.component.css']
})
export class SaleShareComponent implements OnInit {

  NumberOFShares: string;
  ShareDescription: string;
  ShareCreatedDate: string;
  UnitPrice: string;
  ValidTo: Date;
  SaleRemarks: string;
  AvailableShares: string;
  ShareDescriptionPopup: string;
  NumberOFSharesPopup: string;
  UnitPricePopup: string;
  ValidToPopup: Date;
  SaleRemarksPopup: string;
  AvailableSharesPopup: string;
  ShareCreatedDatePopup: string;
  successTemplateMessage: string;
  bidRejectionReason: string;
  IsAdmin: boolean
  enableAddSaleFields: boolean;
  PriceNegotiable: number;
  PriceNegotiablePopup: number;
  

  shareId: number;
  deleteSaleId: number;
  editSaleId: number;
  bidSaleId: number;
  response: any;
  minDate: Date;

  @ViewChild('Successtemplate') successtemplate : any;

  @ViewChild(MatPaginator) paginator: MatPaginator;  
  @ViewChild(MatPaginator) paginatorBid: MatPaginator;  
  @ViewChildren(MatPaginator) paginatorNew = new QueryList<MatPaginator>();


  displayedColumns: string[] = [];
  displayedColumnsBid: string[] = [];
  dataSource: MatTableDataSource < SaleDetailsVM > = new MatTableDataSource < SaleDetailsVM >() ;
  dataSourceBid: MatTableDataSource < ProposalDetailsVM > = new MatTableDataSource < ProposalDetailsVM >() ;
  modalOption: ModalOptions = {};
  modalRef: BsModalRef;
  modalSuccessRef: BsModalRef;
  modalRefBid: BsModalRef;
  modalRefBidReject: BsModalRef;

  saleListSubscription: Subscription;
  shareListSubscription: Subscription;
  addSaleSubscription: Subscription;
  deleteSaleSubscription: Subscription;
  bidSubscription: Subscription;
  
  saleDetails: SaleDetailsVM;
  shareDetails: ShareDetailsVM;
  bidDetails: ProposalDetailsVM;
  deleteData: SaleDetailsVM;

  saleList: SaleDetailsVM[];
  shareList: ShareDetailsVM[];
  bidList: ProposalDetailsVM[];
  shareListsuggestions: any[];
  
  options: string[] = ['One', 'Two', 'Three'];
  filteredOptionsPopup: Observable<any[]>;
  filteredOptions: Observable<any[]>;
  // myControl = new FormControl();
  // myControlPopupFC = new FormControl('', [ Validators.required]);

  
  formGroup: FormGroup;
  formGroupEditSale: FormGroup;

  constructor(private restServiceSale: SaleService, private restServiceShare: ShareService, 
    private modalService: BsModalService, private spinner: NgxSpinnerService
  , private restServiceBid: BidService) { 

    this.minDate = new Date();

      this.formGroup = new FormGroup({
        NumberOFSharesFC: new FormControl('', [ Validators.required,Validators.pattern('^-?[0-9]\\d*(\\.\\d{1,2})?$'), this.numberOFSharesDataChangeValidator()]),
        // ShareDescription: new FormControl(),
        ShareCreatedDateFC: new FormControl(),
        UnitPriceFC: new FormControl('', [ Validators.required,Validators.pattern('^-?[0-9]\\d*(\\.\\d{1,2})?$')]),
        SaleRemarksFC: new FormControl(),
        AvailableSharesFC: new FormControl(),
        PriceNegotiableFC: new FormControl(),
        ValidToFC:  new FormControl('', [ Validators.required])
      });

      this.formGroupEditSale = new FormGroup({
        NumberOFSharesPopupFC: new FormControl('', [ Validators.required,Validators.pattern('^-?[0-9]\\d*(\\.\\d{1,2})?$'), this.numberOFSharesDataChangeValidator1()]),
        UnitPricePopupFC: new FormControl('', [ Validators.required,Validators.pattern('^-?[0-9]\\d*(\\.\\d{1,2})?$')]),//,Validators.pattern('^[1-9]\d*(\.\d+)?$')
        SaleRemarksPopupFC: new FormControl(),
        AvailableSharesPopupFC: new FormControl(),
        ShareCreatedDatePopupFC: new FormControl(),
        ValidToPopupFC:  new FormControl('', [ Validators.required]),
        PriceNegotiablePopupFC: new FormControl()
      });
  // this.formGroup.addControl('myControl',this.myControl);
  // this.formGroupEditSale.addControl('myControlPopupFC',this.myControlPopupFC);
  }

  ngOnInit(): void {
    this.enableAddSaleFields = false;
    this.IsAdmin = sessionStorage.getItem("Role") == 'Admin';
    this.saleDetails  = new SaleDetailsVM();
    this.shareDetails = new  ShareDetailsVM();
    this.bidDetails = new  ProposalDetailsVM();
    this.deleteData = new SaleDetailsVM();
    this.saleList  = [];
    this.shareList = [];  
    this.shareListsuggestions = [];
    this.bidList = [];
    this.getSaleData();

  }


  initialize(){
    if(this.IsAdmin){
      this.displayedColumns = ['NumberOfShares', 'UnitPrice','IsNegotiable', 'Status','CreatedBy_String', 'CreatedDt','BidCount'];
    } 
    else{
      this.displayedColumns = ['NumberOfShares', 'UnitPrice','IsNegotiable', 'Status', 'CreatedDt','BidCount', 'Actions'];
    }
    this.dataSource = new MatTableDataSource(this.saleList);
    this.dataSource.paginator = this.paginatorNew.toArray()[0];
    this.spinner.hide();
  }
  initializeBidList(template){
    
    if(this.IsAdmin){
      this.displayedColumnsBid = ['BidPrice','BidUnit', 'StatusDescription','CreatedBy_String', 'CreatedDt'];
    } 
    else{
      
      this.displayedColumnsBid = ['BidPrice','BidUnit', 'StatusDescription','CreatedBy_String', 'CreatedDt', 'Actions' ];
    }
    this.dataSourceBid = new MatTableDataSource(this.bidList);
    this.dataSourceBid.paginator = this.paginatorNew.toArray()[1];    
    if(template != null && template != ""){
      this.modalRefBid = this.modalService.show(template, this.modalOption);
    }
    this.spinner.hide();
  }

  getSaleData(){
    this.spinner.show();
    this.saleDetails = new SaleDetailsVM();
    this.saleDetails.SaleId = 0;
    this.saleDetails.CreatedBy = Number(sessionStorage.getItem('UserId'));
    this.saleListSubscription = this.restServiceSale.GetSaleData(this.saleDetails).subscribe(
      data =>
      {      
        
        this.getAndSetShareDetails(0);

        this.saleList = data;
        this.saleList.forEach((element) => {
          element.CreatedDt =new Date(element.CreatedDt)
        });
        this.initialize();
        // this.getShareData();
      }
    );
  }

  /* getShareData(){    
    debugger;
    this.shareDetails.ShareDetailsId = 0;
    this.shareDetails.CreatedBy = Number(sessionStorage.getItem('UserId'));
    this.shareListSubscription = this.restServiceShare.GetShareData(this.shareDetails).subscribe(
      data =>
      {      
        this.shareList = data; 
        this.filteredOptions = this.myControl.valueChanges
        .pipe(
          startWith(''),
          map(
              shareDetails => this.filterShares(shareDetails) 
              )
        ); 
        this.spinner.hide();
      }
    );
  } */
/* 

  getShareDataEdit(template){    
    debugger;
    this.shareDetails.ShareDetailsId = 0;
    this.shareDetails.CreatedBy = Number(sessionStorage.getItem('UserId'));
    this.shareListSubscription = this.restServiceShare.GetShareData(this.shareDetails).subscribe(
      data =>
      {      
        this.shareListsuggestions = data; 
        this.spinner.hide();
        this.modalRef = this.modalService.show(template, this.modalOption);

      }
    );
  }
 */
  
  getAndSetShareDetails(ShareDetailsId: number){    
    debugger;
    this.shareId = 0;
    this.shareDetails.ShareDetailsId = ShareDetailsId;
    this.shareDetails.CreatedBy = Number(sessionStorage.getItem('UserId'));
    this.shareListSubscription = this.restServiceShare.GetShareData(this.shareDetails).subscribe(
      data =>
      {       
        this.shareId = data[0].ShareDetailsId;
        this.AvailableShares = data[0].AvailableShares.toString();
        // this.ShareDescription = data[0].Description.toString();
        this.ShareCreatedDate = new Date(data[0].CreatedDt).toUTCString().split(' ').slice(0, 4).join(' ');
        this.enableAddSaleFields = true;            
      }
    );
  }

  getAndSetShareDetailsEdit(ShareDetailsId: number){    
    debugger;
    this.shareId = ShareDetailsId;
    this.shareDetails.ShareDetailsId = ShareDetailsId;
    this.shareDetails.CreatedBy = Number(sessionStorage.getItem('UserId'));
    this.shareListSubscription = this.restServiceShare.GetShareData(this.shareDetails).subscribe(
      data =>
      {       
        this.AvailableSharesPopup = data[0].AvailableShares.toString();
        // this.ShareDescriptionPopup = data[0].Description.toString();
        this.ShareCreatedDatePopup = new Date(data[0].CreatedDt).toUTCString().split(' ').slice(0, 4).join(' ');
      }
    );
  }

  getAndSetSaleDetails(saleId, template){    
    this.spinner.show();
    // this.ShareDescriptionPopup = '';
    this.ShareCreatedDatePopup = '';
    this.AvailableSharesPopup = '';
    this.NumberOFSharesPopup = '';
    this.UnitPricePopup = '';
    this.SaleRemarksPopup = '';

    this.saleDetails = new SaleDetailsVM();
    this.saleDetails.SaleId = saleId;
    this.saleDetails.CreatedBy = Number(sessionStorage.getItem('UserId'));
    this.saleListSubscription = this.restServiceSale.GetSaleData(this.saleDetails).subscribe(
      data =>
      { 
        // this.ShareDescriptionPopup = data[0].ShareDescription;
        this.ShareCreatedDatePopup = new Date(data[0].CreatedDt).toUTCString().split(' ').slice(0, 4).join(' ');
        this.AvailableSharesPopup = data[0].AvailableShares;
        this.NumberOFSharesPopup = data[0].NumberOfShares;
        this.UnitPricePopup = data[0].UnitPrice;
        this.SaleRemarksPopup = data[0].SaleRemarks;
        this.shareId =   data[0].ShareDetailsId;
        this.ValidToPopup = data[0].ValidTo;
        this.PriceNegotiablePopup = data[0].IsNegotiable?1:2;
        this.spinner.hide();
        this.modalRef = this.modalService.show(template, this.modalOption);
        // this.getShareDataEdit(template);        
      }
    );
  }

  refreshBidData(saleId)
  {
    this.spinner.show();
    this.bidDetails = new ProposalDetailsVM();
    this.bidDetails.SaleId = this.bidSaleId;
    this.bidDetails.ProposalId = 0;
    this.bidDetails.CreatedBy = Number(sessionStorage.getItem('UserId'));
    this.bidSubscription = this.restServiceBid.GetBidDataForSale(this.bidDetails).subscribe(
      data =>
      {      
        this.bidList = data;
        this.bidList.forEach((element) => {
          element.CreatedDt =new Date(element.CreatedDt)
        });
        this.initializeBidList(''); 
      }
    );
  }

  onSubmit(){
    if(this.shareId == 0 && ((this.NumberOFShares == ''  &&  this.UnitPrice == '') || (this.NumberOFShares == undefined  &&  this.UnitPrice == undefined))){
      this.openSuccessModal('Please select a share to add sale',this.successtemplate);  
    } 
    else{
        if(!this.formGroup.invalid){
        debugger;
        this.spinner.show();
        this.saleDetails.NumberOfShares =  Number(this.NumberOFShares);
        this.saleDetails.ShareDetailsId =  this.shareId;
        this.saleDetails.UnitPrice = Number(this.UnitPrice);
        this.saleDetails.SaleRemarks = this.SaleRemarks;
        this.saleDetails.IsNegotiable = this.PriceNegotiable == 1;
        this.saleDetails.CreatedBy = Number(sessionStorage.getItem('UserId'));
        this.saleDetails.ValidTo = this.ValidTo;
        this.addSaleSubscription = this.restServiceSale.AddNewSale(this.saleDetails).subscribe(
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
              this.getSaleData();
              this.openSuccessModal('Sale submitted successfully',this.successtemplate);
              this.NumberOFShares = '';
              this.UnitPrice = '';
              this.SaleRemarks = '';
              this.AvailableShares = '';
              // this.ShareDescription = '';
              this.ShareCreatedDate = '';
              this.formGroup.markAsUntouched();
            }
          }
        );
      }
      else{
        if (Number(this.formGroup.controls.NumberOFSharesFC.value) > Number(this.AvailableShares))
        {
          this.formGroup.controls.NumberOFSharesFC.setErrors( {forbiddenName: {value: false}});
        }
      }
  }

  }

  deleteSale(data){
    this.spinner.show();
    this.saleDetails.SaleId = data.SaleId;   
    this.saleDetails.ShareDetailsId = data.ShareDetailsId;    
    this.saleDetails.NumberOfShares = Number(data.NumberOfShares);   
    this.saleDetails.Status = 2;//Cancelled Sale
    this.saleDetails.UpdatedBy = Number(sessionStorage.getItem('UserId'));
    this.deleteSaleSubscription = this.restServiceSale.DeleteSale(this.saleDetails).subscribe(
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
          this.getSaleData();
        }
      }
    );
  }

  updateSale(){
    debugger;
    this.spinner.show();
    this.saleDetails = new SaleDetailsVM();
    this.saleDetails.SaleId = this.editSaleId;
    this.saleDetails.ShareDetailsId =  this.shareId;
    this.saleDetails.NumberOfShares =  Number(this.NumberOFSharesPopup);
    this.saleDetails.UnitPrice = Number(this.UnitPricePopup);
    this.saleDetails.SaleRemarks = this.SaleRemarksPopup;
    this.saleDetails.UpdatedBy = Number(sessionStorage.getItem('UserId'));
    this.saleDetails.ValidTo = this.ValidToPopup;
    this.saleDetails.IsNegotiable = this.PriceNegotiablePopup == 1;
    this.addSaleSubscription = this.restServiceSale.UpdateSale(this.saleDetails).subscribe(
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
          this.getSaleData();
          this.openSuccessModal('Changes saved successfully',this.successtemplate); 
        }
      }
    )}
  

  approveBid(data){
    this.spinner.show();
    this.bidSaleId = data.SaleId;
    this.bidDetails = new ProposalDetailsVM();
    this.bidDetails.ProposalId = data.ProposalId;
    this.bidDetails.SaleId = data.SaleId;
    this.bidDetails.Status = 2; //Approved
    this.bidDetails.BidPrice = data.BidPrice;    
    this.bidDetails.BidUnit = data.BidUnit;   
    this.bidDetails.StatusComments = '';
    this.bidDetails.UpdatedBy = Number(sessionStorage.getItem('UserId'));
    this.bidSubscription = this.restServiceBid.UpdateSale(this.bidDetails).subscribe(
      data =>
      {   
               
        if(!data.body.status) 
        {            
          this.spinner.hide();
          this.openSuccessModal(data.body.exception, this.successtemplate);              
        }
        else
        {   
          this.spinner.hide();
          this.response = data.body;
          this.openSuccessModal('Bid has been approved',this.successtemplate);
          this.refreshBidData(this.bidSaleId);
        }
      }
    );
  }
  rejectBid(){    
    this.spinner.show();
    this.bidDetails.StatusComments = this.bidRejectionReason;
    this.bidDetails.UpdatedBy = Number(sessionStorage.getItem('UserId'));
    this.bidSubscription = this.restServiceBid.UpdateSale(this.bidDetails).subscribe(
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
          this.openSuccessModal('Bid has been rejected',this.successtemplate);    
          this.refreshBidData(this.bidSaleId);
        }
      }
    );
  }

  numberOFSharesDataChangeValidator(): ValidatorFn {
    
    return (control: AbstractControl): {[key: string]: any} | null => {
      const forbidden = Number(control.value) > Number(this.AvailableShares);
    
      if(control.value =='' || this.AvailableShares == null || this.AvailableShares == undefined){
        return {forbiddenName: null};
      }
      else
      return forbidden ? {forbiddenName: {value: false}} : null;
    };
  }

  numberOFSharesDataChangeValidator1(): ValidatorFn {
    
    return (control: AbstractControl): {[key: string]: any} | null => {
      const forbidden = Number(control.value) > Number(this.AvailableSharesPopup);
    
      if(control.value =='' || this.AvailableSharesPopup == null || this.AvailableSharesPopup == undefined){
        return {forbiddenName: null};
      }
      else
      return forbidden ? {forbiddenName: {value: false}} : null;
    };
  }

  openEditActionModal(saleId, shareId, template){    
    this.formGroupEditSale.markAsUntouched();
    this.modalOption.backdrop = 'static';
    this.modalOption.keyboard = false;    
    this.modalOption.class = "edit-model-sale";    
    this.editSaleId = saleId;
    this.shareId = shareId;
    this.getAndSetSaleDetails(saleId, template);
  }
  openSuccessModal(message,template: TemplateRef<any>){
    this.successTemplateMessage = message;
    this.modalOption.backdrop = 'static';
    this.modalOption.keyboard = false;    
    this.modalSuccessRef = this.modalService.show(template, this.modalOption);
  }
  
  openDeleteActionModal(data, template){    
  this.modalOption.backdrop = 'static';
  this.modalOption.keyboard = false;    
  this.modalRef = this.modalService.show(template, this.modalOption);
  this.deleteData = data;
}

  openBidActionModal(saleId, template){
    
    this.spinner.show();
    this.modalOption.backdrop = 'static';
    this.modalOption.keyboard = false;    
    this.modalOption.class = "edit-model-sale"; 
    this.modalOption.keyboard = false;  
    this.bidDetails = new ProposalDetailsVM();
    this.bidDetails.SaleId = saleId;
    this.bidDetails.ProposalId = 0;
    this.bidDetails.CreatedBy = Number(sessionStorage.getItem('UserId'));
    this.bidSubscription = this.restServiceBid.GetBidDataForSale(this.bidDetails).subscribe(
      data =>
      {      
        this.bidList = data;
        if(this.bidList.length ==0){          
          this.spinner.hide();
          this.openSuccessModal('No bid found for this sale', this.successtemplate);
        }
        else{
          this.bidList.forEach((element) => {
            element.CreatedDt =new Date(element.CreatedDt)
          });
          this.initializeBidList(template);
        }
      }
    );
  }

  openBidRejectActionModal(data, template){
    this.bidRejectionReason = '';
    this.bidSaleId = data.SaleId;
    this.bidDetails = new ProposalDetailsVM();
    this.bidDetails.ProposalId = data.ProposalId;
    this.bidDetails.Status = 3; //Rejected
    this.bidDetails.BidPrice = data.BidPrice;    
    this.bidDetails.BidUnit = data.BidUnit;   
    this.modalOption.backdrop = 'static';
    this.modalOption.keyboard = false;    
    this.modalRefBidReject = this.modalService.show(template, this.modalOption);
  }

  confirm(): void {
    this.deleteSale(this.deleteData);
    this.deleteSaleId = 0;
    if (this.modalRef !== undefined && this.modalRef !== null) {
      this.modalRef.hide();
    }
  }
 
  decline(): void {
    if (this.modalRef !== undefined && this.modalRef !== null) {
      this.modalRef.hide();
    }
  }
  
  cancelEdit(): void {
    if (this.modalRef !== undefined && this.modalRef !== null) {
      this.modalRef.hide();
    }
  }
  cancelBidList(): void {
    if (this.modalRef !== undefined && this.modalRef !== null) {
      this.modalRefBid.hide();
    }
  }
  cancelBidRejection(){
    if (this.modalRefBidReject !== undefined && this.modalRefBidReject !== null) {
      this.modalRefBidReject.hide();
    }
  }

  successOkay(): void {
    if (this.modalSuccessRef !== undefined && this.modalSuccessRef !== null) {
      this.modalSuccessRef.hide();
    }    
    if (this.modalRefBidReject !== undefined && this.modalRefBidReject !== null) {
      this.modalRefBidReject.hide();
    }   
    if (this.modalRef !== undefined && this.modalRef !== null) {
      this.modalRef.hide();
    }
  }

  saveEdit(){
    
    if(!this.formGroupEditSale.invalid){
    this.updateSale();
    }
  }

  filterShares(description: string) {
 
    if(description== '')
    {          
        this.shareId = 0;
        this.AvailableShares = '';
        this.ShareCreatedDate = '';
    }
    return this.shareList.filter(share =>
      share.Description.toLowerCase().indexOf(description.toLowerCase()) === 0);
  }

  onSaleSelectionChange(selectedShareId){  
    this.shareId = selectedShareId;
    // this.ShareDescription = '';
    this.ShareCreatedDate = '';
    this.AvailableShares = '';
    this.getAndSetShareDetails(selectedShareId);
  }
  onSaleSelectionChangePopup(selectedShareId){    
    // this.ShareDescription = '';
    this.ShareCreatedDate = '';
    this.AvailableShares = '';
    this.getAndSetShareDetailsEdit(selectedShareId);
  }

  ngOnDestroy() {
    if (this.saleListSubscription !== undefined) {
      this.saleListSubscription.unsubscribe();
    }
    if (this.shareListSubscription !== undefined) {
      this.shareListSubscription.unsubscribe();
    }    
    if (this.deleteSaleSubscription !== undefined) {
      this.deleteSaleSubscription.unsubscribe();
    }     
    if (this.bidSubscription !== undefined) {
      this.bidSubscription.unsubscribe();
    }
  }

}
