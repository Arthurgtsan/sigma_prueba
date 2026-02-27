<%@ page import="java.util.*" session="true" %>
<%@ page import="java.io.*"%>
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
<script language="javascrpt" type="text/javascript">
<%
String ban = request.getParameter("imp");
String w = request.getParameter("w");
String h = request.getParameter("h");
HttpSession sesion = request.getSession(true);

if ((sesion != null && !sesion.isNew())) {
        //out.println("LA SESION SIGUE ACTIVA");


      String remotehost  = session.getAttribute("remotehost").toString();
      out.println("var host='"+remotehost+"';");
%>
var reg = opener.idreggeo;
window.resizeTo(500,450);
function desc(){
    var w ='<% out.print(w); %>';
    var h ='<% out.print(h); %>';
    var ban ='<% out.print(ban); %>';
    var escala = opener.map.getScale();
    var extent  = opener.map.getExtent().transform(opener.map.projection, opener.map.displayProjection);
    var width   = opener.map.getSize().w;
    var height  = opener.map.getSize().h;
    var layers = '';
    var styles = '';
    var cql = '';
    var filtermz = "ban<>'3' and ban<>'1' and ban<>'5' and ban<>'6' and ban<>'Y' and ban<>'E' and ban<>'D' and ban<>'H' and ban<>'G' and ban<>'I' and ban<>'M' and ban<>'N' and ban<>'O' and ban<>'K' and ban<>'R' and ban<>'T' and ban<>'C' and ban<>'X';";
    var filterau = "ban<>'3' and ban<>'4' and ban<>'9';";
    var filterpr = "ban<>'3';";
    if (opener.cartas.getVisibility() && opener.cartas.minScale>=escala){layers+='INEGI:CARTAS,';styles+='cartas,';cql+='INCLUDE;'}
    if (opener.cartaset.getVisibility() && opener.cartaset.minScale>=escala){layers+='INEGI:CARTAS,';styles+='cartaset,';cql+='INCLUDE;'}
    if (opener.estados.getVisibility() && opener.estados.minScale>=escala){layers+='INEGI:ESTADOS,';styles+='estados,';cql+='INCLUDE;'}
    if (opener.estadoset.getVisibility() && opener.estadoset.minScale>=escala){layers+='INEGI:ESTADOS,';styles+='estadoset_sig,';cql+='INCLUDE;'}
    if (opener.municipios.getVisibility() && opener.municipios.minScale>=escala){layers+='INEGI:MUNICIPIOS,';styles+='municipios,';cql+='INCLUDE;'}
    if (opener.municipioset.getVisibility() && opener.municipioset.minScale>=escala){layers+='INEGI:MUNICIPIOS,';styles+='municipioset_sig,';cql+='INCLUDE;'}
    if (opener.agebs.getVisibility() && opener.agebs.minScale>=escala){layers+='INEGI:AGEB,';styles+='agebs,';cql+='INCLUDE;'}
    if (opener.agebset.getVisibility() && opener.agebset.minScale>=escala){layers+='INEGI:AGEB,';styles+='agebset,';cql+='INCLUDE;'}
    if (opener.locurb.getVisibility() && opener.locurb.minScale>=escala){layers+='INEGI:POLIGONOS_URBANOS,';styles+='urbanas,';cql+='INCLUDE;'}
    if (opener.locurbet.getVisibility() && opener.locurbet.minScale>=escala){layers+='INEGI:POLIGONOS_URBANOS,';styles+='urbanaset,';cql+='INCLUDE;'}
    if (document.enviar.act.checked){
        if ((opener.locrurpol_ext.getVisibility() || opener.locrurpol_ext_gen.getVisibility()) && opener.locrurpol_ext.minScale>=escala){layers+='INEGI'+reg+':edit_pe,';styles+='pol_rur_ext,';cql+=filterpr;}
    }else{
        if ((opener.locrurpol_ext.getVisibility() || opener.locrurpol_ext_gen.getVisibility()) && opener.locrurpol_ext.minScale>=escala){layers+='INEGI:POL_RUR_EXT,';styles+='pol_rur_ext,';cql+='INCLUDE;'}
    }
    if (opener.locrur0.getVisibility() && opener.locrur0.minScale>=escala){layers+='INEGI:locs_puntuales_b,';styles+='locsrur0,';cql+='INCLUDE;'}
    if (opener.locruret0.getVisibility() && opener.locruret0.minScale>=escala){layers+='INEGI:locs_puntuales_b,';styles+='locsruret0,';cql+='INCLUDE;'}
    if (opener.locrur1.getVisibility() && opener.locrur1.minScale>=escala){layers+='INEGI:locs_puntuales_v,';styles+='locsrur1,';cql+='INCLUDE;'}
    if (opener.locruret1.getVisibility() && opener.locruret1.minScale>=escala){layers+='INEGI:locs_puntuales_v,';styles+='locsruret1,';cql+='INCLUDE;'}
    if (opener.asen.getVisibility() && opener.asen.minScale>=escala){layers+=opener.shp_asen_ss+',';styles+='asen1,';cql+='INCLUDE;'}
    if (opener.asenet.getVisibility() && opener.asenet.minScale>=escala){layers+=opener.shp_asen_ss+',';styles+='asen1et,';cql+='INCLUDE;'}
    if (document.enviar.act.checked){
        if ((opener.mza_gen.getVisibility() || opener.mza.getVisibility()) && opener.mza.minScale>=escala){layers+='INEGI'+reg+':cat_manz,';styles+='mza,';cql+=filtermz;}
        if ((opener.mza_gen.getVisibility() || opener.mzaet.getVisibility()) && opener.mzaet.minScale>=escala){layers+='INEGI'+reg+':cat_manz,';styles+='mzaetbd,';cql+=filtermz;}
        if ((opener.agebsur.getVisibility() || opener.agebu_gen.getVisibility()) && opener.agebsur.minScale>=escala){layers+='INEGI'+reg+':edit_agebu,';styles+='agebs,';cql+=filterau;}
        if ((opener.agebsuret.getVisibility() || opener.agebu_gen.getVisibility()) && opener.agebsuret.minScale>=escala){layers+='INEGI'+reg+':edit_agebu,';styles+='agebsetbd,';cql+=filterau;}
        if ((opener.locrurpol.getVisibility() || opener.polr_gen.getVisibility()) && opener.locrurpol.minScale>=escala){layers+='INEGI'+reg+':edit_locr,';styles+='porur,';cql+=filterpr;}
        if ((opener.locrurpolet.getVisibility() || opener.polr_gen.getVisibility()) && opener.locrurpolet.minScale>=escala){layers+='INEGI'+reg+':edit_locr,';styles+='poruretbd,';cql+=filterpr;}
        if ((opener.caserio.getVisibility() || opener.caserio_gen.getVisibility()) && opener.caserio.minScale>=escala){layers+='INEGI'+reg+':cat_cd,';styles+='caserio,';cql+='INCLUDE;'}
    }else{
        if ((opener.mza_gen.getVisibility() || opener.mza.getVisibility()) && opener.mza.minScale>=escala){layers+='INEGI:manz,';styles+='mza,';cql+='INCLUDE;'}
        if ((opener.mza_gen.getVisibility() || opener.mzaet.getVisibility()) && opener.mzaet.minScale>=escala){layers+='INEGI:manz,';styles+='mzaet,';cql+='INCLUDE;'}
        if ((opener.agebsur.getVisibility() || opener.agebu_gen.getVisibility()) && opener.agebsur.minScale>=escala){layers+='INEGI:AGEBURB,';styles+='agebs,';cql+='INCLUDE;'}
        if ((opener.agebsuret.getVisibility() || opener.agebu_gen.getVisibility()) && opener.agebsuret.minScale>=escala){layers+='INEGI:AGEBURB,';styles+='agebset,';cql+='INCLUDE;'}
        if ((opener.locrurpol.getVisibility() || opener.polr_gen.getVisibility()) && opener.locrurpol.minScale>=escala){layers+='INEGI:POLIGONOS_RURALES,';styles+='porur,';cql+='INCLUDE;'}
        if ((opener.locrurpolet.getVisibility() || opener.polr_gen.getVisibility()) && opener.locrurpolet.minScale>=escala){layers+='INEGI:POLIGONOS_RURALES,';styles+='poruret,';cql+='INCLUDE;'}
        if ((opener.caserio.getVisibility() || opener.caserio_gen.getVisibility()) && opener.caserio.minScale>=escala){layers+='INEGI:caserio,';styles+='caserio,';cql+='INCLUDE;'}
    }
    /// poner el caserio y el poligono externo

    if (opener.servs.getVisibility() && opener.servs.minScale>=escala){layers+='servs,';styles+=',';cql+='INCLUDE;INCLUDE;INCLUDE;'}
    if (opener.vial.getVisibility() && opener.vial.minScale>=escala){layers+='INEGI:vialidades,';styles+='vialet,';cql+='INCLUDE;'}
    //if (opener.bd_loc.getVisibility() && opener.bd_loc.minScale>=escala){layers+='INEGI:a_bd_loc,';styles+='a_bd_loc,';cql+='INCLUDE;'}
    if (opener.predig.getVisibility() && opener.predig.minScale>=escala){layers+='INEGI'+reg+':z_digpe,INEGI'+reg+':z_digmp,INEGI'+reg+':z_digmz,';styles+='z_digpe,z_digmp,z_digmz,';cql+='INCLUDE;INCLUDE;INCLUDE;'}
    layers=layers.substring(0,(layers.length-1));
    styles=styles.substring(0,(styles.length-1));
    cql=cql.substring(0,(cql.length-1));
    var val=0;

    if (document.enviar.res[0].checked)val=1;
    if (document.enviar.res[1].checked)val=1.5;
    if (document.enviar.res[2].checked)val=2;
    if (document.enviar.res[3].checked)val=2.5;
    if (document.enviar.res[4].checked)val=3;
    if (document.enviar.res[5].checked)val=3.5;
    if (document.enviar.res[6].checked)val=4;
    var res=parseFloat(val);
    width=width*res;
    height=height*res;
    var url = 'http://'+host+'/geoserver/wms?service=WMS&version=1.1.0&request=GetMap&srs=EPSG:4326';
    url += '&bbox=' + extent;
    url += '&width=' + Math.round(width);
    url += '&height=' + Math.round(height);
    url += '&layers=' + layers;
    url += '&styles=' + styles;
    url += '&CQL_FILTER=' + cql;
    if (ban=='JPG'){
        url += '&format=image%2Fjpeg';
    }else{
        url += '&format=application%2Fpdf';
    }
      window.open(url);
      console.log(url);
}
</script>
  </head>
<body>
<form action="descarga.jsp" method="post" name="enviar">
<%

try {
        out.println ("<center><br><table border=1 cellpadding=2>"+
        "<tr class=n bgcolor=#BBBBBB align=center><th >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Descarcar imagen en "+ban+" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+
        "<tr class=n align=center><td class=n title='Reemplaza las manzanas base por las actualizadas'><input type='checkbox' name='act'>Manzanas actualizadas"+
        "<tr class=n align=center><td class=n>&nbsp;"+
        "<tr class=n align=center><td class=n align=center>Seleccionar resolucion:"+
        "<tr class=n align=center><td class=n align=left>"+
        "<input type='radio' name='res' value=1 checked>Resolucion x1 ("+w+" x "+h+") (Mapa)<br>"+
        "<input type='radio' name='res' value=1.5>Resolucion x1.5 ("+Math.round((Integer.parseInt(w)*1.5))+" x "+Math.round((Integer.parseInt(h)*1.5))+")<br>"+
        "<input type='radio' name='res' value=2>Resolucion x2 ("+Math.round((Integer.parseInt(w)*2))+" x "+Math.round((Integer.parseInt(h)*2))+")<br>"+
        "<input type='radio' name='res' value=2.5>Resolucion x2.5 ("+Math.round((Integer.parseInt(w)*2.5))+" x "+Math.round((Integer.parseInt(h)*2.5))+")<br>"+
        "<input type='radio' name='res' value=3>Resolucion x3 ("+Math.round((Integer.parseInt(w)*3))+" x "+Math.round((Integer.parseInt(h)*3))+")<br>"+
        "<input type='radio' name='res' value=3.5>Resolucion x3.5 ("+Math.round((Integer.parseInt(w)*3.5))+" x "+Math.round((Integer.parseInt(h)*3.5))+")<br>"+
        "<input type='radio' name='res' value=4>Resolucion x4 ("+Math.round((Integer.parseInt(w)*4))+" x "+Math.round((Integer.parseInt(h)*4))+")<br>");
        out.println ("<tr><td>&nbsp;<tr><td nowrap align=center><input class='boton' type='Button' name='descargar' onClick='desc();' value=' Descargar "+ban+" '></table>");
}
    catch(Exception ex){
      out.println("<script>");
      out.println("  alert(\"Se genero la expresion: "+ex.getMessage()+" !\");");
      out.println("</script>");
    }
    }else{
          out.println("</script><script>opener.cerrarSesion();window.close();</script>");
    }

%>
</form>
</body>
</html>