(function () {
    var debugHighlightChecker = function () {
        var className = window.getSelection().isCollapsed ? '' : 'debug';
        document.getElementsByTagName('body')[0].className = className;
    };

    var debugHighlightHandler = function() {
        debugHighlightChecker();

        // если одиночный щелчок мышью пришёлся по выделению, то
        // событие может прийти раньше, чем выделение снимается
        window.setTimeout(debugHighlightChecker, 100);
    };

    document.addEventListener('mouseup', debugHighlightHandler);
    document.addEventListener('keyup', debugHighlightHandler);
})();
