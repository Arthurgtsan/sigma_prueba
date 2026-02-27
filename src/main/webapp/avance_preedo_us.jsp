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
.t{font-family: Arial; font-size: 14pt; font-weight: bold; color: #000000;text-align : center;}
.c{font-family: Arial; font-size: 10pt; line-height: 1.3; font-weight: normal;text-align : center;}
.n{font-family: Arial; font-size: 10pt; line-height: 1.3; font-weight: bold;text-align : center;}


</style>
<script language="javascrpt" type="text/javascript">
window.resizeTo(900,700);
</script>
<link rel="stylesheet" href="menu_reporte.css" type="text/css">
<body style="background:url('images/fondo1.jpg'); background-repeat: no-repeat; background-size: cover;">
<%
String  edo = request.getParameter("filedo");
String consulta1 = "select * from (select cons,nombre,correo,case when (select min(fact) from respaldo_z_digmz where us=cons)=null then (select min(fact) from respaldo_z_digmp where us=cons) else (select min(fact) from respaldo_z_digmz where us=cons) end as minf, case when (select max(fact) from respaldo_z_digmz where us=cons)=null then (select max(fact) from respaldo_z_digmp where us=cons) else (select max(fact) from respaldo_z_digmz where us=cons) end as maxf,  (select count(*) from respaldo_z_digmz where us=cons) as nf,  (select count(*) from respaldo_z_digpe where us=cons) as ne,  (select count(*) from respaldo_z_digmp where us=cons) as cartas  from usuarios  where id='"+edo+"' and nivel=1 group by cons,nombre,correo  order by cons ) c1 where nf>0 or ne>0 or cartas>0";


//out.println(consulta1);
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
      rs = str.executeQuery( consulta1 );
      out.println("<center><font class='titulo'>Avance por usuarios - "+edo+" </font><br><br>");
      out.println("<table border=1><tr class=titulo2><th>&nbsp;Usuario&nbsp;<th>&nbsp;Fecha&nbsp;<br>&nbsp;Inicio&nbsp;<th>&nbsp;Fecha&nbsp;<br>&nbsp;Fin&nbsp;<th>&nbsp;Manzanas&nbsp;<th>&nbsp;Poligonos&nbsp;<br>Externos<th>&nbsp;Puntos&nbsp;");
      String cve_ent,n1,n2,n3,n4,n5,n6,n7,n8;
      int sum1=0;
      int sum2=0;
      int sum3=0;
      int sum4=0;
      int sum5=0;
      int sum6=0;
      int sum7=0;
      int sum8=0;
      while(rs.next()){
        sum1=sum1+1;
        n1=rs.getObject(3).toString();
        n2="0000-00-00";
        if (rs.getString(4)!=null){
          n2=rs.getObject(4).toString().substring(0,10);
        }
        n3="0000-00-00";
        if (rs.getString(5)!=null){
          n3=rs.getObject(5).toString().substring(0,10);
        }
        n4=rs.getObject(6).toString();
        n5=rs.getObject(7).toString();
        n6=rs.getObject(8).toString();
        sum6+=Integer.parseInt(n4);
        sum7+=Integer.parseInt(n5);
        sum8+=Integer.parseInt(n6);
        out.println("<tr class=n2><td>&nbsp;"+n1+"&nbsp;<td>&nbsp;"+n2+"&nbsp;<td>&nbsp;"+n3+"&nbsp;<td>&nbsp;"+n4+"&nbsp;<td>&nbsp;"+n5+"&nbsp;<td>&nbsp;"+n6+"&nbsp;");
      }
      out.println("<tr class=n3><td colspan=3>TOTAL<td>"+sum6+"<td>"+sum7+"<td>"+sum8);
      str.close();
      conexion.close();

%>
<br>
</body>
</html>
