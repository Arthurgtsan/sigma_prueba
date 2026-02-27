////////// FUNCION PARA LA SELECCION DE LA MANZANA //// ******************************************************************************************************
function onFeatureSelectPr(event){
 if (map.popups.length>0){
    onPopupCloseprall();
}
 var feature = event.feature;
 idpop=feature.id;
// console.log(feature);

var  theHTML = '<center>';
theHTML += '<table><tr><th colspan=2 class=label style="text-align:center">ATRIBUTOS';
theHTML += '<tr><td colspan=2>&nbsp;';
var theHTMLextra ='';
var theHTMLextra2 ='';
if (drawmz.active || drawmulti.active || (modiatmz.active && feature.state == OpenLayers.State.INSERT) || (modiatmz.active && (feature.attributes.ban==2 || feature.attributes.ban==0)) ){
    if  (drawmz.active){
        feature.attributes.ban=1;
        feature.attributes.cve_ent='00';
        feature.attributes.cve_mun='000';
        feature.attributes.cve_loc='0000';
        feature.attributes.cve_ageb='000-0';
    }else if  (drawmulti.active){
        feature.attributes.ban=8;
        feature.attributes.cve_ent='00';
        feature.attributes.cve_mun='000';
        feature.attributes.cve_loc='0000';
        feature.attributes.cve_ageb='000-0';
    }else  if  (modiatmz.active && feature.attributes.ban!=8){
        feature.attributes.ban=4;
    }
    if  (drawmz.active){
            theHTML += '<tr><td class=label style="text-align:right">Clave entidad:&nbsp;<td><input class=input id="cve_ent_'+feature.id+'" type="text" size="6" maxlength="2"  value="'+feature.attributes.cve_ent+'" readonly>';
            theHTML += '<tr><td class=label style="text-align:right">Clave municipio:&nbsp;<td><input class=input id="cve_mun_'+feature.id+'" type="text" size="6" maxlength="3"  value="'+feature.attributes.cve_mun+'" readonly>';
            theHTML += '<tr><td class=label style="text-align:right">Clave localidad:&nbsp;<td><input class=input id="cve_loc_'+feature.id+'" type="text" size="6" maxlength="4"  value="'+feature.attributes.cve_loc+'" readonly>';
            theHTML += '<tr><td class=label style="text-align:right">Clave Ageb-R:&nbsp;<td><input class=input id="cve_ageb_'+feature.id+'" type="text" size="6" maxlength="5"  value="'+feature.attributes.cve_ageb+'" readonly>';
            theHTML += '<tr><td class=label colspan=2 style="text-align:center">&nbsp;';
            theHTML += '<tr><td class=label colspan=2 style="text-align:center">';
            theHTML += '</center>';
        }else  if(drawmulti.active || modiatmz.active){
            theHTML += '<tr><td class=label style="text-align:right">Clave entidad:&nbsp;<td><input class=input id="cve_ent_'+feature.id+'" type="text" size="6" maxlength="2"  value="'+feature.attributes.cve_ent+'">';
            theHTML += '<tr><td class=label style="text-align:right">Clave municipio:&nbsp;<td><input class=input id="cve_mun_'+feature.id+'" type="text" size="6" maxlength="3"  value="'+feature.attributes.cve_mun+'">';
            theHTML += '<tr><td class=label style="text-align:right">Clave localidad:&nbsp;<td><input class=input id="cve_loc_'+feature.id+'" type="text" size="6" maxlength="4"  value="'+feature.attributes.cve_loc+'">';
            theHTML += '<tr><td class=label style="text-align:right">Clave Ageb-R:&nbsp;<td><input class=input id="cve_ageb_'+feature.id+'" type="text" size="6" maxlength="5"  value="'+feature.attributes.cve_ageb+'">';
            theHTML += '<tr><td class=label colspan=2 style="text-align:center">&nbsp;';
            theHTML += '<tr><td class=label colspan=2 style="text-align:center">';
            theHTML += '</center>';
        }

if (feature.fid==null){   //insert
    feature.fid=feature.id;
}

theHTML += '<input onclick="updateAttributesPr(\'' + feature.id + '\');" class=input type="button" name="enviar" value="Guardar">';
if(!(modiatmz.active)){
    theHTML += '&nbsp;&nbsp;&nbsp;<input onclick="crearHuecoPr(\'' + feature.id + '\');" class=input type="button" name="enviar" value="Hueco">';
}

    if (map.getExtent().containsLonLat(feature.geometry.getBounds().getCenterLonLat())){
        var varcent=feature.geometry.getBounds().getCenterLonLat();
    }else{
        var varcent=map.getCenter();
    }
    feature.popup = new OpenLayers.Popup.AnchoredBubble
    ("pop", varcent, new OpenLayers.Size(280,170),
    theHTML,    null,   true    //este false es el boton de cerrar
       ,onPopupClosepr                //funcion al cerrar
    );
    feature.popup.opacity=0.9;
    feature.popup.backgroundColor="#BBCCFF";
    map.addPopup(feature.popup);
    document.getElementById("pop").style.zIndex = "999";
     if  (drawmz.active){
            obtCvePr(feature);
    }
}else if (modimz1.active || modimz2.active){
   return false;
}else{
   alertmsg("No puede cambiar de clave una localidad existente")
   return false;
}
}//funcion

