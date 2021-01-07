var dttbPatients = "";

$(document).ready(function(){
    _init_search();
});

function _init_search(){
    setPatientsTable();
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
            targets: 0, render: function (protocol_number) {
                if (protocol_number == null || protocol_number == ""){
                    return ""
                }
                else{
                    return protocol_number.pad(5)
                }
            }
        },
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