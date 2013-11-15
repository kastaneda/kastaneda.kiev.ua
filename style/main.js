
// Google Analytics
var _gaq = _gaq || [];
_gaq.push(['_setAccount', 'UA-7610138-1']);
_gaq.push(['_trackPageview']);

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

    // Google Analytics
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
})();
