<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%
String  x = request.getParameter("x");
String  y = request.getParameter("y");
String gid = request.getParameter("gid");
int num = Integer.parseInt(request.getParameter("num"));
String ruta = request.getParameter("ruta");
int tipo = Integer.parseInt(request.getParameter("tipo"));

String consulta="";
try {
	if (tipo==1){  //inicial
		consulta = "select gid||'|'||ruta||'|'||uid::integer||'|'||st_x(st_centroid(geom))||'|'||st_y(st_centroid(geom)) as val  from rutas where st_intersects(geom,st_buffer(ST_SetSRID( ST_Point("+x+","+y+") ,3857),10)) order by st_distance(geom,ST_SetSRID( ST_Point("+x+","+y+") ,3857)) limit 1";
    }else if (tipo==2){ //adelanta
		consulta = "select gid||'|'||ruta||'|'||uid::integer||'|'||st_x(st_centroid(geom))||'|'||st_y(st_centroid(geom)) as val  from rutas where ruta='"+ruta+"' and gid!="+gid+" and uid="+(num+1)+" limit 1";
	}else if (tipo==3){ //atras
		consulta = "select gid||'|'||ruta||'|'||uid::integer||'|'||st_x(st_centroid(geom))||'|'||st_y(st_centroid(geom)) as val  from rutas where ruta='"+ruta+"' and gid!="+gid+" and uid="+(num-1)+" limit 1";
	}
      //out.print(consulta);

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
    out.println(consulta);
  }
    catch (SQLException ex){
      out.print("x");
  }
      catch(Exception ex){
        out.print("x");
  }
%>