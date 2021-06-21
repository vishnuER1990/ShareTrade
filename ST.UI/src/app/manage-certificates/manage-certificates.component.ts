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

import { CertificateService } from '../services/certificate.service';
import { UserService } from '../services/user.service';
import { UserVM } from '../Models/UserVM';
import { CertificatesVM } from '../Models/CertificatesVM';


@Component({
  selector: 'app-manage-certificates',
  templateUrl: './manage-certificates.component.html',
  styleUrls: ['./manage-certificates.component.css']
})
export class ManageCertificatesComponent implements OnInit {
  userId: number;
  shareholderNgModel: string;
  selectedUserId: string
  private isUploadBtn: boolean = true;  
  certificateSubscription: Subscription;
  userSubscription: Subscription;
  filteredOptions: Observable<any[]>;
  userDetails: UserVM;  
  userList: UserVM[];
  certificateList: CertificatesVM[];

  dataSource: MatTableDataSource < any >;  
  displayedColumns: string[] = [];
  
  formGroup: FormGroup;
  myControl = new FormControl('', [ Validators.required]);
  @ViewChild('shareholderSearch') shareholderSearch;  
  @ViewChild(MatPaginator, {static: true}) paginator: MatPaginator; 

  constructor(private restServiceCertificate: CertificateService, private restServiceUser: UserService,
    private modalService: BsModalService, private spinner: NgxSpinnerService) {

      this.formGroup = new FormGroup({  });
      
      this.formGroup.addControl('myControl',this.myControl);

     }

  ngOnInit(): void {
    this.userList =[];
    this.certificateList =[];
    this.userId = Number(sessionStorage.getItem('UserId')); 
    this.getUserData(0);
  }

  getUserData(userId: number){    
    this.userDetails = new UserVM();
    this.userDetails.UserId = 0;
    this.userSubscription = this.restServiceUser.GetUser(this.userDetails).subscribe(
      data =>
      {  
        this.userList = data;
        this.userList.forEach((element) => {
          element.CreatedDt =new Date(element.CreatedDt)
        });

        this.filteredOptions = this.myControl.valueChanges
        .pipe(
          startWith(''),
          map(value => typeof value === 'string' ? value : value.Full_Name),
          map(details => details ? this.filter(details.toString()) : this.userList.slice())
        ); 
        this.getCertificateLits();
      }
    );
  }
  filter(Input: string) {
    debugger;
    return this.userList.filter(qid =>
      qid.Full_Name.toString().toLowerCase().indexOf(Input.toLowerCase()) === 0);
  }

  getCertificateLits(){
    this.certificateSubscription = this.restServiceCertificate.GetFiles(this.userId).subscribe(
      data =>
      {        
        if(data.length !=0)  {
          this.certificateList = data;
          this.certificateList.forEach((element) => {
            element.UploadedDt =new Date(element.UploadedDt)
          });
      }
        this.initialize();
      }
    );
  }

  
  initialize(){
    this.displayedColumns = ['UserFullName','Path','UploadedDt', 'Actions'];
    this.dataSource = new MatTableDataSource(this.certificateList);
    this.dataSource.paginator = this.paginator;
    this.spinner.hide();
  }

  onshareholderSelectionChange(event){
    this.selectedUserId = '';
    this.selectedUserId = event.option.value.UserId;
    }

  fileChange(event) {  
    debugger;  
    let fileList: FileList = event.target.files;  
    if (fileList.length > 0) {  
    let file: File = fileList[0];  
    let formData: FormData = new FormData();  
    formData.append('uploadFile', file, file.name);  
    formData.append('userId', this.selectedUserId.toString());  
      this.certificateSubscription = this.restServiceCertificate.UploadFile(formData).subscribe(
        data =>
        {          
          this.getCertificateLits();
        }
      );
    }
    
  }
  
  displayFn(user: UserVM): string {
    return user && user.Full_Name ? user.Full_Name : '';
  }

}
