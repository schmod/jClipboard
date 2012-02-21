package {
	// Simple Set Clipboard System
	// Author: Joseph Huckaby
	
	import flash.display.Stage;
	import flash.display.Sprite;
	import flash.desktop.Clipboard;
	import flash.desktop.ClipboardFormats;
	import flash.display.LoaderInfo;
	import flash.display.StageScaleMode;
	import flash.events.*;
	import flash.display.StageAlign;
	import flash.external.ExternalInterface;
	import flash.system.Security;
	import flash.utils.*;
	import flash.system.System;
 
	public class jClipboard extends Sprite {
		
		private var id:String = '';
		private var button:Sprite;
		private var textText:String = '';
		private var htmlText:String = '';
		
		public function jClipboard10() {
			
			// constructor, setup event listeners and external interfaces
			stage.scaleMode = StageScaleMode.EXACT_FIT;
			flash.system.Security.allowDomain("*");
			
			// import flashvars
			var flashvars:Object = LoaderInfo( this.root.loaderInfo ).parameters;
			id = flashvars.id;
			
			// invisible button covers entire stage
			button = new Sprite();
			button.buttonMode = true;
			button.useHandCursor = true;
			button.graphics.drawRect(0, 0, Math.floor(flashvars.width), Math.floor(flashvars.height));
			button.alpha = 0.0;
			addChild(button);
			button.addEventListener(MouseEvent.CLICK, clickHandler);
			
			button.addEventListener(MouseEvent.MOUSE_OVER, function(event:Event) {
				ExternalInterface.call( '$(".jclip-' + id + '").trigger("mouseOver")');
			} );
			button.addEventListener(MouseEvent.MOUSE_OUT, function(event:Event)
			{
				ExternalInterface.call( '$(".jclip-' + id + '").trigger("mouseOut")');
			} );
			button.addEventListener(MouseEvent.MOUSE_DOWN, function(event:Event) {
				ExternalInterface.call( '$(".jclip-' + id + '").trigger("mouseDown")');
			} );
			button.addEventListener(MouseEvent.MOUSE_UP, function(event:Event) {
				ExternalInterface.call( '$(".jclip-' + id + '").trigger("mouseUp")');
			} );
			
			// external functions
			ExternalInterface.addCallback("setHandCursor", setHandCursor);
		}
		
		public function setHandCursor(enabled:Boolean) {
			// control whether the hand cursor is shown on rollover (true)
			// or the default arrow cursor (false)
			button.useHandCursor = enabled;
		}
		
		private function clickHandler(event:Event):void {
			// user click copies text to clipboard
			// as of flash player 10, this MUST happen from an in-movie flash click event

			htmlText = ExternalInterface.call("eval", '$(".jclip-' + id + '").triggerHandler("copyHTML")');
			textText = ExternalInterface.call("eval", '$(".jclip-' + id + '").triggerHandler("copyText")');
			
			Clipboard.generalClipboard.clear();
			if (htmlText) {
				Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT, htmlText);
			}
			if (textText) {
				Clipboard.generalClipboard.setData(ClipboardFormats.HTML_FORMAT, htmlText);
			}
			textText = ExternalInterface.call("eval", '$(".jclip-' + id + '").triggerHandler("success")');
		}
	}
}
