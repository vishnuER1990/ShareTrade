import { Component, OnInit, Input, ViewChild,ViewChildren, TemplateRef, QueryList  } from '@angular/core';
import { Subscription } from 'rxjs';
import { MatPaginator } from '@angular/material/paginator';
import { MatTableDataSource } from '@angular/material/table';
import { Observable,  } from 'rxjs';
import { map, startWith } from 'rxjs/operators';
import {FormControl, FormGroup, Validators, ValidatorFn, AbstractControl} from '@angular/forms';
import { ModalOptions, BsModalRef, BsModalService } from 'ngx-bootstrap/modal';
import { NgxSpinnerService } from "ngx-spinner";

import { SaleService } from '../services/sale.service';
import { BidService } from '../services/bid.service';
import { SaleDetailsVM } from '../Models/SaleDetailsVM';
import { ProposalDetailsVM } from '../Models/ProposalDetailsVM';
import { NotifyVM } from '../Models/NotifyVM';


@Component({
  selector: 'app-buy-share',
  templateUrl: './buy-share.component.html',
  styleUrls: ['./buy-share.component.css']
})
export class BuyShareComponent implements OnInit {


  @ViewChildren(MatPaginator) paginatorNew = new QueryList<MatPaginator>();

  @ViewChild(MatPaginator) paginator: MatPaginator; 
  @ViewChild(MatPaginator) paginatorBid: MatPaginator; 
  @ViewChild('Successtemplate') successtemplate : any;   

  saleListSubscription: Subscription;
  bidSubscription: Subscription;

  saleDetails: SaleDetailsVM;
  bidDetails: ProposalDetailsVM;
  notify: NotifyVM;

  response: any;
  addSaleId: number;
  proposalId: number;
  proposalIdEdit: number;
  proposalIdStatus: number;
  bidUnit: string;
  bidPrice: string;
  bidUnitEdit: string;
  bidPriceEdit: string;
  successTemplateMessage: string;
  bidDescription: string;
  bidRejectionReason: string;
  availableShareForValidation: string;
  saleIdValidation: number;
  IsAdmin: boolean;
  errorTemplateMessage: string='';
  DisableBidPrice: boolean;
  InterestedShares: string;
  InterestedUnitPrice: string;  

  saleList: SaleDetailsVM[]; 
  bidList: ProposalDetailsVM[]; 
  displayedColumns: string[] = [];
  displayedColumnsBid: string[] = [];
  filteredOptions: Observable<any[]>;
  filteredOptionsBid: Observable<any[]>;
  dataSource: MatTableDataSource < SaleDetailsVM > = new MatTableDataSource < SaleDetailsVM >();;
  dataSourceBid: MatTableDataSource < ProposalDetailsVM > = new MatTableDataSource < ProposalDetailsVM >();;

  formGroup: FormGroup; 
  formGroupBidEdit: FormGroup;
  formGroupBidEdit1: FormGroup;
  modalOption: ModalOptions = {};
  modalRef: BsModalRef;
  modalSuccessRef: BsModalRef;

  constructor(private restServiceSale: SaleService, private modalService: BsModalService, 
    private spinner: NgxSpinnerService, private restServiceBid: BidService) {
    this.formGroup = new FormGroup({
      InterestedSharesFC: new FormControl('', [ Validators.required, Validators.pattern('^-?[0-9]\\d*(\\.\\d{1,2})?$')]),// Validators.pattern('^[0-9]\\d*$')
      InterestedUnitPriceFC: new FormControl('', [ Validators.required, Validators.pattern('^-?[0-9]\\d*(\\.\\d{1,2})?$')]), 
    //   bidDescription: new FormControl(),
     });

      this.formGroupBidEdit = new FormGroup({
        bidUnitFC: new FormControl('', [ Validators.required, this.isNormalInteger(), this.bidPriceChangeValidator()]), //Validators.pattern('^-?[0-9]\\d*(\\.\\d{1,2})?$'), this.bidPriceChangeValidator()
         bidPriceFC: new FormControl('', [ Validators.required, Validators.pattern('^-?[0-9]\\d*(\\.\\d{1,2})?$')])
      });

      this.formGroupBidEdit1 = new FormGroup({
        bidUnitEditFC: new FormControl('', [ Validators.required, Validators.pattern('^-?[0-9]\\d*(\\.\\d{1,2})?$'), this.bidPriceChangeValidator1()]),//, this.bidPriceChangeValidator1()
        bidPriceEditFC: new FormControl('', [ Validators.required, Validators.pattern('^-?[0-9]\\d*(\\.\\d{1,2})?$')])
      });
   }

