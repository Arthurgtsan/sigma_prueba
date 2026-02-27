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
    consulta = "select tipo,cve_ent,cve_mun,cve_loc,ST_AsText(st_transform(geom,3857)) as geom from (select cve_ent,cve_mun,cve_loc,'1' as tipo,((st_multi(geom))) as geom from act_cu.bcu_bd_pe where f_registro> (select fecha from vista_fecha_corte where tipo='inicia') and proc!=1 union select cve_ent,cve_mun,cve_loc,'2' as tipo, ((st_multi(the_geom))) as geom from z_digpe ) t2 where st_intersects(geom,st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),32800)) order by tipo,st_Area(geom) limit 1";
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
    out.print(rs.getObject(2).toString());
    out.print(rs.getObject(3).toString());
    out.print(rs.getObject(4).toString());
    out.print(rs.getObject(5).toString());
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

