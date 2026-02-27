<%@ page import="java.util.*" session="true" %>
<%@ page import="java.sql.*"%>
<%
String  id = request.getParameter("id");
String  ban = request.getParameter("ban");
String tipo = request.getParameter("tipo");
String consulta="";
HttpSession sesion = request.getSession(false);
String remotehost  = session.getAttribute("remotehost").toString();
try {
  /*if (ban.equals("3")){
			consulta = "select ST_AsText(st_transform(geom,3857)) from mcc_poblacion.cat_manz_modcar where cgo='3' and gid="+id;
  }else{
      consulta = "select ST_AsText(st_transform(geom,3857)) from mcc_poblacion.cat_manz_modcar where cgo!='3' and gid="+id;
  }*/
  if (tipo.equals("1")){
    consulta = "select ST_AsText(st_transform(geom,3857)) from mcc_poblacion.cat_manz_modcar where gid||figura='"+id+"'";
  }else{
    consulta = "select st_x(geom)||','||st_y(geom) from mcc_poblacion.loc_rur where gid||figura='"+id+"'";
}
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
    }
    catch (SQLException ex){
      out.print("1");
  }
      catch(Exception ex){
        out.print("1");
   }
%>
