<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
 <%@ page import="com.restfb.*, com.restfb.types.*,facebook.*,common.*" %>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>Insert title here</title>
	<script language="javascript" type="text/javascript" src="http://connect.facebook.net/en_US/all.js"></script>
	<script language="javascript" type="text/javascript" src="./jquery-1.7.js"></script>
	<script language="javascript" type="text/javascript" src="./jquery-animate-css-rotate-scale.js"></script>
	<script language="javascript" type="text/javascript">
		function addQuotes(str){ return "\"" + str + "\""; }
		
		var divIdIndicator = 1;
		var Albums = new Array(); 
		var albumCounts = 0; 

		function HtmlObject()
		{
			////////////////////////////////////////  constructor  ///////////////////////////////////// 
			$("#html-root").prepend("<div class = \"Photo\" id = " + addQuotes("div"+divIdIndicator) +"></div>");
			
			
			this.m_htmlDiv = $("#div" + divIdIndicator);
			this.m_htmlDiv.addClass("Photo");
			var m_id = divIdIndicator;
			divIdIndicator++;
			///////////////////////////////////////////////////////////////////////////
			
			this.getID     = function() { return this.m_id;}
			
			this.getWidth  = function() { return this.m_htmlDiv.width();}
			this.getHeight = function() { return this.m_htmlDiv.height();}
			this.getX      = function() { return this.m_htmlDiv.position().left;}
			this.getY	   = function() { return this.m_htmlDiv.position().top;}
			this.getCenterX = function() {return this.getX() + this.getWidth() * 0.5;}
			this.getCenterY = function() {return this.getY() + this.getHeight() * 0.5;}
		
			this.getDiv    = function() { return this.m_htmlDiv;}
			
			this.setX	   = function(x) { this.m_htmlDiv.css({"left":x+"px"}); }			
			this.setY	   = function(y) { this.m_htmlDiv.css({"top":y+"px"});  }
			this.setWidth  = function(width) {this.m_htmlDiv.css({"width":width+"px"});}
			this.setheight = function(height){this.m_htmlDiv.css({"height":height+"px"});}
			this.setWidthByDelta  = function(dWidth)  { this.setWidth(getWidth() + dWidth);  }
			this.setHeightByDelta = function(dHeight) { this.setHeight(getHeight() + dHeight); }
			
			this.setBounds = function(x,y,width,height) { this.setX(x); this.setY(y); this.setWidth(width); this.setHeight(height);}
			
			///
			this.animatePos 		= function(x,y,speed){ this.m_htmlDiv.animate({"left":x+"px","top":y+"px"},speed);}
			this.animateSize 		= function(width,height,speed,bMaintainCenter)
			{
				this.m_htmlDiv.animate({"width":width+"px","height":height+"px"},speed);
				if(bMaintainCenter == 1) 
				{
					this.animatePos( this.getCenterX() - width * 0.5,this.getCenterY() - height * 0.5);
				}
			}	
			this.animatePosByDelta  = function(dx,dy,speed){ this.animatePos(this.getX() + dx,this.getY() + dy,speed); }
			this.animateSizeByDelta = function(dWidth,dHeight,spedd){ this.animateSize(this.getWidth() + dWidth, this.getHeight() + dHeight,speed);}
		}
		
		
		
		//페북 API를 호출했을때 가지고 오는 photo 객채를 그냥 넘긴다. 
		function Photo(fb_photo)
		{
			//Constructor
			HtmlObject.call(this);
			
			this.m_fbPhoto = fb_photo;
		
			this.getDiv().prepend("<img src = " + addQuotes(fb_photo.source) + "/>");
			
			var outerThis =this;
			FB.api("/" + fb_photo.id + "/comments", function (response) {
				for(var i =0;i<response.data.length;i++)
				{
					outerThis.getDiv().prepend(addQuotes(response.data[i].message) + "<br>");
				}
			});
			
			this.getDiv().css({"border-width":"0px"});
			
			var OuterThis = this;
			this.getDiv().mouseenter( function()
			{
			//	OuterThis.getDiv().clearQueue();
				OuterThis.animateSize(130,130,"fast");
			});
			this.getDiv().mouseleave( function()
			{
			//	OuterThis.getDiv().clearQueue(); 
				OuterThis.animateSize(100,100,"fast");  
			});
			
			this.m_htmlImg = this.getDiv().find("img");
			///////////////////////////////////
			
			///// Overide 
			this.setWidth  = function(width) 
			{
				//this.setWidth(width);
				//HtmlObject.setWidth.call(this,width);    // Call super-class method 
				this.m_htmlDiv.css({"width":width+"px"});
				this.m_htmlImg.css({"width":width+"px"});
			}
			this.setHeight = function(height) 
			{
				//this.setHeight(height);
				//HtmlObject.setHeight.call(this,height);    // Call super-class method
				this.m_htmlDiv.css({"height":height+"px"});
				this.m_htmlImg.css({"height":height+"px"});
			}
			this.animateSize = function(width,height,speed,bMaintainCenter)
			{ 
				this.m_htmlDiv.animate({"width":width+"px","height":height+"px"},speed);
				this.m_htmlImg.animate({"width":width+"px","height":height+"px"},speed);
			}
		}
		Photo.prototype = new HtmlObject();
		Photo.prototype.constructor = Photo;
		
		
		function Album(fb_album)
		{
			//Constructor
			Albums[albumCounts++] = this;
			
			HtmlObject.call(this);
			
			this.m_fbAlbum = fb_album;
			this.m_photos = new Array();
			
			var OuterThis = this;
			FB.api("/" + fb_album.cover_photo, function (response) 
			{
				OuterThis.getDiv().prepend("<img src = " + addQuotes(response.source) + " width = 200 height = 200 />");
			});
			FB.api("/" + fb_album.id + "/photos",function (response)
			{
				for(var i=0;i<response.data.length;i++)
				{
					OuterThis.m_photos[i] = new Photo(response.data[i]);
					OuterThis.m_photos[i].setBounds(OuterThis.getX(),OuterThis.getY(),100,100);
					OuterThis.m_photos[i].getDiv().hide();
				}
			});
			this.getDiv().prepend("<h1>" + fb_album.name + "</h1>");
			
			this.getDiv().click (function()
			{
				OuterThis.animatePos(0,0);
				for(var i =0 ;i<Albums.length;i++)
				{
					if(Albums[i] != OuterThis)
						Albums[i].getDiv().fadeOut();	
				}
				for(var i=0;i<OuterThis.m_photos.length;i++)
				{
					OuterThis.m_photos[i].getDiv().fadeIn();
					OuterThis.m_photos[i].animatePos( 100 + i * 120 ,400,"slow");
				}
			});
			
			
			this.setX(0); this.setY(0);
			
			////////////////////////////////////// 	
		
			this.getPhotos = function getPhotos() {return m_photos;}
		}
		Album.prototype = new HtmlObject(); 
		Album.prototype.constructor = Album;
		
		$(document).ready(function(){

			FB.init({ appId: '191785150891389', status: false, cookie: true, xfbml: true });
		    FB.getLoginStatus(function(response) {
		    	  if (response.status == 'connected') 
		    	  {
		    		  FB.api("me/albums",function ( response ){
		    		  	for(var i = 0;i<response.data.length;i++)
		    		  	{
		    		  		var albumHtml = new Album(response.data[i]);
							albumHtml.animatePosByDelta(i*250,0);
		    		  	}
		    		  ));
		    	  } 
		    });
		    	
		});
	</script>
	<style>
	.Photo
	{
		position:absolute;
		width:200px;
		height:200px;
		border-style:solid;
		border-width:3px;
		border-color:black;
	}
	</style>
</head>
	<body>
		<div id="html-root"></div>
		<div id = "fb-root"></div>

	</body>
</html>