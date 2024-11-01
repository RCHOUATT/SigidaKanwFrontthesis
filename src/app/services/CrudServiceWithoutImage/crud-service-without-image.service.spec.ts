import { TestBed } from '@angular/core/testing';

import { CrudServiceWithoutImageService } from './crud-service-without-image.service';

describe('CrudServiceWithoutImageService', () => {
  let service: CrudServiceWithoutImageService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(CrudServiceWithoutImageService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
