// -----------------------------------------------------------------------------------
// http://wowslider.com/
// JavaScript Wow Slider is a free software that helps you easily generate delicious 
// slideshows with gorgeous transition effects, in a few clicks without writing a single line of code.
// Last updated: 2011-10-27
//
//***********************************************
// Obfuscated by Javascript Obfuscator
// http://javascript-source.com
//***********************************************
function ws_basic_linear(c,a,b){var d=jQuery;var e=d("<div></div>").css({position:"absolute",display:"none","z-index":2,width:c.width*2+"px",height:c.height+"px"}).appendTo(b);a.each(function(f){d(this).css({"z-index":0});if(!f){d(this).show()}else{d(this).hide()}});this.go=function(f,i){e.stop(1,1);var g=(((f-i+1)%a.length)?"left":"right");d(a[i]).clone().css({position:"absolute",left:"auto",right:"auto",top:0}).appendTo(e).css(g,0);d(a[f]).clone().css({position:"absolute",left:"auto",right:"auto",top:0}).appendTo(e).css(g,c.width+"px").show();e.css({left:"auto",right:"auto",top:0}).css(g,0).show();d(a[i]).hide();var h={};h[g]=-c.width+"px";e.animate(h,c.duration,"easeInOutExpo",function(){d(a[f]).show();d(this).hide().html("")});return f}};// -----------------------------------------------------------------------------------
// http://wowslider.com/
// JavaScript Wow Slider is a free software that helps you easily generate delicious 
// slideshows with gorgeous transition effects, in a few clicks without writing a single line of code.
// Last updated: 2011-10-27
//
//***********************************************
// Obfuscated by Javascript Obfuscator
// http://javascript-source.com
//***********************************************
jQuery("#wowslider-container1").wowSlider({effect:"basic_linear",prev:"",next:"",duration:20*100,delay:20*100,outWidth:967,outHeight:277,width:967,height:277,autoPlay:true,stopOnHover:false,loop:false,bullets:true,caption:false,controls:false});