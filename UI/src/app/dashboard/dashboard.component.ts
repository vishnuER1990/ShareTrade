import { Component, OnInit, Input, ViewChild, TemplateRef, ViewChildren, QueryList } from '@angular/core';
import { CommonModule } from '@angular/common';  
import { BrowserModule } from '@angular/platform-browser';
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
import { SummaryService } from '../services/summary.service';
import { SummaryBidsReceivedVM } from '../Models/SummaryBidsReceivedVM';
import { SummaryBidsSubmittedVM } from '../Models/SummaryBidsSubmittedVM';
import { SummaryNotifications } from '../Models/SummaryNotifications';
import { SummaryVM } from '../Models/SummaryVM';
import * as Chartist from 'chartist';

@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.css']
})
export class DashboardComponent implements OnInit {

  @ViewChild(MatPaginator, {static: true}) paginator: MatPaginator; 
  @ViewChildren(MatPaginator) paginatorNew = new QueryList<MatPaginator>();

  summarySubscription: Subscription;
  bidSubscription: Subscription;

  IsAdmin: boolean = false;
  userId: number =0
  AvailableShares: number;
  QID: number;
  SaleRegisteredForSale: number;
  
  summaryDetails: SummaryVM;

  bidSubmittedList: SummaryBidsSubmittedVM[]; 
  bidReceivedList: SummaryBidsReceivedVM[]; 
  notificationsList: SummaryNotifications[]; 

  displayedColumnsSubmittedBids: string[] = [];
  displayedColumnsReceivedBids: string[] = [];
  displayedColumnsNotifications: string[] = [];
  filteredOptions: Observable<any[]>;
  filteredOptionsBid: Observable<any[]>;
  filteredOptionsNotifications: Observable<any[]>;

  dataSourceNotifications: MatTableDataSource < SummaryNotifications > =  new MatTableDataSource < SummaryNotifications >();
  dataSourceReceivedBids: MatTableDataSource < SummaryBidsReceivedVM > = new MatTableDataSource < SummaryBidsReceivedVM >();
  dataSourceSubmittedBids: MatTableDataSource < SummaryBidsSubmittedVM >  = new MatTableDataSource < SummaryBidsSubmittedVM >();

  constructor(private restServiceSale: SaleService, private modalService: BsModalService, 
    private spinner: NgxSpinnerService, private restServiceBid: BidService, private restServiceSummary: SummaryService) { }
 
  
  ngOnInit() {
    debugger;
    this.bidSubmittedList  = [];
    this.bidReceivedList  = [];
    this.userId = Number(sessionStorage.getItem('UserId'));

    this.IsAdmin =  sessionStorage.getItem("Role") == 'Admin';

     if(!this.IsAdmin){
       this.GetSummary();
     }
  }

  GetSummary(){
    debugger;
    this.spinner.show();
    this.summarySubscription = this.restServiceSummary.GetSummary(this.userId, false, false, false).subscribe(
      data =>
      {      
        if(data != null){
          this.AvailableShares = data.AvailableShares;
          this.QID = data.QID;
          this.SaleRegisteredForSale = data.SaleRegisteredForSale;
        }
        this.GetSubmittedBids();
      }      
    );
  }
  
  GetSubmittedBids(){
    debugger;
    this.summarySubscription = this.restServiceSummary.GetSummary(this.userId, true, false, false).subscribe(
      data =>
      {      
        this.bidSubmittedList = data;
        this.initializeSubmittedBids(); 
        this.GetReceivedBids();
      }
    );
  }

  GetReceivedBids(){
    debugger;
    this.summarySubscription = this.restServiceSummary.GetSummary(this.userId, false, true, false).subscribe(
      data =>
      {      
        this.bidReceivedList = data;
        this.initializeBidReceivedBids();
        this.GetNotification();
      }
    );
  }

  GetNotification(){
    debugger;
    this.summarySubscription = this.restServiceSummary.GetSummary(this.userId, false, false, true).subscribe(
      data =>
      {      
        this.notificationsList = data;
        this.notificationsList.forEach((element) => {
          element.Createdate =new Date(element.Createdate)
        });
        this.initializeNotification();
      }
    );
  }

  initializeSubmittedBids(){
    this.displayedColumnsSubmittedBids = ['ShareholderName', 'BidPrice','BidStatus'];
    this.dataSourceSubmittedBids = new MatTableDataSource(this.bidSubmittedList);
    this.dataSourceSubmittedBids.paginator = this.paginatorNew.toArray()[2];
  }

  initializeBidReceivedBids(){
    this.displayedColumnsReceivedBids = ['BidderName', 'BidPrice', 'BidderContactNumber'];
    this.dataSourceReceivedBids = new MatTableDataSource(this.bidReceivedList);
    this.dataSourceReceivedBids.paginator = this.paginatorNew.toArray()[1];
    this.spinner.hide();
  }

  initializeNotification(){
    this.displayedColumnsNotifications = ['NotificationText'];
    this.dataSourceNotifications = new MatTableDataSource(this.notificationsList);
    this.dataSourceNotifications.paginator = this.paginatorNew.toArray()[0];;
    this.spinner.hide();
  }



}
