/*
---------------------------------
*/
var url_purchasebytype = '../../widget/ws/purchasebytype.ashx';
var opt_purchasebytype = {
    chart: {
        type: 'column',
        renderTo: 'purchasebytype',
        spacing: [0, 0, 0, 0]
    },
    title: {
        text: 'Purchase by Type'
    },
    xAxis: {
        categories: ['Expense', 'FA Asset', 'Inventory Consumtive', 'Inventory'],
        title: {
            text: '<b>Type</b>'
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
    url: url_purchasebytype,
    method: 'GET',
    dataType: 'json',
    success: function(data) {
        opt_purchasebytype.series[0].name = 'Item';
        opt_purchasebytype.series[0].data = data;
        var chart = new Highcharts.Chart(opt_purchasebytype);
    }
});