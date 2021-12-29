//globals
//@task refactor here DRY(within all function in analyze part)
var _breadcrumbs = [],
        _rendered = [],
        _isRendered = false,
        _isInited = false;
/*_breadcrumbs.push({
        href: "somehref",
        text: "very veryverylong text pushedhere huuuuuurrrrraa"
});*/
function renderBreadCrumbs() {

        var template = $('#breadcrumbTemplate').html(),
        homeIconTemplate = $('#homeIconTemplate').html(),
        intervalTemplate = $('#intervalTemplate').html(),
        $container = $('#breadcrumbContainer'),
        $wrapee = $('#breadcrumbWrapee');
        //init
        if (!_isInited) {
$wrapee.css('display', 'block');
        $wrapee.css('position', 'relative');
        $wrapee.css('width', '100%');
        $container.css('display', 'inline-block');
        $container.css('top', '0');
        $container.css('left', '0');
        _isInited = true;
}

//hide
$container.html('');
$container.css('position', 'absolute');
$container.css('visibility', 'hidden');
$container.css('overflow', 'visible');

//render all
if( !_isRendered ) {
        var regex = new RegExp('<%.*%>', 'g');
        $.each(_breadcrumbs, function(index, b){
        var html = template.replace(regex, function(match){
        var substr = '',
                varName = match.replace('<%', '').replace('%>', '');
                if (undefined !== b[varName]) {
        substr = b[varName];
}
return substr;
});
_rendered.push( $(html) );
});
_isRendered = true;
}

//normal try;
$.each(_rendered, function(index,$el){
                $container.append($el);
});

//@task what about margins?
//analyze
var maxWidth = $wrapee.width(),
gap = 5,
currentWidth = $container.width();

//try replace
if( currentWidth >= (maxWidth-gap) ) {
                var totalBreadCrumbs = _rendered.length;
                lastAlreadyCutted = false;
                intervalWasSet = false;
                for (index = 0; index < totalBreadCrumbs; index++){
        var $el = _rendered[index];
                //try to replace to home icon
                if (index === 0) {
        $el.replaceWith(homeIconTemplate);
                //cut the last one
} else if ( !lastAlreadyCutted ) {
                _rendered[totalBreadCrumbs - 1].replaceWith('');
                lastAlreadyCutted = true;
                totalBreadCrumbs--;
                index--;
                //replace top with interval
} else if ( !intervalWasSet) {
                $el.replaceWith(intervalTemplate);
                intervalWasSet = true;
                //cut other
} else {
                $el.replaceWith('');
}

currentWidth = $container.width();
if ( currentWidth <= (maxWidth-gap) ) {
                break;
} 
}
}

//show
$container.css('position', 'static');
$container.css('visibility', 'visible');
$container.css('overflow', 'auto');

}

//@task very strange event binding
document.addEventListener("DOMContentLoaded", function(){
                $(window).on('load', renderBreadCrumbs);
                $(window).on('resize', renderBreadCrumbs);
});


