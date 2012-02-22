jClipboard
==========
Copy text to your clipboard with jQuery
---------------------------------------

jClipboard is a small jQuery plugin that allows you to copy rich text to the system clipboard.  jClipboard is loosely based around [jClip](http://www.steamdev.com/zclip/) and [Zero Clipboard](http://www.steamdev.com/zclip/), but weighs much less, thanks to the delegation of much of the heavy lifting to jQuery.  Unlike other solutions that work with rich text, jClipboard also provides the system clipboard with a text-only rendition of your content for applications that cannot accept HTML.

Requires Flash 10.  Sorry.


###Installation
[Download jClipboard](https://github.com/schmod/jClipboard/tarball/master), extract somewhere into your site, and include jQuery and jClipboard in your page
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
	<script type="text/javascript" src="jquery.zclip.js"></script>

###Usage

Activate jClipboard on the element that you'd like to use as your copy button.

	$('a.copy').jclip({
		path:'js/jClip10.swf',
		copy:function(){
			return $('textarea#myText').val();
		}
	)};

We accept some other parameters too.  Here's a full list:

 * `path`: Path to the jClipboard .SWF file.  Defaults to `js/jClip10.swf`
 * `copy`: Tells jClip what text or elements to copy.  Accepts strings, jQuery objects, DOM Elements, and functions.
 * `success`: Callback function executed after text has been copied.  Accepts one parameter containing the text that was copied.
 * `setHandCursor`: Set to `false` if you do not wish to use a pointer cursor over your copy button.  Defaults to `true`.