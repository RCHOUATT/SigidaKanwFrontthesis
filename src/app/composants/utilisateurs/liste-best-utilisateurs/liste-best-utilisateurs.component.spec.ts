import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ListeBestUtilisateursComponent } from './liste-best-utilisateurs.component';

describe('ListeBestUtilisateursComponent', () => {
  let component: ListeBestUtilisateursComponent;
  let fixture: ComponentFixture<ListeBestUtilisateursComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ListeBestUtilisateursComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ListeBestUtilisateursComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
