<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import=" java.util.ArrayList,
    madeleine.biz.*,
    madeleine.entity.*,
    facebook.*,
    com.restfb.*,
    com.restfb.types.*,
    java.net.URLEncoder"%>
    
<!DOCTYPE html>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
	<style>
	BODY
	{ 
		width:100%;
		height:100%;
		overflow-y:hidden; 
		overflow-x:hidden;
		background-color : black;
	}

	</style>
	<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css"/>
	<link href="../css/custom/Controller.css" rel="stylesheet" type="text/css"/>
	<script language="javascript" type="text/javascript" src="http://connect.facebook.net/en_US/all.js"></script>
	<script language="javascript" type="text/javascript" src="../js/jquery-1.7.1.js"></script>
	<script language="javascript" type="text/javascript" src="../js/jquery-ui.js"></script>
	<script language="javascript" type="text/javascript" src="../js/custom/macro.js"></script>
	<script language="javascript" type="text/javascript" src="../js/custom/vector.js"></script>
	<script language="javascript" type="text/javascript" src="../js/custom/dynamicObject.js"></script>
	<script language="javascript" type="text/javascript" src="../js/custom/ImageObject.js"></script>
	<script language="javascript" type="text/javascript" src="../js/custom/ImageDiv.js"></script>
	<script language="javascript" type="text/javascript" src="../js/custom/Controller.js"></script>
	
	<script language="javascript" type="text/javascript">
	function rand( min , max)
	{
		return min + (max - min) * Math.random();
	}
	
	function SlideObject()
	{	
		ImageObject.call(this);
	
		this.m_comments = new Array();
		this.m_vPosDelta = new Vector2(0,0);
	
		var prevOnLoad = this.image.onload;
		var outerSlideObject = this;
		this.image.onload = function()
		{
			prevOnLoad.call(this);
			
			var oriWidth = outerSlideObject.image.width;
			var oriHeight = outerSlideObject.image.height;
			var aveSize = (oriWidth+oriHeight) * 0.5;
			
			var targetSize = 450;
			var scale = targetSize/aveSize;
				
			outerSlideObject.setBounds(window.screen.availWidth * 0.5 + rand(-150,150),window.screen.availHeight * 0.5 - 350, oriWidth * scale, oriHeight * scale);
			outerSlideObject.setAlpha(0);
			outerSlideObject.setRotation(toRadian( Math.random() * 60 - 30));
		}
		this.fillStyle = "rgb(255,255,220)";
		
		this.addComment = function( comment)
		{
			this.m_comments.push(comment);
		};
		this.getImageSrc = function() {return this.image.src;}
		///////// override 
		var prevOnMove = this.onMove;
		this.onMove = function()
		{
			prevOnMove.call(this);
			
			this.m_vPos.x += this.m_vPosDelta.x;
			this.m_vPos.y += this.m_vPosDelta.y;
		};
		
		this.onRender = function(context)
		{
			if(this.m_isImageLoaded)
			{
				if(this.m_vSize.x > 0 && this.m_vSize.y > 0 && this.isVisible())
				{
					context.save();
						this._applyTransform(context);
						this.setSizeByDelta(30,30);
							context.save();
								
								context.shadowOffsetX = 0;
								context.shadowOffsetY = 0;
								context.shadowBlur = 1;
								context.shadowColor = "Black";
							
								context.fillRect(this.getLeftX(),this.getTopY(),this.m_vSize.x,this.m_vSize.y + 80);
							context.restore();
						this.setSizeByDelta(-30,-30);
						
						context.drawImage(this.image,this.getLeftX(),this.getTopY(),this.m_vSize.x,this.m_vSize.y);
						
						var fontSize = 23;
						context.fillStyle = "rgb(0,0,0)";
						context.font  = fontSize+"px 나눔손글씨 펜";
						
						for(var i=0;i<this.m_comments.length;i++)
						{
							context.fillText(this.m_comments[i],this.getLeftX(), this.getY() + this.m_vSize.y*0.5 + fontSize * (i+1),this.getWidth());
						}
					context.restore();
				}
			}
		}
	}
	SlideObject.prototype = ImageObject.prototype;
	SlideObject.prototype.constructor = SlideObject;
	
	function SlideShow()
	{
		this.m_images = new Array();
		this.m_currentIndex = -1;
		
		this.addSlide = function( imageSrc )
		{
			var newImg = new SlideObject();
			newImg.setImage(imageSrc);

			this.m_images.push(newImg);
			
			return newImg;
		};
		this.getSlides = function() {return this.m_images;};
		this.startShow = function(title,creator)
		{
			var titleObject = new DynamicObject();
				
			titleObject.title = title;
			titleObject.creator = creator; 
			
			titleObject.onRender = function(context)
			{
				if(this.m_vSize.x > 0 && this.m_vSize.y > 0 && this.isVisible())
				{
					context.save();
					
						this._applyTransform(context);
						
						var fontSize = 100;
						context.fillStyle = "rgb(255,255,255)";
						context.font  = fontSize + "px 나눔손글씨 펜";
						
						context.fillText(title,this.m_vPos.x,this.m_vPos.y);
					
					context.restore();
				}
			};
			
			titleObject.setBounds(400, 400, 400, 400);
			titleObject.setAlpha(0);
			
			var aniCallback = function ()
			{
				// 화면에 페이드인이 끝나고 타이틀이 나온 다음, 5초 후에 
				var outerThis = this;
				setTimeout(function() { 
								outerThis.animate({alpha : 0});
								slideShow.showNext();
							}
							,5000);
			};
			titleObject.animate({alpha : 1.0, callback : aniCallback});
		};
		this.showNext = function()
		{
			this.m_currentIndex ++ ;
			if(this.m_images.length > this.m_currentIndex)
			{
				this.m_images[this.m_currentIndex].animate({y : this.m_images[this.m_currentIndex].getY() + 250 ,alpha : 1,callback: function() {this.m_vPosDelta.y = 0.3;} });
				setTimeout(function() {slideShow.showNext();},5000);
				var showObject = this.m_images[this.m_currentIndex];
				setTimeout(function() {showObject.animate({alpha:0,speed:0.04});},15000); 
			}
			else
			{
				this.m_currentIndex--;	
			}
		};
		this.showPrevious = function()
		{
			
		};
	}
	
	var slideShow ;
	var controller;
	
	$(document).ready(function(){
		slideShow = new SlideShow();

		var vSize = new Vector2( window.screen.availWidth, window.screen.availHeight );
		var vPos  = new Vector2(0,0);

		window.moveTo(vPos.x,vPos.y);
		window.resizeTo(vSize.x,vSize.y);
		
		$("#MadeleineLayer").css({width:"100%",height:"100%"});
		SetCanvasSize( $("#MadeleineLayer").width(),$("#MadeleineLayer").height());

		var newSlide = null;
		<%
		String madeleineId = request.getParameter("id");
		MadeleineEntity madeleine = null;
		if(madeleineId != null)
		{
			MadeleineBiz madeleineBiz = new MadeleineBiz();
			MadeleinePhotoBiz photoBiz = new MadeleinePhotoBiz();
			
			System.out.println(madeleineId);
			madeleine =  madeleineBiz.findByIdx(madeleineId);
			
			if(madeleine!=null)
			{	
				ArrayList<MadeleinePhotoEntity> photos = photoBiz.findByParentId(Integer.parseInt(madeleineId));
				
				//마들렌을 만든 사람의 페이스북 아이디를 가지고 검색해서 액세스 토큰을 얻는다. 
				FacebookBiz fbBiz = new FacebookBiz();
				FacebookEntity fbEntity = fbBiz.find(madeleine.getCreator()); 
				FacebookClient FB = new DefaultFacebookClient(fbEntity.getAccess_token());
				
				for( MadeleinePhotoEntity photo : photos)
				{
					Connection<Comment> comments = FB.fetchConnection(photo.getFacebook_id() + "/comments", Comment.class);
					String photoSrc = photo.getSrc();
					photoSrc = photoSrc.trim();
					%>newSlide = slideShow.addSlide("<%=photoSrc%>");
					<%
					for( Comment comment : comments.getData())
					{
						String message = comment.getMessage();
						//message = new String(message.getBytes("UTF8"),"UTF8");
						
						message = message.replace("\'","\\'");
						message = message.replace("\n","\\n");
						message = message.replace("\r","\\r");
						message = message.replace("\t","\\t");
						%>
							newSlide.addComment('<%=comment.getFrom().getName() + " : " + message %>'); 
						<%
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
	});
	
	
	
	</script>
</head>
<body>
	<div id = "MadeleineLayer" style = "position:absolute; left:0px; top:0px;z-index:-1;"
			onmousemove = "ObjectManager.mouseEventProcess(event);"
			onmousedown = "ObjectManager.onmousedown(event);"
			onmouseup   = "ObjectManager.onmouseup(event);">  
			<canvas id 	  = "MadeleineCanvas"
					width ="100%" height="100%">사용하고 계신 웹 브라우져가 HTML5를 지원하지 않습니다.</canvas>
	</div>
	<div id = "html-root"></div>
	
	<div class = "ControllerZone" id = "ControllerZone" 
		onmouseover = "controller.onControllerOn();" 
		onmouseout = "controller.onControllerOff();" >
	</div>
	<div class = "Controller" id = "Controller">
		<input type="button"/>
		<input type="button"/>
		<input type="button"/>
	</div>
	<div class = "ThumbnailZone" id = "ThumbnailZone">
		<div class = "ThumbnailContainer" id = "ThumbnailContainer">
		
		</div>
		<div id = "Film">
			<img src ="../image/film.png" width = 50 height = 100 > 
		</div>
		<div style = "left:80%; top:0px; width:500px; height:500px; z-index:21; background-color:black;position:absolute;">
			
		</div>
	</div>
	
	<audio id = "audio_oldmovie" autoplay ="autoplay" loop = "loop" > 
		<source src = "./sounds/photo.mp3" type = "audio/mp3"></source>
	</audio>
	
	<script> 
		context = document.getElementsByTagName('canvas')[0].getContext('2d');
		
		var ClearColor = 255; 
		
		function draw(){
			//clear
			if (Math.round(ClearColor) != 0) {
				var result = singleLerp(ClearColor, 0, 0.01);
				if (result.result) {
					ClearColor = 0;
					slideShow.startShow("<%=madeleine.getCreated_time()%>", "<%=madeleine.getCreator()%>");
				}
				else {
					ClearColor = result.value;
				}
			}
	
			context.fillStyle = "rgb(" + Math.round(ClearColor) + "," + Math.round(ClearColor) + "," + Math.round(ClearColor) + ")";
			context.fillRect(0, 0, $("#MadeleineCanvas").width(), $("#MadeleineCanvas").height());
			
			// 오브젝트 렌더링 
			ObjectManager.onMove();
			ObjectManager.onRender(context);
		}
		setInterval(draw,10);
	</script>
</body>
</html>