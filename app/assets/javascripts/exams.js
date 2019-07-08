var dttbExams;
var dttbExamTable;

var dttbExamTableOptions = {
    "onUpdate": myDttbExamTableCallbackFunction,
    "inputCss":'form-control',
    "columns": [0,1],
    "allowNulls": true,
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
};

// inicia scripts
$(document).ready(function(){
    _init_exams();
});

function _init_exams(){
    // carrega via ajax o index nas divs corretas
    $('.nav-tabs').find('a').on('shown.bs.tab', function (e) {
        // verifica se é a aba com id consultation
        if ($(this).attr("href")=="#consultation") {
            url=$("fieldset").find("#div-exams").data("url")
            $.getScript(url, function(script, textStatus, XHR){
                // executa o script retornado por index.js.erb
                eval(script);
            });
        }
    });

    $('.nav-tabs').find('a').on('shown.bs.tab', function () {
        // Some code you want to run after the tab is shown (callback)
    });

    // inicializa tabela de um determinado exame
    setExamDetails();

    // tabela com a lista de todos os exames
    setExams();
    // fim

}

function setExams() {
    // tabela com a lista de todos os exames
    var exams_options = $.extend({}, default_table_options);
    exams_options["columnDefs"] = [{
        targets: 1, render: function (data) {
            return moment(data).format('DD/MM/YYYY');
        }
    }];
    dttbExams = $("#dttb-exams").DataTable(exams_options);
}

function setExamDetails(){
    // tabela de valores de um determinado exame
    var exam_table_options = $.extend({}, default_table_options);
    exam_table_options["columns"] = [
        { title: "Sigla Exame" },
        { title: "Valor" },
        {  mRender: function (data, type, row) {
            return "<button type='button' onclick='alert(row.ID)'><span aria-hidden='true'>&times;</span></button>"
        } }];
    if ($("#dttb-exam-table").attr('disabled')){
        exam_table_options["columns"] = [
            { title: "Sigla Exame" },
            { title: "Valor" }];
        exam_table_options["data"] = JSON.stringify($("#exam_exam_table").val());
    }
    dttbExamTable = $("#dttb-exam-table").DataTable(exam_table_options);

    // Fazendo a tabela ser editada diretamente na celula, caso a tabela não esteja desabilitada
    if (!$("#dttb-exam-table").attr('disabled')){
        dttbExamTable.MakeCellsEditable(dttbExamTableOptions);
    }

    // botão para adicionar nova linha na tavela
    $("#add-exam-row").on( 'click', function (){
        // cttb foi definido em generic_init
        dttbExamTable.row.add( ['Clique', 'e altere'] ).draw( false );
        $("#exam_exam_table").val(JSON.stringify(dttbExamTable.data().toArray()));
        console.log('dttb.row.add');
    });

    // verifica se o botão de apagar uma linha da tabela de valores do exame foi clicado
    $('#dttb-exam-table tbody').on( 'click', 'button', function () {
        var row = dttbExamTable.row( $(this).parents('tr') );
        var data = row.data();
        if (confirm("Apagar: " + data[0] + " valor: " + data[1])) {
            row.remove().draw();
            $("#exam_exam_table").val(JSON.stringify(dttbExamTable.data().toArray()));
        }
    } );

    // ao enviar formulario, atualizar valor do campo que contém os valores da tabela
    $(".form-exam").on( 'submit', function (){
        $("#exam_exam_table").val(JSON.stringify(dttbExamTable.data().toArray()));
    });


    // $('.carousel').carousel({
    //     interval: 2000
    // })

    $(".delete-exam-file").on('click', function(){
        _id = $(this).data("id");
        _filename = $(this).data("name");
        if (confirm("Deseja apagar " + _filename + " ?")) {
            var option = {
                type: "DELETE",
                method: "DELETE",
                url: "/file/" + _id + ".json",
                dataType: "json",
                complete: handleDeleteFile($(this))
            }
            $.ajax(option);
            console.log ("Arquivo " + _filename + " apagado.");
        }else{
            console.log ("Segue o jogo");
        }
    })

    // inicializa todos os cards sanfona.
    $('.collapse').collapse();
}

function myDttbExamTableCallbackFunction(updatedCell, updatedRow, oldValue, newValue) {
    console.log(updatedCell +', ' + updatedRow + ', ' + oldValue + ', ' + newValue);
    $("#exam_exam_table").val(JSON.stringify(dttbExamTable.data().toArray()));
    $("#exam_data").val(JSON.stringify(dttbExamTable.data().toArray()));
    console.log(JSON.stringify(dttbExamTable.data().toArray()))
}

function handleDeleteFile(elem){
    console.log('elem.parent() = ' + $(elem).parent().id)
    $(elem).parent().hide();
    return false;
}