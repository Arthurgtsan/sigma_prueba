<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>
SIGMA
</title>
<style type="text/css">
table {
  border-collapse: collapse;
}
.t{font-size: 12pt; font-family: Arial; font-weight: bold; color: #000000;} 
.c{font-family: Arial; font-size: 8pt; line-height: 1.3; font-weight: normal;}
.n{font-family: Arial; font-size: 8pt; line-height: 1.3; font-weight: bold;}
.boton{font-family: Arial; font-size: 10px; line-height: 1; font-weight: normal;}

</style>
<script language="javascrpt" type="text/javascript">
window.resizeTo(450,450);
var ban1=0;
var ban2=0;
var ban3=0;
</script>    
<link rel="stylesheet" href="style.css" type="text/css" />        
  </head>
 <%
 String lat = request.getParameter("lat"),
    lon = request.getParameter("lon"),
	c1 = request.getParameter("c1"),
	c2 = request.getParameter("c2"),
	c3 = request.getParameter("c3"),
	c4 = request.getParameter("c4"),
    consulta = "",
    salida = "",
    st = "";
/*double lat_dec=0,
       lon_dec=0;
double l_lat_dec=Double.parseDouble(lat);
double l_lon_dec=(Double.parseDouble(lon))*(-1);
int n1=(int)Math.floor(l_lat_dec);  //grados
       l_lat_dec=(l_lat_dec-n1)*60;
int n2=(int)Math.floor(l_lat_dec);  //minutos
       l_lat_dec=(l_lat_dec-n2)*60;
double n3=l_lat_dec;
DecimalFormat formateador = new DecimalFormat("##.###");
n3=Double.parseDouble(formateador.format(n3));

//left out.println(String.format("%10s", "foo").replace(' ', '*'));
//rigth out.println(String.format("%-10s", "bar").replace(' ', '*'));
String l_lat_geo=(String.format("%2s", n1).replace(' ', '0')) + (String.format("%2s", n2).replace(' ', '0')) + (String.format("%6s", n3).replace(' ', '0'));
n1=(int)(Math.floor(l_lon_dec));  //grados
       l_lon_dec=(l_lon_dec-n1)*60;
n2=(int)Math.floor(l_lon_dec);  //minutos
       l_lon_dec=(l_lon_dec-n2)*60;
n3=l_lon_dec;
n3=Double.parseDouble(formateador.format(n3));
String l_lon_geo=(String.format("%2s", n1).replace(' ', '0')) + (String.format("%2s", n2).replace(' ', '0')) + (String.format("%6s", n3).replace(' ', '0'));
 */    
 consulta="SELECT latitud,longitud,clave,nom_loc,status,cgo_act,ambito FROM cat_loc where status=1  and " +
          "st_intersects(the_geom,st_transform(ST_SetSRID(ST_MakeBox2D(ST_Point("+c1+", "+c2+"),ST_Point("+c3+" ,"+c4+")),4326),32800)) "+
		  "ORDER BY st_distance(the_geom,st_transform(GeomFromText('POINT("+lon+" "+lat+")',4326),32800)) ASC LIMIT 1";
//out.println(consulta);
 try {
      Statement str = null;
      ResultSet rs = null;
      Connection conexion = null;
      Class.forName("org.postgresql.Driver");
       conexion = DriverManager.getConnection(
                                             "jdbc:postgresql://10.153.3.25:5434/actcargeo10",
                                             "actcar",
                                             "actcar"
                                            );
       str = conexion.createStatement(rs.TYPE_SCROLL_SENSITIVE, rs.CONCUR_UPDATABLE);
      rs = str.executeQuery( consulta );
      rs.
      rs.next();
     String s1= (rs.getObject(1).toString());
     String s2= (rs.getObject(2).toString());
     String s3= (rs.getObject(3).toString());
     String s4= (rs.getObject(4).toString());      
     int s5= Integer.parseInt(rs.getObject(5).toString());
     String s6= (rs.getObject(6).toString());   
     String s7= (rs.getObject(7).toString());   
    out.println("<body><Form action=\"editman.jsp\" method=\"post\" name=\"inicia\"><center><b>BAJA DE LOCALIDAD</b><br><br><table border=1>"+                      
		"<tr><td class=\"search\" nowrap align=right>REFERENCIA ANTERIOR:<td>"+
        "<tr><td class=\"search\" nowrap align=right>CLAVE:<td><input readOnly value='"+s3+"' type=\"text\" name=\"clave\" SIZE=\"12\" class=\"boton\" onFocus='return vaciar(1)' >"+
        "<tr><td class=\"search\" nowrap align=right>NOMBRE:<td><input readOnly value='"+s4+"' type=\"text\" name=\"clave\" SIZE=\"30\" class=\"boton\" onFocus='return vaciar(1)' >"+
        //"<tr><td class=\"search\" nowrap align=right>LATITUD:<td><input readOnly value='"+s1+"' type=\"text\" name=\"latitud\" maxlength=\"10\" SIZE=\"13\" class=\"boton\" >"+
        //"<tr><td class=\"search\" nowrap align=right>LONGITUD:<td><input readOnly value='"+s2+"' type=\"text\" name=\"longitud\" maxlength=\"11\" SIZE=\"14\" class=\"boton\" >"+
        "</table><br><input class=\"boton\" type=\"Button\" onclick='enviar1();' value=\" Capturar \"/></center>"+
        "<input type='hidden' name='lat_dec'><input type='hidden' name='lon_dec'>"
        + "</form></body></html>");
        rs.close();
        str.close();
        conexion.close();
}catch (SQLException ex){
      out.println("<script>");
      out.println("  alert(\"Se genero la expresion de SQL: "+ex.getMessage().substring(0, ex.getMessage().length()-1)+" !\");");
      out.println("  //alert(\"Tienes que proporcionar correctamente las coordenadas!!\");//document.inicia.submit();</script>");
      out.println("</script>");
    }
    catch(Exception ex){
      out.println("<script>");
      out.println("  alert(\"Se genero la expresion: "+ex.getMessage().substring(0, ex.getMessage().length()-1)+" !\");");
      out.println("</script>");
    }
    
%>

<html>