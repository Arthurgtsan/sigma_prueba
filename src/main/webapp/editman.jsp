<%@page import="java.text.DecimalFormat" %>
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
.t{font-size: 12pt; font-family: Arial; font-weight: bold; color: #000000;} 
.c{font-family: Arial; font-size: 8pt; line-height: 1.3; font-weight: normal;}
.n{font-family: Arial; font-size: 8pt; line-height: 1.3; font-weight: bold;}
.boton{font-family: Arial; font-size: 10px; line-height: 1; font-weight: normal;}
<%
String  enti = request.getParameter("ent");
%>
</style>
<script language="javascrpt" type="text/javascript">
window.resizeTo(350,250);
var ban1=0;
var ban2=0;
var ban3=0;
var enti='<% out.print(enti); %>';
function datonum(e){
  var bn=navigator.appName;
  key = (document.all) ? e.keyCode : e.which;
  if (key==8 || key==9 || key==0 || key==127 || key==46 || key==45) return true;
  if (key==13) enviar1();
    if (key < 48 || key > 57) {
        if (bn=="Microsoft Internet Explorer"){
            window.event.keyCode=0;
        }
     return false;
 }

}


function vaciar(e){
  if (e==1){
    if (ban1==0)document.inicia.clave.value='';
    ban1=1;
  }else if (e==2){
    if (ban2==0)document.inicia.latitud.value='';
    ban2=1;
  }else{
    if (ban3==0)document.inicia.longitud.value='';
    ban3=1;
  }
}

function enviar1(){
var clave=document.inicia.clave.value;
var latitud=document.inicia.latitud.value;
var longitud=document.inicia.longitud.value;
var lat_dec=parseInt(latitud.substr(0,2),10)+parseInt(latitud.substr(2,2),10)/60+parseFloat(latitud.substr(4,6),10)/3600;
if (enti!=00){
  if (clave.substring(0,2)!=enti){
    alert ("Clave de entidad incorrecta!!");
    return false;
}
}
if (clave.length<9){
	alert ("La clave debe ser de 9 caracteres!!");
	return false;
}
if (latitud.length<10){
	alert ("La latitud debe ser de 10 digitos!!");
	return false;
}
if (longitud.length<11){
	alert ("La longitud debe ser de 11 digitos!!");
	return false;
}
if (parseInt(latitud,10)>parseInt(325000,10) || parseInt(latitud,10)<parseInt(143000,10)){
	alert ("Latitud fuera de rango!!");
	return false;
}
if (longitud.substr(0,1)=='0'){
	if (parseInt(longitud.substr(1,10),10)>parseInt(1190000,10) || parseInt(longitud.substr(1,10),10)<parseInt(850000,10)){
		alert ("Longitud fuera de rango!!");
		return false;
	}
	var lon_dec=(parseInt(longitud.substr(1,2),10)+parseInt(longitud.substr(3,2),10)/60+parseFloat(longitud.substr(5,6),10)/3600)*(-1);
}else{
	if (parseInt(longitud,10)>parseInt(1190000,10) || parseInt(longitud,10)<parseInt(850000,10)){
		alert ("Longitud fuera de rango!!");
		return false;
	}
	var lon_dec=(parseInt(longitud.substr(0,3),10)+parseInt(longitud.substr(3,2),10)/60+parseFloat(longitud.substr(5,6),10)/3600)*(-1);
}
document.inicia.lat_dec.value=lat_dec;
document.inicia.lon_dec.value=lon_dec;
document.inicia.submit();
}

function nuevoAjax()
{
  /* Crea el objeto AJAX. Esta funcion es generica para cualquier utilidad de este tipo, por
  lo que se puede copiar tal como esta aqui */
  var xmlhttp=false;
  try {
    // Creacion del objeto AJAX para navegadores no IE
    xmlhttp=new ActiveXObject("Msxml2.XMLHTTP");
  }catch(e){
    try {
      // Creacion del objet AJAX para IE
      xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
    }catch(E){
      if (!xmlhttp && typeof XMLHttpRequest!='undefined') xmlhttp=new XMLHttpRequest();
    }
  }return xmlhttp;
}

function pegacoord() {
var ajax=nuevoAjax();
ajax.open("GET",'obtcoord.jsp?ent='+enti, true);
ajax.onreadystatechange=function()
{
    if(ajax.readyState==4)  {
        var val=ajax.responseText;
        if (val=='1'){
            alert ("No hay nada que pegar!");
        }else{
            vec=val.split(',');
            document.inicia.longitud.value=vec[0];
            document.inicia.latitud.value=vec[1];
        }
    }
}
ajax.send(null);
}
</script>
<link rel="stylesheet" href="style.css" type="text/css" />
  </head>
 <%
 String clave=request.getParameter("clave"),
    longitud = request.getParameter("longitud"),
    latitud = request.getParameter("latitud"),
    lat_dec = request.getParameter("lat_dec"),
    lon_dec = request.getParameter("lon_dec"),
    consulta = "",
    salida = "",
    st = "";
  String  pass = request.getParameter("pass");
  String  consultapass="select nivel,edicion,cons from usuarios where md5(password) = '"+pass+"';";
try {
  if (clave==null){
       out.println("<body><Form action=\"editman.jsp\" method=\"post\" name=\"inicia\"><center><b>MODIFICACION DE COORDENADAS</b><br><br><table border=1>"+
        "<tr><td class=\"search\" nowrap align=right>CLAVE:<td><input value='EEMMMLLLL' type=\"text\" name=\"clave\" maxlength=\"9\" SIZE=\"12\" class=\"boton\" onFocus='return vaciar(1)' onKeypress=\"return datonum(event)\">"+
        "<tr><td class=\"search\" nowrap align=right>LATITUD:<td><input value='GGMMSS.SSS' type=\"text\" name=\"latitud\" maxlength=\"10\" SIZE=\"13\" class=\"boton\" onFocus='return vaciar(2)' onKeypress=\"return datonum(event)\">"+
        "<tr><td class=\"search\" nowrap align=right>LONGITUD:<td><input value='GGGMMSS.SSS' type=\"text\" name=\"longitud\" maxlength=\"11\" SIZE=\"14\" class=\"boton\" onFocus='return vaciar(3)' onKeypress=\"return datonum(event)\">"+
        "</table><br><input type='button' value='Pegar coordenadas' name='pegac' class='boton' onclick='pegacoord()'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input class=\"boton\" type=\"Button\" onclick='enviar1();' value=\" Capturar \"/></center>"+
        "<input type='hidden' name='lat_dec'><input type='hidden' name='lon_dec'><input type='hidden' name='pass' value='"+pass+"'>"
        + "</form></body></html>");
  }else{
      consulta="select count(*) from shp_locr_coord where clave='"+clave+"'";
      out.println("<center><b>VALIDANDO...</b></center>");
      ResultSet rs = null;
      Statement str = null;
      Connection conexion = null;
      Class.forName("org.postgresql.Driver");
      conexion = DriverManager.getConnection("jdbc:postgresql://10.153.3.25:5434/actcargeo10","actcar","actcar");
      str = conexion.createStatement(rs.TYPE_SCROLL_SENSITIVE, rs.CONCUR_UPDATABLE);
      rs = str.executeQuery( consultapass );
      rs.next();
      int s1=Integer.parseInt(rs.getObject(1).toString()); //nivel 
      int s2=Integer.parseInt(rs.getObject(2).toString()); //edicion
      int idus=Integer.parseInt(rs.getObject(3).toString()); //edicion
      if ((s2==1)){
          rs = str.executeQuery( consulta );
          rs.next();
        int s3= Integer.parseInt(rs.getObject(1).toString());
        if (s3==0){
            out.println("<Form action=\"editman.jsp\" method=\"post\" name=\"inicia\"></form>");
            out.println("<script>alert('La CLAVE de la localidad es incorrecta!!');document.inicia.submit();</script>");
        }else{
          out.println("<Form action=\"editman.jsp\" method=\"post\" name=\"inicia\"></form></body>");
          consulta="select a_shploc_editman('"+clave+"','"+lon_dec+"','"+lat_dec+"','"+idus+"')";
          rs = str.executeQuery( consulta );
          rs.next();
          String s4=rs.getObject(1).toString();
          out.println("<script>alert('Coordenadas modificadas, distancia: ("+s4+" mts)');"
                  +"window.opener.document.busqueda.latitud.value='"+latitud+"';"
                  +"window.opener.document.busqueda.longitud.value='"+longitud+"';"
                  +"window.opener.enviar();"
                  +"window.opener.document.busqueda.latitud.value='';"
                  +"window.opener.document.busqueda.longitud.value='';"
                  +"window.close();</script>");
        }
     }else{
        out.println ("<br><center>No tienes privilegios<br>para realizar cambios!!</center>");
     }
    rs.close();
    str.close();
    conexion.close();
    }
   }
   catch (SQLException ex){
      out.println("<script>");
      out.println("  alert(\"Se genero la expresion de SQL: "+ex.getMessage().substring(0, ex.getMessage().length()-1)+" !\");");
      out.println("  //alert(\"Tienes que proporcionar correctamente las coordenadas!!\");//document.inicia.submit();</script>");
      out.println("</script>");
    }
    catch(Exception ex){
      out.println("<script>");
      out.println("  alert(\"Se genero la expresion: "+ex.getMessage().substring(0, ex.getMessage().length()-1)+" !\");");
      out.println("</script>");
    }
    
%>

<html>