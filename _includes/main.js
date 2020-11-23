(function () {
    var debugHighlightChecker = function () {
        var className = window.getSelection().isCollapsed ? '' : 'debug';
        document.getElementsByTagName('body')[0].className = className;

        // why not...?
        // document.querySelector('body').classList.toggle('debug', !window.getSelection().isCollapsed);
    };

    var debugHighlightHandler = function() {
        debugHighlightChecker();
        window.setTimeout(debugHighlightChecker, 100);
    };

    document.addEventListener('mouseup', debugHighlightHandler);
    document.addEventListener('keyup', debugHighlightHandler);
})();
