/*
---------------------------------
*/
var url_purchasebyquarter = '../../widget/ws/purchasebyquarter.ashx';
var opt_purchasebyquarter = {
    chart: {
        plotBackgroundColor: null,
        plotBorderWidth: null,
        plotShadow: false,
        type: 'pie',
        renderTo: 'purchasebyquarter',
        spacing: [0, 0, 0, 0]
    },
    title: {
        text: 'Purchase by Quarter'
    },
    plotOptions: {
        pie: {
            allowPointSelect: true,
            cursor: 'pointer',
            dataLabels: {
                enabled: true,
                format: '<b>{point.name}</b>: {point.percentage:.1f} %',
                style: {
                    color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                },
                connectorColor: 'silver'
            }
        }
    },
    tooltip: {
        pointFormat: '{series.name}: <b>{point.percentage:.1f}% {point.y:,.0f}</b>'
    },
//    legend: {
//        layout: 'vertical',
//        align: 'right',
//        verticalAlign: 'top',
//        x: 0,
//        y: 80,
//        floating: true,
//        borderWidth: 1,
//        backgroundColor: ((Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF'),
//        shadow: true,
//        itemStyle: { 'fontSize': '9px' }
//    },
    credits: {
        enabled: false
    },
    series: [{ innerSize: '10%'}]
}


$.ajax({
    url: url_purchasebyquarter,
    method: 'GET',
    dataType: 'json',
    success: function(data) {
        opt_purchasebyquarter.series[0].name = 'Quarter';
        opt_purchasebyquarter.series[0].data = data;
        var chart = new Highcharts.Chart(opt_purchasebyquarter);
    }
});