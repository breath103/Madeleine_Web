var MadeleineContents;
var index = 0;

function MadeleineContentsViewer(id){

		if(id == undefined)
			id=524;
		$.ajax({
			url: "../servlet/GetMadeleineContents.jsp",
			async: false,
			data: {
				"id" : id
			},
			dataType: "json",
			success: function(data){
				MadeleineContents = data;	
			},
			type:"POST"
		});
		return MadeleineContents;
}

function Prev(){
	index = index -1;
	if(MadeleineContents["contents"][index] == undefined && index < 0){
		alert("留����� ������.");
		index = index + 1;
		
		return 1;
	}else{
		var prevPage = $($(".Page")[index+1]);
		prevPage.fadeOut(); 
		var currentPage = $($(".Page")[index]);
		currentPage.fadeIn(); 
	}
}

function Next(){
	index = index + 1;
	if(MadeleineContents["contents"][index] == undefined){
		alert("留����� ������.");
		index= index-1;
		return 1;
	}else{
		var prevPage = $($(".Page")[index-1]);
		prevPage.fadeOut(); 
		var currentPage = $($(".Page")[index]);
		currentPage.fadeIn(); 
	}
}

function MainText(){
	/*
	var mainimage = '<img src="'+MadeleineContents["contents"][index].src+'" style="width:400px; height:220px;">';
	$("#madeleine_image").html(mainimage);
	$("#madeleine_various").html(MadeleineContents["contents"][index].comments);
	*/
	var contentsCnt = MadeleineContents["contents"].length;
	var strpublic ='';
	if(MadeleineContents["info"].is_public){
		strpublic ='Public Post';
		$('.madeleine_create_type').css({"background-image":"url(./images/icon_public.png)"});
	}else{
		strpublic = 'Secret Post';
		$('.madeleine_create_type').css({"background-image":"url(./images/icon_secret.png)"});
	}
	var name = MadeleineContents["info"].name;
	for(var i = 0 ;i < contentsCnt;i++)
	{
		var content = MadeleineContents["contents"][i];
		$("#MCC .madeleine_outer_container").append('<div class="Page">' + 
				'<div class="madeleine_left">'+
					'<div class="madeleine_info"><div class="madeleine_info_content"><font><b>['+name+']</b>님으로부터 도착한 따뜻한 마들렌입니다.</font></div></div>'+
					'<div class="madeleine_image">'+
						'<div class="tape"></div>'+
					'</div>'+
					'<div class="madeleine_bottom_left">'+
					'<div class="madeleine_create_time_outer"><div class="madeleine_create_time"></div>'+
					'<div class="madeleine_create_time_content"><font> '+MadeleineContents["info"].created_time.month+' month ago</font></div></div>'+
					'<div class="madeleine_create_type_outer"><div class="madeleine_create_type"></div>'+
					'<div class="madeleine_create_type_content"><font> '+strpublic+'</font></div></div>'+
					'<div class="madeleine_create_page_outer"><div class="madeleine_create_page"></div>'+
					'<div class="madeleine_create_page_content"><font> '+(i+1)+'/'+contentsCnt+'</font></div></div>'+
					'</div>'+
				'</div>'+
				'<div class="madeleine_right">'+
					'<div class="madeleine_various"><div class="madeleine_various_content"></div></div>'+
				'</div>'+
			'</div>');
	}
	var $pages = $(".Page");
	for(var i = 0 ;i < contentsCnt;i++)
	{
		var $page = $($pages[i]); 
		$page.css("display","none");	
		$page.find(".madeleine_image").append('<img src="'+MadeleineContents["contents"][i].src+'" class="madeleine_facebook_photo" >');
	}
	
	$($pages[0]).css("display","block");
	
	$(".madeleine_outer_container").append($(".madeleine_various_share"));
	
}

	