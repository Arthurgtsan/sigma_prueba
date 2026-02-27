<%@ page import="java.util.*" session="true" %>
<%@ page import="java.sql.*"%>
<%
String  id = request.getParameter("id");
String  ban = request.getParameter("ban");   //1=agebu 2=polrur 3=carta5
String consulta="";
HttpSession sesion = request.getSession(false);
String remotehost  = session.getAttribute("remotehost").toString();
try {
  if (ban.equals("1")){  //z_digmz
			consulta = "select ST_AsText(st_transform(the_geom,3857)) from z_digmz where gid="+id;
  }else if (ban.equals("2")){  //z_digmz
      consulta = "select ST_AsText(st_transform(the_geom,3857)) from z_digpe where gid="+id;
  }else if (ban.equals("3")){  //z_digmz
      consulta = "select ST_AsText(st_transform(st_multi(st_buffer(the_geom,50)),3857)) from z_digmp where gid="+id;
  }

Statement str = null;
      ResultSet rs = null;
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
    }
    catch (SQLException ex){
      out.print("1");
  }
      catch(Exception ex){
        out.print("1");
   }
%>