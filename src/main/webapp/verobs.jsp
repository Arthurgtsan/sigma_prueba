<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>
SIGMA
</title>
      <script language="javascrpt" type="text/javascript">
window.resizeTo(300,300);
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
<script type="text/javascript">
function envia(id) {
    var ajax=nuevoAjax();
    ajax.open("GET",'agregacgo.jsp?id='+id, true);
    ajax.onreadystatechange=function()
    {
        if(ajax.readyState==4)  {
             var vale=ajax.responseText.trim();
             var s1=vale;
             vale=vale.substring(0, 1);
            if (vale=='B'){
                alert ("No se pueden agregar localidades de BAJA!!");
            }else if (vale=='X'){
                alert ("No existe codigo de actualizacion!!");
            }else if (vale=='N'){
                alert ("Ya existe un registro con la informacion!!");
            }else if (vale=='S'){
                alert ("El registro se realizo correctamente Id - "+s1.substring(1,s1.length)+"!!");
            }else{
              alert ("No se pudo agregar la informacion!!");
            }
        }
    }
    ajax.send(null);
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

</script>

  </head>
<body>
<%
String  obs = request.getParameter("obs"),
		gid = request.getParameter("gid"),
    cod = request.getParameter("cod"),
    cve = request.getParameter("cve"),
		img = request.getParameter("img");
String img1="";
if (img.equals("OR")) {
	img1="ORTOFOTO";
}else if (img.equals("S5")) {
	img1="SPOT 5";
}else if (img.equals("S6")) {
	img1="SPOT 6";
}else if (img.equals("GO")) {
  img1="GOOGLE";
}else if (img.equals("DG")) {
  img1="DIGITAL GLOBE";
}else if (img.equals("ES")) {
  img1="ESRI";
}else if (img.equals("MA")) {
  img1="MODIFICACION MANUAL";
}else{
img1="SIN FUENTE";
}

out.println("<table border=1 align=center><tr><th class='n'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;OBSERVACIONES&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>"+cve+"<br>");
out.println("<tr><td class='c'>"+obs+"<br><br>");
if (cod.equals("G")){
    out.println("<tr><td align=center><input class='boton' type='button' value=' Agregar Codigo G - Cambio de AGEB' onclick='envia("+gid+")'>");
}else if (cod.equals("D")){
    out.println("<tr><td align=center><input class='boton' type='button' value=' Agregar Codigo D - Fusionada' onclick='envia("+gid+")'>");
}else if (cod.equals("E")){
    out.println("<tr><td align=center><input class='boton' type='button' value=' Agregar Codigo E - Conurbada ' onclick='envia("+gid+")'>");
}
out.println("<tr><td class='c'>FUENTE: "+img1+"");
out.println("</table>");
%>
</body>
</html>