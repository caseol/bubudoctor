$(document).ready(function(){
    _init();

});


function _init(){
    // Definindo máscaras
    $(".masked_phone").mask("(99) 9999-9999");
    $(".masked_mobile").mask("(99) 99999-9999");

    // mácaras das infos pessoais CPF
    $(".masked_cpf").mask("999.999.999-99");

}