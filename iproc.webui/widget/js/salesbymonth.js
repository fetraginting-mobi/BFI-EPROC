/*
---------------------------------
*/
var url_salesbymonth = '../../widget/ws/salesbymonth.ashx';
var opt_salesbymonth = {
    chart: {
        type: 'spline',
        renderTo: 'salesbymonth',
        spacing: [0, 0, 0, 0]
    },
    title: {
        text: 'Sales by Month'
    },
    xAxis: {
        categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
        title: {
            text: '<b>Month</b>'
        },
        crosshair: true
    },
    yAxis: {
        min: 0,
        title: {
            text: 'in billion'
        }
    },
    tooltip: {
        valueSuffix: ''
    },
    legend: {
        layout: 'vertical',
        align: 'right',
        verticalAlign: 'top',
        x: -40,
        y: 80,
        floating: true,
        borderWidth: 1,
        backgroundColor: ((Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF'),
        shadow: true
    },
    credits: {
        enabled: false
    },
    series: [{}]
}


$.ajax({
    url: url_salesbymonth,
    method: 'GET',
    dataType: 'json',
    success: function(data) {
        opt_salesbymonth.series[0].name = 'Amount';
        opt_salesbymonth.series[0].data = data;
        var chart = new Highcharts.Chart(opt_salesbymonth);
    }
});