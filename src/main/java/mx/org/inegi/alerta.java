package mx.org.inegi;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class alerta
 */
@WebServlet(description = "muestra alertas simples", urlPatterns = { "/alerta" })
public class alerta extends HttpServlet {
	private static final long serialVersionUID = 1L;
public static String  varmsj;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public alerta() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out = response.getWriter();
		try {
			String message = request.getParameter("message");
	        if (message != null) {
	            response.setContentType("text/html");
	            out.println("<script>");
	            out.println("alert(\"" + message + "\");");
	            out.println("</script>");
	            out.flush();
		
	   }
	        } finally {
           out.close();
       }
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		
		
	}
	
		

	
	
	
	
}
