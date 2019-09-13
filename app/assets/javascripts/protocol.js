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
    appointments_options["autoWidth"]= false;
    appointments_options["columnDefs"] = [
        {
        targets: 1, render: function (data) {
            if (data == null || data == "")
                return ""
            else
                return moment(data).format('DD/MM/YYYY HH:mm');
        },
    }];
    appointments_options["order"] = [[ 1, "desc" ]]
    dttbAppointments = $('#dttb-appointments').DataTable(appointments_options);
    // fixando o tamanho final da tabela de consultas em 575px
    $('#dttb-appointments').css("width","575px");
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
    patient_options["columnDefs"] = [

        {
            targets: [2, 6], render: function (data) {
                if (data == null || data == "")
                    return ""
                else
                    return moment(data).format('DD/MM/YYYY');
            },
        }
    ];

    dttbPatients = $("#dttb-patients").DataTable(patient_options);

    dttbPatients.on( 'xhr', function () {
        var json = dttbPatients.ajax.json();
        console.log( json.data.length +' row(s) were loaded' );
        //$('#dttb-patients').DataTable().ajax.reload();
    } );
}