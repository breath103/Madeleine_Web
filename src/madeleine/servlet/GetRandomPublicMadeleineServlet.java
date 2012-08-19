package madeleine.servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import madeleine.biz.MadeleineBiz;
import madeleine.entity.MadeleineEntity;
import net.sf.json.JSONArray;

/**
 * Servlet implementation class GetRandomPublicMadeleineServlet
 */
@WebServlet("/GetRandomPublicMadeleineServlet")
public class GetRandomPublicMadeleineServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetRandomPublicMadeleineServlet() {
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
		MadeleineBiz biz = new MadeleineBiz();
		String count = request.getParameter("count"); 
		
		MadeleineEntity randomMadeleine = biz.getRandomPublicMadeleine();
		JSONArray jsonArray = JSONArray.fromObject(randomMadeleine);
		response.getWriter().write(jsonArray.toString());
	}

}
