<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "madeleine.biz.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
	<script language="javascript" type="text/javascript" src="../js/custom/SlideShow.js"></script>
	<script language="javsscript" type="text/javascript" src="../js/jquery-animate-css-rotate-scale.js"></script>
	<script language="javsscript" type="text/javascript" src="../js/jquery-css-transform.js"></script>
	<style>
		body
		{
			background-color:black;
			width:100%;
			height:100%;
			overflow:hidden;
		}
		.PhotoSlide
		{	
			position		:absolute;
			background-color:white;
			padding-top     :5px;
	 		padding-left    :5px;
	 		padding-right   :5px;
			padding-bottom  :5px;
		}
		.Page
		{
			background-image:url("./images/page_bg1.jpg");
			background-repeat:no-repeat;
			background-size:100% 100%;
			display : inline-block;
			width : 1024px;
			height: 768px; 
			
			position : absolute;
			left:0px;
			top:0px;
		}
		.PhotoSlide img
		{
			width :100%;
			height:auto;
			position:relative; 
		}
		#html-root
		{
			background-color : black;
		}
	</style>
	<script language="javascript" type="text/javascript">
	
		var screenWidth = 1024;
		var screenHeight = 768;
		
		function PhotoSlide(rootDiv,imageSrc)
		{
			ImageDiv.call(this,rootDiv,imageSrc);
			this.getDiv().addClass("PhotoSlide");
			
			////////////////////////////////////////			
			this.m_comments = new Array();
			////////////////////////////////////////
			this.autoScale = function(targetSize)
			{
				var oriWidth  = this.getDiv().width();
				var oriHeight = this.getDiv().height();
				var aveSize = (oriWidth+oriHeight) * 0.5;
				
				var scale = targetSize/aveSize;
					
				this.setSize(oriWidth * scale,oriHeight * scale);
			}
			this.addComment = function(comment)
			{
				this.m_comments.push(comment);
				return comment;
			};
		}
		PhotoSlide.prototype = ImageDiv.prototype;
		PhotoSlide.constructor = PhotoSlide;
		
		function PostSlide(rootDiv,text)
		{
			HtmlObject.call(this,rootDiv);
			this.getDiv().addClass("PostSlide");
			
			////////////////////////////////////////			
			this.m_comments = new Array();
			////////////////////////////////////////
			this.autoScale = function(targetSize)
			{
				var oriWidth  = this.getDiv().width();
				var oriHeight = this.getDiv().height();
				var aveSize = (oriWidth+oriHeight) * 0.5;
				
				var scale = targetSize/aveSize;
					
				this.setSize(oriWidth * scale,oriHeight * scale);
			}
			this.addComment = function(comment)
			{
				this.m_comments.push(comment);
				return comment;
			};
		}
		PostSlide.prototype = HtmlObject.prototype;
		PostSlide.constructor = PostSlide;
		
		function Page(rootDiv)
		{
			HtmlObject.call(this,rootDiv);
			
			this.m_contents = new Array();
			
			this.m_slideCapacity = 2; // 이 페이지 디자인에 넣을 수 있는 슬라이드 수
			this.m_pageTimeout = 3000; // 페이지가 보여지는시간.
			
			this.getDiv().addClass("Page");
			
			this.getTimeout = function() { return this.m_pageTimeout;};
			this.addContent = function(content)
			{
				content.autoScale( 400 );
				this.getDiv().append(content.getDiv());
				this.m_contents.push(content);
				
				return !this.isFull();
			};
			
			//페이지안의 컨텐츠 위치 정렬 
			this.arrangeContents = function()
			{
				var firstPhoto = this.m_contents[0];
				if(firstPhoto)	
					firstPhoto.setPos(30,30);
					
				var secondPhoto = this.m_contents[1];
				if(secondPhoto)
				{
					secondPhoto.setPos(this.getDiv().width()  - secondPhoto.getWidth()  - 50,
								   	   this.getDiv().height() - secondPhoto.getHeight() - 50);
				}	
				this.getDiv().children("div").rotate(rand(-45,45) + "deg");
			}
			
			// 페이지가 보여지는 효과 설정
			this.showPage = function(onEndShowPage)
			{
				switch(Math.round(Math.random() * 3))
				{
					case 0 : this.getDiv().animate({"left":"-=1024px"},
												2500,
												onEndShowPage);
							 break;
					case 1 : 
							this.getDiv().css({"left":"0px","top":"0px","display":"none"});
							this.getDiv().fadeIn(2500,
							onEndShowPage);
							break;
					case 2 : 
							this.getDiv().css({"left":"0px","top": -screenHeight+"px"});
							this.getDiv().animate({"top":"+="+screenHeight+"px"},
									2500,
									onEndShowPage);
							break;
					default : 
							this.getDiv().animate({"left":"-=1024px"},
								2500,
								onEndShowPage);
							break;
				}
			}
			
			this.isFull = function()
			{
				return this.m_contents.length >= this.m_slideCapacity;
			};
		}
		Page.prototype = HtmlObject.prototype;
		Page.consturcotr = Page;
		
		function AlbumBookSlideShow(title,creator,created_time)
		{
			SlideShow.call(this,title,creator,created_time);
			var outerThis = this;
			
			this.m_currentSlideIndex = -1 ;
			this.m_photoSlideArray;
			
			this.currentSlide = function() {return this.m_slides[this.m_currentSlideIndex];};
			this.previousSlide= function() 
			{
				if( (this.m_currentSlideIndex - 1) < 0 ||
					(this.m_currentSlideIndex - 1) >= this.m_slides.length)
					return null;	
				return this.m_slides[this.m_currentSlideIndex-1];
			};
			this.nextSlide = function()
			{
				if( (this.m_currentSlideIndex + 1) < 0 ||
				    (this.m_currentSlideIndex + 1) >= this.m_slides.length)
					return null;	
				return this.m_slides[this.m_currentSlideIndex + 1];
			};
			this.addSlide = function(type,src)
			{ 
				if(type=="photo")
				{
					var slide = new PhotoSlide($("#html-root"),src);
					this.m_slides.push(slide); 
					thumbnailController.addThumbnail(slide.getDiv().find("img")[0].src);
					return slide;
				}
			};			
			this.startShow    = function() 
			{
				this.m_photoSlideArray = this.m_slides;
				
				this.m_slides = new Array();
				
				var pageCnt = 0;
				var page = new Page($("#html-root"));
				
				this.m_slides.push(page);
				for(var i=0;i<this.m_photoSlideArray.length;i++)
				{
					if(! page.addContent(this.m_photoSlideArray[i]))
					{
						page.getDiv().css({"z-index": 100+i});
						pageCnt++;
						page.arrangeContents();
						page = new Page($("#html-root"));
						this.m_slides.push(page);
					}	
				}
				$(".Page").css({"left":"1024px"});
				
				setTimeout(function(){
					outerThis.showNext();
				},2500);
			};
			this.stop         = function() {};
			this.resume 	  = function() {};
			this.showNext     = function() 
			{
				this.m_currentSlideIndex++;
				
				var currentSlide = this.currentSlide();
				currentSlide.showPage(function(){
					var prevSlide = outerThis.previousSlide();
					if(prevSlide)
						prevSlide.getDiv().hide();
					setTimeout(function(){
						outerThis.showNext();
					},currentSlide.getTimeout());
				});
			};
			this.showPrevious = function() {};
			this.showAt       = function( index ) {};
		}
		AlbumBookSlideShow.prototype   = SlideShow.prototype;
		AlbumBookSlideShow.constructor = AlbumBookSlideShow;
		
		function ThumbnailController()
		{
			this.addThumbnail = function(src)
			{
				var newThumbnail = new ImageDiv($("#thumbnailContainer"),src);
				
				newThumbnail.getDiv().css({"display":"inline","height":"70px","width":"70px"});
				newThumbnail.getDiv().children("img").css({"width":"70px","height":"70px"});
			}
			$("#thumbnailContainer").draggable({ axis: 'x' });
		}
		thumbnailController = new ThumbnailController();
				
		var slideShow;
		var newSlide;
		$(document).ready(function(){
			$("#thumbnailContainer").draggable({ axis: 'x' });
			
			window.moveTo(0,0);
			window.resizeTo(screenWidth,screenHeight);
			window.onresize = function()
			{
				if(window.outerHeight != screenHeight ||
				   window.outerWidth  != screenWidth)
				{
					window.moveTo(0,0);
					window.resizeTo(screenWidth,screenHeight);
				}
			};
			
			<%
				MadeleineBiz biz = new MadeleineBiz();
				out.write(biz.getHTMLSlides("AlbumBookSlideShow",request.getParameter("id")));
			%>
			
			slideShow.startShow();
		});
	</script>
<title></title>
</head>
	<body>
		<center>
			<div id = "html-root">
			
			</div>
		</center>
		<div id="controllerContainer" style = "position:absolute; left:0px;top:70%;width:100%;height:30%;background-color:gray;z-index:1000;">
			<center>
				<div id="controller" style = "position:absolute;width:100px;height:30px;left:50%;top:30%">
					<input type=button>
					<input type=button>
					<input type=button>
				</div>
				<div id="thumbnailBar" style ="position:absolute;top:60%;height:70px; left:10%;width:80%;background-color:yellow;overflow:hidden">
					<div id="thumbnailContainer" style= "height:100%"> 
					</div>
				</div>
				<div id="filmContainer" style="position:absolute;width:50px;height:100px;left:90%;top:60%;">
					<img style="width:auto;height:100%;"src="./images/film.png"/>
				</div>
			</center>
		</div>
	</body>
</html>