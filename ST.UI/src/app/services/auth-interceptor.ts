import { HttpInterceptor, HttpRequest, HttpHandler, HttpEvent, HttpResponse, HttpErrorResponse } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Injectable } from '@angular/core';
import 'rxjs/add/operator/catch';
import 'rxjs/add/operator/do';
import 'rxjs/add/operator/map'

@Injectable()
export class AuthInterceptor implements HttpInterceptor {

    constructor() {

    }

    intercept(req: HttpRequest<any>, next: HttpHandler): Observable<any> {
        let authReq = req.clone();

        if (!req.url.endsWith('/token')
            && !req.url.endsWith('/ad')) {
            if (!authReq.headers.has('Authorization')) {
                authReq = authReq.clone({ headers: authReq.headers.set('Authorization', 'Bearer ' + sessionStorage.getItem('access_token')) });
            }
            if (!authReq.headers.has('Content-Type')) {
                authReq = authReq.clone({ headers: authReq.headers.set('Content-Type', 'application/json; charset=utf-8') });
            }

        }
        return next.handle(authReq)
        .map((event: HttpEvent<any>) => {
          if (event instanceof HttpResponse) {
            return event;
        }
        }).catch((error: any) => {
          if (error instanceof HttpErrorResponse) {
            if (error.status === 401) {
                if (sessionStorage.getItem('Role') !== null) {
                    authReq = authReq.clone({
                        headers: authReq.headers.set('Authorization', 'Bearer ' + sessionStorage.getItem('access_token'))
                    });
                    return next.handle(authReq);
                }
            }
          }
        });
    }
}
