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
.n{font-family: Arial; font-size: 10pt; line-height: 1.6; font-weight: bold;}
.boton{font-family: Arial; font-size: 10px; line-height: 1; font-weight: normal;}

</style>
<script language="javascrpt" type="text/javascript">
window.resizeTo(400,400);

</script>
  </head>
<body>
  <center class='t'>Descriptores</center><br>
  <form name="tema">
    <table border=1 align=center>
<%
String  pass = request.getParameter("tipo");
switch (Integer.parseInt(pass)){
case 1:
  out.println("<tr class=n><td><img src='images/tema1.png'></img>");
  out.println("<td align=left>De 1000 o mas registros<br>");
  out.println("De 500 a 999 registros<br>");
  out.println("De 250 a 499 registros<br>");
  out.println("De 100 a 246 registros<br>");
  out.println("De 50 a 99 registros<br>");
  out.println("De 1 a 49 registros");
  out.println("</td>");
  break;
case 2:
  out.println("<tr class=n><td><img src='images/tema2.png'></img>");
  out.println("<td align=left valign=top>Localidades islas:<br>Son localidades que fisicamente se encuentran en algun espacio diferente al que pertenecen administrativamente.");
  out.println("</td>");
  break;
case 3:
  out.println("<tr class=n><td><img src='images/tema3.png'></img>");
  out.println("<td align=left valign=top>Zonas Metropolitanas:<br> una definicion de zona metropolitana como el conjunto de dos o mas municipios donde se localiza una ciudad de 50 mil o mas habitantes, cuya area urbana, funciones y actividades rebasan el limite del municipio que originalmente la contenia, incorporando como parte de si misma o de su area de influencia directa a municipios vecinos, predominantemente urbanos, con los que mantiene un alto grado de integracion socioeconomica.");
  out.println("</td>");
  break;
}
%>
</table>
<center><br><input type=button onclick="window.close();" value=' Cerrar ' class='boton'>
</center>
  </form>
  <center><br>

</body>
</html>