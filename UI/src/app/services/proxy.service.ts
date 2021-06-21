import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders, HttpParams} from '@angular/common/http';
import { map, catchError } from 'rxjs/operators';
import { Observable, of } from 'rxjs';
import { environment } from '../../environments/environment';
import 'rxjs/Rx';

@Injectable({
  providedIn: 'root'
})
export class ProxyService {

  endpoint = environment.APIEndpoint;
  token = 'Bearer '+ sessionStorage.getItem("access_token");


  constructor(private http: HttpClient) { }

  headers = new HttpHeaders({
    'Content-Type': 'application/json',
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET, POST, PATCH, PUT, DELETE, OPTIONS',
    'Access-Control-Allow-Headers': 'Origin, X-Requested-With, Content-Type, Accept'
  });

  getData(reportId, fromDate, toDate) {
    this.headers = new HttpHeaders({'Authorization': this.token, 'Content-Type': 'application/json'  }); 
    let params = new HttpParams().set("reportId",reportId.toString()).set("fromDate",fromDate != null ? fromDate.toString(): "").set("toDate",toDate != null ? toDate.toString(): "");

    return Observable.interval(2000).flatMap(() => {
     return this.http.get<any>(this.getAPI('Get'),{headers: this.headers, params: params}).pipe(
        map(data => data),
        catchError(this.handleError<any>('GetProxyData'))
      );
    });
  }

  private handleError<T>(result?: T) {
    return (error: any): Observable<T> => {
      return of(error.error as T);
    };
  }

  private getAPI(actionName: string): string {
    return this.endpoint + 'Report/' + actionName;
  }

}
