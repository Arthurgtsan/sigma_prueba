<!DOCTYPE html>
<html lang='en'>
<head>
 <meta charset='utf-8' />

  <meta http-equiv="Expires" content="0">
  <meta http-equiv="Last-Modified" content="0">
  <meta http-equiv="Cache-Control" content="no-cache, mustrevalidate">
  <meta http-equiv="Pragma" content="no-cache">


<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Reproducir Video</title>
<style>
  /* Estilo para el contenedor del video */
  .video-container {
    width: 800px; /* Ancho deseado */
    height: 600px; /* Altura deseada */
    margin: 0 auto; /* Centrar horizontalmente */
  }

  /* Estilo para el video */
  video {
    width: 100%;
    height: 100%;
  }
</style>
  
  
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
<script type='text/javascript' src='OpenLayers/OpenLayers.js'></script>
 <script type='text/javascript' src='subirShape/jszip.js'></script>
 <script type='text/javascript' src='subirShape/jszip-utils.js'></script>
 <script type='text/javascript' src='subirShape/proj4.js'></script>
 <script type='text/javascript' src='subirShape/preprocess.js'></script>
 <script type='text/javascript' src='subirShape/preview.js'></script>
 
 <script type='text/javascript'>

// create a file input element to allow the user to select a shapefile
//var fileInput = document.createElement("input");
//fileInput.type = "file";

//


document.write("<body><center><br><font class='t'>Subir Shapes de referencia</font><br><br>");

document.write("<table border=1 cellpadding=2 width=80%><tr class=n bgcolor=#BBBBBB align=center><th colspan=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Reglas:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
document.write("<tr class=n align=left><td>&nbsp;&nbsp;1&nbsp;&nbsp;<td>Debe ser un archivo ZIP con 4 archivos con el mismo nombre (SHP, SHX, DBF, PRJ)");
document.write("<tr class=n align=left><td>&nbsp;&nbsp;3&nbsp;&nbsp;<td>Considerar no subir una cantidad grande de elementos (se cargan con la capacidad de la PC local)");
document.write("<tr class=n align=left><td>&nbsp;&nbsp;4&nbsp;&nbsp;<td>La proyeccion debe estar en CCL (ESPG:6372)");
document.write("<tr class=n align=left><td>&nbsp;&nbsp;5&nbsp;&nbsp;<td>Se limpia la capa con el boton <img src='OpenLayers/theme/default/img/puntobor.png'</img>");
document.write("<tr class=n align=left><td>&nbsp;&nbsp;6&nbsp;&nbsp;<td>Se puede seleccionar el color y opacidad con los botones <img src='images/estilo.png'</img>");
document.write("<tr class=n align=left><td>&nbsp;&nbsp;7&nbsp;&nbsp;<td>No incluir dimension Z en la gemoetria");
document.write("<tr class=n align=left><td>&nbsp;&nbsp;8&nbsp;&nbsp;<td><a href='video.jsp' >Video</a>");
//document.write("<tr class=n align=left><td>&nbsp;&nbsp;8&nbsp;&nbsp;<td><a href='video.jsp' onclick='openPopup(\"video.jsp\")'>Video</a>");
document.write("<tr class=n align=left><td colspan=2 align=center><input type=file id=fileInput accept='.zip'>");

document.write("</table><body>");


// listen for when the user selects a shapefile
//document.fileInput.addEventListener("change", function(e) {

document.getElementById("fileInput").addEventListener("change", function() {
 uploadFile1();
});

function uploadFile1(){
  // read the shapefile using the file reader
var reader = new FileReader();
var style;
var n=0;
var tip=0;
reader.onload = function(e) {
      // parse the shapefile as GeoJSON
      var TmpPath = URL.createObjectURL(fileInput.files[0]); //lo sube como blob
              loadshp({url: TmpPath, encoding: 'utf-8',EPSG: 6372}, 
                function(geojson) {
                      //Create a format object 
                      var format_geojson = new OpenLayers.Format.GeoJSON({});
                      //Create an array of strategy objects
                      var vector_strategies = [new OpenLayers.Strategy.Fixed()];
                      //Create a vector layer that contains a Format, Protocol, and Strategy class
                      var vector_layer = new OpenLayers.Layer.Vector('More Advanced Vector Layer',{
                      strategies: vector_strategies
                      });

                      //Load in the data
                      vector_layer.addFeatures(format_geojson.read(geojson)); //Aqui se castea el objeto como geojson
                      //console.log(vector_layer);

            frompro = new OpenLayers.Projection('EPSG:4326');
            torpro =new OpenLayers.Projection('EPSG:3857');
            vector_layer.features.forEach(function(feature)
                {
                if (n==0){
                  //console.log(feature.geometry.CLASS_NAME);
                    switch (feature.geometry.CLASS_NAME){
                      case "OpenLayers.Geometry.Point":       tip=1;break;
                      case "OpenLayers.Geometry.LineString":  tip=2;break;
                      case "OpenLayers.Geometry.Polygon":     tip=3;break;
                    }
                  n=1;
                }
                  feature.geometry.transform(frompro,torpro);
                }
              );


              if (opener.document.getElementById('colorin').value=='ffffff'){
                  tip=0;
              }else{
                  color1=opener.document.getElementById('colorin').value;
              }
              //alert (tip);
              switch (tip){
              case 1:
                    style = {
                        pointRadius: 4,
                        fillColor: '#'+color1,
                        fillOpacity: opener.document.getElementById('opac').value,
                        strokeColor: '#'+color1,
                        strokeWidth: 1,
                        graphicName: "circle"
                    };
                    break;
              case 2:
                    style = {
                        strokeColor: '#'+color1,
                        strokeOpacity: 1,
                        strokeWidth: 1,
                    };
                    break;
              case 3:
                    style = {
                        strokeColor: '#'+color1,
                        strokeOpacity: 1,
                        strokeWidth: 1,
                        fillColor: '#'+color1,
                        fillOpacity: opener.document.getElementById('opac').value,
                        label: "${TEXTO}"+"${texto}",
                        fontColor: "#000000",
                        fontOpacity: .7,
                        fontSize: 10,
                        fontFamily: "Arial",
                        fontWeight: "bold"
                    };
                  break;
              }

    var styleMap = new OpenLayers.StyleMap({"default": style});


                opener.puntogen.style=style;
                //opener.puntogen.styleMap=styleMap;

                console.log(opener.puntogen);

                opener.puntogen.addFeatures(vector_layer.features);

                var bounds = opener.puntogen.getDataExtent();
                opener.map.zoomToExtent(bounds);
                opener.alertmsg (" Datos cargados ");
                //window.close();
              }); //load shp
            }; //on load
                      reader.readAsText(fileInput.files[0]);
      }


window.resizeTo(500,470);

</script>
</head>
</html>