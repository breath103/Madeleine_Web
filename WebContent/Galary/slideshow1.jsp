<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%@ page import = "madeleine.biz.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css"/>
	<link href="../css/custom/Controller.css" rel="stylesheet" type="text/css"/>
	
	<script language="javascript" type="text/javascript" src="http://connect.facebook.net/en_US/all.js"></script>
	<script language="javascript" type="text/javascript" src="../js/jquery-1.7.js"></script>
	<script language="javascript" type="text/javascript" src="../js/jquery-ui.js"></script>
	<script src="http://code.jquery.com/mobile/1.0/jquery.mobile-1.0.min.js"></script>
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
			width 		    :180px;
			height			:auto;
			overflow		:hidden;
		}
		.PhotoSlide img
		{
			width :100%;
			height:auto;
			position:relative; 
		}
		.PhotoSlide p
		{
			font-family:"나눔손글씨 펜";
			font-size:20px;
			line-height:1px;
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
			this.addComment = function(comment)
			{
				this.m_comments.push(comment);
				
				this.getDiv().append("<p>"+comment+"</p>");

				return comment;
			};
		}
		PhotoSlide.prototype = new ImageDiv();
		PhotoSlide.constructor = PhotoSlide;
		
		
		function SnapShotSildeShow(title,creator,created_time)
		{
			SlideShow.call(this,title,creator,created_time);
			
			this.m_currentSlideIndex = -1 ;
			
			this.currentSlide = function() {return this.m_slides[this.m_currentSlideIndex];};
			this.addSlide = function(type,src)
			{ 
				if(type=="photo")
				{
					var slide = new PhotoSlide($("#html-root"),src);
					this.m_slides.push(slide); 
					return slide;
				}
			};			
			this.startShow    = function() 
			{
				// 슬라이드 오브젝트들을 재배치 
				for (var i = 0; i < this.m_slides.length; i++) 
				{
					var slide	 = this.m_slides[i];
					var slideDiv = slide.getDiv();
					
					var centerPos = screenWidth/2 + rand(-screenWidth*0.1,screenWidth*0.1);
					slideDiv.css({
						"left": centerPos - slideDiv.width() / 2,
						"top" :	-100,
						"width": screenWidth * 0.4
					});
					slideDiv.rotate(rand(-30,30) + "deg");
					slideDiv.css({"opacity":0.0,
								   "z-index":100+i});
				}
				this.showNext();
			};
			this.stop         = function() {};
			this.resume 	  = function() {};
			this.showNext     = function() 
			{
				this.m_currentSlideIndex++;
				
				var slide = this.currentSlide();
				var slideDiv = slide.getDiv();
				
				var outerThis = this;
				slideDiv.animate({"opacity":1.0,
								  "top":"+="+screenHeight*0.35},2000,function(){
								  		slideDiv.animate({"top":"+="+screenHeight * 0.5},18000,"linear",function(){
											slideDiv.animate({"top":"+="+screenHeight * 0.2,"opacity":0},4000);
										});
										setTimeout(function(){
											outerThis.showNext();	
										},4000);
								  });
			};
			this.showPrevious = function() {};
			this.showAt       = function( index ) {};
		}
		SnapShotSildeShow.prototype = new SlideShow();
		SnapShotSildeShow.constructor = SnapShotSildeShow;
	
		
		var slideShow;
		var newSlide;
		$(document).ready(function(){
				<%
					MadeleineBiz biz = new MadeleineBiz();
					out.write(biz.getHTMLSlides("SnapShotSildeShow",request.getParameter("id")));
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
</body>
</html>