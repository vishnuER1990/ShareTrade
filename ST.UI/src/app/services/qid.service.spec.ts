import { TestBed } from '@angular/core/testing';

import { QidService } from './qid.service';

describe('QidService', () => {
  let service: QidService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(QidService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
