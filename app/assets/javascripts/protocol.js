var dttbAppointments = "";

$(document).ready(function(){
    _init_protocol();
});

function _init_protocol(){
    setAppointmentsTable();

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