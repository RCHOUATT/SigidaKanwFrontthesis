import {Component, ElementRef, OnInit, ViewChild} from '@angular/core';
import {Chart, registerables} from "chart.js";

Chart.register(...registerables);
@Component({
  selector: 'app-pie-chart',
  standalone: true,
  imports: [],
  templateUrl: './pie-chart.component.html',
  styleUrl: './pie-chart.component.scss'
})
export class PieChartComponent implements OnInit {
  @ViewChild('pieChart', { static: true }) chartRef!: ElementRef<HTMLCanvasElement>;
  chart: any;

  public config: any = {
    type: 'doughnut',
    data: {
    labels: [
      'Niveau 1',
      'Niveau 2',
      'Niveau 3'
    ],
    datasets: [{
      label: 'My First Dataset',
      data: [300, 50, 100],
      backgroundColor: [
        'rgb(255, 99, 132)',
        'rgb(54, 162, 235)',
        'rgb(255, 205, 86)'
      ],
      hoverOffset: 4,
    }],
  },
    options: {
      cutout: '30%', // Définit la taille du trou intérieur (50% du diamètre total)
      radius: '80%', // Définit le rayon extérieur (taille totale du doughnut)
      responsive: true,
      maintainAspectRatio: false,
    }
  };

  ngOnInit(): void {
    //this.chart = new Chart(this.chartRef.nativeElement, this.config);
    this.chart = new Chart(this.chartRef.nativeElement, this.config);
  }
}
