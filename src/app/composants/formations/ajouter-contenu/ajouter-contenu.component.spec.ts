import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AjouterContenuComponent } from './ajouter-contenu.component';

describe('AjouterContenuComponent', () => {
  let component: AjouterContenuComponent;
  let fixture: ComponentFixture<AjouterContenuComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AjouterContenuComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(AjouterContenuComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
