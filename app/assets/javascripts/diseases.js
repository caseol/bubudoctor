var dttbDiseases;
var autocomplete_field_disease;

// inicia scripts
$(document).ready(function(){
    _init_diseases();
});

function _init_diseases(){
    // carrega via ajax o index nas divs corretas
    $('.nav-tabs').find('a').on('shown.bs.tab', function (e) {
        // verifica se é a aba com id consultation
        if ($(this).attr("href")=="#diseases") {
            //url=$("fieldset").find("#div-exams").data("url")
            url=$(".container").find("#div-diseases").data("url")
            $.getScript(url, function(script, textStatus, XHR){
                // executa o script retornado por index.js.erb
                //console.log(script);
                eval(script);
            });
        }
    });

    //executa alguma ação qdo o usuário muda de TAB
    $('.nav-tabs').find('a').on('shown.bs.tab', function () {

    });

    // tabela com a lista de todas as doenças do paciente
    setDiseases();

    //bind_autocomplete_disease();
}

function setDiseases() {
    // tabela com a lista de todos os exames
    var diseases_options = $.extend({}, default_table_options);
    dttbDiseases = $("#dttb-diseases").DataTable(diseases_options);
}

function bind_autocomplete_disease(){
    return $(".autocomplete-disease").each(function() {
        var url, target;
        url = $(this).data('autocomplete');
        target = $(this).data('hidden')['target']
        autocomplete_field_disease = $(this).autocomplete({
            source: url,
            appendTo: '.sectionform',
            delay: 500,
            position: { at: "left bottom" },
            response: function(event, ui) {
                if (ui.content.length === 0) {
                    $(".btn-new-disease").show();
                }
                else{
                    $(".btn-new-disease").hide();
                    $("#disease_id").val('');
                }
            },
            select: function (event, ui) {
                $(target).val(ui.item.id);
                //associa doença selecionada ao paciente
                var patient_id = $("#patient_id").val();
                //var disease_id = $("#disease_id").val(); ou
                var disease_id = ui.item.id;

                //chama o controller
                $.getScript("/d/" + disease_id + "/" + patient_id + "/associate", function (script, textStatus, XHR) {
                    // executa o script retornado por associate_patient.js.erb
                    eval(script);
                });
                // Prevent the default focus behavior.
                event.preventDefault();
                // or return false;
            }
        });
        //autocopmplete_field.autocomplete('option', 'appendTo', '.modal')
    });
}