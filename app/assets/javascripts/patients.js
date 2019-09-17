$(document).ready(function(){

});

function setPatientAge(dateString) {
    var today = new Date();
    var arrayBirth = dateString("/")

    var birthDate = new Date(arrayBirth[2]+"-"+arrayBirth[1]+"-"+arrayBirth[0]);

    var age = today.getFullYear() - birthDate.getFullYear();
    var m = today.getMonth() - birthDate.getMonth();
    if (m < 0 || (m === 0 && today.getDate() < birthDate.getDate())) {
        age--;
    }
    if ($("#patients_age") !== undefined){
        $("#patients_age").val(age);
    }
    return age;
}