
	//Marker Size default
	var oSize = new nhn.api.map.Size(28, 37);
	//icon default
	var iconStr = 'http://static.naver.com/maps2/icons/pin_spot2.png';
	
	//NaverMap class
	function MadeleineNaverMap(id){
		//defalut
		var oPoint = new nhn.api.map.LatLng(37.5010226, 127.0396037);
		nhn.api.map.setDefaultPoint('LatLng');
		//Naver Map Create
		oMap = new nhn.api.map.Map(id, {
					point : oPoint,
					zoom : 10, 
					enableWheelZoom : true,
					enableDragPan : true,
					enableDblClickZoom : false,
					mapMode : 0,
					activateTrafficMap : false,
					activateBicycleMap : false,
					minMaxLevel : [ 1, 14 ],
					size : new nhn.api.map.Size(500, 400)
		});
		
		return oMap;			
	};
	
	//want coord move to center
	function NewCenter(x,y, oMap){
		oMap.setCenter(new nhn.api.map.LatLng(x, y));
	};
	
	//Marker size customize
	function MarkerSize(width, height){
		oSize = new nhn.api.map.Size(width, height);
	};
	
	//Icon Model customize
	function CustomIcon(str){
		iconStr = str;
	}
	
	//Event Map
	//evnet parameter = 'click', 'mouseenter', 'mouseleve'
	//func parameter = anonymous function event
	function EventMap(event, func){
		oMap.attach(event, func);	
	}
	
	//Map marker Create
	function MapMarker (x, y, oMap, func){
		//custom coord
		var newPoint = new nhn.api.map.LatLng(x, y);
		
		//mapinfo create
		var mapInfoTestWindow = new nhn.api.map.InfoWindow(); // - info window 
		mapInfoTestWindow.setVisible(false); // - infowindow
		
		oMap.addOverlay(mapInfoTestWindow);	// -	 
		
		var oLabel = new nhn.api.map.MarkerLabel();
		oMap.addOverlay(oLabel); 
				
		oIcon = new nhn.api.map.Icon(iconStr, oSize);
		
		oMarker = new nhn.api.map.Marker(oIcon, {title:'좌표:'+newPoint.toString()});
		
		oMarker.setPoint(newPoint);   
		
		return oMarker;
	};