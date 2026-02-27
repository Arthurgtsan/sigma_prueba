
/////para pa predigitalizacion 
function saveSuccessPredig(tipo){
    alertmsg("Cambios guardados correctamente");
    /*var ajax=nuevoAjax();
    ajax.open("GET",'valida_predig.jsp?id='+iduser+'&filterid='+filterid, true);
    ajax.onreadystatechange=function()
    {
        if(ajax.readyState==4)  {
             var vale=ajax.responseText;
            if (parseInt(vale)==1){
                alertmsg ("No se pudo validar la Digitalizacion");
            }else{
                    wfs.refresh({force: true});
                    wfs.redraw(true);
                    if (predig.getVisibility()){predig.redraw(true);}
            }
        }
    }
    ajax.send(null);
    */
     wfs.refresh({force: true});wfs_punto.refresh({force: true});wfs_pe.refresh({force: true});
     wfs.redraw(true);wfs_punto.redraw(true);wfs_pe.redraw(true);
     if (predig.getVisibility()){predig.redraw(true);}
}

function saveFailPredig(tipo){
    alertmsg ("Error, la sesion de edicion no se pudo guardar!!");
}

//FUNCION QUE BUSCA DESDE LA TABLA DE EQUIVALENCIA DE  LAS MANZANAS// ****************************************************************************************************************
function buscazoompredig(val,geom){
var geometry = OpenLayers.Geometry.fromWKT(geom);
var feature = new OpenLayers.Feature.Vector(geometry, {});
 s0=geometry.getCentroid().x-500;    //ccl , merctor
 s1=geometry.getCentroid().y-500;
 s2=geometry.getCentroid().x+500;
 s3=geometry.getCentroid().y+500;
bounds = new OpenLayers.Bounds(s0,s1,s2,s3);
map.zoomToExtent(bounds);
map.zoomTo(10);
map.controls[0].redraw;
            veravancepredig.activate();
            avdig=1;
            cartas5.setVisibility(true);
            cartas5rep.setVisibility(true);
}


function flashFeatures(features, index) {
                if(!index) {
                    index = 0;
                }
                var current = features[index];
                if(current && current.layer === wfs) {
                    wfs.drawFeature(features[index], "select");
                }
                var prev = features[index-1];
                if(prev && prev.layer === wfs) {
                    wfs.drawFeature(prev, "default");
                }
                ++index;
                if(index <= features.length) {
                    window.setTimeout(function() {flashFeatures(features, index)}, 100);
                }
            }


//esta es para las pre-digitalizaciones
var DeleteFeatureDig = OpenLayers.Class(OpenLayers.Control, {
    initialize: function(layer, options) {
        OpenLayers.Control.prototype.initialize.apply(this, [options]);
        this.layer = layer;
        this.handler = new OpenLayers.Handler.Feature(
            this, layer, {click: this.clickFeature}
        );
    },
    clickFeature: function(feature) {
        // if feature doesn't have a fid, destroy it
        if(feature.fid == undefined) {
            this.layer.destroyFeatures([feature]);
        } else {
            feature.state = OpenLayers.State.DELETE;
            this.layer.events.triggerEvent("afterfeaturemodified",
                                           {feature: feature});
            feature.renderIntent = "select";
            this.layer.drawFeature(feature);
        }
    },
    setMap: function(map) {
        this.handler.setMap(map);
        OpenLayers.Control.prototype.setMap.apply(this, arguments);
    },
    CLASS_NAME: "OpenLayers.Control.DeleteFeature"
});


