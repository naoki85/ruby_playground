<script>
import {Line} from 'vue-chartjs'
import request from '../../utils/requests'

export default {
  extends: Line,
  data: function() {
    return {
      chartDate: [],
      chartPages: []
    }
  },
  mounted () {
    this.fetchSummary(this.$route.params.id);
  },
  methods: {
    fetchSummary: function(userId) {
      request.get('/v1/users/summary?id=' + userId, {}).then((response) => {
        this.chartDate = response.data.summary.date;
        this.chartPages = response.data.summary.pages;
        var dataCollection = this.buildDataCollection();
        var options = this.buildOptions();
        this.renderChart(dataCollection, options);
      }, (error) => {
        console.log(error);
      });
    },
    buildDataCollection: function() {
      return {
        labels: this.chartDate,
        datasets: [
          {
            label: 'Data One',
            backgroundColor: '#1DE9B6',
            pointBackgroundColor: 'white',
            borderWidth: 1,
            pointBorderColor: '#004D40',
            data: this.chartPages
          }
        ]
      }
    },
    buildOptions: function() {
      return {
        scales: {
          yAxes: [{
            ticks: {
              beginAtZero: true
            },
            gridLines: {
              display: true
            }
          }],
          xAxes: [ {
            gridLines: {
              display: false
            }
          }]
        },
        legend: {
          display: true,
          labels: false
        },
        responsive: true,
        maintainAspectRatio: false
      }
    }
  }
}
</script>