

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import madeleine.biz.MadeleineBiz;
import madeleine.biz.MadeleineReplyBiz;
import madeleine.reply.entitiy.MadeleineMovieReplyEntity;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

/**
 * Servlet implementation class FileUploadServlet
 */
@WebServlet("/FileUploadServlet")
public class FileUploadServlet extends javax.servlet.http.HttpServlet implements javax.servlet.Servlet
{
 
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	//���� ���� ���ε�� post����̱� ������ goGet�� ���� �ʴ´�. 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		
		MadeleineReplyBiz biz = new MadeleineReplyBiz();
		biz.insert(new MadeleineMovieReplyEntity(0,0,null,null,"asdf","tqwer","wetyqwer","125123",12,"asgasdf",12,"asdf"));
	}
}