function fusionapre() {
    var sal=0;
if (wfs.selectedFeatures.length==0){
    alertmsg ("Debe seleccionar una manzana sobrepuesta");
    return false;
}else{
        var feature = wfs.getFeatureBy('id', wfs.selectedFeatures[0].id);
        var jsts_parser = new jsts.io.OpenLayersParser();
        var jsts_geomA  = jsts_parser.read(feature.geometry);
        //deselecciono la manzana
        if(modify.active) {
            modify.selectControl.unselectAll();
        }else if(modify2.active) {
            modify2.selectControl.unselectAll();
        }
        var intersects12,ban,i,t;
        if (feature.state!=OpenLayers.State.DELETE){
           for(var j=0; j<wfs.features.length; j++) {
                if (sal==1){
                    return false;
                }
                if (wfs.features[j].state!=OpenLayers.State.DELETE && wfs.features[j].fid!=feature.fid){
                    var jsts_geomB  = jsts_parser.read(wfs.features[j].geometry);
                    intersects12 = feature.geometry.intersects(wfs.features[j].geometry);
                    //que la que tengo seleccionada no este dentro de la otra
                    //if(jsts_geomB.contains(jsts_geomA)==false && jsts_geomA.contains(jsts_geomB)==false && intersects12 && feature.fid!=wfs.features[j].fid && wfs.features[j].attributes.ban!='1' && wfs.features[j].attributes.ban!='3'){
                    // pongo la tipo 9 que es la contened
                    if(intersects12){
                        sal++;
                        var jsts_geomB  = jsts_parser.read(wfs.features[j].geometry);
                        var jsts_result_geom = jsts_geomA.union(jsts_geomB);
                        var geompol = new OpenLayers.Geometry.MultiPolygon(OpenLayers.Geometry.fromWKT(jsts_result_geom.toString()));
                        //var feature1 = wfs.getFeatureBy('fid', wfs.features[j].fid);
                        wfs.eraseFeatures(feature);
                        wfs.eraseFeatures(wfs.features[j]);
                        feature.geometry=geompol;
                        if (feature.state!=OpenLayers.State.INSERT){
                            feature.state = OpenLayers.State.UPDATE;
                        }
                        wfs.drawFeature(feature);
                        feature.attributes.cod  = 1;
                        wfs.features[j].state = OpenLayers.State.DELETE;

                    }//intersect
                }//delete
            }//for
        if (sal==0){
            alertmsg("Debe de sobreponer las manzanas");
        }//sal=0
    } //if delete
}//1er if
}//function
////////// TERMINA PARTE DE LA EDICION DE LAS MANZNA//////////////// // ****************************************************************************************************************



function subdividepre(e){
//console.log(e);
var intersects12,ban,i;
var l=wfs.features.length-1;
//var attributes = {clave: "000", filtro: clavefil};
   for(var i=0; i<=l; i++) {
    if (wfs.features[i].state!=OpenLayers.State.DELETE){
        intersects12 = e.intersects(wfs.features[i].geometry);
          // i es igual al numero de poligonos que va a subdividir... hay que comparar que solo sea el primero
                // los de baja y los de nueva creacion (4,A,B, no se puede subdividir)
             if(intersects12){
                var c = null;
                //sacar el primer polygono (tiene que ser polygono para que lo pueda hacer y no multipol como esta la capa)
                for (c in wfs.features[i].geometry.components) {
                    var poly = wfs.features[i].geometry.components[c];
                    break;
                }
                var reader = new jsts.io.WKTReader();
                var a = reader.read(poly.toString());
                var b = reader.read(e.toString());
                var startPoint = reader.read(e.components[0].toString());
                var lastPoint = reader.read(e.components[e.components.length-1].toString());
                // si no contiene los 2 puntos que si lo haga
                if (a.contains(startPoint)==true || a.contains(lastPoint)==true){
                    alertmsg("Linea adentro, no se puede subdividir");
                }else{
                    var union = a.getExteriorRing().union(b);
                    var polygonizer = new jsts.operation.polygonize.Polygonizer();
                    polygonizer.add(union);
                    var polygons = polygonizer.getPolygons();
                // primero valido que se divida en 2 solo 1
                for(var j=0; j<polygons.array.length; j++) {  //aqui solo debe entrar 2 veces si no hace un relajo
                    if (j>1){
                        alertmsg("Solo se puede subdividir en 2 la manzana");
                        return false;
                    }
                }
                var feature1 = wfs.getFeatureBy('fid', wfs.features[i].fid);
                var feature;
                for(var j=0; j<polygons.array.length; j++) {
                    var geompol = new OpenLayers.Geometry.MultiPolygon(OpenLayers.Geometry.fromWKT(polygons.array[j].toString()));
                        if (j==0){
                            wfs.eraseFeatures(feature1);
                            feature1.geometry=geompol;
                            if (feature1.state!=OpenLayers.State.INSERT){
                                feature1.state = OpenLayers.State.UPDATE;
                            }
                            feature1.attributes.cod  = 2;
                            wfs.drawFeature(feature1);
                        }else{
                            wfs.addFeatures([new OpenLayers.Feature.Vector(geompol)]);
                            var n=wfs.features.length-1;
                            wfs.features[n].state=OpenLayers.State.INSERT;
                            feature = wfs.getFeatureBy('fid', wfs.features[n].fid);
                            feature.attributes.cve_ent=filterid;
                            feature.attributes.img  = baseimg;
                            feature.attributes.us  = iduser;
                            feature.attributes.cur  = feature1.attributes.cur;
                            feature.attributes.cod  = 2;
                        }
                }//for
                    return false; //finaliza correctamente con el primero que cumpla las condiciones y se sale
            }//else linea afuera
        }//if intersect
    }//if != delete
  }//for
}//funcion



