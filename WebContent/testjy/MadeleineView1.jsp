<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="../js/jquery-1.7.1.js"></script>
<script type="text/javascript" src="NaverSearch.js"></script>
<script type="text/javascript" src="MadeleineView1_js.js"></script>


</head>
<style  type="text/css">
#total {margin:0 auto; width : 976px; height : 644px; background :transparent;}

#outer_prev{float:left;}
#emptyspace1{top:auto; height : 312px;}
#prev{margin:0; float :left; background-image : url('./images/main_section2_button_leftarrow.png'); width : 19px; height : 26px;}

#MCC{float : left; margin:0 auto; width :916px; height : 644px;}
.madeleine_outer_container{ position:relative;   bottom : auto; margin-top:50px; background-image : url('./images/main_contents_bg.png'); width : 916px; height : 544px;}

#outer_next{float:left;}
#emptyspace2{top:auto; height : 312px;}
#next{float : left;	background-image : url('./images/main_section2_button_rightarrow.png');width : 19px;height : 26px;}

.Madeleine_local_search{
border-bottom : 1px #d8d3c9;
	width:100%;
	height:20%;
}

.Madeleine_media_search
{
	border-bottom : 1px #d8d3c9;
	width:100%;
	height:20%;
}

.madeleine_left{float:left; width:458px; height:487px;}
.madeleine_name{top:auto; height:57px;}
.madeleine_info{float:left; width:458px; height:32px;}
.madeleine_empty_space_left{top:auto; height:30px;}
.madeleine_image
{
	float:left;
	position:relative; 
	margin:18px; 
	background-image : url('./images/left/main_section2_left_photo_bg.png'); 
	background-size  : 100% 100%;
	width : 433px;	
	height : 321px;
	text-align:center;	
}
.madeleine_image_container
{
	position:relative;
	left: 28px;
	top : 21px;
	width:85%;
	height:285px;
	overflow:hidden;
}
.madeleine_image_container img
{
	width : 100%;
	height: 100%;
}

.madeleine_info_content{margin-left:32px; margin-top:12px;}

.madeleine_right{float:left; width:458px; height:487px;}
.madeleine_right_top{ width:458px; height:57px;  }
.madeleine_empty_space_right_top{float:left; width:347px; height:57px;}
.madeleine_share{margin-left:335px; z-index:10000;   float: left; margin-top:25px; background-image : url('./images/main_section1_right_button_gongam_basic.png'); width : 100px; height : 33px;}

.madeleine_local_vote{float:left;background-image : url('./images/placebasic.png'); width:93px; height:33px; margin-top:24px;}
.madeleine_media_vote{float:left;background-image : url('./images/right_up_menu_button_media_basic.png');width:117px; height:33px;margin-top:24px;}
.madeleine_comment_vote{margin-left:13px; float:left;background-image : url('./images/commentclick.png');width:90px; height:33px;margin-top:24px;}
.madeleine_share_vote{float:left;background-image : url('./images/sharebasic.png');width:100px; height:33px;margin-top:24px;}



.madeleine_menu_space{margin-left:30px; margin-top:15px; width:458px; height:14px; }
.madeleine_menu_info{float:left;background-image : url('./images/main_section2_right_text_jundal.png');	width : 138px; 	height : 14px;}

.madeleine_menu_selector_outer{ margin-left: 30px; margin-top:20px; width:428px; height:118px;}
.madeleine_menu_selector{float:left; background-image : url('./images/main_section2_right_center_bg.png');width : 407px;height : 118px;}
.madeleine_comment{float:left;	background-image : url('./images/comment/main_section2_right_button_write_basic.png');	width : 127px;	height : 116px;}
.madeleine_media{float:left; margin-left: 12px; background-image : url('./images/media/main_section2_right_button_media_basic.png');width : 127px;height : 116px;}
.madeleine_local{float:left; margin-left:12px; background-image : url('./images/local/main_section2_right_button_place_basic.png');width : 127px;height : 116px;}

.tape{ position:absolute;	background-image : url('./images/left/main_section2_left_photo_tape.png'); width : 400px; height : 220px; top : 5px;}
.madeleine_facebook_photo{width:350px; height:265px;margin-top:27px;margin-right: 14px;} 

