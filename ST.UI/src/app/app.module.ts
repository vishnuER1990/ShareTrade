import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { HttpClientModule, HTTP_INTERCEPTORS } from '@angular/common/http';
import { HttpModule } from '@angular/http';
import { RouterModule } from '@angular/router';
import { ModalModule } from 'ngx-bootstrap/modal';
import {MatSnackBarModule} from '@angular/material/snack-bar';


import { AppRoutingModule } from './app.routing';
import { ComponentsModule } from './components/components.module';

import { AppComponent } from './app.component';

import { DashboardComponent } from './dashboard/dashboard.component';
import { UserProfileComponent } from './user-profile/user-profile.component';
import { TableListComponent } from './table-list/table-list.component';
import { TypographyComponent } from './typography/typography.component';
import { IconsComponent } from './icons/icons.component';
import { MapsComponent } from './maps/maps.component';
import { NotificationsComponent } from './notifications/notifications.component';
import { UpgradeComponent } from './upgrade/upgrade.component';

import {AuthInterceptor} from './services/auth-interceptor';

import {
  AgmCoreModule
} from '@agm/core';
import { AdminLayoutComponent } from './layouts/admin-layout/admin-layout.component';
import { SaleShareComponent } from './sale-share/sale-share.component';
import { BuyShareComponent } from './buy-share/buy-share.component';
import { UserVerificationComponent } from './user-verification/user-verification.component';
import { ManageShareSaleComponent } from './manage-share-sale/manage-share-sale.component';
import { ManageUserComponent } from './manage-user/manage-user.component';
import { CredentialComponent } from './services/credential/credential.component';
import { ApprovebidComponent } from './approvebid/approvebid.component';
import { ReportComponent } from './report/report.component';
import { ReportsComponent } from './reports/reports.component';
@NgModule({
  imports: [
    BrowserAnimationsModule,      
    HttpClientModule,
    FormsModule,
    ReactiveFormsModule,
    HttpModule,
    ComponentsModule,
    RouterModule,
    AppRoutingModule,
    AgmCoreModule.forRoot({
      apiKey: 'YOUR_GOOGLE_MAPS_API_KEY'
    }),
    ModalModule.forRoot(),
    MatSnackBarModule
  ],
  declarations: [
    AppComponent,
    AdminLayoutComponent,
    CredentialComponent,
    ApprovebidComponent,
    ReportsComponent
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
