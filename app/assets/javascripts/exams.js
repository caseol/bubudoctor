// inicia scripts
$(document).ready(function(){
    _init_exams();
});

function _init_exams(){
    // carrega via ajax o index nas divs corretas
    $('.nav-tabs').find('a').on('shown.bs.tab', function (e) {
        if ($(this).attr("href")=="#consultation") {
            url=$("fieldset").find("#div-exames").data("url")
            //$("fieldset").find("#div-exames").load(url + " .sectionform");
            $.getScript(url, function(script, textStatus, XHR){
                // executa o script retornado por index.js.erb
                eval(script);
            });
        }
    });

    $('.nav-tabs').find('a').on('shown.bs.tab', function () {
        // Some code you want to run after the tab is shown (callback)
    });
}