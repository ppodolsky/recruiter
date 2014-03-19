jQuery(document).ready(function($) {
    $("[data-href]").click(function() {
        window.document.location = $(this).data("href");
    });
});