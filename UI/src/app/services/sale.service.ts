import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders, HttpParams} from '@angular/common/http';
import { map, catchError } from 'rxjs/operators';
import { Observable, of } from 'rxjs';
import { environment } from '../../environments/environment';
import { SaleDetailsVM } from '../Models/SaleDetailsVM';
import { NotifyVM } from '../Models/NotifyVM';

@Injectable({
  providedIn: 'root'
})
export class SaleService {


  endpoint = environment.APIEndpoint;
  token = 'Bearer '+ sessionStorage.getItem("access_token");

  constructor(private http: HttpClient) { }
  
  headers = new HttpHeaders({
    'Content-Type': 'application/json',
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET, POST, PATCH, PUT, DELETE, OPTIONS',
    'Access-Control-Allow-Headers': 'Origin, X-Requested-With, Content-Type, Accept'
  });

  GetSaleData(saleDetail: SaleDetailsVM,fullList: boolean = false){   
    this.headers = new HttpHeaders({'Authorization': this.token, 'Content-Type': 'application/json'  }); 
    
    let params = new HttpParams().set("saleId",saleDetail.SaleId.toString()).set("fullList",fullList.toString()).set("createdBy",saleDetail.CreatedBy.toString());

    return this.http.get<SaleDetailsVM>(this.getAPI('Get'),{headers: this.headers, params: params}).pipe(
        map(data => data),
        catchError(this.handleError<any>('GetSaleData'))
      );
  }

  AddNewSale(saleDetail: SaleDetailsVM): Observable<any> {
    this.headers = new HttpHeaders({'Authorization': this.token, 'Content-Type': 'application/json'  }); 

    return this.http.post<SaleDetailsVM>(this.getAPI('Post'), saleDetail,
      { headers: this.headers, observe: 'response' }).pipe(
        map(data => data),
        catchError(this.handleError<any>('AddNewSale'))
      );
  }

  DeleteSale(saleDetail: SaleDetailsVM): Observable<any> {    
    this.headers = new HttpHeaders({'Authorization': this.token, 'Content-Type': 'application/json'  }); 
    
    let params = new HttpParams().set("saleId",saleDetail.SaleId.toString()).set("deletedBy",saleDetail.UpdatedBy.toString());

    return this.http.delete<SaleDetailsVM>(this.getAPI('Delete'),{headers: this.headers, params: params}).pipe(
        map(data => data),
        catchError(this.handleError<any>('DeleteSale'))
      );
  }

  UpdateSale(saleDetail: SaleDetailsVM): Observable<any> {
    this.headers = new HttpHeaders({'Authorization': this.token, 'Content-Type': 'application/json'  }); 
    
    return this.http.post<SaleDetailsVM>(this.getAPI('Post'), saleDetail,
      { headers: this.headers, observe: 'response' }).pipe(
        map(data => data),
        catchError(this.handleError<any>('AddNewSale'))
      );
  }

  NotifyPurchaseInterest(notify: NotifyVM ): Observable<any> {
    this.headers = new HttpHeaders({'Authorization': this.token, 'Content-Type': 'application/json'  }); 
    return this.http.post<any>(this.getAPI_Notify('Post'), notify,
      { headers: this.headers, observe: 'response' }).pipe(
        map(data => data),
        catchError(this.handleError<any>('NotifyPurchaseInterest'))
      );
  }
  
  private handleError<T>(result?: T) {
    return (error: any): Observable<T> => {
      return of(error.error as T);
    };
  }

  private getAPI(actionName: string): string {
    return this.endpoint + 'SaleDetails/' + actionName;
  }

    private getAPI_Notify(actionName: string): string {
    return this.endpoint + 'Notification/' + actionName;
  }

}
