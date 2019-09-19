var objEstranho = "";
$(document).ready(function(){
    bind_patient_birth()
});

function bind_patient_birth(){
    // bind no campo data de nascimento para autocompletar a idade
    $("#datepicker-pacient-birth").on("change.datetimepicker", function(){
        setPatientAge($("#patient_birth").val())
    });
    $("#patient_birth").on("focusout", function(){
        setPatientAge($("#patient_birth").val())
    });
    $("#patient_form").on("submit", function(){
        setPatientAge($("#patient_birth").val())
    });
}

function setPatientAge(dateString) {
    var today = new Date();

    if (dateString != "" && dateString !== undefined) {
        var arrayBirth = dateString.split("/")

        var birthDate = new Date(arrayBirth[2]+"-"+arrayBirth[1]+"-"+arrayBirth[0]);

        var age = today.getFullYear() - birthDate.getFullYear();
        var m = today.getMonth() - birthDate.getMonth();
        if (m < 0 || (m === 0 && today.getDate() < birthDate.getDate())) {
            age--;
        }

        if ($("#patient_age") !== undefined){
            $("#patient_age").val(age);
        }
        return age;
    }
    else{
        return "";
    }
}