<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"
    import="madeleine.*,
    java.util.ArrayList,
    facebook.*,
    com.restfb.*,
    com.restfb.types.*"%>
    
<!DOCTYPE html>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
	<style>
	BODY { overflow-y:hidden; 
	overflow-x:hidden;}
	.Slide
	{
		position:absolute;
	}
	</style>
	<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css"/>
	<link href="../Controller.css" rel="stylesheet" type="text/css"/>
	<script language="javascript" type="text/javascript" src="http://connect.facebook.net/en_US/all.js"></script>
	<script language="javascript" type="text/javascript" src="../jquery-1.7.js"></script>
	<script language="javascript" type="text/javascript" src="../jquery-ui.js"></script>
	<script language="javascript" type="text/javascript" src="../macro.js"></script>
	<script language="javascript" type="text/javascript" src="../vector.js"></script>
	<script language="javascript" type="text/javascript" src="../dynamicObject.js"></script>
	<script language="javascript" type="text/javascript" src="../ImageObject.js"></script>
	<script language="javascript" type="text/javascript" src="../ImageDiv.js"></script>
	<script language="javascript" type="text/javascript" src="../Controller.js"></script>
	<script language="javascript" type="text/javascript" src="../SlideShow.js"></script>
	
	<script language="javascript" type="text/javascript">
	function rand( min , max)
	{
		return min + (max - min) * Math.random();
	}
	
	function Comment(text)
	{
		this.m_text = text;
		
		this.getText = function() {return text;}
	}
	function SlideObject(rootDiv,imageURL)
	{
		ImageDiv.call(this,rootDiv,imageURL);
		
		this.m_comments = new Array() ;
		
		this.addComment  = function(text) { this.m_comments.push(new Comment(text)); };
		this.getComments = function() 	  { return this.m_comments;};
		
		this.addClass("Slide");
		
		this.getImage = function() {return this.m_image;};
		
		// Must Be Implemented
		this.getImageSrc    = function(){return this.m_image.src;   };
		this.getImageWidth  = function(){return this.m_image.width; };
		this.getImageHeight = function(){return this.m_image.height;};
	}
	SlideObject.prototype = new ImageDiv();
	SlideObject.prototype.constructor = SlideObject;
	
	function ModernSlideShow( title,creator,created_time)
	{		
		SlideShow.call(this, title,creator,created_time);
		
		this.m_currentSlideIndex = -1;
		this.m_NextshowNextID 	 = undefined;		 
		this.m_isPlaying  		 = false; 
		
		this.m_slideContainerDiv = $("#html-root");
		
		var maxWidth = window.screen.width;
		var maxHeight = window.screen.height;
		this.startShow = function() 
		{	
			$("#MadeleineLayer").animate({"background-color":"black"},5000);
			
			for(var i=0;i<this.m_slides.length;i++)
			{
				var oriWidth  = this.m_slides[i].getImageWidth();
				var oriHeight = this.m_slides[i].getImageHeight();
				// oriWidth : oriHeight = width : maxHeight
				var width = oriWidth * maxHeight / oriHeight;	
			
				this.m_slides[i].setBounds( maxWidth * 0.5 - width* 0.5 , maxHeight * -(i+1) , width , maxHeight);
				this.m_slides[i].getDiv().css({"display":"none"}); 
			}
			
			var outerThis = this; 
			var TitleObject = new HtmlObject($("#html-root"));
			TitleObject.getDiv().css({"position":"absolute","display":"none"});
			TitleObject.setBounds(0,0,window.screen.width,window.screen.height);
			var text = TitleObject.getDiv().prepend("<p>" + this.m_title+"<br>"+ this.m_created_time + "</p>");
			text.css({"text-align":"center","font-size":"100px","font-family":"나눔손글씨 펜","color":"white"});
			
			TitleObject.getDiv().fadeIn(5000);
			TitleObject.getDiv().fadeOut(5000,function(){
				outerThis.showNext();
			});
		};
		
		this.togglePlay = function()
		{
			if(this.m_isPlaying)
				this.stop();
			else
				this.resume();
		}
	
	
		this.stop = function() 
		{
			this.cancelReservedShowNext();
			this.m_slideContainerDiv.stop(true);
			
			this.m_isPlaying = false;
		};
		this.resume = function() 
		{
			this.cancelReservedShowNext();
			this.m_slideContainerDiv.stop(true);
			
			this.m_isPlaying = true;
			
			this.showNext();	
		};
		
		this.cancelReservedShowNext = function()
		{
			if(this.m_NextshowNextID != undefined)
			{
				clearTimeout(this.m_NextshowNextID);
			}
		}
		
		this.showNext = function() 
		{
			this.m_isPlaying = true; 
			if (++this.m_currentSlideIndex < this.m_slides.length) {
				this.m_slides[this.m_currentSlideIndex].getDiv().css({"display":"block"});
				var outerThis = this;
				
				this.m_slides[this.m_currentSlideIndex].getDiv().show();
				
				this.cancelReservedShowNext();
				
				this.m_slideContainerDiv.animate({
					top: "+=" + maxHeight
				}, 3000, function()
				{
					if(outerThis.m_isPlaying)
						outerThis.m_NextshowNextID = setTimeout(function(){outerThis.showNext();},5000);
				});
			}
			else
			{
				this.m_isPlaying = false;
			}
		};
		this.showPrevious = function() 
		{
			if(this.m_currentSlideIndex-- > 0)
			{
				this.cancelReservedShowNext();
				this.m_slideContainerDiv.stop(true);
				
				var outerThis = this;
				this.m_slideContainerDiv.animate({
					top: "-=" + maxHeight
				}, 3000 ,function()
				{
					if(outerThis.m_isPlaying)
						outerThis.m_NextshowNextID = setTimeout(function(){outerThis.showNext();},5000);
				});
			}
		};
		this.showAt = function( index , callback ) 
		{
			if (index >= 0 && index < this.m_slides.length) {
				this.m_slideContainerDiv.stop(true);
				
				var targetSlide = this.m_slides[index];
			
				this.m_slideContainerDiv.animate({
					top :  (-targetSlide.getY())
				}, Math.abs(index - this.m_currentSlideIndex) * 500 ,
					callback);
			}
		};
	}
	ModernSlideShow.prototype = new SlideShow();
	ModernSlideShow.prototype.constructor = ModernSlideShow;
	
	
	var slideShow ;
	var controller;
	
	$(document).ready(function(){

		var vSize = new Vector2( window.screen.availWidth, window.screen.availHeight );
		var vPos  = new Vector2(0,0);

		window.moveTo(vPos.x,vPos.y);
		window.resizeTo(vSize.x,vSize.y);
		
		$("#MadeleineLayer").css({width:"100%",height:"100%"});
		
		<%
		String madeleineId = request.getParameter("id");
		if(madeleineId == null)
			madeleineId = "126";
		MadeleineEntity madeleine = null;
		if(madeleineId != null)
		{
			MadeleineBiz madeleineBiz = new MadeleineBiz();
			MadeleinePhotoBiz photoBiz = new MadeleinePhotoBiz();
			
			System.out.println(madeleineId);
			madeleine =  madeleineBiz.find(madeleineId);
			
			if(madeleine!=null)
			{	
				%>
					slideShow = new ModernSlideShow("<%=madeleine.getName()%>","<%=madeleine.getCreator()%>","<%=madeleine.getCreated_time()%>");
				<%
				ArrayList<MadeleinePhotoEntity> photos = photoBiz.findByParentId(Integer.parseInt(madeleineId));
				
				//마들렌을 만든 사람의 페이스북 아이디를 가지고 검색해서 액세스 토큰을 얻는다. 
				FacebookBiz fbBiz = new FacebookBiz();
				FacebookEntity fbEntity = fbBiz.find(madeleine.getCreator()); 
				
				FacebookClient FB = new DefaultFacebookClient(fbEntity.getAccess_token());
				
				for( MadeleinePhotoEntity photo : photos)
				{
					Connection<Comment> comments = FB.fetchConnection(photo.getFacebook_id() + "/comments", Comment.class);
					
					%>newSlide = slideShow.addSlide(new SlideObject($("#html-root"),"<%=photo.getSrc()%>"));
					<%
					for( Comment comment : comments.getData())
					{
						%>newSlide.addComment("<%=comment.getFrom().getName() + " : " + comment.getMessage() %>"); <%
					}
				}
			}	
			else
			{
				return;
			}
		}
		%>
		
		controller = new Controller(); 
		controller.initThumbnails(slideShow.getSlides());
		
		slideShow.startShow();
	});
	
	</script>
</head>
<body>
	<div id = "MadeleineLayer" style = "position:absolute; left:0px; top:0px;z-index:-5;width:100%;height:100%; ">
	</div>

	<div id = "html-root" style= "position:absolute;"></div>
	
	<div class = "ControllerZone" id = "ControllerZone" 
		onmouseover = "controller.onControllerOn(); " 
		onmouseout  = "controller.onControllerOff();" >
	</div>
	<div class = "Controller" id = "Controller">
		<input id="showPreviousButton" 	 type="button" onclick="slideShow.showPrevious();"/>
		<input id="togglePlayButton"	 type="button" onclick="slideShow.togglePlay();"/>
		<input id="showNextButton" 		 type="button" onclick="slideShow.showNext();"/>
	</div>
	<div class = "ThumbnailZone" id = "ThumbnailZone">
		<div class = "ThumbnailContainer" id = "ThumbnailContainer">
		
		</div>
		<div id = "Film">
			<img src ="../image/film.png" width = 50 height = 100 > 
		</div>
		<div style = "left:80%; top:0px; width:100%; height:100%; z-index:21; background-color:black;position:absolute;">
			
		</div>
	</div>
	
	<script> 
	</script>
</body>
</html>