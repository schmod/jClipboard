/*
 * jClipboard :: jQuery ZeroClipboard v0.0.1
 * http://schmod.github.com/jClipboard
 *
 * Based on ZeroClipboard andd zClip
 * http://code.google.com/p/zeroclipboard/
 * http://www.steamdev.com/zclip/
 *
 * Copyright 2012, 
 * Released under the MIT license.
 * http://www.opensource.org/licenses/mit-license.php
 *
 * Date: Tues Feb 21, 2012
 */

(function ($) {

    $.fn.jclip = function (params) {

        if (typeof params == "object" && !params.length) {

            var settings = $.extend({
                path: 'js/jClip.swf',
                copy: null,
                success: null,
                setHandCursor: true
            }, params);

            return this.each(function () {

                var o = $(this);
                uid = parseInt($(".jclip_movie").size(),10) + 1;
                o.addClass("jclip-" + uid);
                o.data("jclipID",uid);

                var embed = $().add("<embed>")
                        .addClass("jclip_movie")
                        .css("position","absolute")
                        .css("left",o.position().left)
                        .css("top",o.position().top)
                        .css("zIndex",o.zIndex+1)
                        .attr("src",settings.path)
                        .attr("loop","false")
                        .attr("menu","false")
                        .width(o.width())
                        .height(o.height())
                        .attr("allowscriptaccess","always")
                        .attr("allowfullscreen","false")
                        .attr("type","application/x-shockwave-flash")
                        .attr("flashvars","id=" + uid + "&width=" + o.width() + "&height=" + o.height())
                        .attr("wmode","transparent")
                        .attr("id","jclip-movie-" + uid);

                o.parent().append(embed);

                o.on("copyHTML",function(){

                    if($.isFunction(settings.copy)){
                        htmlText = settings.copy();
                        // textText = newText.replace(/<\/?[^>]+>/gi,'');
                    }
                    else if(settings.copy instanceof jQuery || settings.copy instanceof HTMLElement){
                        htmlText = $(settings.copy).html();
                    }
                    else {
                        htmlText='';
                    }
                    return "\"" + htmlText.replace("\"", "\\\"") + "\"";
                });

                o.on("copyText",function(){
                    if($.isFunction(settings.copy)){
                        textText = newText.replace(/<\/?[^>]+>/gi,'');
                    }
                    else if(settings.copy instanceof jQuery || settings.copy instanceof HTMLElement){
                        textText = $(settings.copy).text();
                    }
                    else {
                        textText='';
                    }
                    return "\"" + textText.replace("\"", "\\\"") + "\"";
                });

                o.on("success",function(content){
                    if($.isFunction(settings.success)){
                        settings.success(content);
                    }
                });
            });
        }
    }	
})(jQuery);