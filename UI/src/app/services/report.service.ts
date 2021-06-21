import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders, HttpParams} from '@angular/common/http';
import { map, catchError } from 'rxjs/operators';
import { Observable, of } from 'rxjs';
import { environment } from '../../environments/environment';
import { PurchaseReportVM } from '../Models/PurchaseReportVM';
import { SaleReportVM } from '../Models/SaleReportVM';
import * as FileSaver from 'file-saver';  
import * as XLSX from 'xlsx'; 
const EXCEL_TYPE = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;charset=UTF-8';  
const EXCEL_EXTENSION = '.xlsx'; 

@Injectable({
  providedIn: 'root'
})
export class ReportService {
  endpoint = environment.APIEndpoint;
  token = 'Bearer '+ sessionStorage.getItem("access_token");

  constructor(private http: HttpClient) { }
  
  headers = new HttpHeaders({
    'Content-Type': 'application/json',
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET, POST, PATCH, PUT, DELETE, OPTIONS',
    'Access-Control-Allow-Headers': 'Origin, X-Requested-With, Content-Type, Accept'
  });

  GetReport(reportId, fromDate, toDate){   
    this.headers = new HttpHeaders({'Authorization': this.token, 'Content-Type': 'application/json'  }); 
    let params = new HttpParams().set("reportId",reportId.toString()).set("fromDate",fromDate != null ? fromDate.toString(): "").set("toDate",toDate != null ? toDate.toString(): "");

    return this.http.get<SaleReportVM>(this.getAPI('Get'),{headers: this.headers, params: params}).pipe(
        map(data => data),
        catchError(this.handleError<any>('GetSaleData'))
      );
  }

  GetSharHolderData(id){   
    this.headers = new HttpHeaders({'Authorization': this.token, 'Content-Type': 'application/json'  }); 
    let params = new HttpParams().set("id",id.toString());

    return this.http.get<SaleReportVM>(this.getAPI1('Get'),{headers: this.headers, params: params}).pipe(
        map(data => data),
        catchError(this.handleError<any>('GetSharHolderData'))
      );
  }

  public exportAsExcelFile(json: any[], excelFileName: string): void {  
    const worksheet: XLSX.WorkSheet = XLSX.utils.json_to_sheet(json);  
    const workbook: XLSX.WorkBook = { Sheets: { 'data': worksheet }, SheetNames: ['data'] };  
    const excelBuffer: any = XLSX.write(workbook, { bookType: 'xlsx', type: 'array' });  
    this.saveAsExcelFile(excelBuffer, excelFileName);  
  }  
  private saveAsExcelFile(buffer: any, fileName: string): void {  
     const data: Blob = new Blob([buffer], {type: EXCEL_TYPE});  
     FileSaver.saveAs(data, fileName + '_Export_' + new  Date().getTime() + EXCEL_EXTENSION);  
  }  

  private handleError<T>(result?: T) {
    return (error: any): Observable<T> => {
      return of(error.error as T);
    };
  }

  private getAPI(actionName: string): string {
    return this.endpoint + 'Report/' + actionName;
  }
  private getAPI1(actionName: string): string {
    return this.endpoint + 'ShareHolderData/' + actionName;
  }
}
