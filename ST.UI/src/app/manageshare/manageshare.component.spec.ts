import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ManageshareComponent } from './manageshare.component';

describe('ManageshareComponent', () => {
  let component: ManageshareComponent;
  let fixture: ComponentFixture<ManageshareComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ManageshareComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ManageshareComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