  ngOnInit(): void {
    this.IsAdmin = sessionStorage.getItem("Role") == 'Admin';
    this.saleDetails  = new SaleDetailsVM();
    this.notify = new NotifyVM();
    this.saleList  = [];
    this.getSaleData(); 
  }

  initialize(){
    this.displayedColumns = [ 'NumberOfShares','UnitPrice','ShareholderContactNumber','IsNegotiable','CreatedDt','ValidTo', 'Actions'];
    this.dataSource = new MatTableDataSource(this.saleList);
    this.dataSource.paginator = this.paginatorNew.toArray()[0];
    this.spinner.hide();
  }

  initializeBid(){
    if(sessionStorage.getItem("Role") == 'Admin'){      
    this.displayedColumnsBid = ['Seller', 'Buyer', 'BidUnit', 'BidPrice','SellerAvailableShares', 'StatusDescription', 'Actions'];
    }
    else{
      this.displayedColumnsBid = [ 'BidPrice', 'BidUnit','CreatedDt','StatusDescription', 'Actions'];
    }
    this.dataSourceBid = new MatTableDataSource(this.bidList);
    this.dataSourceBid.paginator = this.paginatorNew.toArray()[1];
    this.spinner.hide();
  }

  
  getSaleData(){
    debugger;
    this.spinner.show();
    this.saleDetails = new SaleDetailsVM();
    this.saleDetails.SaleId = 0;
    this.saleDetails.ProposalId = 0;
    this.saleDetails.CreatedBy = Number(sessionStorage.getItem('UserId'));
    this.saleListSubscription = this.restServiceSale.GetSaleData(this.saleDetails, true).subscribe(
      data =>
      {      
        this.saleList = data;
        this.saleList.forEach((element) => {
          element.CreatedDt =new Date(element.CreatedDt),
          element.ValidTo = new Date (element.ValidTo)
        });
        this.saleList = this.saleList.filter(x=>x.CreatedBy != Number(sessionStorage.getItem("UserId")));
        this.initialize();        
        this.getBidData();
      }
    );
  }
  
  getBidData(){
    debugger;
    this.spinner.show();
    this.bidDetails = new ProposalDetailsVM();
    this.bidDetails.ProposalId = 0;
    this.bidDetails.SaleId = 0;
    this.bidDetails.CreatedBy = Number(sessionStorage.getItem('UserId'));
    this.bidSubscription = this.restServiceBid.GetBidDataForSale(this.bidDetails).subscribe(
      data =>
      {      
        this.bidList = data;
        this.bidList.forEach((element) => {
          element.CreatedDt =new Date(element.CreatedDt)
        });
        this.initializeBid();
      }
    );
  }
  onSubmit(){

  }
  openBidActionModal(element, template){
    this.formGroupBidEdit.markAsUntouched();
    this.formGroupBidEdit.get('bidPriceFC').enable();
    this.formGroupBidEdit.get('bidPriceFC').setValidators([Validators.required, Validators.pattern('^-?[0-9]\\d*(\\.\\d{1,2})?$')])
    this.bidPrice = '';
    this.bidUnit = '';
    this.DisableBidPrice = false;
    this.modalOption.backdrop = 'static';
    this.modalOption.keyboard = false;    
    this.modalOption.class = "edit-model-sale";    
    this.addSaleId = element.SaleId;
    this.availableShareForValidation = element.AvailableShares;
    if(!element.IsNegotiable){
      this.formGroupBidEdit.get('bidPriceFC').disable();
      this.formGroupBidEdit.get('bidPriceFC').setValidators(null);
      this.bidPrice = element.UnitPrice;
      this.DisableBidPrice = true;
    }
    this.modalRef = this.modalService.show(template, this.modalOption);
  }

