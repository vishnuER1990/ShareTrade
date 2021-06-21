import { Component, OnInit, Input, ViewChild,ViewChildren, TemplateRef, QueryList  } from '@angular/core';
import { Subscription } from 'rxjs';
import { MatPaginator } from '@angular/material/paginator';
import { MatTableDataSource } from '@angular/material/table';
import { Observable,  } from 'rxjs';
import { map, startWith } from 'rxjs/operators';
import {FormControl, FormGroup, Validators, AbstractControl, ValidatorFn} from '@angular/forms';
import { ModalOptions, BsModalRef, BsModalService } from 'ngx-bootstrap/modal';
import { NgxSpinnerService } from "ngx-spinner";
import { DatePipe } from '@angular/common';


import { ReportService } from '../services/report.service';
import { PurchaseReportVM } from '../Models/PurchaseReportVM';
import { SaleReportVM } from '../Models/SaleReportVM';
import { UserVM } from '../Models/UserVM';
import { UserReportVM } from '../Models/UserReportVM';

@Component({
  selector: 'app-report',
  templateUrl: './report.component.html',
  styleUrls: ['./report.component.css'],
   providers: [
    DatePipe
  ]
})
export class ReportComponent implements OnInit {

  
  dataSubscription: Subscription;
  purchasReport: PurchaseReportVM[];
  saleReport: SaleReportVM[];
  userList: UserVM[];
  userReport: UserReportVM[];
  userListFromDate: Date;
  userListToDate: Date;
  saleListFromDate: Date;
  saleListToDate: Date;
  PurchaseListFromDate: Date;
  PurchaseListToDate: Date;

  constructor(private restService: ReportService, 
    private modalService: BsModalService, private spinner: NgxSpinnerService, private datePipe: DatePipe) { }

  ngOnInit(): void {
    this.purchasReport = [];
    this.saleReport = [];
    this.userList = [];
    this.userReport = [];
  }

  getUsers(){
    this.dataSubscription = this.restService.GetReport(1,this.datePipe.transform(this.userListFromDate,'dd/MM/yyyy'),this.datePipe.transform(this.userListToDate,'dd/MM/yyyy')).subscribe(
      data =>
      {      
        
        this.userReport = data;
        this.userReport.forEach((element) => {
          element.RegisteredDate =new Date(element.RegisteredDate)
        });
        
        this.restService.exportAsExcelFile( this.userReport, 'Report_UserList_');  
      }
    );
  }


  getSaleReport(){
    this.dataSubscription = this.restService.GetReport(2,this.datePipe.transform(this.saleListFromDate,'dd/MM/yyyy'),this.datePipe.transform(this.saleListToDate,'dd/MM/yyyy')).subscribe(
      data =>
      {      
        
        this.saleReport = data;
        this.saleReport.forEach((element) => {
          element.SaleCreatedDate =new Date(element.SaleCreatedDate)
        });
        this.restService.exportAsExcelFile( this.saleReport, 'Report_SaleList_');  
      }
    );
  }

  getPurchaseReport(){
    this.dataSubscription = this.restService.GetReport(3,this.datePipe.transform(this.PurchaseListFromDate,'dd/MM/yyyy'),this.datePipe.transform(this.PurchaseListToDate,'dd/MM/yyyy')).subscribe(
      data =>
      {      
        
        this.purchasReport = data;
        this.purchasReport.forEach((element) => {
          element.BidCreatedDate =new Date(element.BidCreatedDate)
        });
        this.restService.exportAsExcelFile( this.purchasReport, 'Report_PurchaseList_');  
      }
    );
  }

  getShareholderList(){
    this.dataSubscription = this.restService.GetSharHolderData(0).subscribe(
      data =>
      {     
        
        this.restService.exportAsExcelFile( data, 'Report_ShareHolderList_');  
      }
    );
  }

 
}
