import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ManageShareSaleComponent } from './manage-share-sale.component';

describe('ManageShareSaleComponent', () => {
  let component: ManageShareSaleComponent;
  let fixture: ComponentFixture<ManageShareSaleComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ManageShareSaleComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ManageShareSaleComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