  openBidEditActionModal(data, template){
    this.formGroupBidEdit1.markAsUntouched();
    this.formGroupBidEdit1.get('bidPriceEditFC').enable();
    this.formGroupBidEdit1.get('bidPriceEditFC').setValidators([Validators.required, Validators.pattern('^-?[0-9]\\d*(\\.\\d{1,2})?$')])

    this.DisableBidPrice = false;
    this.modalOption.backdrop = 'static';
    this.modalOption.keyboard = false;    
    this.modalOption.class = "edit-model-sale";    
    this.modalRef = this.modalService.show(template, this.modalOption);
    this.bidUnitEdit = data.BidUnit;
    this.bidPriceEdit = data.BidPrice;
    this.proposalIdEdit = data.ProposalId;
    this.proposalIdStatus = data.Status;
    this.saleIdValidation = data.SaleId;
    let priceNegotiable = false;
    priceNegotiable = this.saleList.find(x=> x.SaleId == data.SaleId ).IsNegotiable;
    if(!priceNegotiable){
      this.formGroupBidEdit1.get('bidPriceEditFC').disable();
      this.formGroupBidEdit1.get('bidPriceEditFC').setValidators(null);
      this.bidPrice = data.UnitPrice;
      this.DisableBidPrice = true;
    }
  }
  openBidDeleteActionModal(data, template){
    this.proposalId = data.ProposalId;
    this.modalRef = this.modalService.show(template, this.modalOption);
  }
  openBidInfoActionModal(data, template){
    this.bidRejectionReason = data.StatusComments;
    this.modalRef = this.modalService.show(template, this.modalOption);
  }