function obtCvePe(feature){
    var id=feature.id;
    var geom=feature.geometry.toString();
    var ajax=nuevoAjax();
    ajax.open("GET",'obtcve.jsp?tipo=pr&geom='+geom, true);
    ajax.onreadystatechange=function()
    {
        if(ajax.readyState==4)  {
             var vale=String(ajax.responseText).trim();
            if (vale=="0" || vale==0){
                alertmsg ("No se pudo obtener la clave de Loc");
            }else{
                feature.attributes.cve_ent=(vale.substring(0,2));
                feature.attributes.cve_mun=(vale.substring(2,5));
                feature.attributes.cve_loc=(vale.substring(5,9));
                feature.attributes.cve_ageb=(vale.substring(9,14));
            }
        }
    }
    ajax.send(null);
}


//funcion al cerrar el popup de cualquier tipo
function onPopupClosepe(){
    var feature = wfs_pe.getFeatureBy('id', idpop);
    if (feature!=null){
        if (feature.popup!=null){
            map.removePopup(feature.popup);
        }
        if (drawmz.active){
            wfs_pe.destroyFeatures([feature]);
        }
    }
}


function onPopupClosemzp(){
    var feature = wfs.getFeatureBy('id', idpop);
    if (feature!=null){
        if (feature.popup!=null){
            map.removePopup(feature.popup);
        }
        if (drawmz.active){
            wfs.destroyFeatures([feature]);
        }
    }
}



//FUNCION QUE BUSCA DESDE LA TABLA DE EQUIVALENCIA DE  LAS MANZANAS// ****************************************************************************************************************
function buscazoompre(val,geom){
var geometry = OpenLayers.Geometry.fromWKT(geom);
var feature = new OpenLayers.Feature.Vector(geometry, {}, {
        strokeColor: '#000000',
        strokeOpacity: 1,
        strokeWidth: 1,
        fillColor: '#'+document.getElementById('colorin').value,
        fillOpacity: 0.5
    });
 if (val==3){
     s0=geometry.getCentroid().x-5000;    //ccl , merctor
     s1=geometry.getCentroid().y-5000;
     s2=geometry.getCentroid().x+5000;
     s3=geometry.getCentroid().y+5000;
 }else{
     s0=geometry.getCentroid().x-500;    //ccl , merctor
     s1=geometry.getCentroid().y-500;
     s2=geometry.getCentroid().x+500;
     s3=geometry.getCentroid().y+500;
 }
puntogen.addFeatures([feature]);
bounds = new OpenLayers.Bounds(s0,s1,s2,s3);
map.zoomToExtent(bounds);
//map.zoomToExtent(geometry.bounds);
//map.zoomTo(12);
map.controls[0].redraw;
}
