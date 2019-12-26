var dttbConsultations;

// inicia scripts
$(document).ready(function(){
    _init_consultations();
});

function _init_consultations() {
    // carrega via ajax o index nas divs corretas
    $('.nav-tabs').find('a').on('shown.bs.tab', function (e) {
        // verifica se é a aba com id consultation
        if ($(this).attr("href") == "#consultations") {
            url = $("#div-consultations").data("url")
            $.getScript(url, function (script, textStatus, XHR) {
                // executa o script retornado por index.js.erb
                eval(script);
            });
        }
    });

    //executa alguma ação qdo o usuário muda de TAB
    $('.nav-tabs').find('a').on('shown.bs.tab', function () {
        // Some code you want to run after the tab is shown (callback)
    });

    setDeleteButton();

    set_date_picker();

    // inicializa todos os cards sanfona.
    //$('.collapse').collapse();
}

function setConsultations() {
    // tabela com a lista de todos os exames
    var consultation_options = $.extend({}, default_table_options);
    consultation_options["order"] = [[ 0, "desc" ]]
    consultation_options["columnDefs"] = [
        { type: 'date-ptBR', targets: [0] },
        {
        targets: 0, render: function (data) {

            return moment(data).format('DD/MM/YYYY');
        }
    }];
    dttbConsultations = $("#dttb-consultations").DataTable(consultation_options);
    set_date_picker();
}