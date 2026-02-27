<%@ page import="java.util.*" session="true" %>
<%@ page import="java.sql.*"%>
<%
String  clave = request.getParameter("clave");
String consulta="";
HttpSession sesion = request.getSession(false);
String remotehost  = session.getAttribute("remotehost").toString();
try {
      //consulta = "select cve_ent||cve_mun||cve_loc||cve_ageb  from (select cve_ent,cve_mun,cve_loc,cve_ageb,the_geom from edit_ploc.edit_agebu union select cve_ent,cve_mun,cve_loc,cve_ageb,the_geom from edit_ploc.edit_locr union select cve_ent,cve_mun,cve_loc,cve_ageb,the_geom from cat_loc where status=1) t2 where st_dwithin(st_transform(ST_GeomFromText('"+clave+"',3857),32800), the_geom, 10000) order by ST_Distance(st_transform(ST_GeomFromText('"+clave+"',3857),32800), the_geom) limit 1";
      consulta = "select cve_ent||cve_mun||cve_loc||cve_ageb from (select 1 as n,cve_ent,cve_mun,cve_loc,(select cve_ageb from cat_loc where clave=t1.cve_ent||t1.cve_mun||t1.cve_loc),the_geom from edit_ploc.v_cat_pe t1   union select 2 as n,cve_ent,cve_mun,cve_loc,cve_ageb,the_geom from cd_polext union select 3 as n,cve_ent,cve_mun,cve_loc,cve_ageb,the_geom from  edit_ploc.v_cat_plr union select 4 as n,cve_ent,cve_mun,cve_loc,cve_ageb,the_geom from edit_ploc.v_cat_au union select 5 as n,cve_ent,cve_mun,cve_loc,cve_ageb,the_geom from cat_loc where status=1) t2 where st_dwithin(st_transform(ST_GeomFromText('"+clave+"',3857),32800), the_geom, 10000)  order by ST_Distance(st_transform(ST_GeomFromText('"+clave+"',3857),32800), the_geom),n limit 1";

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
      out.print("0");
  }
      catch(Exception ex){
        out.print("0");
   }
%>