<%@ page import="java.util.*" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.DecimalFormat"%>
<%

String fecha="";
fecha = request.getParameter("fecha");


%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>OpenLayers map preview</title>
        <!-- Import OL CSS, auto import does not work with our minified OL.js build -->
        <link rel="stylesheet" type="text/css" href="http://dc046068asdggma.inegi.gob.mx:8070/geoserver/openlayers/theme/default/style.css"/>
        <!-- Basic CSS definitions -->
		<link rel="stylesheet" href="http://dc046068asdggma.inegi.gob.mx:8888/sismos/menu.css" type="text/css">
        <style type="text/css">
            /* General settings */
            body {
                font-family: Verdana, Geneva, Arial, Helvetica, sans-serif;
                font-size: small;
            }
            /* Toolbar styles */
            #toolbar {
                position: relative;
                padding-bottom: 0.5em;
                display: none;
            }
            
            #toolbar ul {
                list-style: none;
                padding: 0;
                margin: 0;
            }
            
            #toolbar ul li {
                float: left;
                padding-right: 1em;
                padding-bottom: 0.5em;
            }
            
            #toolbar ul li a {
                font-weight: bold;
                font-size: smaller;
                vertical-align: middle;
                color: black;
                text-decoration: none;
            }

            #toolbar ul li a:hover {
                text-decoration: underline;
            }
            
            #toolbar ul li * {
                vertical-align: middle;
            }

            /* The map and the location bar */
            #map {
                clear: both;
                position: relative;
                width: 800px;
                height: 600px;
                border: 1px solid black;
            }
            
            #wrapper {
                width: 500;
            }
            
            #location {
                float: right;
				font-family: Arial;  text-align: center; font-size: 9pt; line-height: 1.3; 
            }
			
			       #scale {
                float: left;
				font-family: Arial;  text-align: center; font-size: 9pt; line-height: 1.3; 
            }
            
            #options {
                position: absolute;
                left: 13px;
                top: 7px;
                z-index: 3000;
            }
			
		.nr{
			font-family: Arial;  text-align: center; font-size: 9pt; line-height: 1.3;color: #ff0000; }
       
        </style>
        <!-- Import OpenLayers, reduced, wms read only version -->
        <script src="http://dc046068asdggma.inegi.gob.mx:8070/geoserver/openlayers/OpenLayers.js" type="text/javascript">
        </script>
        <script defer="defer" type="text/javascript">

		window.resizeTo(900,800);
            var map;
            var untiled;
            var tiled;
            var pureCoverage = false;
            function init(){
                // if this is just a coverage or a group of them, disable a few items,
                // and default to jpeg format

var bounds = new OpenLayers.Bounds(
        //661900.256,238231.923,
        //4317111.930,2444146.841
        //-120.80,13.56,
        //-84.15,33.23
        //-14122073,1332364,-8281061,4199058
        -13459673.0276619,1232095.46159631,-9281930.46183394,4109451.87806631
                );



        var options = {
            controls: [],
            maxExtent: bounds,
            maxResolution: 4891.969809375,    //mercator
            restrictedExtent:bounds,
          //maxResolution: .036,   //4326
          //projection: "EPSG:4326",
            projection: "EPSG:900913",   //mercator
            displayProjection: new OpenLayers.Projection("EPSG:4326"),
            numZoomLevels: 17,
            units: 'm'
            //,allOverlays: true
        };

                map = new OpenLayers.Map('map', options);
                // setup tiled layer
                tiled = new OpenLayers.Layer.WMS.Untiled(
                    "INEGI:sismos - Tiled", "http://dc046068asdggma.inegi.gob.mx:8070/geoserver/INEGI/wms",
                    {
                        "STYLES": 'rep_estados,rep_municipios,rep_pol1,rep_pol2,rep_pol3,rep_pol4',
                        //"STYLES": 'rep_estados,rep_urbanas,rep_porur,rep_pol1,rep_pol2,rep_pol3',
                        "LAYERS": 'INEGI:ESTADOS,INEGI:MUNICIPIOS,INEGI:manz,INEGI:mz_avance,INEGI:mz_predig_sin_act,INEGI:rep_mccno',
                        //"LAYERS": 'INEGI:ESTADOS,INEGI:POLIGONOS_URBANOS,INEGI:POLIGONOS_RURALES,INEGI:manz,INEGI:mz_avance,INEGI:mz_predig_sin_act',
                        "CQL_FILTER": "INCLUDE;INCLUDE;INCLUDE;INCLUDE;INCLUDE;INCLUDE",
						//"CQL_FILTER": "INCLUDE;INCLUDE;INCLUDE;INCLUDE;fact<='<% out.print (fecha); %>';fact<='<% out.print (fecha); %>;'",
                        format: "image/png"
                    },
                    {
                        buffer: 0,
                        displayOutsideMaxExtent: true,
                        isBaseLayer: true,
                        yx : {'EPSG:4326' : true}
                    } 
                );
                map.addLayers([tiled]);

                // build up all controls
                map.addControl(new OpenLayers.Control.Navigation());
                map.addControl(new OpenLayers.Control.Scale($('scale')));
                //map.addControl(new OpenLayers.Control.MousePosition({element: $('location')}));
                map.zoomToExtent(bounds);
                // wire up the option button
                var options = document.getElementById("options");


            }
        </script>
    </head>
    <body onload="init()">
		<center class=n2><?PHP echo $nombre; ?></center><br>
        <center><table><tr><td><div id="map">
        </div><tr><td>
        <div id="wrapper">
            <!--<div id="location">location</div>-->
            <div id="scale">
            </div>
        </div>
		</center>
<br><center>
<font class="n"><A HREF="javascript:window.close()">Cerrar...</a></font>
</center></body>
</html>
