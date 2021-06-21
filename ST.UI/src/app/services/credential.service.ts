import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders, HttpParams} from '@angular/common/http';
import { map, catchError } from 'rxjs/operators';
import { Observable, of } from 'rxjs';
import 'rxjs/add/observable/throw';
import { environment } from '../../environments/environment';
import { UserVM } from '../Models/UserVM';

@Injectable({
  providedIn: 'root'
})
export class CredentialService {

  
  endpoint = environment.APIEndpoint;
  endPointToken = environment.APIEndpointToken;

  constructor(private http: HttpClient) { }  
  
  headers = new HttpHeaders({
    'Content-Type': 'application/json',
    'Access-Control-Allow-Methods': 'GET, POST, PATCH, PUT, DELETE, OPTIONS',
    'Access-Control-Allow-Headers': 'Origin, X-Requested-With, Content-Type, Accept'
  });  

  ValidateUser(userDetail: UserVM, token): Observable<any> {    
    this.headers = new HttpHeaders({'Authorization': token, 'Content-Type': 'application/json'  }); 
    return this.http.post<UserVM>(this.getAPI('Post'), userDetail,
      { headers: this.headers, observe: 'response' }).pipe(
        map(data => data),
        catchError(this.handleError<any>('Error'))
      );
  }
  
  GetToken(userDetail: any): Observable<any> {
    this.headers = new HttpHeaders({'Content-Type': 'application/x-www-form-urlencoded' });  
    let urlSearchParams = new URLSearchParams();
    urlSearchParams.append('UserName', userDetail.UserName);
    urlSearchParams.append('Password', userDetail.Password);
    urlSearchParams.append('grant_type', 'password');
    let body = urlSearchParams.toString();

    return this.http.post(this.endPointToken, body,
      { headers: this.headers, observe: 'response' }).pipe(
        map(data => data),
        catchError(this.handleError<any>('Error'))
      );
  }

  forgotPassword(userDetail: UserVM): Observable<any> {
    return this.http.post<UserVM>(this.getAPIPassword('Post'), userDetail,
      { headers: this.headers, observe: 'response' }).pipe(
        map(data => data),
        catchError(this.handleError<any>('Error'))
      );
  }
  
  private handleError<T>(result?: T) {
    return (error: any): Observable<T> => {
      return of(error.error as T);
    };
  }

  private getAPI(actionName: string): string {
    return this.endpoint + 'Credential/' + actionName;
  }
  
  private getAPIPassword(actionName: string): string {
    return this.endpoint + 'Signup/' + actionName;
  }

}
