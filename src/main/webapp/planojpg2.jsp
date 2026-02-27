<%@ page import="java.util.*" %>
<%@ page import="java.sql.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>
Mapa del Marco Geoestadistico Nacional
</title>
<style type="text/css">


<%
Float lat = Float.parseFloat(request.getParameter("lat")),
      lon = Float.parseFloat(request.getParameter("lon"));
int  n = 0,car=0,ent=0,mun=0,locu=0,locr=0,ageb=0,upm=0,tipo=0,loc=0,manz=0,serv=0,vial=0;
String   bounds = request.getParameter("bounds"),
         consulta = "";

%>
table {
  border-collapse: collapse;
}
.t{font-size: 12pt; font-family: Arial; font-weight: bold; color: #000000;}
.c{font-family: Arial; font-size: 8pt; line-height: 1.3; font-weight: normal;}
.n{font-family: Arial; font-size: 8pt; line-height: 1.3; font-weight: bold;}
.boton{font-family: Arial; font-size: 10px; line-height: 1; font-weight: normal;}
    body {
        /* height: 1275px; */
        width: 1650px;
        /* to centre page on screen*/
       /* margin-left: auto;
        margin-right: auto;*/
    }
  
   /* The map and the location bar */
            #map {
                    width: 1560px;
                    height: 1170px;
                /*
                clear: both;
                position: relative;
                border: 1px solid black;*/
            }



#qrcode {background: #EFEFEF;position: fixed;top: 24px;left: 24px;border: 1px solid #888888;z-index:900;-webkit-animation: fadeIn 1s; animation: fadeIn 1s;}


