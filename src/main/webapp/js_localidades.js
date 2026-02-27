
////////// FUNCION SELECCIONA UNA LOCALIDAD //////////////// // ****************************************************************************************************************
function onFeatureSelectLoc(event){
var feature = event.feature;
// registrar el id del seleccionado para regresar movimientos
if (wfsmov.length>0){
    if (wfsmov.indexOf(feature.id)<0){
     wfsmov.push(feature.id);
    }
}else{
    wfsmov.push(feature.id);
}

    feature.state = OpenLayers.State.UPDATE;
    feature.attributes.img  = baseimg;
    feature.attributes.usuario  = iduser;
if (valida.active==true){
    if (feature.attributes.ban=="0" || feature.attributes.ban=="4"){
        feature.attributes.ban = "1";
        feature.attributes.ok = "FALSE";
        alertmsg("Validada");
    }
}else if (pendiente.active==true){
    //if (feature.attributes.ban=="0" || feature.attributes.ban=="1"){
        feature.attributes.ban = "4";
        //feature.attributes.ok = "FALSE";
        alertmsg("Pendiente");
    //}
}else if (modify.active==true){
    feature.attributes.ban = "2";
    feature.attributes.ok = "TRUE";
}else if (modify2.active==true){
    feature.attributes.ban = "3";
    feature.attributes.ok = "TRUE";
}
}

////FUNCION  DESELECCIONA UNA LOCALIDAD
function onFeatureUnSelectLoc(event){
var feature = event.feature;
//if (modify.active==true || modify2.active==true){
    if (feature.modified == null && (feature.attributes.ban=='3' || feature.attributes.ban=='2')){
        feature.attributes.ban = feature.data.ban;
        feature.attributes.ok = feature.data.ok;
        //feature.state = null;
    }
    if (feature.modified){
        alertmsg("Movido");
    }
//}
}
////////// TERMINA PARTE DE LA EDICION DE LAS LOCALIDADES ////////////////

// FUNCIONES QUE OCURREN AL GUARDAR CORRECTAMENTE O INCORRECTAMENTE LA CAPA DE LOCALIDADES  **********************************
function saveSuccessLoc(){
        borra();
    alertmsg("Cambios guardados correctamente");
    var tip=0;
    wfs.refresh({force: true});
    wfs.redraw(true);
}



function saveFailLoc(e){
    var ve=e.response.reqFeatures;
    var txt=e.response.priv.responseText;
    var feature;
    var xy;
    var msg1="";
    var valt="";
    var n = txt.indexOf("Error performing insert");
    if (n>=0){
        msg1="insertar";
        valt="Insert";
    }else{
        msg1="actualizar";
        valt="Update";
    }
    for (var i = 0; i <ve.length;i++){
        if (ve[i].state==valt){
            xy = ve[i].geometry.getCentroid();
            xy.transform(
                new OpenLayers.Projection('EPSG:32800'),
                new OpenLayers.Projection('EPSG:900913')
            );
            feature = new OpenLayers.Feature.Vector(xy, {}, {
                strokeColor: '#330000',
                strokeOpacity: 1,
                strokeWidth: 1,
                fillColor: '#FF0000',
                //fillOpacity: 0.5,
                pointRadius: 9,
                graphicName: 'circle'
            });
            puntogen.addFeatures([feature]);
        }
    }
    alertmsg("Error al "+msg1+", no se guardo");
}

//FUNCION QUE BUSCA DESDE LA TABLA DE EQUIVALENCIA DE  LAS LOCALIDADES // ****************************************************************************************************************
function buscazoomte(val,s0,s1){
 geometry = new OpenLayers.Geometry.Point(s0, s1);
 if (parseInt(val)==0){
var feature = new OpenLayers.Feature.Vector(geometry, {}, {
        strokeColor: '#000000',
        strokeOpacity: 1,
        strokeWidth: 1,
        fillColor: '#FF0000',
        fillOpacity: 0.5,
        pointRadius: 7,
        graphicName: 'star'
    });
 }else{
var feature = new OpenLayers.Feature.Vector(geometry, {}, {
        strokeColor: '#000000',
        strokeOpacity: 1,
        strokeWidth: 1,
        fillColor: '#000000',
        fillOpacity: 0.5,
        pointRadius: 7,
        graphicName: 'star'
    });
 }
    puntogen.addFeatures([feature]);
    s0=geometry.x-2000;    //ccl , merctor
    s1=geometry.y-2000;
    s2=geometry.x+2000;
    s3=geometry.y+2000;
    //s0=geometry.x-.02000;     //lon/lat
    //s1=geometry.y-.02000;
    //s2=geometry.x+.02000;
    //s3=geometry.y+.02000;
bounds = new OpenLayers.Bounds(s0,s1,s2,s3);
map.zoomToExtent(bounds);
map.controls[0].redraw;
}



//esta es para las pre-digitalizaciones
var DeleteFeature = OpenLayers.Class(OpenLayers.Control, {
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