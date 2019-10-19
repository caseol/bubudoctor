var dttbDiseases;

// inicia scripts
$(document).ready(function(){
    _init_diseases();
});

function _init_diseases(){
    // carrega via ajax o index nas divs corretas
    $('.nav-tabs').find('a').on('shown.bs.tab', function (e) {
        // verifica se é a aba com id consultation
        if ($(this).attr("href")=="#diseases") {
            //url=$("fieldset").find("#div-exams").data("url")
            url=$(".container").find("#div-diseases").data("url")
            $.getScript(url, function(script, textStatus, XHR){
                // executa o script retornado por index.js.erb
                //console.log(script);
                eval(script);
            });
        }
    });

    //executa alguma ação qdo o usuário muda de TAB
    $('.nav-tabs').find('a').on('shown.bs.tab', function () {

    });

    // tabela com a lista de todos os exames
    setDiseases();
    // fim
}

function setDiseases() {
    // tabela com a lista de todos os exames
    var diseases_options = $.extend({}, default_table_options);
    dttbDiseases = $("#dttb-diseases").DataTable(diseases_options);
}