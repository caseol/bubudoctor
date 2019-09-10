var dttbPatients = "";

$(document).ready(function(){
    _init_protocol();
});

function _init_protocol(){
    setAppointmentsTable();
    setPatientsTable();
}

function setAppointmentsTable() {
    // tabela com a lista de todos os agendamentos
    var appointments_options = $.extend({}, default_table_options);
    appointments_options["columnDefs"] = [{
        targets: 1, render: function (data) {
            return moment(data).format('DD/MM/YYYY HH:MM');
        }
    }];
    dttbAppointments = $('#dttb-appointments').DataTable(appointments_options);
}

function setPatientsTable() {
    // tabela com a lista de todos os exames
    var patient_options = $.extend({}, default_table_modal_options);
    //patient_options["dom"] = 'frtiBp';
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