import { Component, OnInit } from '@angular/core';

declare const $: any;
declare interface RouteInfo {
    path: string;
    title: string;
    icon: string;
    class: string;
    adminOnly: boolean;
}
export const ROUTES: RouteInfo[] = [
        { path: '/dashboard', title: 'Home',  icon: 'dashboard', class: '',adminOnly: false },
        { path: '/user-profile', title: 'User Profile',  icon:'person', class: '',adminOnly: false },
        { path: '/buy-share', title: 'Purchase',  icon:'shopping_basket', class: '',adminOnly: false },
        { path: '/sale-share', title: 'sale',  icon:'card_travel', class: '',adminOnly: false },
        { path: '/logout', title: 'Logout',  icon:'power_settings_new', class: '',adminOnly: false },
        // { path: '/manage-certificates', title: 'View Certificates',  icon:'power_settings_new', class: '',adminOnly: false },

        { path: '/dashboard', title: 'Home',  icon: 'dashboard', class: '',adminOnly: true },
        { path: '/user-profile', title: 'User Profile',  icon:'person', class: '',adminOnly: true },
        { path: '/manageshare', title: 'Add Shares',  icon:'add_business', class: '',adminOnly: true },
        { path: '/buy-share', title: 'Approve Sale',  icon:'done_all', class: '',adminOnly: true },
        { path: '/sale-share', title: 'View Sales',  icon:'view_list', class: '',adminOnly: true },
        { path: '/report', title: 'Report',  icon:'article', class: '',adminOnly: true },
        { path: '/logout', title: 'Logout',  icon:'power_settings_new', class: '',adminOnly: true },
        { path: '/proxy', title: 'Proxy',  icon:'people', class: '',adminOnly: true },
        // { path: '/manage-certificates', title: 'Upload Certificates',  icon:'power_settings_new', class: '',adminOnly: true },
];

@Component({
  selector: 'app-sidebar',
  templateUrl: './sidebar.component.html',
  styleUrls: ['./sidebar.component.css']
})
export class SidebarComponent implements OnInit {
  menuItems: any[];

  constructor() { }

  ngOnInit() {
      debugger;
    if(sessionStorage.getItem('Role') !='Admin'){

        if(+sessionStorage.getItem('ShareCount') == 0){
            this.menuItems = ROUTES.filter(menuItem => menuItem.path != '/sale-share' &&  menuItem.adminOnly == false);
        }
        else{
            this.menuItems = ROUTES.filter(menuItem => menuItem.adminOnly == false);
        }
    } else{        
        this.menuItems = ROUTES.filter(menuItem => menuItem.adminOnly == true);
    }
  }
  isMobileMenu() {
      if ($(window).width() > 991) {
          return false;
      }
      return true;
  };
}