</style>
  </head>
  <script src="OpenLayers/OpenLayers.js"></script>
  <script src="qrcode.min.js"></script>

  <!--<script src="proj4js.js"></script>
  <script src="EPS32800.js"></script>
  <script src="funciones_especiales.js"></script>
  <script src="todo.js"></script>
  <script src="jsts-master/lib/javascript.util.js"></script>
  <script src="jsts-master/lib/jsts.js"></script>"-->
  <script>
  function init(){
    var reg = opener.idreggeo;

     OpenLayers.ProxyHost = '/openlayers/cgi-bin/proxy.cgi?url=';
   var bounds = new OpenLayers.Bounds(<% out.print(bounds); %>);
 var options = {
            controls: [],
            //restrictedExtent:bounds,
            maxResolution: 4891.969809375,    //mercator
            projection: "EPSG:3857",   //mercator
            displayProjection: new OpenLayers.Projection("EPSG:4326"),
            numZoomLevels: 17,
            units: 'm'
        };
        map = new OpenLayers.Map('map', options);
        map.addControl(new OpenLayers.Control.Navigation());
        //map.addControl(new OpenLayers.Control.MousePosition());
        //map.addControl(new OpenLayers.Control.PanZoomBar());
        //map.addControl(new OpenLayers.Control.LayerSwitcher());


   var layers='';var layers2='';
   var styles='';var styles2='';
   var cql='';var cql2='';

    layers+='INEGI:MUNICIPIOS,';styles+='municipios,';cql+='INCLUDE;';
    layers+='INEGI:MUNICIPIOS,';styles+='municipioset_sig,';cql+='INCLUDE;';
    layers+='INEGI:AGEB,';styles+='agebs,';cql+='INCLUDE;';
    layers+='INEGI:AGEB,';styles+='agebset,';cql+='INCLUDE;';
    //layers+='INEGI:POLIGONOS_URBANOS,';styles+='urbanas,';cql+='INCLUDE;';
    //layers+='INEGI:POLIGONOS_URBANOS,';styles+='urbanaset,';cql+='INCLUDE;';
    //layers+='INEGI:POL_RUR_EXT,INEGI:POLIGONOS_RURALES,';styles+='pol_rur_ext,porur,';cql+='INCLUDE;';
    //layers+='INEGI:POLIGONOS_RURALES,';styles+='poruret,';cql+='INCLUDE;';
    layers+='INEGI:POL_RUR_EXT,';styles+='pol_rur_ext,';cql+='INCLUDE;';
    layers+='INEGI:locs_puntuales_v,';styles+='locsrur1,';cql+='INCLUDE;';
    layers+='INEGI:locs_puntuales_v,';styles+='locsruret1,';cql+='INCLUDE;';
    // actualizado
    layers+='INEGI:manz,';styles+='mza,';cql+='INCLUDE;';
    layers+='INEGI:AGEBURB,';styles+='agebs,';cql+='INCLUDE;';
    layers+='INEGI:AGEBURB,';styles+='agebset,';cql+='INCLUDE;';
    layers+='INEGI:POLIGONOS_RURALES,';styles+='porur,';cql+='INCLUDE;';
    layers+='INEGI:POLIGONOS_RURALES,';styles+='poruret,';cql+='INCLUDE;';
    layers2+='INEGI:servarea,INEGI:servpun,INEGI:servlin,';styles2+='servarea,servpun,servlin,';cql2+='INCLUDE;INCLUDE;INCLUDE;';
    layers2+='INEGI:vialidades,';styles2+='vialet,';cql2+='INCLUDE;';
    layers+='INEGI'+reg+':z_digmp,';styles+='z_digmp_AB,';cql+='INCLUDE;';
    layers+='INEGI'+reg+':z_digmz,';styles+='z_digmz_AB,';cql+="cve_baja<>'BCUU';";
    layers+='INEGI'+reg+':z_digpe,';styles+='z_digpe,';cql+='INCLUDE;';
    layers+='INEGI:CARTAS,';styles+='cartas,';cql+='INCLUDE;';
    layers=layers.substring(0,(layers.length-1));
    styles=styles.substring(0,(styles.length-1));
    cql=cql.substring(0,(cql.length-1));
    layers2=layers2.substring(0,(layers2.length-1));
    styles2=styles2.substring(0,(styles2.length-1));
    cql2=cql2.substring(0,(cql2.length-1));

var capas = new OpenLayers.Layer.WMS( "CAPAS1",
           "http://"+opener.hostnew+"/geoserver/wms", {
                layers: layers,
                STYLES: styles,
                CQL_FILTER: cql,
                transparent: true
            },{
                visibility: true,
                singleTile: true});

var capaszoom = new OpenLayers.Layer.WMS( "CAPAS2",
           "http://"+opener.hostnew+"/geoserver/wms", {
                layers: layers2,
                STYLES: styles2,
                CQL_FILTER: cql2,
                transparent: true
            },{
                visibility: true,
                singleTile: true,
                maxScale: 0,
                minScale: 100000});


var matrixIds = new Array(21);
    for (var i=0; i<21; ++i) {
        matrixIds[i] = "EPSG:3857:" + (i+5);
    }
/*
var diglob = new OpenLayers.Layer.WMTS({name: "4-DIG. GLOBE",
url: "https://securewatch.maxar.com/earthservice/wmtsaccess?connectid=d00cf4ef-159e-4abe-bc7b-816599f09238&",
        layer: "DigitalGlobe:ImageryTileService",matrixSet: "EPSG:3857",matrixIds: matrixIds,
        format: "image/png",style: "_null",isBaseLayer: true});
diglob.opacity=opener.diglob.opacity;
*/
esri = new OpenLayers.Layer.ArcGIS93Rest("6-ESRI","http://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/export?f=image",{sphericalMercator: true} );
orto = new OpenLayers.Layer.WMS( "1-ORTOFOTOS","http://gaiamapas1.inegi.org.mx/mdmCache/service/wms?format=image/jpeg", {layers: 'MapaBaseOrtofoto',transparent: true},{isBaseLayer:true,displayInLayerSwitcher: true} );
//geoeye1 son las del 2016 para atraz y el geoeye2 son las supuetas 2017

geoeye1 = new OpenLayers.Layer.WMS("9-GEOEYE","http://10.152.11.51:6080/arcgis/services/alta_res/cpc/ImageServer/WMSServer?srs=EPSG:3857", {layers: 'cpc',transparent: true},{isBaseLayer:true,displayInLayerSwitcher: true} );
geoeye2 = new OpenLayers.Layer.WMS("10-GEOEYE","http://10.152.11.51:6080/arcgis/services/alta_res/ortorec_bcuu/MapServer/WMSServer?srs=EPSG:3857", {layers: 'Imagen',transparent: true},{isBaseLayer:true,displayInLayerSwitcher: true} );

fondovacio = new OpenLayers.Layer.OSM("0-VACIO","images/blank.png",{numZoomLevels:17,minZoomLevel:5,maxZoomLevel:21,maxResolution: 4891.969809375});
fondo = new OpenLayers.Layer.WMS("0-VACIO","http://gaiamapas3.inegi.org.mx/mdmCache/service/wms?format=image/jpeg",{layers: 'MapaBaseTopograficov61_sinsombreado',transparent: true},{isBaseLayer:true,displayInLayerSwitcher: true, opacity: 0.3} );

spot6 = new OpenLayers.Layer.WMS("3-SPOT-6","http://10.152.11.51:6080/arcgis/services/spot/spot6_2014_2015_wm/ImageServer/WMSServer?srs=EPSG:3857", {layers: '0',transparent: true},{isBaseLayer:true,displayInLayerSwitcher: true} );


 var gooimg = new OpenLayers.Layer.XYZ("5-GOOGLE",["https://mt0.google.com/vt/lyrs=s&w=256&h=256&hl=en&style=40,18&x=${x}&y=${y}&z=${z}"],
        {
            zoomOffset: 5,
            visibility: true,
            isBaseLayer : true
        });



var projectionExtentMosDG = [-13038511.776818, 1674751.145936, -8709231.955807999, 3839391.0564410007];//projectionMosDG.getExtent();
var size = 8455.624650410158;//ol.extent.getWidth(projectionExtentMosDG) / 256;
var resolutionsMosDG = new Array(21);


var getleft=new OpenLayers.LonLat(-13038511.776818,3839391.0564410007);

var matrixIdsMosDG = new Array(21);
//var projectionMosDG=OpenLayers.Projection('EPSG:3857');
   for (var z = 0; z < 21; ++z) {
                resolutionsMosDG[z] = size / Math.pow(2, z);
                matrixIdsMosDG[z] = "EPSG:900913:" + (z);
            }

diglob2 = new OpenLayers.Layer.WMTS({name: "13-DIG. GLOBE2",
        url: "https://ce2024.inegi.org.mx/mdmCacheSatCE24/service/wmts",
        layer: "Mapa%20imagenes%20CE2024",matrixSet: "EPSG:900913",matrixIds: matrixIdsMosDG,
        zoomOffset: 5,
        format: "image/jpeg",style: "_null",isBaseLayer: true});




/*
var fo;
switch (opener.baseimg){
case '':
    fo=fondovacio;
    fo.opacity=opener.fondo.opacity;
    break;
case 'OR':
    fo=orto;
    fo.opacity=opener.orto.opacity;
    break;
case 'S5':
    fo=spot6;
    fo.opacity=opener.spot5.opacity;
    break;
case 'S6':
    fo=spot6;
    fo.opacity=opener.spot6.opacity;
    break;
case 'DG':
    fo=diglob;
    fo.opacity=opener.diglob.opacity;
    break;
case 'D2':
    fo=diglob2;
    fo.opacity=opener.diglob2.opacity;
    break;
case 'GO':
case 'BI':
    //fo=gooimg;
    //gooimg.setOpacity(opener.gooimg.opacity);
    fo=esri;
    fo.opacity=opener.gooimg.opacity;
    break;
case 'ES':
    fo=esri;
    fo.opacity=opener.esri.opacity;
    break;
case 'G1':
    fo=geoeye1;
    fo.opacity=opener.geoeye1.opacity;
    break;
case 'G2':
    fo=geoeye2;
    fo.opacity=opener.geoeye2.opacity;
    break;
}
*/
var fo;
switch (opener.baseimg){
case '':
    fo=fondovacio;
    fo.opacity=opener.fondo.opacity;
    break;
default:
    fo=diglob2;
    fo.opacity=opener.diglob2.opacity;
    break;
}

   map.addLayers([fo,capas,capaszoom]);
   //map.addLayers([diglob,capas]);
   map.zoomToExtent(bounds);
   //console.log(map);
  }




  </script>
