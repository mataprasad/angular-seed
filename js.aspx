<%@ Page Language="C#" AutoEventWireup="true" CodeFile="js.aspx.cs" Inherits="Content_app_js" %>

window.openMenu = function () {
    var dropdown = document.getElementById('ddl-menu');
    var event;
    event = document.createEvent('MouseEvents');
    event.initMouseEvent('mousedown', true, true, window);
    dropdown.dispatchEvent(event);
}

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


window.__ServiceURL="<%=Page.ResolveClientUrl("~/api/service.aspx?")%>";