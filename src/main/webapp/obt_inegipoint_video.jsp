<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%
int num = Integer.parseInt(request.getParameter("num"));
String ruta = request.getParameter("ruta");


String consulta="";
try {
	consulta = "select gid||'|'||ruta||'|'||uid::integer||'|'||st_x(st_centroid(geom))||'|'||st_y(st_centroid(geom)) as val from rutas where ruta='"+ruta+"' and uid::integer="+(num+1)+" limit 1";	
	ResultSet rs = null;
    Statement str = null;
    Connection conexion = null;
    Class.forName("org.postgresql.Driver");
    conexion = DriverManager.getConnection(
                                            "jdbc:postgresql://10.153.3.25:5434/actcargeo10",
                                            "actcar",
                                            "actcar"
                                           );
    str = conexion.createStatement(rs.TYPE_SCROLL_SENSITIVE, rs.CONCUR_UPDATABLE);
    rs = str.executeQuery( consulta );
  	rs.next();
    out.print(rs.getObject(1).toString());
    str.close();
    conexion.close();
    }
    catch (SQLException ex){
      out.print("x");
  }
      catch(Exception ex){
        out.print("x");
   }
%>