.madeleine_bottom_left{float:left; width:458px;height:32px; margin-top:60px;}


.madeleine_create_time{float:left; background-image: url('./images/rightbottom/main_section3_right_icon_clock.png'); width:12px; height:11px; margin-top:3px; margin-left:255px;}
.madeleine_create_type{float:left; background-image: url('./images/rightbottom/main_section3_right_icon_locker.png'); width:12px; height:11px; margin-top:3px; margin-left:5px;}
.madeleine_create_page{float:left; background-image: url('./images/rightbottom/main_section3_right_icon_page.png'); width:12px; height:11px; margin-top:3px; margin-left:5px;}

.madeleine_event{position:relative; float:left; margin-left:45px; margin-top:68px; width:413px; height:215px;}
.madeleine_comment_event_top{width:377px; height:15px;}
.madeleine_comment_media_event_top{ width:377px; height:15px}
.madeleine_comment_media_event_top_content{float:left; width:127px; height:11px; background-image: url('./images/text.png');}
.
.madeleine_comment_event_center{background-image: url('./images/comment/main_section2_right_comment_form_write.png'); width:377px; height:111px;}
textarea{width:377px; height:111px; background:none; border:none; }
.madeleine_comment_event_bottom{background-image: url('./images/comment/main_section2_right_comment_button_write.png'); width:377px; height:35px;}

.madeleine_media_event_top{float:left;background-image: url('./images/media/main_section2_right_media_form_search.png'); width:281px; height:35px;}
.madeleine_media_event_top_text{float:left;background-image: url('./images/media/main_section2_right_media_form_search.png'); width:281px; height:35px;}
.madeleine_media_event_top2{float:left; margin-left:5px;background-image: url('./images/media/main_section2_right_media_button_search.png'); width:84px; height:34px;}
.madeleine_media_event_center{overflow:scroll; float:left;background-image: url('./images/media/main_section2_right_media_resultarea_bgimg.png'); width:377px; height:168px;}
.madeleine_media_event_center2{overflow:scroll; float:left;background-image: url('./images/media/main_section2_right_media_resultarea_bgimg.png'); width:377px; height:168px;}

.madeleine_comment_event_center{background-image: url('./images/comment/main_section2_right_comment_form_write.png'); width:377px; height:111px;}
.madeleine_media_event_bottom{float:left;background-image: url('./images/media/main_section2_right_media_write_button.png'); width:377px; height:35px;}

.madeleine_searchtext{width:280px; height:30px; background:none; border:none;}
.Page
{
	position:absolute; 
	left:0px;
	top :57px;
	width : 100%;
	height : 100%
}
.madeleine_various_share
{
	position : absolute;
	display:none;
	left : 50%;
	top  : 57px;
	width:458px;
	height:487px;
}

.Madeleine_search{float:left;width:350px; height:59px; border-bottom:solid; border-top:solid;}

.madeleine_event_comment{display:none;}
.madeleine_event_media{display:none;}
.madeleine_event_local{display:none;}
.madeleine_event_media2{display:none;}

.madeleine_create_time_outer{float:left;}
.madeleine_create_type_outer{float:left;}
.madeleine_create_page_outer{float:left;}

.madeleine_various_content{float:left; margin-top:45%; margin-left:38px;}
.madeleine_create_time_content{float:left;}
.madeleine_create_type_content{float:left;}
.madeleine_create_page_content{float:left;}

div#viewLoad{
	text-align: center;
	padding-top: 0px;
	background: #FFFFF0;
	filter:alpah(opacity=60);
	opacity: alpha*0.6;
}

.madeleine_event_loacation{width:451px; height:488px; background-image:url('./images/comment_bg_2.png');}

font{
font-family: Tahoma;
			font-size: 5pt;
			font-weight:none;
			line-height: 100%;
			word-spacing: normal;
			line-spacing:-50;
			text-indent: 0ex;
			color:#8f8887;
}

</style>

