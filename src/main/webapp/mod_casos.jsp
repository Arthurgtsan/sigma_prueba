<%@ page import="java.util.*" session="true" %>
<%@ page import="java.sql.*"%>

<%
String  cgo = request.getParameter("cgo");
String  cve_ent = request.getParameter("cve_ent");
String  cve_mun = request.getParameter("cve_mun");
String  cve_loc = request.getParameter("cve_loc");
String  cve_ageb = request.getParameter("cve_ageb");
String  img = request.getParameter("img");
String  proy = request.getParameter("proy");
String  us  = request.getParameter("us");
String  geom  = request.getParameter("geom");
String consulta="";
HttpSession sesion = request.getSession(false);
String remotehost  = session.getAttribute("remotehost").toString();
try {
		consulta = "select m_casos_especiales('"+cgo+"','"+cve_ent+"','"+cve_mun+"','"+cve_loc+"','"+cve_ageb+"','"+img+"','"+proy+"','"+us+"','"+geom+"')";
      ResultSet rs = null;
      Statement str = null;
      Connection conexion = null;
      Class.forName("org.postgresql.Driver");
      String hostbd  = session.getAttribute("hostbd").toString();
      String remotehostbd  = session.getAttribute("remotehostbd").toString();
      conexion = DriverManager.getConnection("jdbc:postgresql://"+remotehostbd+":5434/"+hostbd,"actcar","actcar");
    //out.print(consulta);
    str = conexion.createStatement(rs.TYPE_SCROLL_SENSITIVE, rs.CONCUR_UPDATABLE);
    rs = str.executeQuery( consulta );
  	rs.next();
    out.print(rs.getObject(1).toString());
    str.close();
    conexion.close();
    }
    catch (SQLException ex){
      out.print("0");
  }
      catch(Exception ex){
        out.print("0");
   }
%>