import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders, HttpParams} from '@angular/common/http';
import { map, catchError } from 'rxjs/operators';
import { Observable, of } from 'rxjs';
import { environment } from '../../environments/environment';
import { QIDDetailsVM } from '../Models/QIDDetailsVM';

@Injectable({
  providedIn: 'root'
})
export class QidService {

 
  endpoint = environment.APIEndpoint;
  token = 'Bearer '+ sessionStorage.getItem("access_token");

  constructor(private http: HttpClient) { }

  
  headers = new HttpHeaders({
    'Content-Type': 'application/json',
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET, POST, PATCH, PUT, DELETE, OPTIONS',
    'Access-Control-Allow-Headers': 'Origin, X-Requested-With, Content-Type, Accept'
  });  

  GetQIDDetails(QIDDetails: QIDDetailsVM, validateQid){   
    this.headers = new HttpHeaders({'Authorization': this.token, 'Content-Type': 'application/json'  }); 

    let params = new HttpParams().set("qid",QIDDetails.QID.toString()).set("validateQid",validateQid.toString());
    return this.http.get<QIDDetailsVM>(this.getAPI('Get'),{headers: this.headers, params: params}).pipe(
        map(data => data),
        catchError(this.handleError<any>('GetQIDDetails'))
      );
  }  

  AddQIDDetails(QIDDetails: QIDDetailsVM): Observable<any> {
    this.headers = new HttpHeaders({'Authorization': this.token, 'Content-Type': 'application/json'  }); 

    return this.http.post<QIDDetailsVM>(this.getAPI('Post'), QIDDetails,
      { headers: this.headers, observe: 'response' }).pipe(
        map(data => data),
        catchError(this.handleError<any>('AddQIDDetails'))
      );
  }
  
  DeleteQIDDetails(QIDDetails: QIDDetailsVM): Observable<any> {        
    this.headers = new HttpHeaders({'Authorization': this.token, 'Content-Type': 'application/json'  }); 

    let params = new HttpParams().set("qid",QIDDetails.QID.toString());
    return this.http.delete<QIDDetailsVM>(this.getAPI('Delete'),{headers: this.headers, params: params}).pipe(
        map(data => data),
        catchError(this.handleError<any>('DeleteQIDDetails'))
      );
  }

  UpdateQIDDetails(QIDDetails: QIDDetailsVM): Observable<any> {
    this.headers = new HttpHeaders({'Authorization': this.token, 'Content-Type': 'application/json'  }); 
    
    return this.http.post<QIDDetailsVM>(this.getAPI('Post'), QIDDetails,
      { headers: this.headers, observe: 'response' }).pipe(
        map(data => data),
        catchError(this.handleError<any>('UpdateQIDDetails'))
      );
  }


  private handleError<T>(result?: T) {
    return (error: any): Observable<T> => {

      console.error(error); // log to console instead


      return of(result as T);
    };
  }

  private getAPI(actionName: string): string {
    return this.endpoint + 'QID/' + actionName;
  }
}
