import { Routes } from '@angular/router';

import { DashboardComponent } from '../../dashboard/dashboard.component';
import { UserProfileComponent } from '../../user-profile/user-profile.component';
import { TableListComponent } from '../../table-list/table-list.component';
import { TypographyComponent } from '../../typography/typography.component';
import { IconsComponent } from '../../icons/icons.component';
import { MapsComponent } from '../../maps/maps.component';
import { NotificationsComponent } from '../../notifications/notifications.component';
import { UpgradeComponent } from '../../upgrade/upgrade.component';
import { SaleShareComponent } from '../../sale-share/sale-share.component';
import { BuyShareComponent } from '../../buy-share/buy-share.component';
import { ManageshareComponent } from '../../manageshare/manageshare.component';
import { LoginComponent } from '../../login/login.component';
import { LogoutComponent } from '../../logout/logout.component';
import { ManageCertificatesComponent } from '../../manage-certificates/manage-certificates.component';
import { ReportComponent } from '../../report/report.component';
import { ProxyComponent } from '../../proxy/proxy.component';

export const AdminLayoutRoutes: Routes = [   
    { path: 'dashboard',      component: DashboardComponent },
    { path: 'user-profile',   component: UserProfileComponent },
    { path: 'table-list',     component: TableListComponent },
    { path: 'typography',     component: TypographyComponent },
    { path: 'icons',          component: IconsComponent },
    { path: 'maps',           component: MapsComponent },
    { path: 'notifications',  component: NotificationsComponent },
    { path: 'upgrade',        component: UpgradeComponent },
    { path: 'sale-share',     component: SaleShareComponent },
    { path: 'buy-share',       component: BuyShareComponent },
    { path: 'manageshare',     component: ManageshareComponent },
    { path: 'login',            component: LoginComponent },
    { path: 'logout',           component: LogoutComponent },
    { path: 'manage-certificates',     component: ManageCertificatesComponent },
    { path: 'report',     component: ReportComponent },
    { path: 'proxy',     component: ProxyComponent },
];