<body style="backgroud:transparent;">
<div id="total">
	<div id="outer_prev">
		<div id="emptyspace1"  onclick="Madeleine();"></div>
		<div id="prev" onclick="PagePrev();"></div>
	</div>
	<div id="MCC">
		<div class="madeleine_outer_container" id="madeleine_outer" >
			<div class="Default" style="width:100%;height:100%;">
				<div class="madeleine_left">
				
				</div>
				<div class="madeleine_right">
					<div class="madeleine_right_top">
						<div class="madeleine_comment_vote"></div>
						<div class="madeleine_media_vote"></div>
						<div class="madeleine_local_vote"></div>
						<div class="madeleine_share_vote"></div>
					</div>
					<div class="madeleine_various">
						<div class="madeleine_event_loacation">
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div id="outer_next">
		<div id="emptyspace2"></div>
		<div id="next" onclick="PageNext();"></div>
	</div>
</div>

<script type="text/javascript">
var flag = 0 ;
//Viewer part	
	function Madeleine(){
		new MadeleineContentsViewer(524);
		new MainText();
	}
	function PagePrev(){
		if(flag ==1)
			$('.madeleine_various_content').css({"display":"none"});
		else if(flag==0)
			$('.madeleine_various_content').fadeIn();
		var temp = new Prev();
		
	}
	function PageNext(){
		if(flag ==1)
			$('.madeleine_various_content').css({"display":"none"});
		else if(flag==0)
			$('.madeleine_various_content').fadeIn();
		var temp = new Next();
		
	}

$('.madeleine_comment_vote').click(function(){
	$('.madeleine_event_loacation').css({"background-image":"url(./images/comment_bg_2.png)"});
	$('.madeleine_local_vote').css({"background-image":"url(./images/placebasic.png)"});
	$('.madeleine_media_vote').css({"background-image":"url(./images/right_up_menu_button_media_basic.png)"});
	$('.madeleine_share_vote').css({"background-image":"url(./images/sharebasic.png)"});
	$('.madeleine_comment_vote').css({"background-image":"url(./images/commentclick.png)"});
	
	
});
$('.madeleine_local_vote').click(function(){
	$('.madeleine_event_loacation').css({"background-image":"url(./images/place_bg_1.png)"});
	$('.madeleine_media_vote').css({"background-image":"url(./images/right_up_menu_button_media_basic.png)"});
	$('.madeleine_comment_vote').css({"background-image":"url(./images/commentbasic.png)"});
	$('.madeleine_share_vote').css({"background-image":"url(./images/sharebasic.png)"});
	$(this).css({"background-image":"url(./images/placeclick.png)"});
	
	
});
$('.madeleine_media_vote').click(function(){
	$('.madeleine_event_loacation').css({"background-image":"url(./images/media_bg_1.png)"});
	$('.madeleine_local_vote').css({"background-image":"url(./images/placebasic.png)"});
	$('.madeleine_comment_vote').css({"background-image":"url(./images/commentbasic.png)"});
	$('.madeleine_share_vote').css({"background-image":"url(./images/sharebasic.png)"});
	$(this).css({"background-image":"url(./images/mediaclick.png)"});
	
});
$('.madeleine_share_vote').click(function(){
	$('.madeleine_event_loacation').css({"background-image":"url(./images/share_bg.png)"});
	$('.madeleine_local_vote').css({"background-image":"url(./images/placebasic.png)"});
	$('.madeleine_comment_vote').css({"background-image":"url(./images/commentbasic.png)"});
	$('.madeleine_media_vote').css({"background-image":"url(./images/right_up_menu_button_media_basic.png)"});
	$(this).css({"background-image":"url(./images/shareclick.png)"});
	
	
});


$(document).ready(function(){
	$('body').css({"display":"none"});
	
	
	$('body').fadeIn("slow",function(){
	//	$.fancybox.showActivity();
		<%
			String id = request.getParameter("id");
			if(id!=null)
			{
				%>
				new MadeleineContentsViewer(<%=id%>);
				new MainText();
				<%
			}
		%>
	//	$.fancybox.hideActivity();
	});		
});
//comment part
</script>
</body>
</html>