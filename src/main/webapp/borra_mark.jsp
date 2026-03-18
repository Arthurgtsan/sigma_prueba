<%@ page import="java.sql.*"%>

<%@ page import="javax.sql.rowset.*" %> 
<%@ page import="com.sun.rowset.CachedRowSetImpl" %>
<%@ page import="mx.org.inegi.Constructor_de_Consultas2"%>

<%
String  gid = request.getParameter("gid");
String consulta="";
try {
 
/*
	  consulta="delete from cat_marks where gid="+gid;

      ResultSet rs = null;
      Statement str = null;
      Connection conexion = null;
      Class.forName("org.postgresql.Driver");
      String hostbd  = session.getAttribute("hostbd").toString();
      String remotehostbd  = session.getAttribute("remotehostbd").toString();
      conexion = DriverManager.getConnection("jdbc:postgresql://"+remotehostbd+":5434/"+hostbd,"actcar","actcar");


    str = conexion.createStatement(rs.TYPE_SCROLL_SENSITIVE, rs.CONCUR_UPDATABLE);
    str.executeUpdate(consulta);
*/

	Constructor_de_Consultas2.consulta_borra_mark_01("act10_ed", gid);
    //out.println (consulta);
    //conexion.close();
    out.println("0");
    }
    catch (SQLException ex){
      out.print("1");
  }
      catch(Exception ex){
        out.print("1");
   }

%>