<body onload="init()">
<%

try {
//out.print("<table border=1 align=center width=1650px height=1175px>");
out.print("<table border=0>");
out.print("<tr><td align=center><div id='map'></div></img>");



      String s1="",s2="",s3="",s4="",s5="",s6="",s7="",s8="",s9="",s10="",s11="";
      Statement str = null;
      ResultSet rs = null;
      Connection conexion = null;
      Class.forName("org.postgresql.Driver");
             conexion = DriverManager.getConnection(
                                             "jdbc:postgresql://10.153.3.25:5434/actcargeo10",
                                             "actcar",
                                             "actcar"
                                            );

      str = conexion.createStatement(rs.TYPE_SCROLL_SENSITIVE, rs.CONCUR_UPDATABLE);
      consulta = "select cve_ent,nom_ent from cat_ent where st_intersects(the_geom,st_transform(ST_SetSRID(st_point("+lon+","+lat+"),3857),32800))";
      rs = str.executeQuery( consulta );
      while(rs.next()){
            s3=rs.getObject(1).toString();
            s4=rs.getObject(2).toString();
      }
      consulta = "select cve_mun,nom_mun from cat_mun where st_intersects(the_geom,st_transform(ST_SetSRID(st_point("+lon+","+lat+"),3857),32800))";
      rs = str.executeQuery( consulta );
      while(rs.next()){
            s5=rs.getObject(1).toString();
            s6=rs.getObject(2).toString();
      }
      consulta = "select substring(clave,6,9)||' - R',nom_loc from cat_loc where st_intersects(the_geom_pr,st_transform(ST_SetSRID(st_point("+lon+","+lat+"),3857),32800))";
     rs = str.executeQuery( consulta );
     n=0;
      while(rs.next()){
            s7=rs.getObject(1).toString();
            s8=rs.getObject(2).toString();
            n=1;
      }
      if (n==0){
            consulta = "select substring(clave,6,9)||' - U',nom_loc from cat_loc where st_intersects(the_geom_pu,st_transform(ST_SetSRID(st_point("+lon+","+lat+"),3857),32800))";
          rs = str.executeQuery( consulta );
          while(rs.next()){
                s7=rs.getObject(1).toString();
                s8=rs.getObject(2).toString();
          }
      }
      consulta = "select cve_ageb from cat_ageb where st_intersects(the_geom,st_transform(ST_SetSRID(st_point("+lon+","+lat+"),3857),32800))";
      rs = str.executeQuery( consulta );
      n=0;
      while(rs.next()){
            s9=rs.getObject(1).toString();
            n=1;
      }
      if (n==0){
          consulta = "select cve_ageb from cat_agebu where st_intersects(the_geom,st_transform(ST_SetSRID(st_point("+lon+","+lat+"),3857),32800))";
          rs = str.executeQuery( consulta );
          while(rs.next()){
                s9=rs.getObject(1).toString();
          }
      }

      rs.close();
      str.close();
      conexion.close();
      out.print("<tr class=c>");

out.print("<td align=center>Entidad:");      out.print(" "+s3+" - "+s4);
out.print(" :: Municipio:");      out.print(" "+s5+" - "+s6);
out.print(" :: Localidad:");      out.print(" "+s7+" - "+s8);
out.print(" :: Ageb ");
if (n==1){
  out.print("Rural");
}else{
  out.print("Urbana");
}
out.print(":");      out.print(" "+s9+"<br>&nbsp;");
}
    catch (SQLException ex){
      out.println("<script>");
      out.println("  alert(\'Se genero la expresion de SQL: "+ex.getMessage()+" !\');");
      out.println("</script>");
    }

    catch(Exception ex){
      out.println("<script>");
      out.println("  alert(\'Se genero la expresion: "+ex.getMessage()+" !\');");
      out.println("</script>");
    }


%>
</table>
<div id='qrcode'></div><tr>
</body>
<script>
    var center = opener.map.getCenter().transform("EPSG:900913", "EPSG:4326");
    var zoom= (opener.map.getZoom()+4)
    const url = "https://www.google.com.mx/maps/@"+center.lat+","+center.lon+","+zoom+"z"

 // Crear un nuevo código QR
 const qr = new QRCode(document.getElementById('qrcode'), {
 text: url,
 width: 120,
 height: 120,
 colorDark : "#000000",
 colorLight : "#ffffff",
 correctLevel : QRCode.CorrectLevel.H
 });
</script>
</html>
