<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%
String  x = request.getParameter("x");
String  y = request.getParameter("y");
Float  filnu = Float.parseFloat(request.getParameter("filnu"));
String  filfe = request.getParameter("filfe");
String  baseimg = request.getParameter("baseimg");


if (filfe==null)filfe="";


String consulta="";
String filtro="";
try {

    if (filnu==100 && filfe==""){
      filtro = "";
    }else if (filnu==100 && filfe!=""){
      filtro = "fecha<'"+filfe+"' and ";
    }else if (filnu<100 && filfe==""){
      filtro = "cloudcover<"+filnu+" and ";
    }else if (filnu<100 && filfe!=""){
      filtro = "fecha<'"+filfe+"' and cloudcover<"+filnu+" and ";
    }


      if (baseimg.equals("DG")){
	  consulta = "select left(fecha::varchar,10) from a_digitalglobe where CE90accura is not null and "+filtro+" st_intersects(geom,ST_SetSRID(ST_Point("+x+","+y+"),4326)) order by fecha desc limit 1";
  }else if (baseimg.equals("D2")){
    consulta = "select left(fecha::varchar,10) from a_digitalca22 where st_intersects(geom,ST_SetSRID(ST_Point("+x+","+y+"),4326)) order by fecha desc limit 1";
  }
//    out.println(consulta);
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