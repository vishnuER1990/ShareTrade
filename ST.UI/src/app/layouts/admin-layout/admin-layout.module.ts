import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';
import { CommonModule } from '@angular/common';
import { HttpClientModule, HTTP_INTERCEPTORS } from '@angular/common/http';
import { HttpModule } from '@angular/http';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { AdminLayoutRoutes } from './admin-layout.routing';

import { DashboardComponent } from '../../dashboard/dashboard.component';
import { UserProfileComponent } from '../../user-profile/user-profile.component';
import { TableListComponent } from '../../table-list/table-list.component';
import { TypographyComponent } from '../../typography/typography.component';
import { IconsComponent } from '../../icons/icons.component';
import { MapsComponent } from '../../maps/maps.component';
import { NotificationsComponent } from '../../notifications/notifications.component';
import { UpgradeComponent } from '../../upgrade/upgrade.component';
import { AdminLayoutComponent } from '../../layouts/admin-layout/admin-layout.component';
import { SaleShareComponent } from '../../sale-share/sale-share.component';
import { BuyShareComponent } from '../../buy-share/buy-share.component';
import { UserVerificationComponent } from '../../user-verification/user-verification.component';
import { ManageShareSaleComponent } from '../../manage-share-sale/manage-share-sale.component';
import { ManageUserComponent } from '../../manage-user/manage-user.component';
import { ManageshareComponent } from '../../manageshare/manageshare.component';
import { LoginComponent } from '../../login/login.component';
import { SignupComponent } from '../../signup/signup.component';
import { LogoutComponent } from '../../logout/logout.component';
import { ManageCertificatesComponent } from '../../manage-certificates/manage-certificates.component';
import { ReportComponent } from '../../report/report.component';
import { ProxyComponent } from '../../proxy/proxy.component';

import { AuthInterceptor } from '../../services/auth-interceptor';

import {MatButtonModule} from '@angular/material/button';
import {MatInputModule} from '@angular/material/input';
import {MatRippleModule} from '@angular/material/core';
import {MatFormFieldModule} from '@angular/material/form-field';
import {MatTooltipModule} from '@angular/material/tooltip';
import {MatSelectModule} from '@angular/material/select';
import {MatTableModule} from '@angular/material/table';
import {MatSortModule} from '@angular/material/sort';
import {MatPaginatorModule} from '@angular/material/paginator';
import {MatAutocompleteModule} from '@angular/material/autocomplete';
import {MatCheckboxModule} from '@angular/material/checkbox';
import {MatRadioModule} from '@angular/material/radio';
import {MatDatepickerModule} from '@angular/material/datepicker';
import {MatNativeDateModule} from '@angular/material/core';
import { ModalModule } from 'ngx-bootstrap/modal';
import {AutoCompleteModule} from 'primeng/autocomplete';
import { NgxSpinnerModule } from "ngx-spinner";
import { NgCircleProgressModule } from 'ng-circle-progress';

@NgModule({
  imports: [
    CommonModule,    
    HttpClientModule,
    HttpModule,
    RouterModule.forChild(AdminLayoutRoutes),
    FormsModule,
    ReactiveFormsModule,
    MatButtonModule,
    MatRippleModule,
    MatFormFieldModule,
    MatInputModule,
    MatSelectModule,
    MatTooltipModule,
    MatTableModule,
    MatSortModule,
    MatPaginatorModule,
    MatAutocompleteModule,
    MatCheckboxModule,
    MatRadioModule,
    MatDatepickerModule,
    MatNativeDateModule,
    ModalModule.forRoot(),
    AutoCompleteModule,
    NgxSpinnerModule,
    NgCircleProgressModule.forRoot()
  ],
  declarations: [
    DashboardComponent,
    UserProfileComponent,
    TableListComponent,
    TypographyComponent,
    IconsComponent,
    MapsComponent,
    NotificationsComponent,
    UpgradeComponent,
    SaleShareComponent,
    BuyShareComponent,
    UserVerificationComponent,
    ManageShareSaleComponent,
    ManageUserComponent,
    ManageshareComponent,
    LoginComponent,
    SignupComponent,
    LogoutComponent,
    ManageCertificatesComponent,
    ReportComponent,
    ProxyComponent
  ],
  providers: [{ provide: HTTP_INTERCEPTORS, useClass: AuthInterceptor, multi: true }]
})

export class AdminLayoutModule {}
