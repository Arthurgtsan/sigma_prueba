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
<%
String usuario= request.getParameter("user");
String usuariodg= request.getParameter("userdg");



%>
</style>
<script language="javascrpt" type="text/javascript">
window.resizeTo(640,380);


/* function actualiza(){
ventana = window.open('zedit_act.jsp','Observapre','scrollbars=no,toolbar=no');
document.captura.submit();
ventana.focus();
} */


function validaenviar(){
	
salida1=0;
for(a=1; a<document.captura.elements.length-1; a++) {
		if (document.captura.elements[a].value.length==0){
			salida1=1;
		}	
}
if (salida1>0){
  alert("Tiene que proporcionar los datos correspondientes!!");
  return false;
}

if (confirm("Los datos son correctos?")){
document.captura.submit();
}}




</script>
</head>


<body><table BORDER=1><center><table   border="0"  bgcolor="#dddddd" width=80% align="center">
<form name="captura" action="zedit_act.jsp" method="post" >

<%
out.println( "<H2><CENTER CLASS=n ALIGN=CENTER> Actualizar Password de Imagenes Digitalglobe (securewatch) <br> para el usuario: "+usuariodg+"</H2>");
out.println("<td>");
out.println("<br>");
out.println("<td>");
out.println("<tr>");
out.println("<td class=n align='center'><b>&nbsp;&nbsp;Password de Sigma:&nbsp;&nbsp;</b></td>");
out.println("<td align=center><INPUT type='password' NAME='pas_sigma' SIZE=20  maxlength=20 class='input' value='' style='text-transform:uppercase;' onClick='this.select()'></td>");
out.println("<tr>");
out.println("<td class=n align='center'><b>&nbsp;&nbsp;Nuevo Password de&nbsp;&nbsp;<br>&nbsp;&nbsp;Digitalglobe (securewatch):&nbsp;&nbsp;</b></td>");
out.println("<td align=center><INPUT type='text' NAME='new_pas' SIZE=20  maxlength=20 class='input' value='' onClick='this.select()'></td>");
out.println("<tr><td>&nbsp;<td>&nbsp;<br>");
out.println("<tr>");
out.println("<td  align=center class=n  colspan='2'><input  type='button' align='right' name='enviar' value='Actualizar Password' onclick='validaenviar();' class='boton'></td>");
out.println("<tr>");
out.println("<td>");
out.println("<input id='prodId' name='prodId' type='hidden' value="+usuariodg+">");
out.println("<input id='prodId' name='prodIdco' type='hidden' value="+usuario+">");
out.println("<br>");
out.println("<td>");


%>

</table></table>
</form>
</body>

</html>