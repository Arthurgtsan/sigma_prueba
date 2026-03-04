package mx.org.inegi;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.PrintWriter;

import mx.org.inegi.AdministradorDataSource_Sigma;



/**
 * Servlet implementation class monitor
 */
@WebServlet(description = "checar el pool", urlPatterns = { "/monitor" })
public class monitor extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public monitor() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html");
        PrintWriter out = response.getWriter();
		
        try {
            //DataSource_10 dataSource = new DataSource_10(); // Reemplaza por tu objeto DataSource

        	
        	
        	
            //int numIdleConnections = dataSource.getNumIdleConnections();
            //int numActiveConnections = dataSource.getNumActiveConnections();
        	int numMaxConnections = AdministradorDataSource_Sigma.Pool_details_max();
        	int numActiveConnections = AdministradorDataSource_Sigma.Pool_details_active();
        	int numinActiveConnections = AdministradorDataSource_Sigma.Pool_details_inactive();
        	String mibase =  AdministradorDataSource_Sigma.Pool_details_base_10();
        	
        	out.println("<html>");
        	out.println("<head>");
        	out.println("<title>Monitoreo del pool de conexiones</title>");
        	out.println("<meta http-equiv=\"refresh\" content=\"3\">"); // Actualización automática cada 3 segundos
        	out.println("<style>");
        	out.println("body { font-family: Arial, sans-serif; }");
        	out.println(".container { border: 1px solid #ccc; padding: 20px; }");
        	out.println(".header { border: 2px solid #000080; background-color: #87CEFA; padding: 10px; }");
        	out.println(".header h1 { margin: 0; }");
        	out.println("h1 { color: #333; }");
        	out.println("p { margin-bottom: 10px; }");
        	out.println("</style>");
        	out.println("</head>");
        	out.println("<body>");
        	out.println("<div class=\"container\">");
        	out.println("<div class=\"header\">");
        	out.println("<h1>Monitoreo del pool de conexiones</h1>");
        	out.println("</div>");
        	out.println("<p>Base de Datos: " + mibase + "</p>");
        	out.println("<p>Número máximo de conexiones permitidas: " + numMaxConnections + "</p>");
        	out.println("<p>Número de conexiones activas: " + numActiveConnections + "</p>");
        	out.println("<p>Número de conexiones inactivas: " + numinActiveConnections + "</p>");
        	out.println("</div>");
        	out.println("</body>");
        	out.println("</html>");
        	} catch (Exception e) {
        	    // Manejo de errores
        	    out.println("<html>");
        	    out.println("<head>");
        	    out.println("<title>Error</title>");
        	    out.println("<style>");
        	    out.println("body { font-family: Arial, sans-serif; }");
        	    out.println(".container { border: 1px solid #ccc; padding: 20px; }");
        	    out.println(".header { border: 2px solid #556B2F; background-color: #F0FFF0; padding: 10px; }");
        	    out.println(".header h1 { margin: 0; }");
        	    out.println("h1 { color: #333; }");
        	    out.println("p { margin-bottom: 10px; }");
        	    out.println("</style>");
        	    out.println("</head>");
        	    out.println("<body>");
        	    out.println("<div class=\"container\">");
        	    out.println("<div class=\"header\">");
        	    out.println("<h1>Error al obtener el estado del pool de conexiones</h1>");
        	    out.println("</div>");
        	    out.println("<p>" + e.getMessage() + "</p>");
        	    out.println("</div>");
        	    out.println("</body>");
        	    out.println("</html>");
        	
        	
        	
        	

        } finally {
            out.close();
        }
    }
		
        
        //response.getWriter().append("Served at: ").append(request.getContextPath());
		
				
	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
