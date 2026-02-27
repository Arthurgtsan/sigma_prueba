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

  // aqui agarra el que sea para cambiar de forma
    //    consulta = "select cve_ent||cve_mun||cve_loc||replace(cve_ageb,'-','')||cve_mza from cat_manz where inv_fte='0' AND ban not in ('1', '3', '5', '6', 'E', 'D', 'H', 'I', 'K', 'M', 'N', 'O', 'R', 'T', 'C', 'Y', 'G', 'K', 'X', 'J') and st_intersects(the_geom,st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),32800)) order by st_Area(the_geom) limit 1";

//--aqui agarra 2 posibilidades
  // las actualizaciones que llegaron con el corte 2024 
  // y las actualizaciones poteriores al 2025 que son las que lleguen f_registro > '2026-02-20'  y el inv_fte=2




consulta = "select clave from ( "+
"select clave,the_geom from ( "+
"select cve_ent||cve_mun||cve_loc||replace(cve_ageb,'-','')||cve_mza as clave,the_geom from cat_manz where inv_fte='2' AND ban not in ('1', '3', '5', '6', 'E', 'D', 'H', 'I', 'K', 'M', 'N', 'O', 'R', 'T', 'C', 'Y', 'G', 'K', 'X', 'J') "+
"and vienede::integer in (select gid from act_cu.bcu_bd_manzana where f_registro between '2026-01-01' and '2026-02-20') "+
"and st_intersects(the_geom,st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),32800)) "+
"union "+
"select cve_ent||cve_mun||cve_loc||replace(cve_ageb,'-','')||cve_mza as clave,the_geom from cat_manz where inv_fte='2' AND ban not in ('1', '3', '5', '6', 'E', 'D', 'H', 'I', 'K', 'M', 'N', 'O', 'R', 'T', 'C', 'Y', 'G', 'K', 'X', 'J') "+
"and cve_ent||cve_mun||cve_loc||replace(cve_ageb,'-','')||cve_mza in (select cvegeo from act_cu.bcu_bd_manzana where f_registro > '2026-01-01' and left(tip_act,1) = '1') "+
"and st_intersects(the_geom,st_transform(ST_SetSRID(ST_Point("+x+","+y+"), 4326),32800)) "+
") tt "+
"order by st_Area(the_geom) limit 1 "+
") t2 ";


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