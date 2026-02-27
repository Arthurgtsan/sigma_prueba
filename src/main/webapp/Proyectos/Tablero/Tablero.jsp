<%@ page import="java.util.*" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.DecimalFormat"%>
<html xmlns="http://www.w3.org/1999/xhtml">
 <head>
    <title>
SIGMA
</title>
<script language='javascript' src="popcalendar.js">
function abre(ent){
	alert("entrando");
var liga='';
  liga='Consulta.php?gid='+ent;
ventana = window.open(liga,'scrollbars=no,toolbar=no');
ventana.focus()
}

</script>
<style>
.titulo{ font-family: Arial, Helvetica, sans-serif; font-size: 18px; font-style: normal; line-height: normal; font-weight: bold; font-variant: normal; text-transform: none; color: #000000; text-indent: 10pt; text-align: center; white-space: nowrap; height: 14px; border-style: none}
.titulo2{ color:#000000; font-family: Arial, Helvetica, sans-serif; font-size: 14px; font-style: normal; line-height: normal; font-weight: bold; text-align: center; }
.n{font-family: Arial;  text-align: center; font-size: 10pt; line-height: 1.3;}
.n0{font-family: Arial;  text-align: center; font-size: 8pt; line-height: 1.3;}
.n1{font-family: Arial;  text-align: left; font-size: 12px; line-height: 1.3; font-weight: bold;color: #000000;}
.n2{font-family: Arial;  text-align: center; font-size: 14px; line-height: 1.3; font-weight: bold;color: #000000;}
.n3{font-family: Arial;  text-align: center; font-size: 12px; line-height: 1.3; font-weight: bold;color: #000000; background-color: #D8D8D8;}
.n4{font-family: Arial;  text-align: center; font-size: 12px; line-height: 1.3; font-weight: bold; color: #999999;}
.boton{font-family: Verdana,sans-serif;  text-align: center; font-size: 10px; line-height: 1.3; font-weight: normal;}

.t{font-family: Arial;  text-align: center; font-size: 18px; line-height: 1.3; font-weight: bold;color: #000000;}
a:link {color: black; }
a:visited {color: black;}
a:hover {color: #FFFFFF; background-color: #000000}
.aa{font-family: Arial; font-size: 12px; font-weight: bold;text-decoration:underline}
.aa1{font-family: Arial; font-size: 14px; font-weight: bold;text-decoration:underline}
.fecha{font-family: Arial; font-size: 14px; font-weight: bold;text-decoration:underline}

table {
  border-collapse: collapse;
}
table1 {
  font-size:100%;
  font-family:inherit;
  border-top:1.0pt solid ;
  border-right:1.0pt solid ;
  border-bottom:1.0pt solid ;
  border-left:1.0pt solid ;
  color:#00002
}

table1 {
  font-size:100%;
  font-family:inherit;

}


td{
  padding: 3px;
}

th{
  padding: 5px;
}

</style>

<!--<body style="background:url('images/fondo1.jpg'); background-repeat: no-repeat; background-size: cover;">-->
<body style="">
<%

Calendar fecha = Calendar.getInstance();
String m1="",d1="",fec1="",fec2="",filfe2="",filentrega="",filentrega2="",filentrega1="";
if (fecha.get(Calendar.MONTH)<9)m1="0";   // supongo que el mes empieza por 0
if (fecha.get(Calendar.DATE)<10)d1="0";
fec2=fecha.get(Calendar.YEAR) + "-" + m1 + (fecha.get(Calendar.MONTH)+1) + "-" + d1 + fecha.get(Calendar.DATE);
filfe2 = request.getParameter("filfe2");
String entrega = request.getParameter("entrega");
String fechapre="";
if (entrega!=null){
  //filentrega=" and fact>='2018-08-06' ";
  //filentrega1=" and fresp>='2018-08-06' ";
  //filentrega2=" and f_registro>='2018-08-06' ";
  fechapre=" and fact>='2019-02-01' ";
}
//filfe1 += " 00:00:00";
if (filfe2==null)filfe2=fec2;
filfe2 += " 23:59:59";

String consulta1 = "select gid,fecha_cap,numero,remitente,fecha_sol,responsable from tab_casos order by gid";
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
      //out.println(consulta1);
      rs = str.executeQuery( consulta1 );
      out.println("<form method=\"post\" name=\"enviar\"><CENTER CLASS=T ALIGN=CENTER>Avance de la Actualizacion Cartografica (Manzanas Aceptadas)<!-- a la fecha: <input class='boton' name='filfe2' type='text' id='p1id' onClick=\"popUpCalendar(this, enviar.p1id, 'yyyy-mm-dd');\" size='10' readOnly value='"+filfe2.substring(0,10)+"'>&nbsp;&nbsp;<input class='boton' type=submit value='Ir'>-->");
out.println("<br><br><center><table border=1 class=table><tr class=titulo2>");
out.println("<th rowspan=3 bgcolor=#dadeda>&nbsp;Entidad&nbsp;");
out.println("<th colspan=1 rowspan=3 bgcolor=#8299BB>&nbsp;&nbsp;Actualizaciones&nbsp;<br>&nbsp;integradas<br>&nbsp;en SIGMA&nbsp;&nbsp;");
out.println("<th colspan=8 bgcolor=#c2f0c2>&nbsp;TABLAS DE EQUIVALENCIA&nbsp;");
out.println("<tr class=titulo2>");
out.println("<th rowspan=2 bgcolor=#c2f0c2>&nbsp;Registros de&nbsp;<br>&nbsp;actualizacion&nbsp;");
out.println("<th rowspan=2 bgcolor=#c2f0c2>&nbsp;Alta&nbsp;");
out.println("<th rowspan=2 bgcolor=#c2f0c2>&nbsp;Subdivision&nbsp;");
out.println("<th rowspan=2 bgcolor=#c2f0c2>&nbsp;Fusion&nbsp;");
out.println("<th rowspan=2 bgcolor=#c2f0c2>&nbsp;Baja&nbsp;");
out.println("<th rowspan=2 bgcolor=#c2f0c2>&nbsp;Registros&nbsp;<br>validados<br>&nbsp;OC&nbsp;");
out.println("<th rowspan=2 bgcolor=#c2f0c2>&nbsp;Registros&nbsp;<br>validados<br>&nbsp;REG&nbsp;");
out.println("<th rowspan=2 bgcolor=#ffffff>&nbsp;Registros&nbsp;<br>cambios<br>&nbsp;de forma&nbsp;");
out.println("<tr class=titulo2>");

      String gid,fecha_cap,numero,remitente,sol="",responsable;
      String imprimir="";
      int colorfila=0;
      String color="";
while(rs.next()){
      if (colorfila==0){
        color= "#FAFAFA";
        colorfila=1;
      }else{
        color="";
        colorfila=0;
      }
	  
	 if(rs.getObject(6) == null){
		  
		  responsable=" ";
	  }else{
		  
		  responsable=rs.getObject(6).toString();
	  }
	 
	  gid=rs.getObject(1).toString();
	  fecha_cap=rs.getObject(2).toString();
	  numero=rs.getObject(3).toString();
	  remitente=rs.getObject(4).toString();
	  sol=rs.getObject(5).toString();
	  //sol=rs.getObject(5).toString();
	  
	  
	  imprimir+=("<tr onmouseover='this.style.background=\"#c0c0c0\"' onmouseout='this.style.background=\""+color+"\"' class=n align=center bgcolor='"+color+"'>");
		imprimir+=("<td>"+gid+"");
		imprimir+=("<td>"+fecha_cap+"");
		imprimir+=("<td>"+numero+"");
		imprimir+=("<td>"+remitente+"");
		imprimir+=("<td>"+sol+"");
		imprimir+=("<td>"+responsable+"");
		imprimir+=("<td><img src='mensaje.png' width=20 onclick=\"return abre()\"</img>");
		
		//onkeypress=\"return enviarkey(event)\"
		
		//printf ( "<td><img src='mensaje.png' width=20 onclick='abre(".gid.")'></img>");


}

  //  out.println("<tr class=n2 align=center style='background-color:#8299BB;'><td>TOTAL");
//out.println("<td>"+formateador.format(sum1)+"");
//out.println("<td>"+formateador.format(sum2)+"");
//out.println("<td>"+formateador.format(sum3)+"");
//out.println("<td>"+formateador.format(sum4)+"");
//out.println("<td>"+formateador.format(sum5)+"");
//out.println("<td>"+formateador.format(sum6)+"");
//out.println("<td>"+formateador.format(sum7)+"");
//out.println("<td>"+formateador.format(sum8)+"");
//out.println("<td>"+formateador.format(sum6+sum7+sum8)+"");

//out.println("<td>"+formateador.format(sum11)+"");  //TCAR


out.println(imprimir);

//out.println("<td>"+formateador.format(sum15)+"");
//out.println("&nbsp;&nbsp;("+formateador.format(sum16)+")");   //manzanas en registros

//out.println("<td>"+formateador.format(sum13));
  out.println("</table><font class=c align=left> <br>");
  //out.println("<div align='center' style='position:absolute;left:0;right:0;margin-left:auto;margin-right:auto;top:300;opacity:0.3;'><center><img src='http://dc046068asdggma:8070/geoserver/INEGI/wms?LAYERS=INEGI%3AESTADOS%2CINEGI%3Aa_rep_mun&TRANSPARENT=TRUE&SERVICE=WMS&VERSION=1.1.1&REQUEST=GetMap&STYLES=estados%2Ca_rep_mun_av&FORMAT=image%2Fpng&SRS=EPSG%3A900913&bbox=-1.3181079254380183E7,1635334.4672155518,-9652558.161913535,3858019.1970224283&WIDTH=2871&HEIGHT=1480' width=800 height=512></img></center></div>");

out.println("</form>");

  //out.println("");
      str.close();
      conexion.close();

%>

</body>
</html>
