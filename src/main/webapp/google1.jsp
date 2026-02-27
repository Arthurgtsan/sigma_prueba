<%@ page import="java.util.*" %>
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
.c{font-family: Arial; font-size: 10pt; line-height: 1.3; font-weight: normal;}
.n{font-family: Arial; font-size: 10pt; line-height: 1.3; font-weight: bold;}
.boton{font-family: Arial; font-size: 10px; line-height: 1; font-weight: normal;}

</style>
<%
String w = request.getParameter("w");
String h = request.getParameter("h");
%>
<script language="javascrpt" type="text/javascript">
    window.resizeTo(400,300);


function desc(){
    var co = opener.map.getExtent().transform(opener.map.projection, opener.map.displayProjection);
    var escala = opener.map.getScale();
    co = co.toString();
    var coord = co.split(",");
    var w ='<% out.print(w); %>';
    var h ='<% out.print(h); %>';
    var layers = '';
    var styles = '';
    var cql = '';
    var filtermz = "ban<>'3' and ban<>'1' and ban<>'5' and ban<>'6' and ban<>'Y' and ban<>'E' and ban<>'D' and ban<>'H' and ban<>'G' and ban<>'I' and ban<>'M' and ban<>'N' and ban<>'O' and ban<>'K' and ban<>'R' and ban<>'T' and ban<>'C' and ban<>'X';";
    var filterau = "ban<>'3' and ban<>'4';";
    var filterpr = "ban<>'3';";
    if (opener.cartas.getVisibility() && opener.cartas.minScale>=escala){layers+='INEGI:CARTAS,';styles+='cartas,';cql+='INCLUDE;'}
    if (opener.estados.getVisibility() && opener.estados.minScale>=escala){layers+='INEGI:ESTADOS,';styles+='estados,';cql+='INCLUDE;'}
    if (opener.municipios.getVisibility() && opener.municipios.minScale>=escala){layers+='INEGI:MUNICIPIOS,';styles+='municipios,';cql+='INCLUDE;'}
    if (opener.agebs.getVisibility() && opener.agebs.minScale>=escala){layers+='INEGI:AGEB,';styles+='agebs,';cql+='INCLUDE;'}
    if (opener.locurb.getVisibility() && opener.locurb.minScale>=escala){layers+='INEGI:POLIGONOS_URBANOS,';styles+='urbanas,';cql+='INCLUDE;'}
    if (opener.locrurpol_ext.getVisibility() && opener.locrurpol_ext.minScale>=escala){layers+='INEGI:POL_RUR_EXT,';styles+='pol_rur_ext,';cql+='INCLUDE;'}
    if (opener.asen.getVisibility() && opener.asen.minScale>=escala){layers+=opener.shp_asen_ss+',';styles+='asen1,';cql+='INCLUDE;'}
    if (document.google.act.checked){
        if ((opener.mza_gen.getVisibility() || opener.mza.getVisibility()) && opener.mza.minScale>=escala){layers+='INEGI'+opener.idreggeo+':cat_manz,';styles+='mza,';cql+=filtermz;}
        if ((opener.agebsur.getVisibility() || opener.agebu_gen.getVisibility()) && opener.agebsur.minScale>=escala){layers+='INEGI'+opener.idreggeo+':edit_agebu,';styles+='agebs,';cql+='INCLUDE;'}
        if ((opener.locrurpol.getVisibility() || opener.polr_gen.getVisibility()) && opener.locrurpol.minScale>=escala){layers+='INEGI'+opener.idreggeo+':edit_locr,';styles+='porur,';cql+='INCLUDE;'}
    }else{
        if ((opener.mza_gen.getVisibility() || opener.mza.getVisibility()) && opener.mza.minScale>=escala){layers+='INEGI:manz,';styles+='mza,';cql+='INCLUDE;'}
        if ((opener.agebsur.getVisibility() || opener.agebu_gen.getVisibility()) && opener.agebsur.minScale>=escala){layers+='INEGI:AGEBURB,';styles+='agebs,';cql+='INCLUDE;'}
        if ((opener.locrurpol.getVisibility() || opener.polr_gen.getVisibility()) && opener.locrurpol.minScale>=escala){layers+='INEGI:POLIGONOS_RURALES,';styles+='porur,';cql+='INCLUDE;'}
    }
    if (opener.locrur0.getVisibility() && opener.locrur1.getVisibility() && escala<=opener.locrur0.minScale){layers+='INEGI:locs_puntuales_b,';styles+='locsrurgoogle2,';cql+='INCLUDE;';
    }else{
       if (opener.locrur0.getVisibility() && escala<=opener.locrur0.minScale){layers+='INEGI:locs_puntuales_b,';styles+='locsrurgoogle0,';cql+='INCLUDE;'}
       if (opener.locrur1.getVisibility() && escala<=opener.locrur1.minScale){layers+='INEGI:locs_puntuales_v,';styles+='locsrurgoogle1,';cql+='INCLUDE;'}
    }
    if (opener.bd_loc.getVisibility() && escala<=opener.bd_loc.minScale){layers+='INEGI:a_bd_loc,';styles+='a_bd_loc,';cql+='INCLUDE;'}
    layers=layers.substring(0,(layers.length-1));
    styles=styles.substring(0,(styles.length-1));
    cql=cql.substring(0,(cql.length-1));

    document.google.c1.value=coord[0];
    document.google.c2.value=coord[1];
    document.google.c3.value=coord[2];
    document.google.c4.value=coord[3];
    document.google.width.value=w;
    document.google.height.value=h;
    document.google.layers.value=layers;
    document.google.styles.value=styles;
    document.google.cql.value=cql;
    document.google.submit();


}
</script>
  </head>
<body>
<%
out.println("<Form action='google2.jsp' method='post' name='google'>" +
        "<center class='t'>Ver En Google Earth<br><br><table border=0>" +
        "<tr class=n align=center><td class=n title='Reemplaza las manzanas base por las actualizadas'><input type='checkbox' name='act'>Manzanas actualizadas"+
        "<tr class=n align=center><td class=n>&nbsp;"+
        "<tr class=c><td><input type='radio' name='esc' value='0' checked> - Vista sin informacion</td>");
    out.println("<tr class=c><td><input type='radio' name='esc' value='1'> - Con informacion de la vista</td>");
out.println("</table>" +
        "<br><input type='Button' name='descargar' onClick='desc();' class='boton' value='Ir a Google Earth'>" +
        "<input type='hidden' name='c1' value=''>" +
        "<input type='hidden' name='c2' value=''>" +
        "<input type='hidden' name='c3' value=''>" +
        "<input type='hidden' name='c4' value=''>" +
        "<input type='hidden' name='width' value=''>" +
        "<input type='hidden' name='height' value=''>" +
        "<input type='hidden' name='layers' value=''>" +
        "<input type='hidden' name='styles' value=''>" +
        "<input type='hidden' name='cql' value=''>" +
        "</center></form></body></html>");
%>
</body>

</html>