$(document).ready(function() {
  var chartsData = $("#charts-data").data();
  if (!(chartsData && chartsData.daily)) { return; }
  plotChartFor('daily-chart', chartsData.daily, 'Daily');
  plotChartFor('weekly-chart', chartsData.weekly, 'Weekly');
  plotChartFor('monthly-chart', chartsData.monthly, 'Monthly');
});

function plotChartFor(containerId, data, title) {
    Highcharts.chart(containerId, {
        chart: { type: 'column' },
        title: { text: title },
        xAxis: {
            categories: $.map(data, function(i) { return i[0]; })
        },
        yAxis: {
            min: 0,
            title: {
                text: 'Late %'
            }
        },
        tooltip: {
            pointFormat: '<span style="color:{series.color}">{series.name}</span>: <b>{point.y}</b> ({point.percentage:.0f}%)<br/>',
            shared: true
        },
        plotOptions: {
            column: { stacking: 'percent' }
        },
        series: [{
            name: 'On-time',
            data: $.map(data, function(i) { return i[1]; })
        }, {
            name: 'Late',
            data: $.map(data, function(i) { return i[2]; })
        }]
    });
}