  openBidAdminApproveActionModal(data, template){

    this.bidDetails = new ProposalDetailsVM();
    this.bidDetails.ProposalId = data.ProposalId;
    this.bidDetails.SaleId = data.SaleId;
    this.bidDetails.Status = 4; //Admin Approved
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
          this.getBidData();
        }
      }
    );
  }

  openBidAdminRejectActionModal(data, template){

    this.bidDetails = new ProposalDetailsVM();
    this.bidDetails.ProposalId = data.ProposalId;
    this.bidDetails.SaleId = data.SaleId;
    this.bidDetails.Status = 5; //Admin Rejected
    this.bidDetails.UpdatedBy = Number(sessionStorage.getItem('UserId')); 

    this.modalOption.backdrop = 'static';
    this.modalOption.keyboard = false;     
    this.modalRef = this.modalService.show(template, this.modalOption);
  }

  openSuccessModal(message,template: TemplateRef<any>){
    this.successTemplateMessage = message;
    this.modalOption.backdrop = 'static';
    this.modalOption.keyboard = false;    
    this.modalSuccessRef = this.modalService.show(template, this.modalOption);
  }

  addBid(){
    if(!this.formGroupBidEdit.invalid){
      this.spinner.show();
      this.bidDetails = new ProposalDetailsVM();
      this.bidDetails.SaleId = this.addSaleId; //Submitted
      this.bidDetails.Status = 1; //Submitted
      this.bidDetails.BidPrice = Number(this.bidPrice);   
      this.bidDetails.BidUnit = Number(this.bidUnit);   
      this.bidDetails.CreatedBy = Number(sessionStorage.getItem('UserId')); 
      this.bidSubscription = this.restServiceBid.AddNewBid(this.bidDetails).subscribe(
        data =>
        {      
          if(data.body.status){
            this.openSuccessModal('Bid has been submitted succeesfully',this.successtemplate);
            this.getBidData();
          } 
          else{
            this.spinner.hide();
            this.errorTemplateMessage = data.body.exception;
            this.openSuccessModal('Bid submission failed. ',this.successtemplate);
          }
        }
      );
    }
  }
  EditBid(){    
    if(!this.formGroupBidEdit1.invalid){
    this.spinner.show();
    this.bidDetails = new ProposalDetailsVM();
    this.bidDetails.ProposalId = this.proposalIdEdit; 
    this.bidDetails.BidPrice = Number(this.bidPriceEdit);   
    this.bidDetails.BidUnit = Number(this.bidUnitEdit);   
    this.bidDetails.Status = this.proposalIdStatus;
    this.bidDetails.UpdatedBy = Number(sessionStorage.getItem('UserId'));
    this.bidSubscription = this.restServiceBid.UpdateBid(this.bidDetails).subscribe(
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
          this.getBidData();
          this.openSuccessModal('Bid has been submitted succeesfully',this.successtemplate);
        }
      }
    );
  }
  }
  Notify(){    
    if(!this.formGroup.invalid){
      this.spinner.show();
      this.notify.Price =  this.InterestedUnitPrice;
      this.notify.Share = this.InterestedShares;
      this.notify.userId = Number(sessionStorage.getItem('UserId'))
      this.bidSubscription = this.restServiceSale.NotifyPurchaseInterest(this.notify).subscribe(
        data =>
        {      
          this.response = data.body;
          this.formGroup.markAsUntouched();
          this.spinner.hide();        
          this.openSuccessModal('Shareholders were notified about your purchase interest',this.successtemplate)
          
        }
      );
    }
    else{
      this.formGroup.markAllAsTouched();
    }
  }
  confirmDelete(){    
    this.spinner.show();
    this.bidDetails = new ProposalDetailsVM();
    this.bidDetails.ProposalId = this.proposalId; 
    this.bidDetails.UpdatedBy = Number(sessionStorage.getItem('UserId'));
    this.bidSubscription = this.restServiceBid.DeleteBid(this.bidDetails).subscribe(
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
          this.getBidData();
          this.openSuccessModal('Bid removed succesfully.', this.successtemplate);
        }
      }
    )
  }

  cancelBid(){
    if (this.modalRef !== undefined && this.modalRef !== null) {
      this.modalRef.hide();
    }
  }
  cancelBidEdit(){
    if (this.modalRef !== undefined && this.modalRef !== null) {
      this.modalRef.hide();
    }
  }

  declineDelete(): void {
    if (this.modalRef !== undefined && this.modalRef !== null) {
      this.modalRef.hide();
    }
  }
  CloseBidInfo(): void {
    if (this.modalRef !== undefined && this.modalRef !== null) {
      this.modalRef.hide();
      this.bidRejectionReason = '';
    }
  }
  successOkay(){
    
    if (this.modalSuccessRef !== undefined && this.modalSuccessRef !== null) {
      this.modalSuccessRef.hide();
    }    
    if (this.modalRef !== undefined && this.modalRef !== null) {
      this.modalRef.hide();
    }
  }

   isNormalInteger() {
    return (control: AbstractControl): {[key: string]: any} | null => {           
      let num = Number(control.value);
      let n = Number(num) > 0 && Number.isInteger(num);
      return n ?  null :{forbiddenName: {value: false}};
    };
}

isNormalIntegerNotify() {
  return (control: AbstractControl): {[key: string]: any} | null => {           
    let num = Number(control.value);
    let n = Number(num) >= 0 && Number.isInteger(num);
    return n ?  null :{forbiddenName: {value: false}};
  };
}
  bidPriceChangeValidator(): ValidatorFn {
    
    return (control: AbstractControl): {[key: string]: any} | null => {
      const forbidden = Number(control.value) > Number(this.availableShareForValidation);
    
      if(control.value =='' ){
        return {forbiddenName: null};
      }
      else
      return forbidden ? {forbiddenName: {value: false}} : null;
    };
  }
  bidPriceChangeValidator1(): ValidatorFn {
    return (control: AbstractControl): {[key: string]: any} | null => {
      let forbidden ;
      if(this.saleList != undefined)
      {
        const availableShare = this.saleList.filter(x=>x.SaleId == this.saleIdValidation);
        forbidden = Number(control.value) > availableShare[0].AvailableShares;
      }
      else
      {        
        return {forbiddenName: null};
      }
    
      if(control.value =='' ){
        return {forbiddenName: null};
      }
      else
      return forbidden ? {forbiddenName: {value: false}} : null;
    };
  }

  rejectBid(){
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
          this.openSuccessModal('Bid has been rejected',this.successtemplate);
          this.getBidData();
        }
      }
    );
  }
  cancelBidRejection(){
        if (this.modalRef !== undefined && this.modalRef !== null) {
      this.modalRef.hide();
    }

  }

}
