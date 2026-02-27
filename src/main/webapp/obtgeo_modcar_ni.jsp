<%@ page import="java.util.*" session="true" %>
<%@ page import="java.sql.*"%>
<%
String  id = request.getParameter("id");
String consulta="";
HttpSession sesion = request.getSession(false);
String remotehost  = session.getAttribute("remotehost").toString();

    consulta = "select ST_AsText(st_transform(geom,3857)) from mcc_poblacion.ca_terrenos where gid||clave_operativa='"+id+"'";
      ResultSet rs = null;
      Statement str = null;
      Connection conexion = null;
      Class.forName("org.postgresql.Driver");
      String hostbd  = session.getAttribute("hostbd").toString();
      String remotehostbd  = session.getAttribute("remotehostbd").toString();
      conexion = DriverManager.getConnection("jdbc:postgresql://"+remotehostbd+":5434/"+hostbd,"actcar","actcar");
    str = conexion.createStatement(rs.TYPE_SCROLL_SENSITIVE, rs.CONCUR_UPDATABLE);
    rs = str.executeQuery( consulta );
	  rs.next();
    out.print(rs.getObject(1).toString());
    str.close();
    conexion.close();
  
%>
