import { Component, OnInit, ViewChild, ElementRef } from '@angular/core';
import { Chart, registerables } from 'chart.js';

Chart.register(...registerables);

@Component({
  selector: 'app-bar-chart',
  standalone: true,
  templateUrl: './bar-chart.component.html',
  styleUrls: ['./bar-chart.component.scss']
})
export class BarChartComponent implements OnInit {
  @ViewChild('barChart', { static: true }) chartRef!: ElementRef<HTMLCanvasElement>;
  chart: any;

  public config: any = {
    type: 'bar',
    data: {
      labels: ["Lun", "Mar", "Mer", "Jeu", "Ven", "Sam", "Dim"],
      datasets: [{
        label: 'My First Dataset',
        data: [65, 59, 80, 81, 56, 55, 40],
        backgroundColor: [
          'rgba(255, 99, 132, 0.8)',
          'rgba(255, 159, 64, 0.8)',
          'rgba(255, 205, 86, 0.8)',
          'rgba(75, 192, 192, 0.8)',
          'rgba(54, 162, 235, 0.8)',
          'rgba(153, 102, 255, 0.8)',
          'rgba(201, 203, 207, 0.8)'
        ],
        borderColor: [
          "rgba(0, 0, 0, 0)"
        ],
        /*borderColor: [
          'rgb(255, 99, 132)',
          'rgb(255, 159, 64)',
          'rgb(255, 205, 86)',
          'rgb(75, 192, 192)',
          'rgb(54, 162, 235)',
          'rgb(153, 102, 255)',
          'rgb(201, 203, 207)'
        ],*/
        borderWidth: 1,
        borderRadius: 10
      }]
    },
    options: {
      responsive: true, // Rend le graphique responsive
      maintainAspectRatio: false, // Permet au graphique de remplir son conteneur
      scales: {
        y: {
          display: false,
          beginAtZero: true,
          grid: {
            display: false // Masque les lignes de la grille pour l'axe des ordonnées
          }
        },
        x: {
          // Configuration de l'axe des abscisses (X)
          grid: {
            display: false, // Masquer les lignes de la grille pour l'axe X
          },
          ticks: {
            font: {
              size: 14, // Taille de la police des étiquettes sur l'axe X
            },
            color: 'gray', // Couleur des étiquettes sur l'axe X
          }
        },
      },
      plugins: {
        legend: {
          display: false // Masque la légende
        },
        tooltip: {
          callbacks: {
            label: function(context: any):any {
              return `${context.raw}`; // Affiche seulement la valeur numérique dans l'infobulle
            }
          }
        }
      }
    }
  };

  ngOnInit(): void {
    //this.chart = new Chart(this.chartRef.nativeElement, this.config);
    this.chart = new Chart(this.chartRef.nativeElement, this.config);
  }
}
