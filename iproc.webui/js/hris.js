function jsToCurrency(num) {
    var a = num.split('.');
    var dec = 2

    if (a.length == 2)
        dec = a[1].length;

    return accounting.formatNumber(num, dec, ',');
}

function jsFormatCurrency(ctrl) {
    ctrl.value = jsToCurrency(ctrl.value);
}

function jsToNumber(num) {
    num = num.toString().replace(/\,/g, '');

    if (isNaN(num))
        num = "0";

    return num;
}

function jsFormatNumber(ctrl) {
    ctrl.value = jsToNumber(ctrl.value);
}

function fnParseURL(url) {

    //parse jika ada PARC nya
    var x = url.split("?");
    var y = x[1];
    var requestParams = y.split("&");

    var i = 0;

    for (i = 0; i < requestParams.length; i++) {
        var requestParam = requestParams[i].split("=");

        if (requestParam[0].substr(0, 4) == 'parc') {
            var ctrl = requestParam[1];
            url = url.replace(requestParam[1], $get(ctrl).value);
        }
    }

    return url;
}

function fnParseURLForApproval(url) {

    //parse jika ada PARC nya
    var x = url.split("?");
    var y = x[1];
    var requestParams = y.split("&");

    var i = 0;

    for (i = 0; i < requestParams.length; i++) {
        var requestParam = requestParams[i].split("=");

        if (requestParam[0].substr(0, 4) == 'parc') {
            var ctrl = requestParam[1];
            url = url.replace(requestParam[1], $get(ctrl).innerHTML);
        }
    }

    return url;
}

function fnParseURLForApprovalWithComment(url) {

    //parse jika ada PARC nya
    var x = url.split("?");
    var y = x[1];
    var requestParams = y.split("&");

    var i = 0;

    for (i = 0; i < requestParams.length; i++) {
        var requestParam = requestParams[i].split("=");

        if (requestParam[0].substr(0, 4) == 'parc') {
            var ctrl = requestParam[1];
            url = url.replace(requestParam[1], $get(ctrl).innerHTML);
        }
    }

    return url;
}

function fnShowDialog(url) {

    url = fnParseURL(url);
    
    $get('ifrpopup').src = url;
    $('#ModalPopup').modal('show');
}

function fnShowErrorNotif(errMsg, errTechMsg) {
    //$get('ErrorMsg').innerHTML = errMsg;
    $('#ErrorMsg').text(errMsg)
    $('#ErrorNotif').modal('show');

    if (errTechMsg != '') {
        $('#ErrorTechMsg').text(errTechMsg);
        $('#PanelTechMsg').show();
    }
}

function fnShowApprovalDialog(url) {

    url = fnParseURLForApproval(url);

    $get('ifrapproval').src = url;
    $('#ApprovalPassword').modal('show');
}

function fnShowApprovalWithCommentDialog(url) {

    url = fnParseURLForApprovalWithComment(url);

    $get('ifrapprovalWithComment').src = url;
    $('#ApprovalPasswordWithComment').modal('show');
}

function fnShowErrorNotifFromApproval(errMsg, errTechMsg) {
    //$get('ErrorMsg').innerHTML = errMsg;
    parent.$('#ErrorMsg').text(errMsg)
    parent.$('#ErrorNotif').modal('show');

    if (errTechMsg != '') {
        parent.$('#ErrorTechMsg').text(errTechMsg);
        parent.$('#PanelTechMsg').show();
    }
}

/* (+) Mod Start Anton 2016-03-16, create approval tiered */
function fnShowApprovalTieredDialog(url) {

    url = fnParseURLForApproval(url);

    $get('ifrapprovalTiered').src = url;
    $('#ApprovalTiered').modal('show');
}
/* (+) Mod End Anton 2016-03-16, create approval tiered */

function fnShowSuccessNotif(successMsg) {
    $('#SuccessMsg').text(successMsg);
    $('#SuccessNotif').modal('show');
}

function fnShowModalChangePassword() {
    $('#ModalChangePassword').modal('show');
}

function fnShowModalApproval() {
    $('#ModalRequestApproval').modal('show');
}

function fnShowModalApprovalWithComment() {
    $('#ModalRequestApprovalWithComment').modal('show');
}

function fnShowModalApprovalTiered() {
    $('#ModalRequestApprovalTiered').modal('show');
}

function fnShowModalBranch() {
    $('#ModalBranch').modal('show');
}

function fnShowGritter(titleString, textString) {

    $.extend(parent.$.gritter.options, {
        class_name: 'gritter-blue', // for light notifications (can be added directly to $.gritter.add too)
        position: 'top-right' // possibilities: bottom-left, bottom-right, top-left, top-right
        //fade_in_speed: 100, // how fast notifications fade in (string or int)
        //fade_out_speed: 100, // how fast the notices fade out
        //time: 3000 // hang on the screen for...
    });

    parent.$.gritter.add({
        // (string | mandatory) the heading of the notification
        title: titleString,
        // (string | mandatory) the text inside the notification
        text: textString,
        // (string | optional) the image to display on the left
        image: 'img/mail-avatar.jpg',
        // (bool | optional) if you want it to fade out on its own or just sit there
        sticky: false,
        // (int | optional) the time you want it to be alive for before fading out
        time: 2000
    });

    return false
}

function fnSetTab(code) {
    
    if($get('ctl00_cpb_txtTabCode') != null){
        $get('ctl00_cpb_txtTabCode').value = code;
    }
}

function fnSetActiveTab() {

    if($get('ctl00_cpb_txtTabCode') != null){
        var code = $get('ctl00_cpb_txtTabCode').value;
        

        $('a[id="' + code + '"]').parent().siblings().attr('class', '');
        $('a[id="' + code + '"]').parent().attr('class', 'active');
        var id = $('a[id="' + code + '"]').attr('href');

        id = id.replace('#', '');

        $('div[id="' + id + '"]').siblings().attr('class', 'tab-pane');
        $('div[id="' + id + '"]').attr('class', 'tab-pane active');
    }
}

function fnCheckAll(checkbox, cssclass) {
    var value = $get(checkbox).checked;
    $('.' + cssclass).prop('checked', value);
}

function fnCalculateBaseAmount(amount, exch, result)
{
    var orig_amount = jsToNumber(document.getElementById(amount).value);
    var exch = jsToNumber(document.getElementById(exch).value);
    
    var base_amount = 0.00; 
        
    orig_amount = parseFloat(orig_amount);
    exch = parseFloat(exch);
    base_amount = parseFloat(base_amount);
    
    //Itung Base Amount  = Orig Amount * Exch
    base_amount = orig_amount * exch;
    
//    alert (orig_amount);
//    alert (exch);
//    alert (base_amount);    
    
    document.getElementById(result).value = base_amount;
    jsFormatCurrency(document.getElementById(result));
}

/*(+)Mod Start [create generic iframe] - Rifky - 06-Feb-2016*/
function fnShowGenericScreen(url) {
    url = fnParseURL(url);

    $get('ifgenericscreen').src = url;
    $('#GenericScreen').modal('show');
}
function fnHideGenericScreen() {
    $('#GenericScreen').modal('hide');
}
/*(+)Mod End - Rifky*/

function textBoxInit() 
{
    $(".form-control").keydown(function(e) 
    {        
        //PREVENT SINGLE QUOTE
        if (e.keyCode == 222) 
        {
            e.preventDefault();
        }
        //PREVENT %
        else if (e.shiftKey && e.keyCode == 53) 
        {
            e.preventDefault();
        }
    });
}