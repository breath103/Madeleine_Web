<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
 <%@ page import="com.restfb.*, com.restfb.types.*,facebook.*,common.*" %>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>Insert title here</title>
	<script language="javascript" type="text/javascript" src="http://connect.facebook.net/en_US/all.js"></script>
	<script language="javascript" type="text/javascript" src="./jquery.js"></script>
	
	<script language="javascript" type="text/javascript">
		

		$(document).ready(function(){
			function addQuotes(str)
			{
				return "\"" + str + "\"";
			}
			
			// �������� 	
			FB.init({ appId: '191785150891389', status: false, cookie: true, xfbml: true });
		    FB.getLoginStatus(function(response) {
			    	  if (response.status == 'connected') 
			    	  {
			    		  	// �׼��� ��ū�� ���� 
			    		  	$.post("./SetFacebookInfoServlet",
			    		  		   {facebook_id : response.session.uid ,access_token : response.session.access_token },
			    		  		 	function(data) {});
			    		  	/*
			    		  	FB.api("me/albums",function ( response ){
			    		  		for(var i = 0;i<response.data.length;i++)
			    		  		{
			    		  			var album  = response.data[i];
			    		  		    $("#fb-root").append(" <p id = \"album"+i+"\">" + album.name + "</p>");	
								}
			    		  	});
			    		  	*/
			    		 	location.href = "./mainApp.jsp";
			    	  } 
			    	  else
			    	  {
			    		    // �����ȵ� �����. �׼��� ��ū�� �޾ƿͼ� �������ش�. 
			    		  	alert("���� �ȵ�");
			    			var appID = "191785150891389";
			    		    var path = 'https://www.facebook.com/dialog/oauth?';
			    		 	var queryParams = ['client_id=' + appID,
			    		    				   'redirect_uri=' + window.location,
			    		    				   'response_type=token',
			    		    				   'scope=user_about_me,user_photos,publish_stream,read_friendlists,offline_access'];
			    		   	var query = queryParams.join('&');
			    		   	var url = path + query;
			    		 
			    			location.href = url;
			    	  }
		    	  }
		    );
	});
	</script>
	
</head>
	<body>
		<!--  ����� ������  -->
  		<div id="fb-root"></div>
		<!--  ����� ������ ��  -->
	</body>
</html>