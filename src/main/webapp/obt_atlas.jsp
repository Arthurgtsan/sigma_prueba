<%@ page import="java.util.*" session="true" %>
<%@ page import="java.sql.*"%>
<%
String  x = request.getParameter("x");
String  y = request.getParameter("y");
String  box = request.getParameter("box");
String  boxtotal = request.getParameter("boxtotal");
String  correo = request.getParameter("correo");
String  api  = request.getParameter("api");
String  filtro = request.getParameter("filtro");
String consulta="";
HttpSession sesion = request.getSession(false);
String remotehost  = session.getAttribute("remotehost").toString();
try {

/*consulta = "select string_agg(texto, '#') from ( " +
      "select row_number() OVER () AS gid,* "+
      "from ( "+
      "select * from ( "+
      "        select id||'&'||date(fecha)||'&'||st_astext(st_transform(geom,3857))||'&'||constellation||'&'||cloudcover||'&'||incidenceangle as texto from a_digitalglobe " +
      "       where st_intersects(geom,st_transform(ST_SetSRID(ST_GeomFromText('POLYGON(("+box+"))'),3857),4326)) and " +
      "       processinglevel='SENSOR' order by CASE constellation WHEN 'PNEO' THEN 1 WHEN 'PHR' THEN 1 else 3 " +
      "    end, date(fecha) desc limit 2) as t1 " +
      "   ) tt order by gid desc ) tty ";
*/

    consulta="select obt_atlas('"+filtro+"','"+box+"','"+boxtotal+"','"+correo+"','"+api+"')";
    //out.print(consulta);


      ResultSet rs = null;
      Statement str = null;
      Connection conexion = null;
      Class.forName("org.postgresql.Driver");
      String hostbd  = session.getAttribute("hostbd").toString();
      String remotehostbd  = session.getAttribute("remotehostbd").toString();
      conexion = DriverManager.getConnection("jdbc:postgresql://"+remotehostbd+":5434/actcargeo10","actcar","actcar");
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