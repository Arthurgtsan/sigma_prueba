package mx.org.inegi.maven_eclipse_test.controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mx.org.inegi.maven_eclipse_test.dao.MgDAO;
import mx.org.inegi.maven_eclipse_test.dto.AgeeDTO;
import mx.org.inegi.maven_eclipse_test.dto.AgemDTO;
import mx.org.inegi.maven_eclipse_test.dto.LocsDTO;

/**
 * Servlet implementation class ConsultaMG
 */
@WebServlet(urlPatterns = { "/consulta_mg.do" })
public class ConsultaMG extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ConsultaMG() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String opcion = request.getParameter("opcion");
		
		if (opcion.equals("estados")) {
                    MgDAO dao = new MgDAO();
                    try {
                        List<AgeeDTO> lista = dao.obtenerEstados();				
                        request.setAttribute("lista", lista);
                        RequestDispatcher requestDispatcher = request.getRequestDispatcher("/views/lista_estados.jsp");
                        requestDispatcher.forward(request, response);
                    } catch (Exception e) {
                        // TODO Auto-generated catch block
                        e.printStackTrace();
                    }
		} else if (opcion.equals("municipios")) {
                    String cve_ent = request.getParameter("cve_ent");

                    MgDAO dao = new MgDAO();
                    try {
                        List<AgemDTO> lista = dao.obtenerMunicipios(cve_ent);				
                        request.setAttribute("lista", lista);
                        RequestDispatcher requestDispatcher = request.getRequestDispatcher("/views/lista_municipios.jsp");
                        requestDispatcher.forward(request, response);
                    } catch (Exception e) {
                        Logger.getLogger(ConsultaMG.class.getName()).log(Level.SEVERE, null, e);
                    }
		} else if (opcion.equals("localidades")) {
                    String cvegeo = request.getParameter("cvegeo");

                    try {
                        List<LocsDTO> lista = new MgDAO().obtenerLocalidades(cvegeo);
                        /*
                        for (LocsDTO item : lista) {
                            System.out.println(item);
                        }
						*/
                        Gson gson = new GsonBuilder().create();
                        String json = gson.toJson(lista);

                        PrintWriter out = response.getWriter();
                        try {
                            response.setContentType("application/json;charset=UTF-8");
                            out.print(json);
                        } finally {
                            if(out != null)
                                out.close();
                        } 
                    } catch (Exception e) {
                        Logger.getLogger(ConsultaMG.class.getName()).log(Level.SEVERE, null, e);
                    }
		} else {
		    RequestDispatcher requestDispatcher = request.getRequestDispatcher("/index.jsp");
		    requestDispatcher.forward(request, response);
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
