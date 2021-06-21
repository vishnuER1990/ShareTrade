import {
  Component,
  OnInit
} from '@angular/core';
import {
  FormControl,
  FormGroup,
  Validators
} from '@angular/forms';

import { ProxyService } from '../services/proxy.service';
import { ReportService } from '../services/report.service';
import { QuorumVM } from '../Models/QuorumVM';
import { Subscription } from 'rxjs';



@Component({
  selector: 'app-proxy',
  templateUrl: './proxy.component.html',
  styleUrls: ['./proxy.component.css']
})
export class ProxyComponent implements OnInit {

  personallyAttended: number = 0;
  personallyAttendedTitle: number = 0;
  providedProxy: number = 0;
  providedProxyTitle: number = 0;
  totalAttendance: number = 0;
  totalAttendanceTitle: number = 0;
  totalQuorum: number = 0;
  totalQuorumTitle: number = 0;
  personallyReportedAttendees: number = 0;
  MaximumAttendees: number = 347;
  shareIdArray: string[] = [];
  proxyArray: string[] = [];
  personallyReportedArray: string[] = [];
  formGroup: FormGroup;
  ShareholderID: string;
  proxyChecked = false;
  dataSubscription: Subscription;
  quorum: QuorumVM[];
  quorumObj: QuorumVM;

  constructor(private restService: ProxyService,private restServiceShareData: ReportService) {
    this.formGroup = new FormGroup({
      ShareholderIDFormControl: new FormControl('', [Validators.required]),
      ProxyCheckedFormControl: new FormControl(),
    });
    
  }

  ngOnInit(): void {
    this.quorumObj = new QuorumVM();
    this.quorum =[];
    this.getProxyReport();
    this.personallyAttendedTitle = 0;
    this.providedProxyTitle = 0;
    this.totalAttendanceTitle = 0;
    this.totalQuorumTitle = 0;
    this.personallyReportedAttendees = 0;
    // this.calculatePersonallyAttended();
    // this.calculateProvidedProxy();
    // this.calculateTotalAttendance();
    // this.calculateQuorum();
  }

  calculatePersonallyAttended() {
    this.personallyAttended = this.personallyAttendedTitle / this.MaximumAttendees * 100;
  }

  calculateProvidedProxy() {
    this.providedProxy = this.providedProxyTitle / this.MaximumAttendees * 100;
  }

  calculateTotalAttendance() {
    this.totalAttendance = this.totalAttendanceTitle / this.MaximumAttendees * 100;
  }

  calculateQuorum() {
    //this.totalQuorum = this.totalQuorumTitle / this.MaximumAttendees * 100;
    this.totalQuorum = this.totalQuorumTitle;
  }
  Add() {
    if (this.formGroup.valid) {

      this.shareIdArray.push(this.ShareholderID);

      if (this.proxyChecked) {
        this.proxyArray.push(this.ShareholderID);
      } else {
        this.personallyReportedArray.push(this.ShareholderID);
      }
      this.CalculateAll();
    }
  }
  CalculateAll() {
    this.personallyAttendedTitle = this.personallyReportedArray.length;
    this.providedProxyTitle = this.proxyArray.length;
    this.totalAttendanceTitle = this.shareIdArray.length;
    this.totalQuorumTitle = this.shareIdArray.length;

    this.calculatePersonallyAttended();
    this.calculateProvidedProxy();
    this.calculateTotalAttendance();
    this.calculateQuorum();
  }

  getProxyReport(){
    this.dataSubscription = this.restService.getData(3,null,null).subscribe(
      data =>
      {      
        this.personallyAttendedTitle = data[0].PersonallyAttended
        this.providedProxyTitle = data[0].ProvidedProxy
        this.totalAttendanceTitle = data[0].TotalAttendance
        this.totalQuorumTitle = data[0].Quorum

        this.calculatePersonallyAttended();
        this.calculateProvidedProxy();
        this.calculateTotalAttendance();
        this.calculateQuorum()

      }
    );
  }

  getShareholderData(){
    this.dataSubscription = this.restServiceShareData.GetSharHolderData(1).subscribe(
      data =>
      {     
        this.quorumObj.Datetime = new Date();
        this.quorumObj.personallyAttendedTitle = this.personallyAttendedTitle;
        this.quorumObj.providedProxyTitle  = this.providedProxyTitle;
        this.quorumObj.totalAttendanceTitle = this.totalAttendanceTitle;
        this.quorumObj.totalQuorumTitle = Math.ceil(Number(this.totalQuorumTitle)).toString() +"%";
        this.quorumObj.TotalNumberofShares = data[0].TotalNumberofShares;
        this.quorumObj.TotalSharesValue = data[0].TotalSharesValue;
        this.quorum.push(this.quorumObj);
        this.restServiceShareData.exportAsExcelFile( this.quorum, 'Quorum_Report_');  
      }
    );
  }

}