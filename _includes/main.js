(function () {
  var debugHighlightChecker = function () {
    var className = 'js-selection';
    var body = document.getElementsByTagName('body')[0];

    if (window.getSelection().isCollapsed) {
      body.classList.remove(className);
    } else {
      body.classList.add(className);
    }
  };

  var debugHighlightHandler = function() {
    debugHighlightChecker();
    window.setTimeout(debugHighlightChecker, 100);
  };

  document.addEventListener('mouseup', debugHighlightHandler);
  document.addEventListener('keyup', debugHighlightHandler);
})();
