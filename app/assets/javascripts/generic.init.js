// objeto carrregado com dataTable
var dttb = undefined;
var dttb_editor = undefined;

// objeto carrregado com datePicker
var date_picker = undefined;

// Variável Global para montagem do Datepicker
var datepicker_options = {
    closeText: 'Fechar',
    prevText: '&#x3c;Anterior',
    nextText: 'Pr&oacute;ximo&#x3e;',
    currentText: 'Hoje',
    monthNames: ['Janeiro','Fevereiro','Mar&ccedil;o','Abril','Maio','Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro'],
    monthNamesShort: ['Jan','Fev','Mar','Abr','Mai','Jun','Jul','Ago','Set','Out','Nov','Dez'],
    dayNames: ['Domingo','Segunda-feira','Ter&ccedil;a-feira','Quarta-feira','Quinta-feira','Sexta-feira','Sabado'],
    dayNamesShort: ['Dom','Seg','Ter','Qua','Qui','Sex','Sab'],
    dayNamesMin: ['Dom','Seg','Ter','Qua','Qui','Sex','Sab'],
    weekHeader: 'Sm',
    //dateFormat: 'dd/mm/yyyy',
    //altFormat: 'yyyy-mm-dd',
    changeYear: true,
    changeMonth: true,
    yearRange: '1900:2040',
    firstDay: 0,
    showMonthAfterYear: true,
    yearSuffix: ''
};
// Variável Global para DataTable
var language_table_options = {
    "sEmptyTable": "Nenhum registro encontrado",
    "sInfo": "Mostrando de _START_ até _END_ de _TOTAL_",
    "sInfoEmpty": "Mostrando 0 até 0 de 0",
    "sInfoFiltered": "(Filtrados de _MAX_)",
    "sInfoPostFix": "",
    "sInfoThousands": ".",
    "sLengthMenu": "_MENU_ resultados por página",
    "sLoadingRecords": "Carregando...",
    "sProcessing": "Processando...",
    "sZeroRecords": "Nenhum registro encontrado",
    "sSearch": "Pesquisar",
    "oPaginate": {
        "sNext": ">>",
        "sPrevious": "<<",
        "sFirst": "Primeiro",
        "sLast": "Último"
    },
    "oAria": {
        "sSortAscending": ": Ordenar colunas de forma ascendente",
        "sSortDescending": ": Ordenar colunas de forma descendente"
    }
}

var default_table_options = {
    language: language_table_options,
    pageLength: 10,
    searchDelay: 850,
    columnDefs: [
        {"targets": 'no-sort', "orderable": false},
        {"targets": 'do-sort', "orderable": true}
    ],
    dom: 'frtiBp',
    buttons: [
        {
            extend: 'copy',
            text: 'Copiar'
        },
        {
            extend: 'csv',
            text: 'CSV'
        },
        {
            extend: 'print',
            text: 'Imprimir'
        }
    ]
}

var default_table_modal_options = {
    language: language_table_options,
    responsive: {
        details: {
            display: $.fn.dataTable.Responsive.display.modal( {
                header: function ( row ) {
                    var data = row.data();
                    if (data['url'] !==undefined){
                        return data['url'];
                    }
                    else{
                        return '';
                    }
                }
            } ),
            renderer: $.fn.dataTable.Responsive.renderer.tableAll()
        }
    },
    pageLength: 10,
    searchDelay: 850,
    columnDefs: [
        {"targets": 'no-sort', "orderable": false}
    ],
    /*
    columnDefs: [
         { type: 'date-br', targets: 3 }
     ],
    columnDefs: [
        {targets: [ 0 ], orderData: [ 0, 1 ]},
        {targets: [ 1 ], orderData: [ 0, 1 ]},
        {targets: [ 2 ],orderData: [ 0, 2 ]}
    ],
    aoColumnDefs: [ {/*
     "aTargets": [ 1 ],
     "mData": "Valor",
     "mRender": function ( data, type, full ) {
     return 'R$' + parseFloat(data/100).toFixed(2).toString().replace(".", ",");
     }
    } ],
    */
    /*
    aoColumnDefs: [ {
        "aTargets": [ 1 ],
        "mData": "Aluno",
        "mRender": function ( data, type, full ) {
            return data;//'R$' + parseFloat(data/100).toFixed(2).toString().replace(".", ",");
        }
    } ],
    */
    dom: 'frtiBp',
    buttons: [
        {
            extend: 'copy',
            text: 'Copiar'
        },
        {
            extend: 'csv',
            text: 'CSV'
        },
        {
            extend: 'print',
            text: 'Imprimir'
        }
    ]
}

var simple_table_options = {
    language: language_table_options,
    responsive: true,
    //searching: false,
    bLengthChange: false,
    pageLength: 12,
    columnDefs: [
        {"targets": 'no-sort', "orderable": false}
    ]
}

