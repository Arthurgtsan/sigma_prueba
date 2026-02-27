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
    consulta = "select * from (select '1' as tip,st_Astext(st_transform(the_geom,3857)),cve_ent||cve_mun||cve_loc as cvegeo,st_distance(the_geom,ST_SetSRID(ST_Point("+x+","+y+"),32800)) from cat_loc where st_intersects(the_geom,st_buffer(ST_SetSRID(ST_Point("+x+","+y+"),32800),200)) union select '2' as tip,st_Astext(st_transform(the_geom,3857)),cve_ent||cve_mun||cve_loc as cvegeo,st_distance(the_geom,ST_SetSRID(ST_Point("+x+","+y+"),32800)) from cat_cd_base where st_intersects(the_geom,st_buffer(ST_SetSRID(ST_Point("+x+","+y+"),32800),200)) ) t2 order by st_distance limit 1";
    //out.println (consulta);
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
    out.print(rs.getObject(3).toString());
    out.print(rs.getObject(2).toString());
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