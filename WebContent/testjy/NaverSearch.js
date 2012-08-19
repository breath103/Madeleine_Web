function GetSearch(){
	this.LastSearchParam = null;
	this.LastResult = {};
	this.LastResult["total"]=0;
	this.LastResult["items"]=[];
};

GetSearch.prototype = {
	Search: function(SearchParam){
		/*
		 SearchParam(JSON)
		 query : string
		 display : int default 10
		 start : int default 1
		 target : string default 'local'
		 */
		if (undefined == SearchParam["query"]) 
			return;
		if (undefined == SearchParam["display"]) 
			SearchParam["display"] = 10;
		if (undefined == SearchParam["target"]) 
			SearchParam["target"] = "local";
		if (undefined == SearchParam["start"]) 
			SearchParam["start"] = 1;
		this.LastSearchParam = SearchParam;
		
		var total;
		var jSon =new Array(10);
		var cnt=0;
		$.ajax({
			url: "SearchProxy.jsp",
			type: "POST",
			async: false,
			data: {
				"query": encodeURI(SearchParam["query"]),
				"target": SearchParam["target"],
				"start": SearchParam["start"]
			},
			success: function(data){
							total = $(data).find("total").text();
							$(data).find('item').each(function(){
									var $item = $(this);
									var title = $item.find('title').text();
									var image = $item.find('image').text();
									var link = $item.find('link').text();
									var author = $item.find('author').text();
									var publisher = $item.find('publisher').text();
									var	subtitle = $item.find('subtitle').text();
									var pubDate = $item.find('pubDate').text();
									var actor = $item.find('actor').text();
									var userRating = $item.find('userRating').text();
									var director = $item.find('director').text();
									var description = $item.find('description').text();
									var telephone = $item.find('telephone').text();
									var address = $item.find('address').text();
									var mapX = $item.find('mapx').text();
									var mapY = $item.find('mapy').text();	
								
									var Param = {
										"target":SearchParam["target"],
										"title": title ,
										"image": image ,
										"link" : link ,
										"author" : author , 
										"publisher" : publisher ,
										"subtitle" : subtitle ,
										"pubDate" : pubDate ,
										"actor" : actor , 
										"userRating" : userRating , 
										"director" : director ,
										"description" : description ,
										"telephone" : telephone ,
										"address" : address ,
										"mapX" : mapX ,
										"mapY" : mapY
									};
									
									if(total>cnt){
										jSon[cnt]=Param;
										cnt++;
									}
									
												
							});
			}});
		
		this.LastResult["total"]=total-this.LastSearchParam["start"];
		this.LastResult["items"]=jSon;
		return jSon;
		
	},
	SearchMovie: function (Param) { // 占쏙옙占썹�占썲�占쏙옙占쏙옙占�
        Param["target"] = "movie";
        return this.Search(Param);
    },
    SearchBook: function (Param) {  // 筌�옙占�野�옙占쏙옙占쏙옙 
        Param["target"] = "book";
        return this.Search(Param);
    },
	NextSearch:function(){
		if(this.LastSearchParam==null) return;
		this.LastSearchParam["start"]	+= this.LastSearchParam["display"];
        return this.Search(this.LastSearchParam);
	}
};