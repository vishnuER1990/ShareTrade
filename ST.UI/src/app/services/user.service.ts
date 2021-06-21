import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders, HttpParams} from '@angular/common/http';
import { map, catchError } from 'rxjs/operators';
import { Observable, of } from 'rxjs';
import { environment } from '../../environments/environment';
import { UserVM } from '../Models/UserVM';

@Injectable({
  providedIn: 'root'
})
export class UserService {

  
  endpoint = environment.APIEndpoint;
  token = 'Bearer '+ sessionStorage.getItem("access_token");

  constructor(private http: HttpClient) { }

  
  headers = new HttpHeaders({
    'Content-Type': 'application/json',
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET, POST, PATCH, PUT, DELETE, OPTIONS',
    'Access-Control-Allow-Headers': 'Origin, X-Requested-With, Content-Type, Accept'
  });  

  GetUser(userDetail: UserVM){   
    this.headers = new HttpHeaders({'Authorization': this.token, 'Content-Type': 'application/json'  }); 

    let params = new HttpParams().set("userId",userDetail.UserId.toString());
    return this.http.get<UserVM>(this.getAPI('Get'),{headers: this.headers, params: params}).pipe(
        map(data => data),
        catchError(this.handleError<any>('GetUser'))
      );
  }  

  AddNewUser(userDetail: UserVM): Observable<any> {
    return this.http.post<UserVM>(this.getAPI('Post'), userDetail,
      { headers: this.headers, observe: 'response' }).pipe(
        map(data => data),
        catchError(this.handleError<any>('AddNewUser'))
      );
  }
  
  DeleteUser(userDetail: UserVM): Observable<any> {        
    this.headers = new HttpHeaders({'Authorization': this.token, 'Content-Type': 'application/json'  }); 

    let params = new HttpParams().set("userId",userDetail.UserId.toString());
    return this.http.delete<UserVM>(this.getAPI('Delete'),{headers: this.headers, params: params}).pipe(
        map(data => data),
        catchError(this.handleError<any>('DeleteUser'))
      );
  }

  UpdateUser(userDetail: UserVM): Observable<any> {
    this.headers = new HttpHeaders({'Authorization': this.token, 'Content-Type': 'application/json'  }); 

    return this.http.post<UserVM>(this.getAPI('Post'), userDetail,
      { headers: this.headers, observe: 'response' }).pipe(
        map(data => data),
        catchError(this.handleError<any>('UpdateUser'))
      );
  }

  Logout(): Observable<any> {
    this.headers = new HttpHeaders({'Authorization': this.token, 'Content-Type': 'application/json'  }); 
    return this.http.post<any>(this.getAPILogout('Post'),
      { headers: this.headers, observe: 'response' }).pipe(
        map(data => data),
        catchError(this.handleError<any>('Logout'))
      );
  }


  private handleError<T>(result?: T) {
    return (error: any): Observable<T> => {

      console.error(error.error); // log to console instead


      return of(result as T);
    };
  }

  private getAPI(actionName: string): string {
    return this.endpoint + 'UserDetails/' + actionName;
  }
  private getAPILogout(actionName: string): string {
    return this.endpoint + 'Logout/' + actionName;
  }
}
