<%@ page import="java.util.*" session="true" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.DecimalFormat"%>
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
<script>
window.resizeTo(950,355);

</script>
<body style="background:url('images/fondo1.jpg'); background-repeat: no-repeat; background-size: cover;">


<%
String ent = request.getParameter("ent");
String ent2="";
int n = Integer.parseInt(request.getParameter("n"));
if (n==1){
  ent="'"+ent+"'";
  ent2=" and t2.cve_ent in ("+ent+") ";
}else{
 switch (ent){
case "01":
  ent = "'02','03','25','26'";  ent2=" and t2.cve_ent in ("+ent+") ";
  break;
case "02":
  ent = "'08','10','32'";ent2=" and t2.cve_ent in ("+ent+") ";
  break;
case "03":
  ent = "'19','28','05',''";ent2=" and t2.cve_ent in ("+ent+") ";
  break;
case "04":
  ent = "'06','14','16','18'";ent2=" and t2.cve_ent in ("+ent+") ";
  break;
case "05":
  ent = "'01','11','22','24'";ent2=" and t2.cve_ent in ("+ent+") ";
  break;
case "06":
  ent = "'12','17','15'";ent2=" and t2.cve_ent in ("+ent+") ";
  break;
case "07":
  ent = "'13','21','29','30'";ent2=" and t2.cve_ent in ("+ent+") ";
  break;
case "08":
  ent = "'07','20','27'";ent2=" and t2.cve_ent in ("+ent+") ";
  break;
case "09":
  ent = "'04','31','23'";ent2=" and t2.cve_ent in ("+ent+") ";
  break;
case "10":
  ent = "'09'";ent2=" and t2.cve_ent in ("+ent+") ";
  break;
case "00":
  ent2=" ";
  break;
}
 

}
HttpSession sesion = request.getSession(true);
if ((sesion != null && !sesion.isNew())) {
        //out.println("LA SESION SIGUE ACTIVA");


String remotehost  = session.getAttribute("remotehost").toString();
String regionalid  = session.getAttribute("regionalid").toString();
String hostbd  = session.getAttribute("hostbd").toString();


String consulta = "select t2.cve_ent,";
consulta += "(select count(*) from mcc_poblacion.cat_manz_modcar t1 where t1.cve_ent=t2.cve_ent) as todos, ";
consulta += "(select count(*) from mcc_poblacion.cat_manz_modcar t1 where t1.cve_ent=t2.cve_ent and ((figura='CENSOR' and t1.status in ('1','7')) or figura='TCAR' or cgo='46') and proc!=0 ) as ya,";
consulta += "(select count(*) from mcc_poblacion.cat_manz_modcar t1 where t1.cve_ent=t2.cve_ent and ((figura='CENSOR' and t1.status in ('1','7') and cgo!='46') or figura='TCAR') and proc=0 ) as faltan,";
consulta += "(select count(*) from mcc_poblacion.cat_manz_modcar t1 where t1.cve_ent=t2.cve_ent and cgo='46' and proc=0) as c46,";
consulta += "(select count(*) from mcc_poblacion.cat_manz_modcar t1 where t1.cve_ent=t2.cve_ent  and figura='CENSOR' and t1.status not in ('1','7') and cgo!='46') as rechazados, ";
consulta += "(select count(*) from mcc_poblacion.loc_rur t1 where t1.cve_ent=t2.cve_ent) as ltodos,";
consulta += "(select count(*) from mcc_poblacion.loc_rur t1 where t1.cve_ent=t2.cve_ent and (proc!=0 or codigoact=9)) as lya,";
consulta += "(select count(*) from mcc_poblacion.loc_rur t1 where t1.cve_ent=t2.cve_ent and proc=0 and codigoact!=9) as lfaltan ";
//consulta += "(select count(*) from mcc_poblacion.loc_rur t1 where t1.cve_ent=t2.cve_ent and codigoact=9) as lcambio ";
consulta += "from cat_ent t2 where t2.status=1 "+ent2+"";
consulta += "group by t2.cve_ent order by t2.cve_ent";
//--group by cve_ent




 ResultSet rs = null;
      Statement str = null;
      Connection conexion = null;
      Class.forName("org.postgresql.Driver");
      String remotehostbd  = session.getAttribute("remotehostbd").toString();
      conexion = DriverManager.getConnection("jdbc:postgresql://"+remotehostbd+":5434/"+hostbd,"actcar","actcar");
      str = conexion.createStatement(rs.TYPE_SCROLL_SENSITIVE, rs.CONCUR_UPDATABLE);

      rs = str.executeQuery( consulta );
      out.println("<form method=\"post\" name=\"enviar\"><center><font class='titulo2'></font><br>");
      String c1="",c2="",c3="",c4="";
      String t1="",t2="",t3="",t4="",t5="",t6="",t7="",t8="",t9="",t10="";
      out.println("<b> REPORTE DE ACTUALIZACIONES </b><br><br><table border=0>");
out.println("<tr bgcolor=#FFF9DE><td><table align=center border=1 class=table2><tr><td align=center colspan=13>Actualizaciones - MCC");
out.println("<tr class=titulo2><th align=center>&nbsp;Estado:&nbsp;");
out.println("<th align=center  bgcolor=#96F695>&nbsp;TOTAL&nbsp;<br>&nbsp;MANZANAS&nbsp;");
out.println("<th align=center>&nbsp;Con&nbsp;<br>&nbsp;Respuesta");
out.println("<th align=center  bgcolor=#F79978>&nbsp;Faltan de&nbsp;<br>&nbsp;Respuesta");
out.println("<th align=center>&nbsp;Cgo 46&nbsp;");
out.println("<th align=center>&nbsp;Rechazados&nbsp;<br>&nbsp;a tabla de&nbsp;<br>&nbsp;Frentes&nbsp;");
out.println("<th align=center  bgcolor=#96F695>&nbsp;TOTAL&nbsp;<br>&nbsp;LOCALIDADES&nbsp;");
out.println("<th align=center>&nbsp;Con&nbsp;<br>&nbsp;Respuesta");
out.println("<th align=center  bgcolor=#F79978>&nbsp;Faltan de&nbsp;<br>&nbsp;Respuesta");


    while(rs.next()){
      out.println("<tr><td>"+rs.getObject(1).toString());
      out.println("<td  bgcolor=#96F695>"+rs.getObject(2).toString());
      out.println("<td>"+rs.getObject(3).toString());        
      out.println("<td bgcolor=#F79978>"+rs.getObject(4).toString());
      out.println("<td>"+rs.getObject(5).toString());
      out.println("<td>"+rs.getObject(6).toString());
        out.println("<td bgcolor=#96F695>"+rs.getObject(7).toString());
          out.println("<td>"+rs.getObject(8).toString());
            out.println("<td bgcolor=#F79978>"+rs.getObject(9).toString());
      
      /*
out.println(" <table border=0>");
out.println("<tr bgcolor=#ffffb3><td><table align=center border=1 class=table2><tr><td class=titulo3 colspan=3>&nbsp;Censo Economico - MCC&nbsp;");
out.println("<tr class=titulo2><th align=right>&nbsp;Aceptados:&nbsp;<th align=left colspan=2>&nbsp;"+t2);
out.println("<tr class=titulo2><th align=right>&nbsp;Atendido en SIGMA:&nbsp;<th align=left>&nbsp;"+t4+"<td>"+(Integer.parseInt(t4)*100)/Integer.parseInt(t2)+"%");
out.println("<tr class=titulo2 bgcolor=#ff6600><th align=right>&nbsp;Faltantes en SIGMA:&nbsp;<th align=left>&nbsp;"+(Integer.parseInt(t2)-Integer.parseInt(t4))+"<td>"+((Integer.parseInt(t2)-Integer.parseInt(t4))*100)/Integer.parseInt(t2)+"%");
out.println("<tr class=titulo2><th align=right>&nbsp;Rechazados:&nbsp;<th align=left colspan=2>&nbsp;"+t3);
out.println("<tr class=titulo2><th align=right>&nbsp;Total:&nbsp;<th align=left colspan=2>&nbsp;"+t1);
  */
}     

  //out.println("");
      str.close();
      conexion.close();
    }else{
          out.println("<script>opener.cerrarSesion();window.close();</script>");
    }

%>


</body>
</html>
