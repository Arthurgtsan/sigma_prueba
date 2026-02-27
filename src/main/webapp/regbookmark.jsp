<%@ page import="java.util.*" session="true" %>
<%@ page import="java.sql.*"%>
<%
String  ent = request.getParameter("ent");
String  xx = request.getParameter("x");
String  yy = request.getParameter("y");
String  us = request.getParameter("us");
String  desc = request.getParameter("desc");
String consulta="";
try {
    consulta = "insert into cat_marks (cve_ent,descripcion,fact,us,the_geom) values ('"+ent+"',E'"+desc+"',current_date,"+us+",ST_SetSRID(ST_Point("+xx+","+yy+"),3857))";
      ResultSet rs = null;
      Statement str = null;
      Connection conexion = null;
      Class.forName("org.postgresql.Driver");
      String hostbd  = session.getAttribute("hostbd").toString();
      String remotehostbd  = session.getAttribute("remotehostbd").toString();
      conexion = DriverManager.getConnection("jdbc:postgresql://"+remotehostbd+":5434/"+hostbd,"actcar","actcar");
    str = conexion.createStatement(rs.TYPE_SCROLL_SENSITIVE, rs.CONCUR_UPDATABLE);
    str.executeUpdate(consulta);
    //out.println (consulta);
    conexion.close();
    out.println("0");
    }
    catch(Exception ex){
      out.println("1");
    }

%>
