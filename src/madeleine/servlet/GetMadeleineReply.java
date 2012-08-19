package madeleine.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import madeleine.biz.MadeleineReplyBiz;
import madeleine.reply.entitiy.MadeleinePlaceReplyEntity;

/**
 * Servlet implementation class GetMadeleineReply
 */
@WebServlet("/GetMadeleineReply")
public class GetMadeleineReply extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetMadeleineReply() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		/*
		MadeleineReplyBiz biz = new MadeleineReplyBiz();
		
		biz.insert(new MadeleinePlaceReplyEntity(0, 1, "asdf", null, "title22", "link", "description", "telephone", "address", 1523, 6124));
		System.out.println(biz.findPlaceByMadeleineIdx(1));
		*/
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String madeleine_idx = request.getParameter("madeleine_idx");
		String reply_type    = request.getParameter("type");
		if(madeleine_idx != null && 
			  reply_type != null)
		{
			
		}
	}

}
