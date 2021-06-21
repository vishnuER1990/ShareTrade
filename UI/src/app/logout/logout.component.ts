import { Component, OnInit, Input, ViewChild, TemplateRef } from '@angular/core';
import { Subscription } from 'rxjs';
import { MatPaginator } from '@angular/material/paginator';
import { MatTableDataSource } from '@angular/material/table';
import { Observable,  } from 'rxjs';
import { map, startWith } from 'rxjs/operators';
import {FormControl, FormGroup, Validators, ValidatorFn, AbstractControl} from '@angular/forms';
import { ModalOptions, BsModalRef, BsModalService } from 'ngx-bootstrap/modal';
import { NgxSpinnerService } from "ngx-spinner";
import { Router } from '@angular/router';

@Component({
  selector: 'app-logout',
  templateUrl: './logout.component.html',
  styleUrls: ['./logout.component.css']
})
export class LogoutComponent implements OnInit {

  modalOption: ModalOptions = {};
  modalRef: BsModalRef;
  @ViewChild('LogoutTemplate') logoutTemplate: any;   
  constructor(private router: Router, private modalService: BsModalService, private spinner: NgxSpinnerService) { 

  }

  ngOnInit(): void {
    this.logout();
  }

  logout(){
    this.spinner.show();  
    sessionStorage.clear();  
    localStorage.clear();    
    setTimeout(() => {
      this.router.navigate(['Login']);
    }, 1100);
  }


}