//FUNCION HACE UN UPDATE DE LOS DATOS DE MANZANA// ****************************************************************************************************************
function updateAttributesPr(id){
     var feature = wfs.getFeatureBy('id', id);
        ban = feature.attributes.ban;
        eval ('cve_ent = document.getElementById("cve_ent_'+ id+'").value;');
        eval ('cve_mun = document.getElementById("cve_mun_'+ id+'").value;');
        eval ('cve_loc = document.getElementById("cve_loc_'+ id+'").value;');
        eval ('cve_ageb = document.getElementById("cve_ageb_'+ id+'").value;');
        cve_ageb=cve_ageb.toUpperCase();
// validaciones de campos segun el codigo
if (ban==1){
            if (cve_ent=='00' || cve_ent.length<2){
                alertmsg("Clave de entidad no debe estar vacia");
                return false;
            }else if (cve_mun=='000' || cve_mun.length<3){
                alertmsg("Clave de municipio no debe estar vacia");
                return false;
            }else if (cve_loc=='0000' || cve_loc.length<4){
                alertmsg("Clave de localidad no debe estar vacia");
                return false;
            }else if (cve_ageb=='000-0' || cve_ageb.length<5){
                alertmsg("Clave de ageb no debe estar vacia");
                return false;
            }
}

if (ban==4){
    var clave1=cve_ent.concat(cve_mun).concat(cve_loc);
    var clave2=feature.attributes.cve_ent.concat(feature.attributes.cve_mun).concat(feature.attributes.cve_loc);
    if (clave1==clave2){
           alertmsg("Clave de localidad debe ser diferente");
            return false;
    }
}

if(feature.state != OpenLayers.State.INSERT) {
        feature.state = OpenLayers.State.UPDATE;
}
    feature.attributes.cve_ent  = cve_ent;
    feature.attributes.cve_mun  = cve_mun;
    feature.attributes.cve_loc  = cve_loc;
    feature.attributes.cve_ageb  = cve_ageb;
    feature.attributes.img  = baseimg;
    feature.attributes.us  = iduser;
    feature.attributes.obs  = cutpolvar;
    map.removePopup(feature.popup);
     if(modiatmz.active) {
        modiatmz.selectControl.unselect(feature);
    }
}


//funcion para crear un hueco despues de la subdivision entre manzanas// ****************************************************************************************************************
function crearHuecoPr(id){
    var feature = wfs.getFeatureBy('id', id);
    map.removePopup(feature.popup);
    modiatmz.selectControl.unselect(feature);
    var jsts_parser = new jsts.io.OpenLayersParser();
    var intersects12,ban,i,t,sal=0,area1=0,area2=0;
    for(var j=0; j<wfs.features.length; j++) {
        if (wfs.features[j].state!=OpenLayers.State.DELETE){
            intersects12 = feature.geometry.intersects(wfs.features[j].geometry);
            if(intersects12 && feature.fid!=wfs.features[j].fid && wfs.features[j].attributes.ban!='3'){
                sal++;
                var jsts_geomA  = jsts_parser.read(feature.geometry);
                var jsts_geomB  = jsts_parser.read(wfs.features[j].geometry);
                var jsts_result_geom = jsts_geomB.difference(jsts_geomA);
                if (jsts_result_geom.geometries!=undefined){ // aqui comparo si es el resultado es multipoligono
                    if (jsts_result_geom.geometries.length>0){
                        area1 = jsts_result_geom.geometries[0].getArea();
                        var polarea=0;
                        for(var k=1; j<jsts_result_geom.geometries.length; k++) {
                            area2 = jsts_result_geom.geometries[k].getArea();
                            if (parseFloat(area2)>parseFloat(area1)){
                                polarea=k;
                                area1 = jsts_result_geom.geometries[k].getArea();
                            }
                        }
                    jsts_result_geom=jsts_result_geom.geometries[polarea];
                    }
                }
                var geomtemp=wfs.features[j].geometry;
                var geompol = new OpenLayers.Geometry.MultiPolygon(OpenLayers.Geometry.fromWKT(jsts_result_geom.toString()));
                wfs.eraseFeatures(wfs.features[j]);
                wfs.features[j].geometry=geompol;
                wfs.features[j].attributes.img  = baseimg;
                wfs.features[j].attributes.us  = iduser;
                if (wfs.features[j].state!=OpenLayers.State.INSERT){
                    wfs.features[j].state = OpenLayers.State.UPDATE;
                }
                wfs.drawFeature(wfs.features[j]);
                if(feature.fid == undefined) {
                    wfs.destroyFeatures([feature]);
                } else {
                    feature.state = OpenLayers.State.DELETE;
                    wfs.events.triggerEvent("afterfeaturemodified",{feature: feature});
                    feature.renderIntent = "select";
                    wfs.drawFeature(feature);
                }
            }
        }
    }
    if (sal==0){
            alertmsg("Debe de hacerlo sobre poligonos de localidad");
             if(feature.fid == undefined) {
                wfs.destroyFeatures([feature]);
            } else {
                feature.state = OpenLayers.State.DELETE;
                wfs.events.triggerEvent("afterfeaturemodified",{feature: feature});
                feature.renderIntent = "select";
                wfs.drawFeature(feature);
            }
    }
}

