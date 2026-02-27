<%@ page import="java.util.*" session="true" %>
<%@ page import="java.sql.*"%>
<%
String  x = request.getParameter("x");
String  y = request.getParameter("y");
String  ent = request.getParameter("ent");
String consulta="";
HttpSession sesion = request.getSession(false);
String remotehost  = session.getAttribute("remotehost").toString();
try {
    consulta = "select st_Astext(ST_ExteriorRing(st_transform(geom,3857))) from  (select (ST_Dump(the_geom)).geom from cat_manz where ban not in ('1','3','5','6','Y','E','D','H','G','M','I','N','O','K','R','T','C') and st_intersects(the_geom,ST_SetSRID(ST_Point("+x+","+y+"),32800))) t1 order by st_area(geom) limit 2";
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

