package com.madeleineMobile.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.madeleineMobile.biz.MadeleineMobileBiz;
import com.madeleineMobile.dao.MadeleineMobileDAO;
import com.madeleineMobile.entitiy.MobileUserEntity;

import net.sf.json.JSONObject;


/**
 * Servlet implementation class CheckMailAuthServlet
 */
@WebServlet("/CheckMailAuthServlet")
public class CheckMailAuthServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckMailAuthServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String authCode = request.getParameter("authcode");
		
		JSONObject resultJson = new JSONObject();

		if(authCode!=null)
		{
			MobileUserEntity entity = MailAuthListener.getInstance().checkAuthCode(authCode);
			if(entity != null)
			{
				MailAuthListener.getInstance().invalidateAuthCode(authCode);
				MadeleineMobileBiz biz = new MadeleineMobileBiz();
				biz.insert(entity);
				resultJson.put("result", "success");
				
				resultJson.put("userid", String.valueOf(biz.getLastIDX()));		
			}
			else
			{
				resultJson.put("result", "fail");
				resultJson.put("reason", "invaild AuthCode");
			}
		}
		else
		{
			resultJson.put("result", "fail");
			resultJson.put("reason", "no AuthCode");
		}
		response.getWriter().write(resultJson.toString());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
