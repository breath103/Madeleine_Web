package madeleine.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import oracle.sql.DATE;

import madeleine.biz.MadeleineBiz;
import madeleine.entity.MadeleineEntity;


import common.*;
import com.mail.servlet.MailSenderListener;


/**
 * Servlet implementation class CreateMadeleineServlet
 */
@WebServlet("/CreateMadeleineServlet.do")
public class CreateMadeleineServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CreateMadeleineServlet() {
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
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");
	    response.setContentType("text/html; charset=utf-8");
		
	    MadeleineBiz biz = new MadeleineBiz();
		
		String name    	 	 = request.getParameter("name");
		String creator 	 	 = request.getParameter("creator");
		String reserved_time = request.getParameter("reserved_time");
		String is_public	 = request.getParameter("is_public");
		System.out.println(Boolean.valueOf(is_public));
	
		if(name 		 != null && 
		   creator 		 != null &&
		   reserved_time != null &&
		   is_public 	 != null)
		{
			reserved_time += " 00:00:00";
			
			System.out.println("Madeleine created");
			MadeleineEntity newMadeleine;
				Timestamp created_timestamp = new Timestamp(new Date().getTime());
				newMadeleine = new MadeleineEntity(0,name,creator,created_timestamp,Timestamp.valueOf(reserved_time),false,false,Boolean.valueOf(is_public));
				System.out.println(newMadeleine.getCreated_time());
				if(biz.insert(newMadeleine))
				{
					response.getWriter().write(biz.getLastIDX()+"");
					newMadeleine.setIdx(biz.getLastIDX());
					if(MailSenderListener.getSingleton()!=null)
						MailSenderListener.getSingleton().onNewMadeleine(newMadeleine);
				}
				else
				{
					response.getWriter().write("fail");
				}

		}
		else
		{	
			System.out.println(name+" "+creator+" "+reserved_time+" "+is_public);
		}
	}
}
