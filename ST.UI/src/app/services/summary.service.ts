import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders, HttpParams} from '@angular/common/http';
import { map, catchError } from 'rxjs/operators';
import { Observable, of } from 'rxjs';
import { environment } from '../../environments/environment';
import { SummaryVM } from '../Models/SummaryVM';

@Injectable({
  providedIn: 'root'
})
export class SummaryService {

  endpoint = environment.APIEndpoint;
  token = 'Bearer '+ sessionStorage.getItem("access_token");

  constructor(private http: HttpClient) { }
  
  headers = new HttpHeaders({
    'Content-Type': 'application/json',
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET, POST, PATCH, PUT, DELETE, OPTIONS',
    'Access-Control-Allow-Headers': 'Origin, X-Requested-With, Content-Type, Accept'
  });

  GetSummary(userId, bidSubmitted, bidReceived, notifications){   
    this.headers = new HttpHeaders({'Authorization': this.token, 'Content-Type': 'application/json'  }); 
    
    let params = new HttpParams().set("userId",userId.toString()).set("bidSubmitted",bidSubmitted.toString()).set("bidReceived",bidReceived.toString()).set("notifications",notifications.toString());

    return this.http.get<SummaryVM>(this.getAPI('Get'),{headers: this.headers, params: params}).pipe(
        map(data => data),
        catchError(this.handleError<any>('GetSummary'))
      );
  }

  private handleError<T>(result?: T) {
    return (error: any): Observable<T> => {

      console.error(error); // log to console instea

      return of(result as T);
    };
  }

  private getAPI(actionName: string): string {
    return this.endpoint + 'Summary/' + actionName;
  }
}
