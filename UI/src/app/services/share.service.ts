import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders, HttpParams} from '@angular/common/http';
import { map, catchError } from 'rxjs/operators';
import { Observable, of } from 'rxjs';
import { environment } from '../../environments/environment';
import { ShareDetailsVM } from '../Models/ShareDetailsVM';


@Injectable({
  providedIn: 'root'
})
export class ShareService {


  endpoint = environment.APIEndpoint;
  token = 'Bearer '+ sessionStorage.getItem("access_token");

  constructor(private http: HttpClient) { }

  
  headers = new HttpHeaders({
    'Content-Type': 'application/json',
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET, POST, PATCH, PUT, DELETE, OPTIONS',
    'Access-Control-Allow-Headers': 'Origin, X-Requested-With, Content-Type, Accept'
  });  

  GetShareData(shareDetail: ShareDetailsVM){   
    this.headers = new HttpHeaders({'Authorization': this.token, 'Content-Type': 'application/json'  }); 

    let params = new HttpParams().set("shareDetailsId",shareDetail.ShareDetailsId.toString()).set("CreatedBy",shareDetail.CreatedBy.toString());
    return this.http.get<ShareDetailsVM>(this.getAPI('Get'),{headers: this.headers, params: params}).pipe(
        map(data => data),
        catchError(this.handleError<any>('ShareDetails'))
      );
  }  

  AddNewShare(shareDetail: ShareDetailsVM): Observable<any> {
    this.headers = new HttpHeaders({'Authorization': this.token, 'Content-Type': 'application/json'  }); 

    return this.http.post<ShareDetailsVM>(this.getAPI('Post'), shareDetail,
      { headers: this.headers, observe: 'response' }).pipe(
        map(data => data),
        catchError(this.handleError<any>('AddNewShare'))
      );
  }
  
  DeleteShare(shareDetail: ShareDetailsVM): Observable<any> {        
    this.headers = new HttpHeaders({'Authorization': this.token, 'Content-Type': 'application/json'  }); 

    let params = new HttpParams().set("shareDetailsId",shareDetail.ShareDetailsId.toString()).set("deletedBy",shareDetail.UpdatedBy.toString());
    return this.http.delete<ShareDetailsVM>(this.getAPI('Delete'),{headers: this.headers, params: params}).pipe(
        map(data => data),
        catchError(this.handleError<any>('DeleteShare'))
      );
  }

  UpdateShare(shareDetail: ShareDetailsVM): Observable<any> {
    this.headers = new HttpHeaders({'Authorization': this.token, 'Content-Type': 'application/json'  }); 
    
    return this.http.post<ShareDetailsVM>(this.getAPI('Post'), shareDetail,
      { headers: this.headers, observe: 'response' }).pipe(
        map(data => data),
        catchError(this.handleError<any>('UpdateShare'))
      );
  }

  private handleError<T>(result?: T) {
    return (error: any): Observable<T> => {
      return of(error.error as T);
    };
  }

  private getAPI(actionName: string): string {
    return this.endpoint + 'ShareDetails/' + actionName;
  }
}
