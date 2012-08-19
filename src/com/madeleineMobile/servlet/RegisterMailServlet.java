package com.madeleineMobile.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.madeleineMobile.biz.MadeleineMobileBiz;
import com.madeleineMobile.entitiy.MobileUserEntity;

import net.sf.json.JSONObject;

/**
 * Servlet implementation class RegisterMailServlet
 */
@WebServlet("/RegisterMailServlet")
public class RegisterMailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterMailServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String mailAddress = request.getParameter("email");
		String password    = request.getParameter("password");
		
		JSONObject resultJSON = new JSONObject();
		
		if(mailAddress!=null)
		{
			if(password != null)
			{
				MadeleineMobileBiz biz = new MadeleineMobileBiz();
				MobileUserEntity userEntity = biz.findByEmail(mailAddress);
				
				if(userEntity != null)
				{
					if(userEntity.getPassword().equals(password))
					{
						resultJSON.put("result","success");
					}
					else
					{
						resultJSON.put("result","fail");
						resultJSON.put("reason","wrong password");				
					}
				}
				else
				{
					userEntity = new MobileUserEntity(0,mailAddress,password);
					System.out.println(MailAuthListener.getInstance());
					String authCode = MailAuthListener.getInstance().registerMailForAuth(userEntity);
					if(authCode!=null)
					{
						resultJSON.put("result", "success");
						resultJSON.put("authcode",authCode);
					}
					else
					{
						resultJSON.put("result", "fail");
						resultJSON.put("reason","already registered email");				
					}
				}
			}
			else
			{
				resultJSON.put("result", "fail");
				resultJSON.put("reason","no password");				
			}
		}
		else
		{
			resultJSON.put("result", "fail");
			resultJSON.put("reason","no email");				
		}
		
		response.getWriter().write(resultJSON.toString());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request,response);
		
	}

}
