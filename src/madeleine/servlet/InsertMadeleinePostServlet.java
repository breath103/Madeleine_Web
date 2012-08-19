package madeleine.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import madeleine.biz.MadeleinePhotoBiz;
import madeleine.entity.MadeleinePostEntity;

/**
 * Servlet implementation class InsertMadeleinePostServlet
 */
@WebServlet("/InsertMadeleinePostServlet")
public class InsertMadeleinePostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InsertMadeleinePostServlet() {
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
		String id = request.getParameter("parent_id");
		String facebook_id = request.getParameter("facebook_id");

		PrintWriter writer = response.getWriter();
		if( id != null )
		{
			System.out.println(id + "  " + facebook_id);
			MadeleinePhotoBiz biz = new MadeleinePhotoBiz();
			
			if(biz.insert(new MadeleinePostEntity(0,Integer.parseInt(id),facebook_id)))
			{
				writer.write("{\"result\" : \"success\"}");
			}
			else
			{
				writer.write("{\"result\" : \"fail\"}");
			}
		}
		else
		{
			writer.write("{\"result\" : \"fail\"}");
			
		}
	}

}
