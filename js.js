window.__loadingOn = function () {
    var over = '<div id="overlay">' + '<img id="loading" src="<%=Page.ResolveClientUrl("~/content/app/images/ajax-loader.gif")%>">' + '</div>';
    var isExits = $("#overlay").length;
    if (isExits == 0) {
        $(over).appendTo('body');
    }
}
window.__loadingOff = function () {
    $("#overlay").remove();
}