<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>
SIGMA
</title>
      <script language="javascrpt" type="text/javascript">
window.resizeTo(400,350);
</script>
<style type="text/css">
table {
  border-collapse: collapse;
}
.t{font-size: 12pt; font-family: Arial; font-weight: bold; color: #000000;} 
.c{font-family: Arial; font-size: 8pt; line-height: 1.3; font-weight: normal;}
.n{font-family: Arial; font-size: 8pt; line-height: 1.3; font-weight: bold;}
.boton{font-family: Arial; font-size: 10px; line-height: 1; font-weight: normal;}

</style>
 </head>
<body>
<%
HttpSession sesion = request.getSession(false);
String remotehost  = session.getAttribute("remotehost").toString();
String  capa  = request.getParameter("capa");
String img1="";
	out.println("<br><table border=1 align=center><tr><th class='n' valign=center>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;PROCEDIMIENTO&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<td width=10 class='n' align=center>");
out.println("VIDEO<br><img align=bottom src='images/descarga.png' onclick=\"window.open('manuales/3.14.zip', '_blank'); return false;\"></img>");
if (capa.equals("1")) {
	out.println("<tr><td class='c' align=center colspan=2>:: Manzanas cambio de &aacute;mbito ::");
	out.println("<tr><td class='c' colspan=2>1.- Agregar AGEB nueva, debe de cubrir completamente las manzanas a cambiar de &aacute;mbito");
	out.println("<br>- El AGEB se crea con la herramienta de edici&oacute;n de AGEBs");
	out.println("<br>- Se recomienda crear primero todos los agebs de la localidad");
	out.println("<tr><td class='c' colspan=2>2.- Seleccionar con el bot&oacute;n J el AGEB creado");
	out.println("<tr><td class='c' colspan=2>3.- Presionar en ->COMENZAR<- ");
	out.println("<tr><td class='c' colspan=2>4.- Revisar la tabla de equivalencia generada en el bot&oacute;n T-M-J");
	out.println("<tr><td class='c' colspan=2>5.- Al terminar todas las manzanas, eliminar el pol&iacute;gono de la localidad Rural con la herramienta de edici&oacute;n de pol&iacute;gonos de localidad rural");

}else {
	out.println("<tr><td class='c' align=center  colspan=2>:: Caser&iacute;os cambio de &aacute;mbito ::");
	out.println("<tr><td class='c' colspan=2>1.- Seleccionar (envolver) con el bot&oacute;n J los caser&iacute;os a cambiar");
	out.println("<tr><td class='c' colspan=2>2.- Revisar que sea el AGEB a enviar los caser&iacute;os");
	out.println("<tr><td class='c' colspan=2>3.- Presionar en ->COMENZAR<- ");
	out.println("<tr><td class='c' colspan=2>4.- Revisar la tabla de equivalencia generada en el bot&oacute;n T-M-J");
	out.println("<tr><td class='c' colspan=2>5.- Eliminar PE, de la localidad");
	out.println("<br>- El PE se elimina  con la herramienta de edici&oacute;n de Poligonos Externos");
	out.println("<tr><td class='c' colspan=2>6.- Agregar PEM nuevo, debe de cubrir completamente los caser&iacute;os cambiados");
	out.println("<br>- El PEM se crea con la herramienta de edici&oacute;n de Caser&iacute;os");
}

out.println("</table>");
%>
</body>
</html>