// configurando icones do datapicker
$.fn.datetimepicker.Constructor.Default = $.extend({}, $.fn.datetimepicker.Constructor.Default, {
        icons: {
            time: 'far fa-clock',
            date: 'far fa-calendar-alt',
            up: 'fas fa-arrow-up',
            down: 'fas fa-arrow-down',
            previous: 'fas fa-chevron-left',
            next: 'fas fa-chevron-right',
            today: 'far fa-calendar-day',
            clear: 'far fa-delete',
            close: 'far fa-times'
        }
    });

function bind_autocomplete(){
    return $("input[data-autocomplete]").each(function() {
        var url, target;
        url = $(this).data('autocomplete');
        target = $(this).data('hidden')['target']
        var autocopmplete_field = $(this).autocomplete({
            source: url,
            appendTo: '.modal-content',
            delay: 500,
            position: { at: "left bottom" },
            select: function (event, ui) {
                $(target).val(ui.item.id);
                $("#patient_mobile").val(ui.item.mobile)
                $("#patient_mobile_work").val(ui.item.mobile_work)
                $("#patient_phone").val(ui.item.telephone)
                $("#patient_phone_work").val(ui.item.telephone_work)
                $("#patient_health_insurance").val(ui.item.health_insurance)
                $('#search_patient').val(ui.item.label);

                // Prevent the default focus behavior.
                event.preventDefault();
                // or return false;
            }

        });
        //autocopmplete_field.autocomplete('option', 'appendTo', '.modal')
    });
}

function set_date_picker() {
    // iniciando date picker
    $('.date-picker').datetimepicker({locale: 'pt-BR', format: 'L'})
    $('.date-time-picker').datetimepicker({locale: 'pt-BR'})
}

function _init(){
    //alert('_init()');

    //coloca o foco no alert,
    //dá 15seg e esconde qq div com mensagem de sucesso/erro
    $(".alert").delay(12000).slideUp(200);


    // Definindo máscaras
    var behavior = function (val) {
            return val.replace(/\D/g, '').length === 11 ? '(00) 00000-0000' : '(00) 0000-00009';
        },
        options = {
            onKeyPress: function (val, e, field, options) {
                field.mask(behavior.apply({}, arguments), options);
            }
        };

    $('.masked_phone').mask(behavior, options);

    // mácaras das infos pessoais CPF
    $(".masked_cpf").mask("999.999.999-99");

    // bind de campos CEP para buscar endereço.
    bindZipField($(".patient-address"));

    //Máscara CEP
    $(".masked_cep").mask("99999-999");

    // iniciando datatables
    if (dttb === undefined){
        dttb = $(".dttb").DataTable(default_table_modal_options);
        //dttbAppointments = $('#dttb-appointments').DataTable(default_table_options);
        // Fazendo a tabela ser editada diretamente na celula
        /*dttbAppointments.MakeCellsEditable({
            "onUpdate": myDttbCallbackFunction,
            "inputCss":'form-control',
            "columns": [1,2,3,4],
            "allowNulls": {
                "columns": [3],
                "errorClass": 'error'
            },
            "confirmationButton": false,
            "listenToKeys":  true,
            "inputTypes": [
                {
                    "column": 1,
                    "type": "datetimepicker", // requires jQuery UI: http://http://jqueryui.com/download/
                },
                {
                    "column": 2,
                    "type": "text",
                    "options": null
                },
                {
                    "column":3,
                    "type": "list",
                    "options":[
                        { "value": "first_time", "display": "1a Consulta" },
                        { "value": "return", "display": "Retorno" },
                        { "value": "exam", "display": "Mostrar Exame" },
                        { "value": "procedure", "display": "Procedimento" }
                    ]
                },
                {
                    "column":4,
                    "type": "list",
                    "options":[
                        { "value": "scheduled", "display": "Agendada" },
                        { "value": "done", "display": "Realizada" },
                        { "value": "absence", "display": "Falta" },
                        { "value": "canceled", "display": "Cancelada" }
                    ]
                }
                // Nothing specified for column 3 so it will default to text

            ]
        });*/
    }

    set_date_picker();

    setDeleteButton();

    // Faz o bind de campos com autocomplete
    bind_autocomplete();
}

function myDttbCallbackFunction (updatedCell, updatedRow, oldValue, newValue) {
    console.log("The new value for the cell is: " + newValue);
    console.log("The new TEXT for the cell is: " + updatedCell.data());
    console.log("The old value for that cell was: " + oldValue);
    console.log("The values for each cell in that row are: " + updatedRow.data());
}

function setDeleteButton(){
    // verifica se algum botão de apagar arquivo foi clicado
    $(".delete-file").on('click', function(){
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

    function handleDeleteFile(elem){
        console.log('elem.parent() = ' + $(elem).parent())
        if (elem.parents().length > 1) {
            $(elem.parents()[0]).hide();
            $(elem.parents()[1]).hide();
        }else{
            $(elem.parent()).hide();
        }
        return false;
    }
}


// inicia scripts
$(document).ready(function(){
    _init();
});
