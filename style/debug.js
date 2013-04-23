
document.onmouseup = document.onkeyup = function () {
    var className = window.getSelection().isCollapsed ? '' : 'debug'
    document.getElementsByTagName('body')[0].className = className
}
