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
window.resizeTo(600,400);

function tematico(){
  if (document.tema.tipo[0].checked){
      window.opener.vertema(1,document.tema.opcion1.value);
  }else if (document.tema.tipo[1].checked){
      window.opener.vertema(2,'');
  }else if (document.tema.tipo[2].checked){
      window.opener.vertema(3,'');
  }else{
      alert ("Seleccione un tipo de mapa!!");
      return false;
  }
}

</script>
  </head>
<body>
  <center class='t'>Mapas tem&aacute;ticos e informativos</center><br><br>
  <form name="tema">
    <table border=1 align=center><tr class=n bgcolor=#BBBBBB><th>&nbsp;&nbsp;Tipo de mapa&nbsp;&nbsp;<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Opci&oacute;n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<th>&nbsp;&nbsp;Descripci&oacute;n&nbsp;&nbsp;
      <tr class=n><td><input type="radio" name="tipo" value="1">&nbsp;&nbsp;Registros capturados anualmente&nbsp;&nbsp;
                  <td align=center><select name='opcion1' class='boton'>
                    <option value="2023">2023</option>
                    <option value="2022">2022</option>
                    <option value="2021">2021</option>
                    <option value="2020">2020</option>
                    <option value="2019">2019</option>
                    <option value="2018">2018</option>
                    <option value="2017">2017</option>
                    <option value="2016">2016</option>
                    <option value="2015">2015</option>
                    <option value="2014">2014</option>
                    <option value="2013">2013</option>
                    <option value="2012">2012</option>
                    <option value="2011">2011</option>
                    <option value="2010">2010</option>
                    <option value="2009">2009</option>
                    <option value="2008">2008</option>
                    <option value="2007">2007</option>
                    <option value="2005">2005</option>
                      </select></td><td align='center'><input type=button onclick="window.open('mapatedesc.jsp?tipo=1','MAPATEDESC','toolbar=no,Resizable=1,scrollbars=1');" value=' Ver ' class='boton'></td>
     <tr class=n><td><input type="radio" name="tipo" value="2">&nbsp;&nbsp;Localidades islas&nbsp;&nbsp;
                  <td align=center></td><td align='center'><input type=button onclick="window.open('mapatedesc.jsp?tipo=2','MAPATEDESC','toolbar=no,Resizable=1,scrollbars=1');" value=' Ver ' class='boton'></td>
    <tr class=n><td><input type="radio" name="tipo" value="2">&nbsp;&nbsp;Zonas metropolitanas&nbsp;&nbsp;
                  <td align=center></td><td align='center'><input type=button onclick="window.open('mapatedesc.jsp?tipo=3','MAPATEDESC','toolbar=no,Resizable=1,scrollbars=1');" value=' Ver ' class='boton'></td>
    </table>
    <center><br><input type=button onclick='tematico();' value=' Ver en mapa ' class='boton'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input type=button onclick="window.opener.vertema(0,'');" value=' Limpiar ' class='boton'>
</center>
  </form>
  <center><br>

</body>
</html>