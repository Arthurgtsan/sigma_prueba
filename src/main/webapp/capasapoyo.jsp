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
window.resizeTo(250,290);
var cadena="";

function envia(capa,desc,check){

cadena="";
if (document.tema.c1.checked==true){cadena+='INEGI:C_RUV,INEGI:C_INE,';}
//if (document.tema.c2.checked==true){cadena+='';}
if (document.tema.c3.checked==true){cadena+='INEGI:C_TUITS,';}
if (document.tema.c4.checked==true){cadena+='INEGI:C_VISITA,';}
if (document.tema.c5.checked==true){cadena+='INEGI:C_NOVISITA,';}
if (document.tema.c6.checked==true){cadena+='INEGI:C_BASCRECI,';}
if (document.tema.c7.checked==true){cadena+='INEGI:C_POSLOC,';}
if (document.tema.c8.checked==true){cadena+='INEGI:C_CRECIM,';}
cadena=cadena.substring(0,cadena.length-1);
   opener.parent.mz_ruvine.params["LAYERS"] = cadena;
   opener.parent.mz_ruvine.redraw(true);
if (cadena.length>0){
   opener.parent.mz_ruvine.setVisibility(true);
   //opener.parent.mz_ruvine.redraw(true);
}else{
   opener.parent.mz_ruvine.setVisibility(false);
}
opener.parent.cadenapoyo=cadena;
}



function carga(){
cadena=opener.parent.cadenapoyo;
if (cadena.search("C_RUV")!=-1){ //si se encontro
  document.tema.c1.checked=true;
}
if (cadena.search("C_TUITS")!=-1){ //si se encontro
  document.tema.c3.checked=true;
}
if (cadena.search("C_VISITA")!=-1){ //si se encontro
  document.tema.c4.checked=true;
}
if (cadena.search("C_NOVISITA")!=-1){ //si se encontro
  document.tema.c5.checked=true;
}
if (cadena.search("C_BASCRECI")!=-1){ //si se encontro
  document.tema.c6.checked=true;
}
if (cadena.search("C_POSLOC")!=-1){ //si se encontro
  document.tema.c7.checked=true;
}
if (cadena.search("C_CRECIM")!=-1){ //si se encontro
  document.tema.c8.checked=true;
}


}
</script>
  </head>
<body onload='carga()'>
  <form name="tema">
    <br>
    <table border=1 align=center><tr class=n bgcolor=#BBBBBB><th colspan=3>&nbsp;&nbsp;Capas de apoyo&nbsp;&nbsp;
      <tr class=n>
        <td><img src="images\ineruv.png"><img>
        <td>&nbsp;&nbsp;INE/RUV&nbsp;&nbsp;
        <td><input name='c1' class='boton' type='checkbox' onclick="envia('c1','INEGI:C_RUV',this.checked)">
      <tr class=n>
        <td><img src="images\c3.png"><img>
        <td>&nbsp;&nbsp;TWEETS&nbsp;&nbsp;
        <td><input name='c3' class='boton' type='checkbox' onclick="envia('c3','INEGI:C_TUITS',this.checked)">
      <tr class=n>
        <td><img src="images\c4.png"><img>
        <td>&nbsp;&nbsp;LPR alto dinamismo&nbsp;&nbsp;
        <td><input name='c4' class='boton' type='checkbox' onclick="envia('c4','INEGI:C_VISITA',this.checked)">
      <tr class=n>
        <td><img src="images\c5.png"><img>
        <td>&nbsp;&nbsp;LPR bajo dinamismo&nbsp;&nbsp;
        <td><input name='c5' class='boton' type='checkbox' onclick="envia('c5','INEGI:C_NOVISITA',this.checked)">
      <tr class=n>
        <td><img src="images\c6.png"><img>
        <td>&nbsp;&nbsp;Poligonos LPR&nbsp;&nbsp;
        <td><input name='c6' class='boton' type='checkbox' onclick="envia('c6','INEGI:C_BASCRECI',this.checked)">
      <tr class=n>
        <td><img src="images\c7.png"><img>
        <td>&nbsp;&nbsp;Posible nueva LPR&nbsp;&nbsp;
        <td><input name='c7' class='boton' type='checkbox' onclick="envia('c7','INEGI:C_POSLOC',this.checked)">
      <tr class=n>
        <td><img src="images\c8.png"><img>
        <td>&nbsp;&nbsp;Poligonos de crecimiento&nbsp;&nbsp;
        <td><input name='c8' class='boton' type='checkbox' onclick="envia('c8','INEGI:C_CRECIM',this.checked)">
  </table>
  </center>
</form>
</body>
</html>