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
    responsive: true,
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
    dom: 'BfrtiBp',
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

$(document).ready(function(){
    _init();

});


function _init(){
    // Definindo máscaras
    $(".masked_phone").mask("(99) 9999-9999");
    $(".masked_mobile").mask("(99) 99999-9999");

    // mácaras das infos pessoais CPF
    $(".masked_cpf").mask("999.999.999-99");

    $("#dttb-patients").dataTable(default_table_options);
    $("#dttb-appointments").dataTable(simple_table_options);
}