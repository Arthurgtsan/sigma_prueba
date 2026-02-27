////////// FUNCION PARA LA SELECCION DE LA MANZANA //// ******************************************************************************************************
function onFeatureSelectAu(event){
  if (map.popups.length>0){
    onPopupCloseauall();
}
 var feature = event.feature;
 idpop=feature.id;
// console.log(feature);

var  theHTML = '<center>';
theHTML += '<table><tr><th colspan=2 class=label style="text-align:center">ATRIBUTOS';
theHTML += '<tr><td colspan=2>&nbsp;';
var theHTMLextra ='';
var theHTMLextra2 ='';
if (drawmz.active || (modiatmz.active && feature.state == OpenLayers.State.INSERT) || (modiatmz.active && (feature.attributes.ban==2 || feature.attributes.ban==0)) ){
    if  (drawmz.active){
        feature.attributes.ban=1;
        feature.attributes.cve_ent=cve_ent;
        feature.attributes.cve_mun=cve_mun;
        feature.attributes.cve_loc=cve_loc;
        feature.attributes.cve_ageb='000-0';
    }else{
        if (feature.state == OpenLayers.State.INSERT){
            feature.attributes.cve_ent=cve_ent;
            feature.attributes.cve_mun=cve_mun;
            feature.attributes.cve_loc=cve_loc;
            feature.attributes.cve_ageb=cve_ageb;
        }else{  //es update osea estoy cambiando la clave
            feature.attributes.ban=4;
        }
    }
    theHTML += '<tr><td class=label style="text-align:right">Clave entidad:&nbsp;<td><input class=input id="cve_ent_'+feature.id+'" type="text" size="6" maxlength="2"  value="'+feature.attributes.cve_ent+'" >';
    theHTML += '<tr><td class=label style="text-align:right">Clave municipio:&nbsp;<td><input class=input id="cve_mun_'+feature.id+'" type="text" size="6" maxlength="3"  value="'+feature.attributes.cve_mun+'" >';
    theHTML += '<tr><td class=label style="text-align:right">Clave localidad:&nbsp;<td><input class=input id="cve_loc_'+feature.id+'" type="text" size="6" maxlength="4"  value="'+feature.attributes.cve_loc+'" onkeypress="return datonumat(event)">';
    theHTML += '<tr><td class=label style="text-align:right" nowrap>Clave ageb (con -):&nbsp;<td><input class=input id="cve_ageb_'+feature.id+'" type="text" size="6" maxlength="5"  value="'+feature.attributes.cve_ageb+'" onkeypress="return datonumatageb(event)" onkeyup="return datonumatageb2(event)">';
    theHTML += '&nbsp;&nbsp;<input title="Obtener siguiente clave de ageb urbana" onclick="obtCveAu(\'' + feature.id + '\');" class="input" type="button" id="obtcveau'+feature.id+'" name="obtcveau'+feature.id+'" value="Au">';
    theHTML += '<tr><td class=label colspan=2 style="text-align:center">&nbsp;';
    theHTML += '<tr><td class=label colspan=2 style="text-align:center">';
    theHTML += '</center>';

    if (feature.fid==null){   //insert
        feature.fid=feature.id;
    }

    theHTML += '<input onclick="updateAttributesAu(\'' + feature.id + '\');" class=input type="button" name="enviar" value="Guardar">';
    if (drawmz.active){
        theHTML += '&nbsp;&nbsp;&nbsp;<input onclick="crearHuecoAu(\'' + feature.id + '\');" class=input type="button" name="enviar" value="Hueco">';
    }

    if (map.getExtent().containsLonLat(feature.geometry.getBounds().getCenterLonLat())){
        var varcent=feature.geometry.getBounds().getCenterLonLat();
    }else{
        var varcent=map.getCenter();
    }
    feature.popup = new OpenLayers.Popup.AnchoredBubble
    ("pop", varcent, new OpenLayers.Size(280,170),
    theHTML,    null,   true    //este false es el boton de cerrar
       ,onPopupCloseau                //funcion al cerrar
    );
    feature.popup.opacity=0.9;
    feature.popup.backgroundColor="#BBCCFF";
    map.addPopup(feature.popup);
    document.getElementById("pop").style.zIndex = "999";
}else if (modimz1.active || modimz2.active){
   return false;
}else{
   alertmsg("No puede cambiar de clave un ageb nueva")
   return false;
}
}//funcion

