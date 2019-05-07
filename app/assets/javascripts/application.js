// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require jquery-ui
//= require rails-ujs

//= require popper
//= require bootstrap-sprockets
//= require jquery.mask
//= require datatables

// require bootstrap-datepicker.js
// require bootstrap-datepicker.pt-BR.min
//= require moment
//= require moment/pt-br
// If you require timezone data (see moment-timezone-rails for additional file options)
//= require moment-timezone-with-data
//= require tempusdominus-bootstrap-4


//= require generic.init

function bindZipField(address_div){
    // pega o campo zip dentro da div passada
    var address_zip = address_div.find("#address_zip");

    //Quando o campo cep perde o foco.
    address_zip.focusout(function() {
        //Nova variável com valor do campo "cep".
        var cep = $(this).val();

        //Verifica se campo cep possui valor informado.
        if (cep != "") {

            //Expressão regular para validar o CEP.
            var validacep = /^[0-9]{5}-?[0-9]{3}$/;

            //Valida o formato do CEP.
            if(validacep.test(cep)) {
                // desabilita qualquer botão submit
                $("submit").attr('disabled', true);
                //Preenche os campos com "..." enquanto consulta webservice.

                var address_street = address_div.find("#address_street")
                //address_street.val("...");

                var address_district = address_div.find("#address_district")
                //address_district.val("...");

                var address_city = address_div.find("#address_city")
                //address_city.val("...");

                var address_state = address_div.find("#address_state")
                //address_state.val("...");

                //Consulta o webservice viacep.com.br/
                $.getJSON("//viacep.com.br/ws/"+ cep +"/json/?callback=?", function(dados) {

                    if (!("erro" in dados)) {
                        //Atualiza os campos com os valores da consulta.
                        address_street.val(dados.logradouro);
                        address_district.val(dados.bairro);
                        address_city.val(dados.localidade);
                        address_state.val(dados.uf);

                    } //end if.
                    else {
                        //CEP pesquisado não foi encontrado.
                        limpa_formulário_cep();
                        alert("CEP não encontrado. Por favor informe um CEP válido!");
                        address_street.val("... informe manualmente");
                        address_district.val("... informe manualmente");
                        address_city.val("... informe manualmente");
                        address_state.val("... informe manualmente");
                        $(this).focus();

                    }
                    // reabilita qualquer botão submit
                    $("submit").attr('disabled', false);
                });
            } //end if.
            else {
                //cep é inválido.
                limpa_formulário_cep();
                alert("Formato de CEP inválido. Tente novamente");
                //$(this).focus();
            }
        } //end if.
        else {
            //cep sem valor, limpa formulário.
            limpa_formulário_cep();
            alert("Informe um CEP válido. Tente novamente");
            //$(this).focus();
        }
        // define máscara
        $(this).mask("99999-999");
    });
}
