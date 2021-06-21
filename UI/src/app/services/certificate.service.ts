import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders, HttpParams} from '@angular/common/http';
import { map, catchError } from 'rxjs/operators';
import { Observable, of } from 'rxjs';
import { environment } from '../../environments/environment';
import { CertificatesVM } from '../Models/CertificatesVM';

@Injectable({
  providedIn: 'root'
})
export class CertificateService {

 
  endpoint = environment.APIEndpoint;
  token = 'Bearer '+ sessionStorage.getItem("access_token");

  constructor(private http: HttpClient) { }

  headers = new HttpHeaders({
    'Content-Type': 'application/json',
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET, POST, PATCH, PUT, DELETE, OPTIONS',
    'Access-Control-Allow-Headers': 'Origin, X-Requested-With, Content-Type, Accept'
  });  

  UploadFile(formData): Observable<any> {

    this.headers = new HttpHeaders({'Authorization': this.token, 'Accept': "multipart/form-data"  }); 

    return this.http.post<any>(this.getAPI('Post'),formData,
      { headers: this.headers, observe: 'response' }).pipe(
        map(data => data),
        catchError(this.handleError<any>('UploadFile'))
      );
  }

  GetFiles(userId){   
    this.headers = new HttpHeaders({'Authorization': this.token, 'Content-Type': 'application/json'  }); 

    let params = new HttpParams().set("userId",userId.toString());
    return this.http.get<CertificatesVM>(this.getAPI('Get'),{headers: this.headers, params: params}).pipe(
        map(data => data),
        catchError(this.handleError<any>('GetFiles'))
      );
  }  
  
  
  private handleError<T>(result?: T) {
    return (error: any): Observable<T> => {

      console.error(error); // log to console instead


      return of(result as T);
    };
  }

  private getAPI(actionName: string): string {
    return this.endpoint + 'ManageCertificates/' + actionName;
  }
}