//FUNCION HACE UN UPDATE DE LOS DATOS DE MANZANA// ****************************************************************************************************************
function updateAttributesAu(id){
    var feature = wfs.getFeatureBy('id', id);
        ban = feature.attributes.ban;
        eval ('cve_ent = document.getElementById("cve_ent_'+ id+'").value;');
        eval ('cve_mun = document.getElementById("cve_mun_'+ id+'").value;');
        eval ('cve_loc = document.getElementById("cve_loc_'+ id+'").value;');
        eval ('cve_ageb = document.getElementById("cve_ageb_'+ id+'").value;');
        cve_ageb=cve_ageb.toUpperCase();
// validaciones de campos segun el codigo
if (ban==1 || ban==4){
            if (cve_ent=='00' || cve_ent.length<2){
                alertmsg("Clave de entidad no debe estar vacia");
                return false;f
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
    var clave1=cve_ent.concat(cve_mun).concat(cve_loc).concat(cve_ageb);
    var clave2=feature.attributes.cve_ent.concat(feature.attributes.cve_mun).concat(feature.attributes.cve_loc).concat(feature.attributes.cve_ageb);
    if (clave1==clave2){
           alertmsg("Clave de ageb debe ser diferente");
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
    cvemax=cvemax+',\''+mztemp+'\'';
}



//funcion para crear un hueco despues de la subdivision entre manzanas// ****************************************************************************************************************
function crearHuecoAu(id){
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
            alertmsg("Debe de hacerlo sobre ageb urbana");
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
function onFeatureUnSelectAu(event){
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
function saveSuccessAu(){
        borra();
    alertmsg("Cambios guardados correctamente");
    wfs.refresh({force: true});
    wfs.redraw(true);
    if (agebu_gen.getVisibility()){agebu_gen.redraw(true);}
    //if (agebu_genet.getVisibility()){agebu_genet.redraw(true);}
}



function saveFailAu(e){
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

var DeleteFeatureAu = OpenLayers.Class(OpenLayers.Control, {
    initialize: function(layer, options) {
        OpenLayers.Control.prototype.initialize.apply(this, [options]);
        this.layer = layer;
        this.handler = new OpenLayers.Handler.Feature(
            this, layer, {click: this.clickFeature}
        );
    },
    clickFeature: function(feature) {
                if (revisa_idmax_noborraAu(feature.fid)){
                    alertmsg ("No se puede borrar una ageb urbano agregado");
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

function revisa_idmax_noborraAu(gid){
    if ((parseInt(gid.substring(11,gid.length))>max_au || gid.substring(0,1)=='O')){
        return true;
    }else{
        return false;
    }
}

function obtCveAu(id){
    mztemp='';
    var ajax=nuevoAjax();
    eval ('cve_ent = document.getElementById("cve_ent_'+ id+'").value;');
    eval ('cve_mun = document.getElementById("cve_mun_'+ id+'").value;');
    eval ('cve_loc = document.getElementById("cve_loc_'+ id+'").value;');
     if (cve_ent=='00' || cve_ent.length<2){
                alertmsg("Clave de entidad no debe estar vacia");
                return false;
            }else if (cve_mun=='000' || cve_mun.length<3){
                alertmsg("Clave de municipio no debe estar vacia");
                return false;
            }else if (cve_loc=='0000' || cve_loc.length<4){
                alertmsg("Clave de localidad no debe estar vacia");
                return false;
            }
    var cveconca=cve_ent+cve_mun;
    ajax.open("GET",'obtcve.jsp?tipo=au&clave='+cveconca+'&cvemax='+cvemax, true);
    ajax.onreadystatechange=function()
    {
        if(ajax.readyState==4)  {
             var vale=String(ajax.responseText).trim();
            if (vale=="'0'" || vale=='0'){
                alertmsg ("No se pudo obtener la clave de AgebU");
            }else{
                eval ('document.getElementById("cve_ageb_'+ id+'").value=\''+(vale)+'\';');
                mztemp=cveconca+vale;
            }
        }
    }
    ajax.send(null);
    //eval ('document.getElementById("obtcveau'+id+'").disabled=true;');
}

//funcion al cerrar el popup de cualquier tipo
function onPopupCloseau(){
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

//funcion al cerrar el popup de cualquier tipo
function onPopupCloseauall(){
   for( var i = 0; i <= map.popups.length; ++i ) {
            if (!(map.popups[i]==undefined || map.popups[i]==null) && map.popups[i].id=="pop"){
                map.removePopup(map.popups[i]);
            }
 };
}