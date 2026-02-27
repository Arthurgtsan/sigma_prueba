<%@ page import="java.util.*" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%
float c1 = Float.parseFloat(request.getParameter("c1")),
        c2 = Float.parseFloat(request.getParameter("c2")),
        c3 = Float.parseFloat(request.getParameter("c3")),
        c4 = Float.parseFloat(request.getParameter("c4")),
        esc = Float.parseFloat(request.getParameter("esc")),
        dist = 0;
String  width=request.getParameter("width"),
        height=request.getParameter("height"),
        layers=request.getParameter("layers"),
        cql=request.getParameter("cql"),
        styles=request.getParameter("styles");
Random num = new Random();
String consulta= "",
        punto="",
        punto1="",
        punto2="",
        kml = "",
        nom = "",
        archivo = "",
        archivo1 = "";
int pos=0, ran=0;
if (esc==0){
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
      //ccl
      //consulta = "select ST_Distance(ST_Point("+c1+","+c2+"),ST_Point("+c3+","+c4+")) as dist, "
      //         + "ST_AsText(ST_Transform(st_centroid(ST_SetSRID(ST_MakeBox2D(ST_Point("+c1+","+c2+"),ST_Point("+c3+","+c4+")),32800)),4326)) as punto ";
      //geo
      consulta = "select ST_Distance(ST_Point("+c1+","+c2+"),ST_Point("+c3+","+c4+")) as dist, "
               + "ST_AsText(st_centroid(ST_SetSRID(ST_MakeBox2D(ST_Point("+c1+","+c2+"),ST_Point("+c3+","+c4+")),4326))) as punto ";
      rs = str.executeQuery( consulta );
  while(rs.next()){
            String s1=rs.getObject(1).toString();
            String s2=rs.getObject(2).toString();
            dist  = Float.parseFloat(s1);
            punto = s2.replace("POINT(", "");
            punto = punto.replace(")", "");
            pos = punto.indexOf(" ", -1);
            punto1 = punto.trim().substring(0, pos);
            punto2 = punto.trim().substring(pos,punto.length());
            kml+= "<?xml version='1.0' encoding='UTF-8'?>"+"\n";
            kml+= "<kml xmlns='http://earth.google.com/kml/2.0'>\n";
            kml+= " <Placemark>\n";
            kml+= " <name>Vista</name>\n";
            kml+= " <LookAt>\n";
            kml+= "   <longitude>"+punto1+"</longitude>\n";
            kml+= "   <latitude>"+punto2+"</latitude>\n";
            //kml+= "   <altitude>0</altitude>\n";
            kml+= "   <range>"+(dist*65000)+"</range>\n";
            kml+= " </LookAt>\n";
            kml+= "  </Placemark> \n";
            kml+= " </kml>";
            //out.println(kml);
            ran = num.nextInt(100000);
            archivo = "D:/Sitio/Tomcat/webapps/openlayers/tmp/go"+ran+".kml";
            archivo1 = "tmp/go"+ran+".kml";

    try {
       FileWriter fw = new FileWriter(archivo, false );
       fw.write(kml);
       fw.close();
    } catch (IOException ioe) {
      out.println("Se ha producido un error durante la lectura del archivo " + archivo);
    }
    out.println ("<html><meta HTTP-EQUIV='Refresh' CONTENT='0; URL=http://dc046068asdggma.inegi.gob.mx:8070/openlayers/"+archivo1+"'>");
    }
    }
   catch (SQLException ex){
      out.println("<script>");
      out.println("  alert(\"Se genero la expresion de SQL: "+ex.getMessage().substring(0, ex.getMessage().length()-1)+" !\");");
      out.println("</script>");
    }

    catch(Exception ex){
      out.println("<script>");
      out.println("  alert(\"Se genero la expresion: "+ex.getMessage().substring(0, ex.getMessage().length()-1)+" !\");");
      out.println("</script>");
    }
}else{
    cql = cql.replace("*", "'");
    String url="'http://w-webintratslic.inegi.gob.mx:8080/geoserver/wms?service=WMS&version=1.1.0&request=GetMap&layers="+layers+"&styles="+styles+"&CQL_FILTER="+cql+"&bbox="+c1+","+c2+","+c3+","+c4+"&width="+width+"&height="+height+"&srs=EPSG:4326&format=application%2Fvnd.google-earth.kmz%2Bxml'";
    //out.println(url);
    out.println ("<html><meta HTTP-EQUIV=\"Refresh\" CONTENT=\"0; URL="+url+"\">");
}

%>
<script>
setTimeout("this.frenar()", 30000);
function frenar(){
window.close();
}
</script>
<body>
</body>
</html>
