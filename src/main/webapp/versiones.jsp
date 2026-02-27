<%@ page import="java.util.*"%>
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
.c{font-family: Arial; font-size: 10pt; line-height: 1; font-weight: normal;}
.n{font-family: Arial; font-size: 10pt; line-height: 1.3; font-weight: bold;}
.boton{font-family: Arial; font-size: 10px; line-height: 1; font-weight: normal;}
.f{font-family: Arial; font-size: 9px; line-height: 1; font-weight: normal;}
a.liga2:link {font-family: Arial;color: black; font-size: 9pt; text-decoration: underline}
a.liga2:visited {font-family: Arial;color: black; font-size: 9pt; text-decoration: underline}
a.liga2:hover {font-family: Arial;color: black; font-size: 9pt; text-decoration: underline; background-color: #FFFFFF}

</style>
<script language="javascrpt" type="text/javascript">
window.resizeTo(500,600);
</script>
</head>
<body><center><br><table border=1 cellpadding=2>
<tr class=n bgcolor=#BBBBBB align=center><th colspan=3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Versiones de las diferentes capas&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<tr class=n bgcolor=#DDDDDD align=center><td>CAPA<td>VERSION<td>FECHA

<%
String consulta="";

    consulta = "select nombre,version,fecha from cat_version where cat not in ('cat_front','colindantes','box_shp') order by orden";
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
    while(rs.next()){
      out.println("<tr class=c align=center><td class=n align=left>&nbsp;&nbsp;"+rs.getObject(1).toString()+"&nbsp;&nbsp;");
      out.println("<td class=n align=left>&nbsp;&nbsp;"+rs.getObject(2).toString()+"&nbsp;&nbsp;");
      out.println("<td class=n align=left>&nbsp;&nbsp;");
      if (rs.getObject(3) != null){
            out.println (rs.getObject(3).toString());
      }
      out.println("&nbsp;&nbsp;");


    }
    str.close();
    conexion.close();

%>
</body>

</html>