// FUNCION DESELECCIONA LA MANZANA// ****************************************************************************************************************
function onFeatureUnSelectPr(event){
var feature = event.feature;
    if (feature.modified){
        alertmsg("Movido");
        feature.attributes.img  = baseimg;
        feature.attributes.us  = iduser;
        feature.attributes.obs  = cutpolvar;
    }
    if (feature.popup){
        map.removePopup(feature.popup);
    }
}


// FUNCIONES QUE OCURREN AL GUARDAR CORRECTAMENTE O INCORRECTAMENTE LA CAPA DE LOCALIDADES  **********************************
function saveSuccessPr(){
        borra();
    alertmsg("Cambios guardados correctamente");
    wfs.refresh({force: true});
    wfs.redraw(true);
    if (polr_gen.getVisibility()){polr_gen.redraw(true);}
    //if (polr_genet.getVisibility()){polr_genet.redraw(true);}
}



function saveFailPr(e){
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


var DeleteFeaturePr = OpenLayers.Class(OpenLayers.Control, {
    initialize: function(layer, options) {
        OpenLayers.Control.prototype.initialize.apply(this, [options]);
        this.layer = layer;
        this.handler = new OpenLayers.Handler.Feature(
            this, layer, {click: this.clickFeature}
        );
    },
    clickFeature: function(feature) {
                if (revisa_idmax_noborraPr(feature.fid)){
                    alertmsg ("No se puede borrar una localidad rural agregada");
                    return false;
                }
        // if feature doesn't have a fid, destroy it
        if(feature.fid == undefined) {
            this.layer.destroyFeatures([feature]);
        } else {
            feature.state = OpenLayers.State.DELETE;
            this.layer.events.triggerEvent("afterfeaturemodified",
                                           {feature: feature});
            feature.renderIntent = "select";
            this.layer.drawFeature(feature);
            feature.state = OpenLayers.State.UPDATE;
            feature.attributes.ban  = 3;
            feature.attributes.img  = baseimg;
            feature.attributes.us  = iduser;
            feature.attributes.obs  = cutpolvar;
        }

    },
    setMap: function(map) {
        this.handler.setMap(map);
        OpenLayers.Control.prototype.setMap.apply(this, arguments);
    },
    CLASS_NAME: "OpenLayers.Control.DeleteFeature"
});

function revisa_idmax_noborraPr(gid){
    if ((parseInt(gid.substring(10,gid.length))>max_pr || gid.substring(0,1)=='O')){
        return true;
    }else{
        return false;
    }
}

function obtCvePr(feature){
    var id=feature.id;
    var geom=feature.geometry.toString();
    var ajax=nuevoAjax();
    eval ('cve_ent = document.getElementById("cve_ent_'+ id+'").value;');
    eval ('cve_mun = document.getElementById("cve_mun_'+ id+'").value;');
    eval ('cve_loc = document.getElementById("cve_loc_'+ id+'").value;');
    var cveconca=cve_ent+cve_mun+cve_loc;
    ajax.open("GET",'obtcve.jsp?tipo=pr&geom='+geom+'&clave='+cveconca, true);
    ajax.onreadystatechange=function()
    {
        if(ajax.readyState==4)  {
             var vale=String(ajax.responseText).trim();
            if (vale=="0" || vale==0){
                alertmsg ("No se pudo obtener la clave de Loc");
            }else{
                eval ('document.getElementById("cve_ent_'+ id+'").value="'+(vale.substring(0,2))+'";');
                eval ('document.getElementById("cve_mun_'+ id+'").value="'+(vale.substring(2,5))+'";');
                eval ('document.getElementById("cve_loc_'+ id+'").value="'+(vale.substring(5,9))+'";');
                eval ('document.getElementById("cve_ageb_'+ id+'").value="'+(vale.substring(9,14))+'";');
            }
        }
    }
    ajax.send(null);
}

//funcion al cerrar el popup de cualquier tipo
function onPopupClosepr(){
    var feature = wfs.getFeatureBy('id', idpop);
    if (feature!=null){
        if (feature.popup!=null){
            map.removePopup(feature.popup);
        }
        if (drawmz.active || drawmulti.active){
            wfs.destroyFeatures([feature]);
        }
    }
}

//funcion al cerrar el popup de cualquier tipo
function onPopupCloseprall(){
   for( var i = 0; i <= map.popups.length; ++i ) {
            if (!(map.popups[i]==undefined || map.popups[i]==null) && map.popups[i].id=="pop"){
                map.removePopup(map.popups[i]);
            }
 };
}