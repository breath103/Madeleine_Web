<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css"/>
	<link href="../css/custom/Controller.css" rel="stylesheet" type="text/css"/>
	
	<script language="javascript" type="text/javascript" src="http://connect.facebook.net/en_US/all.js"></script>
	<script language="javascript" type="text/javascript" src="../js/jquery-1.7.js"></script>
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
	/*		overflow:hidden;*/
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
			this.addComment = function(comment)
			{
				this.m_comments.push(comment);

				return comment;
			};
		}
		PhotoSlide.prototype = new ImageDiv();
		PhotoSlide.constructor = PhotoSlide;
		
		
		function SpreadBoardSlideShow(title,creator,created_time)
		{
			SlideShow.call(this,title,creator,created_time);
			
			this.m_currentSlideIndex = -1 ;
			
			this.currentSlide = function() {return this.m_slides[this.m_currentSlideIndex];};
			this.addSlide = function(slide)
			{ 
				this.m_slides.push(slide); 
				return slide;
			};			
			this.startShow    = function() 
			{
				// 슬라이드 오브젝트들을 재배치 
				for (var i = 0; i < this.m_slides.length; i++) 
				{
					var slide	 = this.m_slides[i];
					var slideDiv = slide.getDiv();
					slideDiv.width(screenWidth*1.2);
		//			slideDiv.height(screenHeight*1.2);
					
					slideDiv.css({
						"left" : screenWidth  * 0.5 - slideDiv.width()  * 0.5,
						"top"  : screenHeight * 0.5 - slideDiv.height() * 0.5
					});
					slideDiv.rotate(rand(-45,45) + "deg");
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
				
				var slideWidth  = screenWidth * 0.3;
				var slideHeight = screenHeight * 0.3;
				slideDiv.animate({"opacity":1.0,
								  "rotate" :rand(-45,45) + "deg",
								  "left" : rand(0,screenWidth  - slideWidth),
								  "top"  : rand(0,screenHeight - slideHeight),
								  "width":slideWidth,
								  "height":"auto"},5000,function(){
									 setTimeout(function(){
										 outerThis.showNext();
									 },3000);
								  });
				}
			this.showPrevious = function() {};
			this.showAt       = function( index ) {};
		}
		SpreadBoardSlideShow.prototype = new SlideShow();
		SpreadBoardSlideShow.constructor = SpreadBoardSlideShow;
	
		
		var slideShow;
		var newSlide;
		$(document).ready(function(){
			window.moveTo(0,0);
			window.resizeTo(screenWidth,screenHeight);
			
				slideShow = new SpreadBoardSlideShow("Madeleine","100002717246207","2011-12-11 02:14:49.0");
				newSlide = slideShow.addSlide(new PhotoSlide($("#html-root"),"http://a2.sphotos.ak.fbcdn.net/hphotos-ak-ash4/s720x720/303945_138728336227740_100002717246207_135468_700437639_n.jpg"));
				newSlide = slideShow.addSlide(new PhotoSlide($("#html-root"),"http://a8.sphotos.ak.fbcdn.net/hphotos-ak-ash4/s720x720/305746_127054037395170_100002717246207_105506_889337744_n.jpg"));
				newSlide = slideShow.addSlide(new PhotoSlide($("#html-root"),"http://a6.sphotos.ak.fbcdn.net/hphotos-ak-snc7/s720x720/316401_129238950510012_100002717246207_110857_1045588577_n.jpg"));
				newSlide = slideShow.addSlide(new PhotoSlide($("#html-root"),"http://a7.sphotos.ak.fbcdn.net/hphotos-ak-ash4/316042_110956215671619_100002717246207_56290_101033500_n.jpg"));
				newSlide.addComment("Yongkuk Woo : 상현아 학교 개학이야?"); newSlide.addComment("Sanghyun  Lee : 내일부터 개학이요 ㅠㅠ"); newSlide = slideShow.addSlide(new PhotoSlide($("#html-root"),"http://a5.sphotos.ak.fbcdn.net/hphotos-ak-ash4/s720x720/318600_124820360951871_100002717246207_98703_710072969_n.jpg"));
				newSlide = slideShow.addSlide(new PhotoSlide($("#html-root"),"http://a3.sphotos.ak.fbcdn.net/hphotos-ak-snc7/307218_152205621546678_100002717246207_167905_1389119690_n.jpg"));
				newSlide = slideShow.addSlide(new PhotoSlide($("#html-root"),"http://a4.sphotos.ak.fbcdn.net/hphotos-ak-snc7/s720x720/391548_144362965664277_100002717246207_151230_798371885_n.jpg"));
				newSlide.addComment("Gahee Kim : 나도 챙겨주고싶은데 시간이 없다 미안 ㅠㅜ"); newSlide.addComment("신창호 : 상현아 얼마안남앗구나 편안하게 마무리 ㄱㄱ"); newSlide.addComment("황신하 : 화이팅!!"); newSlide = slideShow.addSlide(new PhotoSlide($("#html-root"),"http://a3.sphotos.ak.fbcdn.net/hphotos-ak-snc7/s720x720/309140_124768670957040_100002717246207_98618_1300176358_n.jpg"));
				newSlide.addComment("Curtis Oh : 혜미누나가 잠 안재우고 일시키나 봅니다 ㅜ 어린이는 일찍자야합니다."); newSlide = slideShow.addSlide(new PhotoSlide($("#html-root"),"http://a1.sphotos.ak.fbcdn.net/hphotos-ak-ash4/s720x720/316832_145961218837785_100002717246207_155136_1312308979_n.jpg"));
				newSlide.addComment("Gahee Kim : 작년 수능 끝나고도 본건데"); newSlide.addComment("심형준 : ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ"); newSlide = slideShow.addSlide(new PhotoSlide($("#html-root"),"http://a3.sphotos.ak.fbcdn.net/hphotos-ak-ash4/s720x720/315081_133708926729681_100002717246207_123039_252323826_n.jpg"));
				newSlide.addComment("Song Sang Hyun : 더 좋은데 갈거야 상현아ㅎㅎ힘내서 해^ㅇ^v"); newSlide.addComment("신창호 : 토닥토닥"); newSlide.addComment("Yo Han Lee : 인재를 못알아보는 대학이군.."); newSlide = slideShow.addSlide(new PhotoSlide($("#html-root"),"http://a4.sphotos.ak.fbcdn.net/hphotos-ak-snc7/s720x720/391612_152047941562446_100002717246207_167503_2111933503_n.jpg"));
				newSlide.addComment("Hyeonjun In : 후잡한 수험생이 여기있네"); newSlide.addComment("Sanghyun  Lee : 레알로 파마가 실수가 아닐까"); newSlide.addComment("Hyeonjun In : 사람 자체가 이미 실수로 가득차서 파마는 강화용 아이템 같음"); newSlide = slideShow.addSlide(new PhotoSlide($("#html-root"),"http://a6.sphotos.ak.fbcdn.net/hphotos-ak-snc6/285036_109485889151985_100002717246207_49112_2533182_n.jpg"));
				newSlide = slideShow.addSlide(new PhotoSlide($("#html-root"),"http://a5.sphotos.ak.fbcdn.net/hphotos-ak-ash4/s720x720/375472_155850377848869_100002717246207_175543_429285278_n.jpg"));
				newSlide = slideShow.addSlide(new PhotoSlide($("#html-root"),"http://a1.sphotos.ak.fbcdn.net/hphotos-ak-snc7/s720x720/316129_152117724888801_100002717246207_167590_246896680_n.jpg"));
				newSlide = slideShow.addSlide(new PhotoSlide($("#html-root"),"http://a7.sphotos.ak.fbcdn.net/hphotos-ak-snc7/s720x720/295976_137303573036883_100002717246207_131603_834805917_n.jpg"));
				newSlide = slideShow.addSlide(new PhotoSlide($("#html-root"),"http://a5.sphotos.ak.fbcdn.net/hphotos-ak-snc7/s720x720/310419_129237767176797_100002717246207_110853_1347818811_n.jpg"));
				newSlide = slideShow.addSlide(new PhotoSlide($("#html-root"),"http://a6.sphotos.ak.fbcdn.net/hphotos-ak-snc6/285036_109485889151985_100002717246207_49112_2533182_n.jpg"));
				newSlide = slideShow.addSlide(new PhotoSlide($("#html-root"),"http://a5.sphotos.ak.fbcdn.net/hphotos-ak-snc7/308548_152205601546680_100002717246207_167904_1743175225_n.jpg"));
				newSlide = slideShow.addSlide(new PhotoSlide($("#html-root"),"http://a6.sphotos.ak.fbcdn.net/hphotos-ak-snc7/s720x720/311090_147715718662335_100002717246207_158995_1450884663_n.jpg"));
				newSlide.addComment("Hyeonjun In : 내가 주인이라면 어떤 고삼이 와서 수험표 있는데 할인 안 해주시나요!!!!하면 천원이라도 할인해줄 것 같음 그러니까 다 물어봐야지"); newSlide.addComment("Sanghyun  Lee : ㅋ 나도 그럴려고"); newSlide.addComment("서혜미 : 아래 책은 고흐그림인데?"); newSlide.addComment("김대영 : 아래책은 민음사책 같음...."); 	
		
				slideShow.startShow();
		});
	</script>
<title></title>
</head>
<body>
	<div id = "html-root">
		
	</div>
</body>
</html>