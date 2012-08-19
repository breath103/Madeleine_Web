package madeleine.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import madeleine.biz.MadeleinePhotoBiz;
import madeleine.entity.MadeleinePhotoEntity;


/**
 * Servlet implementation class InsertMadeleinePhotoServlet
 */
@WebServlet("/InsertMadeleinePhotoServlet")
public class InsertMadeleinePhotoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public InsertMadeleinePhotoServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request,response);
		// TODO Auto-generated method stub
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		String id = request.getParameter("parent_id");
		String src = request.getParameter("src");
		String facebook_id = request.getParameter("facebook_id");
		
		PrintWriter writer = response.getWriter();
		if( id != null && src != null )
		{
		//	System.out.println(id + "  " + src);
			MadeleinePhotoBiz biz = new MadeleinePhotoBiz();
			if(biz.insert(new MadeleinePhotoEntity(0,Integer.parseInt(id),src,facebook_id)))
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
