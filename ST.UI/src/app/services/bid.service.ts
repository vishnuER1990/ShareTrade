import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders, HttpParams} from '@angular/common/http';
import { map, catchError } from 'rxjs/operators';
import { Observable, of } from 'rxjs';
import { environment } from '../../environments/environment';
import { ProposalDetailsVM } from '../Models/ProposalDetailsVM';

@Injectable({
  providedIn: 'root'
})
export class BidService { 

  endpoint = environment.APIEndpoint;
  token = 'Bearer '+ sessionStorage.getItem("access_token");

  constructor(private http: HttpClient) { }
  
  headers = new HttpHeaders({
    'Content-Type': 'application/json',
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET, POST, PATCH, PUT, DELETE, OPTIONS',
    'Access-Control-Allow-Headers': 'Origin, X-Requested-With, Content-Type, Accept'
  });

  GetBidDataForSale(proposalDetail: ProposalDetailsVM){   
    this.headers = new HttpHeaders({'Authorization': this.token, 'Content-Type': 'application/json'  }); 
    
    let params = new HttpParams().set("saleId",proposalDetail.SaleId.toString()).set("proposalId",proposalDetail.ProposalId.toString()).set("createdBy",proposalDetail.CreatedBy.toString());

    return this.http.get<ProposalDetailsVM>(this.getAPI('Get'),{headers: this.headers, params: params}).pipe(
        map(data => data),
        catchError(this.handleError<any>('Error'))
      );
  }

  AddNewBid(proposalDetail: ProposalDetailsVM): Observable<any> {
    this.headers = new HttpHeaders({'Authorization': this.token, 'Content-Type': 'application/json'  }); 

    return this.http.post<ProposalDetailsVM>(this.getAPI('Post'), proposalDetail,
      { headers: this.headers, observe: 'response' }).pipe(
        map(data => data),
        catchError(this.handleError<any>('Error'))
      );
  }

  UpdateSale(proposalDetail: ProposalDetailsVM): Observable<any> {
    this.headers = new HttpHeaders({'Authorization': this.token, 'Content-Type': 'application/json'  }); 

    return this.http.post<ProposalDetailsVM>(this.getAPI('Post'), proposalDetail,
      { headers: this.headers, observe: 'response' }).pipe(
        map(data => data),
        catchError(this.handleError<any>('Error'))
      );
  }

  UpdateBid(proposalDetail: ProposalDetailsVM): Observable<any> {
    this.headers = new HttpHeaders({'Authorization': this.token, 'Content-Type': 'application/json'  }); 

    return this.http.post<ProposalDetailsVM>(this.getAPI('Post'), proposalDetail,
      { headers: this.headers, observe: 'response' }).pipe(
        map(data => data),
        catchError(this.handleError<any>('Error'))
      );
  }  
  
  DeleteBid(proposalDetail: ProposalDetailsVM): Observable<any> {        
    this.headers = new HttpHeaders({'Authorization': this.token, 'Content-Type': 'application/json'  }); 

    let params = new HttpParams().set("proposalId",proposalDetail.ProposalId.toString()).set("deletedBy",proposalDetail.UpdatedBy.toString());
    return this.http.delete<ProposalDetailsVM>(this.getAPI('Delete'),{headers: this.headers, params: params}).pipe(
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
    return this.endpoint + 'ProposalDetails/' + actionName;
  }
}
