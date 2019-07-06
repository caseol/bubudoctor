var dttbExams;

// inicia scripts
$(document).ready(function(){
    _init_exams();
});

function _init_exams(){
    // carrega via ajax o index nas divs corretas
    $('.nav-tabs').find('a').on('shown.bs.tab', function (e) {
        // verifica se é a aba com id consultation
        if ($(this).attr("href")=="#consultation") {
            url=$("fieldset").find("#div-exames").data("url")
            //$("fieldset").find("#div-exames").load(url + " .sectionform");
            $.getScript(url, function(script, textStatus, XHR){
                // executa o script retornado por index.js.erb
                eval(script);
            });
        }
    });

    $('.nav-tabs').find('a').on('shown.bs.tab', function () {
        // Some code you want to run after the tab is shown (callback)
    });

    //default_table_options["columnDefs"] = { type: 'date-ptbr', targets: 1 };
    default_table_options["columnDefs"] = [{targets:1, render:function(data){
            return moment(data).format('DD/MM/YYYY');
        }}];
    dttbExams = $("#dttb-exam-table").DataTable(default_table_options);
    // Fazendo a tabela ser editada diretamente na celula
    dttbExams.MakeCellsEditable({
        "onUpdate": myDttbExamsCallbackFunction,
        "inputCss":'form-control',
        "columns": [0,1],
        "allowNulls": {
            "columns": [],
            "errorClass": 'error'
        },
        "confirmationButton": false,
        "listenToKeys":  true,
        "inputTypes": [
            {
                "column": 0,
                "type": "text",
                "options": null
            },
            {
                "column": 1,
                "type": "text",
                "options": null
            }
        ]
    });


    // botão para adicionar nova linha na tavela
    $("#add-exam-row").on( 'click', function (){
        // cttb foi definido em generic_init
        dttbExams.row.add( ['Clique', 'e altere'] ).draw( true );
        //$("#dttb-exam-hash").row.add( ['Bernard', 'Viado'] ).draw( false );
        console.log('dttb.row.add');
    });

}

function myDttbExamsCallbackFunction(updatedCell, updatedRow, oldValue, newValue) {
    alert(updatedCell +', ' + updatedRow + ', ' + oldValue + ', ' + newValue);
    console.log(updatedCell +', ' + updatedRow + ', ' + oldValue + ', ' + newValue);
}