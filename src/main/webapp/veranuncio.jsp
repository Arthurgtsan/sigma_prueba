<%@ page import="java.util.*" session="true" %>
<%@ page import="java.sql.*"%>
<%
String  cons = request.getParameter("cons");

if (!(cons == null)){
  String consulta="";
  HttpSession sesion = request.getSession(false);
  String remotehost  = session.getAttribute("remotehost").toString();
  try {
      consulta = "update usuarios set anuncio=1 where cons="+cons;
      //out.println (consulta);
      ResultSet rs = null;
      Statement str = null;
      Connection conexion = null;
        Class.forName("org.postgresql.Driver");
        String hostbd  = session.getAttribute("hostbd").toString();
        String remotehostbd  = session.getAttribute("remotehostbd").toString();
                  conexion = DriverManager.getConnection(
                                                 "jdbc:postgresql://10.153.3.25:5434/actcargeo10",
                                                 "actcar",
                                                 "actcar"
                                                );
      str = conexion.createStatement(rs.TYPE_SCROLL_SENSITIVE, rs.CONCUR_UPDATABLE);
      str.executeUpdate( consulta );
      out.print("0");
      str.close();
      conexion.close();
      }
      catch (SQLException ex){
        out.print("1");
    }
        catch(Exception ex){
          out.print("1");
     }
}else{
%>

<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

    <title>
SIGMA
</title>
      <script language="javascrpt" type="text/javascript">
window.resizeTo(750,670);
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

  <center>
<input type=button name=procboton3 onclick='casigna_baja("+gid+")' value=' ENTERADO '>
</center>
<table border=1 align=center cellpadding="5" cellspacing="5"><tr class=n bgcolor=#BBBBBB>
<br><th>Anuncio</th>


<tr><td class=n>&nbsp;&nbsp;&nbsp;<br>

  <b><font color=red>Marco Geoestad&iacute;stico 2026:</font></b>
<ul type="circle">
<li>Se cambia la base de SIGMA con la informaci&oacute;n del cierre EIC2025 </li>
<br>

<li>Se puede comenzar con la revisi&oacute;n/integraci&oacute;n de los registros de la Actualizaci&oacute;n Integral (ACI) al MG.
  <br> - Ya se encuentra disponible la informaci&oacute;n que se detuvo durante la EIC
  <br> - Ya se encuentra disponible la informaci&oacute;n posterior al corte 2025-07-27
  <br> - Se puede integrar manzanas clasificadas como "NO PROCEDE" (se cambia el status autom&aacute;ticamente)
  <br> - Se puede integrar manzanas de la capa de "Manzanas proyectadas"
<br><br><li>Para esta etapa NO se va a permitir cambio de forma de las manzanas y frentes, en SIGMA o en SIVEC
  <br> - Toda modificaci&oacute;n debe de realizarse de origen en la ACI.
  <br> - <b>Solo se puede cambiar de forma la manzana que se va a fusionar a otra (para realizar la fusi&oacute;n)</b>
<br><br><li>Se pretende que todas las actualizaciones que "NO PROCEDEN" sean exclusivamente las manzanas proyectadas (se quedan con su clave 900)
  <br> - Aunque a&uacute;n se puede dejar "NO PROCEDE" divisiones/fusiones/cambios de forma.
<br><br><li>Manual de Integraci&oacute;n: <a href='manuales/manual_intergacion.pdf' target="_blank"><< ABRIR AQUI >></a>

<br><br><li>Se actualiza la p&aacute;gina de reportes del 2026:
    <br> <a href='http://dc046068asdggma.inegi.gob.mx:8888/rep2026/' target="_blank">http://dc046068asdggma.inegi.gob.mx:8888/rep2026/</a>

<br><br><li><span style="background-color: yellow;">A V I S O :</span>
  <br>- Se han eliminado las actualizaciones de cambio de FORMA debido a que se realizaron con el corte MG2024, y actualmente la BD de la ACI, va a retomar las manzanas y formas del MG2025
  <br>- Las actualizaciones de fusiones / divisiones / altas realizadas con el corte MG2024, se podr&aacute;n ajustar su forma en SIGMA de ser necesario
  <br>- Las actualizaciones posterior a aplicar el corte del MG2025 en la CUR, ya no se podr&aacute; cambiar de forma debido a que ya se realizar&aacute;n sobre la misma base del MG2025. 
  <br>- Se agrega un bot&oacute;n para poder aplicar cambios de geometr&iacute;a de forma masiva  
  <img src=http://dc046068asdggma.inegi.gob.mx:8070/openlayers2/OpenLayers/theme/default/img/draw_casoschnform_off.png>


<br>

<!--
<br>
  <b><font color=red>Actualizaciones sobe la EIC:</font></b>
  <ul type="circle">
<li>Se incluye reporte de actualizaciones que se hicieron sobre la muestra de la EIC <img src='../openlayers2/OpenLayers/theme/default/img/error.png' ></img>
<li>Tiene el t&iacute;tulo: "Area modificada para la EIC"
</ul>
<br>
  <b><font color=red>Capas del CE2024:</font></b>
  <ul type="circle">
<li>Se actualizan las capas resultado del Censo Econ&oacute;mico 2024</li>
&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;Localidades Econ&oacute;micas
<br>&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;Puntos de Arribo
<br>&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;Parques Industriales
</ul>
<!--
  <b><font color=red>Se retoma OneAtlas con credenciales manuales debido a lentitud en el servicio (hasta que mejore)</font></b>
<br><br>
<b>IMAGENES ONEATLAS:</b><br>
  <ul type="circle">
<li>Se pone a disposici&oacute;n el servicio de imagenes de OneAtlas, con el siguiente procedimiento:
<br>&nbsp;&nbsp;&nbsp;1.-Configurar el navegador de internet y deshabilitar ventanas emergentes(no estar bloqueadas).
<br>&nbsp;&nbsp;&nbsp;2.-Del selector de capas base de Sigma habilitar la opci&oacute;n OneAtlas.
<br>&nbsp;&nbsp;&nbsp;3.-Se desplegar&aacute; la ventana de inicio de sesi&oacute;n, Nombre de usuario = APIKEY, contrase&ntilde;a = clave que nos compartieron (puedes optar guardar estos par&aacute;metros en tu navegador).
<br>&nbsp;&nbsp;&nbsp;4.-Hecho lo anterior se mostrar&aacute; una imagen y en el centro de &aacute;rea de dibujo de sigma desplegar&aacute; un cuadro de sus l&iacute;mites en color amarillo.
<br>&nbsp;&nbsp;&nbsp;5.-Es importante mencionar que cada vez que realices un recorrido (paneo) en el mapa y quieras actualizar la imagen, debes dar click en el icono de las flechas de actualizar imagen (a un costado de "OneAtlas" en el selector de imagenes).
<br>&nbsp;&nbsp;&nbsp;6.-En el centro de la parte superior aparecer&aacute; un mensaje con la fecha de la imagen y el sat&eacute;lite (PNEO 30 cm, PHR 50 cm, SPOT 1.5 m), (se mostrar&aacute;n las im&aacute;genes m&aacute;s recientes de los sat&eacute;lites pl&eacute;yades, cuando no exista cobertura se desplegar&aacute;n las SPOT)
<br>&nbsp;&nbsp;&nbsp;* Se recomienda limpiar cache del navegador (ctrl-shift-supr) "Archivos e im&aacute;genes en cache"
</ul>
<br>
<!--
 <b>PREDIGITALIZACION:</b><br>
  <ul type="circle">
<li>Para la parte de pre digitalizaci&oacute;n, como cada que se inicia, nos pueden mandar para eliminar informaci&oacute;n obsoleta, ya sea por pol&iacute;gonos, claves, fechas o reiniciar todo, sobre  las tres capas de informaci&oacute;n.
</li></ul>
<br>
  <b>SIGMA Crecimientos:</b><br>
  <ul type="circle">
<li>Se pone a disposici&oacute;n la capa de crecimientos de Google (Crecimientos GGL), para posible detecci&oacute;n de crecimientos.
<li>Se tiene el sistema para la detecci&oacute;n de infraestructura que no empalma con cartograf&iacute;a del MG, para posible detecci&oacute;n de crecimientos. En el &iacute;ndice de las capas se encuentra la ficha t&eacute;cnica.
<br>
<a href='http://dc046068asdggma.inegi.gob.mx:8070/crecimientosgoogle/' target="_blank"><< ABRIR AQUI >></a>
</li></center>
-->

<!--
<img src='OpenLayers/theme/default/img/draw_registra_off.png' ></img>
</li>
<br>
<li>En la capa de "Crecimientos", los que ya fueron revisados, se dibujaran de color naranja con un punto rojo en medio!!
</li>
<br>

<li>Se puede integrar informacion de la CUR de a&nacute;os anteriores al 2021 <br>(capa "MZ-Proyectadas"), con el mismo boton de "Agregar Manzanas desde MCC/CUR" en el apartado de "Editar Manzanas"
<br><img src='OpenLayers/theme/default/img/agm_off.png' ></img>
</li>
</ul>
-->

</td></tr></table></body>
</html>
<script>
 var cons=window.opener.iduser;

  function casigna_baja(gid){
    var ajax=nuevoAjax();
    ajax.open("GET",'veranuncio.jsp?cons='+cons, true);
    ajax.onreadystatechange=function()
    {
        if(ajax.readyState==4)  {
             var vale=ajax.responseText;
            if (parseInt(vale)==0){
                //window.opener.alertmsg (" Registrado ::");
            }else{
              //window.opener.alertmsg ("No se pudo registrar");
            }
            window.close();
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
            if (!xmlhttp && typeof XMLHttpRequest!=undefined) xmlhttp=new XMLHttpRequest();
        }
    }return xmlhttp;
}

</script>
<%
}  //else del cons unll
%>