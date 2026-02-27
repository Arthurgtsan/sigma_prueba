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
window.resizeTo(500,500);
var loc = document.location.href;
var num=0;
     if(/num/.test(location.search)){
        num=1;
     }
if (num==0){
	document.write('<meta http-equiv="refresh" content="0; url='+loc+'?num">');
}
document.write("<body><center><br><table border=1 cellpadding=2>");
document.write("<tr class=n bgcolor=#BBBBBB align=center><th colspan=5>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Informacion de proveedores de imagenes vectoriales&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
document.write("<tr class=n bgcolor=#DDDDDD align=center><td>HOST<td>REGIONAL<td>USUARIO<td>STATUS<td>W-WEB");
for (var n=0;n<opener.arrhost.length;n++){
	document.write("<tr class=c align=center>");
	document.write("<td class=n align=left>"+opener.arrhost[n].toUpperCase().substring(0,3));
    switch (opener.arrhost[n].toUpperCase()){
    case "GEOGAT045732D": document.write("<td>REG 01");break;    // anterior GEOIGB042180D
    case "GEOGAT046166D": document.write("<td>REG 02");break;    //anterior GEOGAT045737D
    case "GEOGAT046025D": document.write("<td>REG 03");break;    // anterior  geoigb042167d
    case "GEOGAT046078D": document.write("<td>REG 04");break;    // ANTERIOR GEOIGB042485D
    case "GEOGAT046050D": document.write("<td>REG 05");break;    //anterior GEOIGB042534D
    case "GEOGAT045677D": document.write("<td>REG 06");break;
    case "GEOGAT045713D": document.write("<td>REG 07-10");break;
    case "GEOGAT046028D": document.write("<td>REG 08");break;    //anterior GEOIGB042483D
    case "GEOGAT045744D": document.write("<td>REG 09");break;    //ANTERIOR GEOIGB042526D
    default: document.write("<td>NACIONAL");

  }
	document.write("<td class=n align=left>"+opener.arrserv[n].toUpperCase());
  if (opener.arrserv[n].toUpperCase()=='NEATIL.CEBALLOS'){
      document.write("<td class=n align=center><img src='http://"+opener.arrhost[n]+":8070/basedatos.png?v="+opener.verjs+"' height='20px'></img>");
  }else{
      document.write("<td class=n align=center><img src='http://"+opener.arrhost[n]+".inegi.gob.mx:8070/geoserver/web/wicket/resource/org.geoserver.web.GeoServerBasePage/favicon-ver-CD7C91844A87FE589C62DFE238A2ACA7.ico?v="+opener.verjs+"' onerror=\"this.src='http://"+opener.localhost+".inegi.gob.mx:8070/error.jpg';\" height='20px'></img>");
  }
      document.write("<td>"+opener.arrservw[n]);

}
document.write("</body>");
</script>
</head>
</html>