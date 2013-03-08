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
	</style> 
	<style>
	.ControllerButton
	{
		width:50px;
		height:50px;
	}
	<style> 
	.Thumbnail
	{
		width:80px;
		height:80px;
	}
	</style>
	<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css"/>
	<script language="javascript" type="text/javascript" src="http://connect.facebook.net/en_US/all.js"></script>
	<script language="javascript" type="text/javascript" src="../jquery-1.7.js"></script>
	<script language="javascript" type="text/javascript" src="../jquery-ui.js"></script>
	<script language="javascript" type="text/javascript" src="../macro.js"></script>
	<script language="javascript" type="text/javascript" src="../vector.js"></script>
	<script language="javascript" type="text/javascript" src="../dynamicObject.js"></script>
	<script language="javascript" type="text/javascript" src="../ImageObject.js"></script>
	
	<script language="javascript" type="text/javascript">
	
	function rand( min , max)
	{
		return min + (max - min) * Math.random();
	}
	/*
	function InitController(screenX, screenY)
	{
		var widthScale = 0.3;
		$("#ControllerZone").css({width:screenX+"px" , height : screenY*widthScale+"px" ,
						 		left:0+"px" , top:(1-widthScale) * screenY+"px"});			
		$("#Controller").css({top : (1-widthScale * 0.5) * screenY+"px"});
		$("#Controller").css({left : (screenX * 0.5 - $("#Controller").width() * 0.5) + "px" });
	}
	*/
	
	function Controller()
	{
		this.m_htmlController = $("#Controller");
		this.m_htmlControllerZone = $("#ControllerZone");
		
		this.m_thumbnails = new Array();
		
		var outerThis = this;
		
		this.initController = function(screenX, screenY)
		{
			var widthScale = 0.3;
			$("#ControllerZone").css({width:screenX+"px" , height : screenY*widthScale+"px" ,
							 		left:0+"px" , top:(1-widthScale) * screenY+"px"});			
			$("#Controller").css({top : (1-widthScale * 0.5) * screenY+"px"});
			$("#Controller").css({left : (screenX * 0.5 - $("#Controller").width() * 0.5) + "px" });
		}
		this.initThumnails = function(slides)
		{
			var rootDiv = $("#ControllerZone");
			for( var i =0;i<slides.length;i++)
			{
				rootDiv.prepend("")
			}
		}
		
		
		this.isHitWithController = function(mouseX,mouseY)
		{
			var x = $("#Controller").position().left;
			var y = $("#Controller").position().top;
			
			var width = $("#Controller").width();
			var height = $("#Controller").height();
			
			return Between(x,mouseX,x+width) && Between(y,mouseY,y+height);
		}
		this.onControllerOn = function()
		{
			if (!this.isHitWithController(event.clientX,event.clientY)) {
				$("#Controller").clearQueue();
				$("#Controller").show("fast");
			}
		};
		this.onControllerOff = function()
		{
			if (!this.isHitWithController(event.clientX,event.clientY)) {
				$("#Controller").clearQueue();
				$("#Controller").fadeOut("fast");
			}
		};
		
		this.stop = function() 
		{
			
		};
		this.resume = function()
		{
			
		};
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
			
			var targetSize = 700;
			var scale = targetSize/aveSize;
				
			outerSlideObject.setBounds(window.screen.availWidth * 0.5,window.screen.availHeight * 0.5 - 90, oriWidth * scale, oriHeight * scale);
			outerSlideObject.setAlpha(0);
	//		outerSlideObject.setRotation(toRadian( rand( - 15, 15)));
		}
		this.fillStyle = "rgb(255,255,220)";
		
		this.addComment = function( comment)
		{
			this.m_comments.push(comment);
		}
		
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
								
							//	context.globalAlpha = 1.0;
								context.shadowOffsetX = 0;
								context.shadowOffsetY = 0;
								context.shadowBlur = 7;
								context.shadowColor = "Black";
							
								context.fillRect(this.getLeftX(),this.getTopY(),this.m_vSize.x,this.m_vSize.y + 80);
							context.restore();
						this.setSizeByDelta(-30,-30);
						
						
						context.drawImage(this.image,this.getLeftX(),this.getTopY(),this.m_vSize.x,this.m_vSize.y);
						
						var fontSize = 23;
						context.fillStyle = "rgb(0,0,0)";
						context.font  = fontSize+"px �����ձ۾� ��";
						
						for(var i=0;i<this.m_comments.length;i++)
						{
							context.fillText(this.m_comments[i],this.getLeftX(), this.getY() + this.m_vSize.y*0.5 + fontSize * (i+1),this.getWidth());
						}
					context.restore();
				}
			}
		}
	}
	SlideObject.prototype = new ImageObject();
	SlideObject.prototype.constructor = SlideObject;
	
	function SlideShow()
	{
		this.m_images = new Array();
		this.m_currentIndex = -1;
		
		this.addImage = function( imageSrc )
		{
			var newImg = new SlideObject();
			newImg.setImage(imageSrc);

			this.m_images.push(newImg);
			
			return newImg;
		};
		
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
						context.font  = fontSize + "px �����ձ۾� ��";
						
						context.fillText(title,this.m_vPos.x,this.m_vPos.y);
					
					context.restore();
				}
			};
			
			titleObject.setBounds(400, 400, 400, 400);
			titleObject.setAlpha(0);
			
			var aniCallback = function ()
			{
				// ȭ�鿡 ���̵����� ������ Ÿ��Ʋ�� ���� ����, 5�� �Ŀ� 
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
			if(this.m_currentIndex >= 0)
			{
				var previousSlide = this.m_images[this.m_currentIndex];
				previousSlide.animate({alpha : 0,speed : 0.04});
			}
			this.m_currentIndex ++ ;
			
			if(this.m_images.length > this.m_currentIndex)
			{
				this.m_images[this.m_currentIndex].animate({alpha : 1, speed : 0.04});
				setTimeout(function() {slideShow.showNext();},5000);
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
	
	var slideShow = new SlideShow();
	var Controller = new Controller(); 
	
	$(document).ready(function(){
		var vSize = new Vector2( window.screen.availWidth, window.screen.availHeight );
		var vPos  = new Vector2(0,0);

		window.moveTo(vPos.x,vPos.y);
		window.resizeTo(vSize.x,vSize.y);
		
		$("#MadeleineLayer").css({width:"100%",height:"100%"});
		SetCanvasSize( $("#MadeleineLayer").width(),$("#MadeleineLayer").height());
		
		Controller.initController(vSize.x,vSize.y);
		
		var newSlide = null;
		<%
		String madeleineId = request.getParameter("id");
		if(madeleineId == null)
			madeleineId = "77";
		MadeleineEntity madeleine = null;
		if(madeleineId != null)
		{
			MadeleineBiz madeleineBiz = new MadeleineBiz();
			MadeleinePhotoBiz photoBiz = new MadeleinePhotoBiz();
			
			System.out.println(madeleineId);
			madeleine =  madeleineBiz.find(madeleineId);
			
			if(madeleine!=null)
			{	
				ArrayList<MadeleinePhotoEntity> photos = photoBiz.findByParentId(Integer.parseInt(madeleineId));
				
				//���鷻�� ���� ����� ���̽��� ���̵� ������ �˻��ؼ� �׼��� ��ū�� ��´�. 
				FacebookBiz fbBiz = new FacebookBiz();
				FacebookEntity fbEntity = fbBiz.find(madeleine.getCreator()); 
				
				FacebookClient FB = new DefaultFacebookClient(fbEntity.getAccess_token());
				
				for( MadeleinePhotoEntity photo : photos)
				{
					Photo fbPhto = FB.fetchObject(photo.getFacebook_id(), Photo.class);
					Connection<Comment> comments = FB.fetchConnection(photo.getFacebook_id() + "/comments", Comment.class);
							
					%>newSlide = slideShow.addImage("<%=photo.getSrc()%>");
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
	});
	
	
	
	</script>
</head>
<body>
	<div id = "MadeleineLayer" style = "position:absolute; left:0px; top:0px;z-index:-1;"
			onmousemove = "ObjectManager.mouseEventProcess(event);"
			onmousedown = "ObjectManager.onmousedown(event);"
			onmouseup   = "ObjectManager.onmouseup(event);">  
			<canvas id 	  = "MadeleineCanvas"
					width ="100%" height="100%">����ϰ� ��� �� �������� HTML5�� �������� �ʽ��ϴ�.</canvas>
	</div>
	
	<div id = "ControllerZone" style = "position:absolute;z-index:10;background-color:black;opacity:0;" 
		onmouseover = "Controller.onControllerOn();" 
		onmouseout = "Controller.onControllerOff();" >
	</div>
			<div id = "Controller" style = "position:absolute; left:500px; background-color:gray; z-index:11; display:none;" >
				<input type="button"/>
				<input type="button"/>
				<input type="button"/>
			</div>
	<script> 
		context = document.getElementsByTagName('canvas')[0].getContext('2d');
		
		var ClearColor = 255; 
		
		function draw()
		{
			//clear
			if(Math.round(ClearColor) !=0 )
			{
				var result = singleLerp(ClearColor,0,0.01);
				if(result.result)
				{
					ClearColor = 0;
					slideShow.startShow("<%=madeleine.getName()%>","<%=madeleine.getCreator()%>");
				}
				else	
				{
					ClearColor = result.value; 
				}
			}
			
			context.fillStyle = "rgb(" + Math.round(ClearColor) + "," +  Math.round(ClearColor) +"," +  Math.round(ClearColor) +")";
			context.fillRect(0,0,$("#MadeleineCanvas").width(),$("#MadeleineCanvas").height());
		
			// ������Ʈ ������ 
			ObjectManager.onMove();
			ObjectManager.onRender(context);

		}
		
		function AddNewObject( event )
		{
			
		}
		setInterval(draw,10);
	</script>
</body>
</html>