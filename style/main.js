
(function () {
    var debugHighlight = function () {
        var className = window.getSelection().isCollapsed ? '' : 'debug';
        document.getElementsByTagName('body')[0].className = className;
    };
    document.addEventListener('mouseup', debugHighlight);
    document.addEventListener('keyup', debugHighlight);
})();
