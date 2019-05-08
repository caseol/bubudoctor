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
    responsive: {
        details: {
            display: $.fn.dataTable.Responsive.display.modal( {
                header: function ( row ) {
                    var data = row.data();
                    if (data['name'] !==undefined){
                        return data['name'];
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

// objeto carrregado com dataTable
var dttb = undefined;

// objeto carrregado com datePicker
var date_picker = undefined;

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
    }
);

function bind_autocomplete(){
    return $("input[data-autocomplete]").each(function() {
        var url, target;
        url = $(this).data('autocomplete');
        target = $(this).data('hidden')['target']
        var autocopmplete_field = $(this).autocomplete({
            source: url,
            appendTo: '.modal',
            delay: 500,
            position: { at: "left bottom" },
            focus: function (event, ui) {
                console.log(target);
                $(target).val(ui.item.id);
                console.log($(target).val());
                // or $('#autocomplete-input').val(ui.item.label);

                // Prevent the default focus behavior.
                event.preventDefault();
                // or return false;
            }

        });
        //autocopmplete_field.autocomplete('option', 'appendTo', '.modal')
    });
}

function _init(){
    //alert('_init()');

    //dá 15seg e esconde qq div com mensagem de sucesso/erro
    $(".alert").delay(12000).slideUp(200)

    // Definindo máscaras
    $(".masked_phone").mask("(99) 9999-9999");
    $(".masked_mobile").mask("(99) 99999-9999");

    // mácaras das infos pessoais CPF
    $(".masked_cpf").mask("999.999.999-99");

    // bind de campos CEP para buscar endereço.
    bindZipField($(".patient-address"));

    //Máscara CEP
    $(".masked_cep").mask("99999-999");

    // iniciando datatables
    if (dttb === undefined){
        dttb = $(".dttb").dataTable(default_table_options);
    }

    // iniciando date picker
    $('.date-picker').datetimepicker({locale: 'pt-BR', format: 'L'})
    $('.date-time-picker').datetimepicker({locale: 'pt-BR'})

    // Faz o bind de campos com autocomplete
    bind_autocomplete();

}

// inicia scripts
$(document).ready(function(){
    _init();
});
