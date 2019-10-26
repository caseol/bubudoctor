var dttbPatients = "";
var dttbAppointments = "";

$(document).ready(function(){
    _init_protocol();
});

function _init_protocol(){
    setAppointmentsTable();
    setPatientsTable();

    // faz o bind com o campo de data para alterar os valores qdo outra data for escolhida
    $("#datepicker-date-appointments").on("change.datetimepicker", function(){
        dttbAppointments.ajax.url("/consulta.json?appointments_date="+ $("#appointements_date").val());
        dttbAppointments.ajax.reload();
    });
}

function setAppointmentsTable() {
    // tabela com a lista de todos os agendamentos
    var appointments_options = $.extend({}, default_table_options);
    appointments_options["columnDefs"] = [
        {
        targets: 0, render: function (data) {
            if (data == null || data == "")
                return ""
            else
                return moment(data).format('DD/MM/YYYY HH:mm');
        },
    }];
    //appointments_options["order"] = [[ 0, "desc" ]]
    dttbAppointments = $('#dttb-appointments').DataTable(appointments_options);
}

function setPatientsTable() {
    // tabela com a lista de todos os exames
    var patient_options = $.extend({}, default_table_modal_options);
    //patient_options["dom"] = 'frtiBp';
    //patient_options["autoWidth"]= true;
    patient_options["dom"] = 'frt';
    patient_options["serverSide"] = true;
    patient_options["ajax"] = {
                                "type": "GET",
                                "url": "/p.json"
    };
    patient_options["order"] = [[ 0, "desc" ]];
    patient_options["columnDefs"] = [
        {
            targets: [2, 6], render: function (data) {
                if (data == null || data == "")
                    return ""
                else
                    return moment(data).format('DD/MM/YYYY');
            },
        },
        { targets: 'no-sort', orderable: false }
    ];
    dttbPatients = $("#dttb-patients").DataTable(patient_options);

    dttbPatients.on( 'xhr', function () {
        var json = dttbPatients.ajax.json();
        console.log( json.data.length +' row(s) were loaded' );
        //$('#dttb-patients').DataTable().ajax.reload();
    } );
}