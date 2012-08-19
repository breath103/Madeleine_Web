package com.mail.servlet;


import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.GMailSender;

/**
 * Servlet implementation class MailSenderServlet
 */
@WebServlet("/MailSenderServlet")
public class MailSenderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MailSenderServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stu
		String creator = request.getParameter("creator");
		String id 	   = request.getParameter("id");
		GMailSender mailSender = new GMailSender("breath103@gmail.com","dltkdgus");
		System.out.println("creator " + creator);
		try {
			mailSender.sendMail("In Young님의 잃어버린 시간이 찾아왔습니다.", "<center><a href = \"http://172.16.10.96:8787/Madeleine/Galary/temp2.html\"> <img src=\"http://172.16.10.96:8787/Madeleine/image/madeleine.jpg\"></a></center>",
								"sender", "dltkdgus211@naver.com");
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
