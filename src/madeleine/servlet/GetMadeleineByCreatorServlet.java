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
 * Servlet implementation class GetMadeleineByCreatorServlet
 */
@WebServlet("/GetMadeleineByCreatorServlet")
public class GetMadeleineByCreatorServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetMadeleineByCreatorServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		MadeleineBiz biz = new MadeleineBiz();
		String creator = request.getParameter("creator");
		
		ArrayList<MadeleineEntity> madeleine_list = biz.findByCreator(creator);
		JSONArray jsonArray = JSONArray.fromObject(madeleine_list);
		System.out.println(jsonArray.toString());
		response.getWriter().write(jsonArray.toString());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
	}

}
