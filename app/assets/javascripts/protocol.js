var dttbPatients = "";

$(document).ready(function(){
    _init_protocol();
});

function _init_protocol(){
    setPatientsTable();
}

function setPatientsTable() {
    // tabela com a lista de todos os exames
    var patient_options = $.extend({}, default_table_modal_options);
    patient_options["dom"] = 'frt';
    patient_options["serverSide"] = true;
    patient_options["ajax"] = {
                                "type": "GET",
                                "url": "/p.json"
    };
    dttbPatients = $("#dttb-patients").DataTable(patient_options);

    dttbPatients.on( 'xhr', function () {
        var json = dttbPatients.ajax.json();
        console.log( json.data.length +' row(s) were loaded' );
        //$('#dttb-patients').DataTable().ajax.reload();
    } );
}