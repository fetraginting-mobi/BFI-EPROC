/*
---------------------------------
*/
var url_odstockaging = '../../widget/ws/odstockaging.ashx';
var opt_odstockaging = {
    chart: {
        type: 'column',
        renderTo: 'odstockaging',
        spacing: [0, 0, 0, 0]
    },
    title: {
        text: 'Overdue Stock Aging'
    },
    xAxis: {
        categories: ['<= 15', '16 - 30', '31 - 60', '61 - 90', '>= 91'],
        title: {
            text: '<b>Days</b>'
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
    url: url_odstockaging,
    method: 'GET',
    dataType: 'json',
    success: function(data) {
        opt_odstockaging.series[0].name = 'Stock';
        opt_odstockaging.series[0].data = data;
        var chart = new Highcharts.Chart(opt_odstockaging);
    }
});