var MadeleineContents;
var index = 0;

var g_totalPageCount;

function MadeleineContentsViewer(id){
		$.ajax({
			url: "../servlet/GetMadeleineContents.jsp",
			async: true,
			data: {
				"id" : id
			},
			dataType: "json",
			success: function(data){
				MadeleineContents = data;	
				MainText();
			},
			type:"POST"
		});
}

function Prev(){
	index = index -1;
	if(index < 0 ){
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
	if(index >= g_totalPageCount){
	
		index = index-1;
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
	for(var i = 0 ;i < Math.floor(contentsCnt/2) + contentsCnt%2;i++)
	{
		var content = MadeleineContents["contents"][i];
		$("#MCC .madeleine_outer_container").append('<div class="Page">' + 
				'<div class="madeleine_left">'+
					'<div class="madeleine_info"></div>'+
					'<div class="madeleine_empty_space_left"></div>'+
					'<div class="madeleine_image">'+
						'<div class="tape"></div>'+
						'<div class="madeleine_image_container"></div>'+
					'</div>'+
					'<div class="madeleine_bottom_left"></div>'+
				'</div>'+
				'<div class="madeleine_right">'+
					'<div class="madeleine_info"></div>'+
					'<div class="madeleine_empty_space_left"></div>'+
					'<div class="madeleine_image">'+
						'<div class="tape"></div>'+
						'<div class="madeleine_image_container"></div>'+
					'</div>'+
					'<div class="madeleine_bottom_left"></div>'+
				'</div>'+
			'</div>');
	}
	var $pages = $(".Page");
	
	g_totalPageCount = Math.floor(contentsCnt/2) + contentsCnt%2;
	
	for(var i = 0 ;i < Math.floor(contentsCnt/2) + contentsCnt%2;i++)
	{
		var $page = $($pages[i]); 
		$page.css("display","none");	
		$($page.find(".madeleine_image_container")[0]).append('<img src="'+MadeleineContents["contents"][i*2].src+'">');
		if(i*2+1 < contentsCnt)
			$($page.find(".madeleine_image_container")[1]).append('<img src="'+MadeleineContents["contents"][i*2+1].src+'">');
	}
	
	$($pages[0]).css("display","block");
	
	$(".madeleine_outer_container").append($(".madeleine_various_share"));
	
}

	