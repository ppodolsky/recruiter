jQuery(document).ready(function($) {
    $("[data-href]").click(function() {
        window.document.location = $(this).data("href");
    });
    $(".remove-link").on("ajax:success", function(e, data, status, xhr){
        alert("The post was deleted.");
    });
});
