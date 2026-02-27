

////////// FUNCION PARA LA SELECCION DE LA MANZANA //// ******************************************************************************************************
function onFeatureSelectcd(event){
if (drawmz.active || event.type==undefined){
        // registrar el id del seleccionado para regresar movimientos
          if (map.popups.length>0){
            onPopupClosemzCd();
        }
        var feature;
        if (event.type==undefined){  //viene del MCC
            feature = event;
        }else{
            feature = event.feature;
        }
         idpop=feature.id;

                feature.attributes.cve_ent=cve_ent;
                feature.attributes.cve_mun=cve_mun;
                feature.attributes.cve_loc=cve_loc;
                feature.attributes.cve_ageb=cve_ageb;
                feature.attributes.cve_mza='800';
        var  theHTML = '<center>';
        theHTML += '<table><tr><th colspan=2 class=label style="text-align:center">ATRIBUTOS';
        theHTML += '<tr><td colspan=2>&nbsp;';
        var theHTMLextra ='';
        var theHTMLextra2 ='';
        theHTML += '<input id="ban_'+feature.id+'" type="hidden" value="4">';
        theHTML += '<tr><td class=label style="text-align:right">Clave entidad:&nbsp;<td><input class=input id="cve_ent_'+feature.id+'" type="text" size="6" maxlength="2"  value="'+feature.attributes.cve_ent+'" onkeypress="return datonumat(event)">';
        theHTML += '<tr><td class=label style="text-align:right">Clave municipio:&nbsp;<td><input class=input id="cve_mun_'+feature.id+'" type="text" size="6" maxlength="3"  value="'+feature.attributes.cve_mun+'" onkeypress="return datonumat(event)">';
        theHTML += '<tr><td class=label style="text-align:right">Clave localidad:&nbsp;<td><input class=input id="cve_loc_'+feature.id+'" type="text" size="6" maxlength="4"  value="'+feature.attributes.cve_loc+'" onkeypress="return datonumat(event)">';
        theHTML += '<tr><td class=label style="text-align:right" nowrap>Clave ageb (con -):&nbsp;<td><input class=input id="cve_ageb_'+feature.id+'" type="text" size="6" maxlength="5"  value="'+feature.attributes.cve_ageb+'" onkeypress="return datonumatageb(event)" onkeyup="return datonumatageb2(event)">';
        theHTML += '<tr><td class=label style="text-align:right">Clave manzana:&nbsp;<td><input class=input id="cve_mza_'+feature.id+'" type="text" size="3" maxlength="3"  readonly value="800" onkeypress="return datonumat(event)">';
        theHTML += '&nbsp;<input title="Obtener clave de manzana POR POSICION" onclick="obtCveMzaGeoCD(\'' + feature.geometry.getCentroid() + '\',\'' + feature.id + '\');" class="input" type="button" id="obtcvemzageocd'+feature.id+'" name="obtcvemzageocd'+feature.id+'" value="Geo">';


    feature.attributes.proy=obtProy;

for (j=0;j<=17;j++){
    eval ('var opy'+j+'="";');
    if (parseInt(feature.attributes.proy)==j){
        eval ('var opy'+j+'=" selected ";');
    }
}



        theHTML += '<tr><td class=label style="text-align:right">Proyecto:&nbsp;<td><select class=input id="proy_'+feature.id+'">';
        //theHTML += '<option value="0" '+opy0+' title="Sin Proyecto">Seleccione...';
        //theHTML += '<option value="1" '+opy1+' title="Censos Economicos 2024">CE2024';
        //theHTML += '<option value="2" '+opy2+' title="Recorrido de Act del MGN 2014">RA2014';
        //theHTML += '<option value="3" '+opy3+' title="Encuesta Intercensal 2025">EI2025';
        //theHTML += '<option value="4" '+opy4+' title="Cartografia Participativa">CP';
        //theHTML += '<option value="5" '+opy5+' title="Carta Topografica">CT';
        //theHTML += '<option value="6" '+opy6+' title="Censos de Escuelas Maestros y Alumnos de Educacion Basica y Especial">CEMABE2013';
        //theHTML += '<option value="7" '+opy7+' title="Actualizacion Permanente del MG 2016">AP2016';
        //theHTML += '<option value="8" '+opy8+' title="Registro Unico de Viviendas 2016">RUV2016';
        //theHTML += '<option value="9" '+opy9+' title="Registro Unico de Viviendas 2014">RUV';
        //theHTML += '<option value="10" '+opy10+' title="Actualizacion Permanente del MG 2015">AP';
        //theHTML += '<option value="11" '+opy11+' title="Registro Unico de Viviendas 2015">RUV2015';
        //theHTML += '<option value="12" '+opy12+' title="Instituto Nacional Electoral 2016">INE';
        //theHTML += '<option value="13" '+opy13+' title="Marco Nacional de Viviendas">MNV';
        //theHTML += '<option value="14" title="Actualizacion Permanente del MG 2025">AP2025';
        //theHTML += '<option value="15" '+opy15+' title="Actualizacion por BCUU">BCUU';
        theHTML += '<option value="16" '+opy16+' title="Actualizacion Integral">ACI';
        //theHTML += '<option value="17" '+opy17+' title="Censo Agropecuario">CA22';

        theHTML += '</select>';
        theHTML += '<tr><td class=label colspan=2 style="text-align:center">&nbsp;';
        theHTML += '<tr><td class=label colspan=2 style="text-align:center">';
        if (feature.fid==null){   //insert
            feature.fid=feature.id;
        }
        theHTML += theHTMLextra;
        theHTML += '<input onclick="updateAttributesCd(\'' + feature.id + '\',1);" class=input type="button" name="enviar" value="Guardar">';
        theHTML += theHTMLextra2;

        theHTML += '</center>';
        var botcierra=true;
        /*if (modiatmz.active){
            botcierra=true;
        }else{
            botcierra=false;
        }*/
        if (map.getExtent().containsLonLat(feature.geometry.getBounds().getCenterLonLat())){
            var varcent=feature.geometry.getBounds().getCenterLonLat();
        }else{
            var varcent=map.getCenter();
        }

            feature.popup = new OpenLayers.Popup.AnchoredBubble
            ("pop", varcent, new OpenLayers.Size(280,220),
            theHTML,    null,   botcierra    //este false es el boton de cerrar
               ,onPopupClosemzCd                //funcion al cerrar
            );
            feature.popup.opacity=0.9;
            feature.popup.backgroundColor="#BBCCFF";
            map.addPopup(feature.popup);
            document.getElementById("pop").style.zIndex = "999";
        }
}

function onFeatureSelectCdpol(event){
    if (cve_pe_tipo==1){   //viene de la capa de PE de CUR
            var feature = event;
            feature.attributes.ban='1';
            feature.attributes.img  = baseimg;
            feature.attributes.proy  = 14;
            feature.attributes.usuario  = iduser;
    }else{
            var feature = event.feature;
            feature.attributes.ban  = '0';
            feature.attributes.img  = baseimg;
            feature.attributes.proy  = 14;
            feature.attributes.usuario  = iduser;
    }

}


//FUNCION QUE OBTIENE LA ULTIMA CLAVE DE MANZANA DEL AGEB POR SOBREPOSICION
function obtCveMzaGeoCD(centroid,id){
    var ajax=nuevoAjax();
    ajax.open("GET",'obtcveCD.jsp?clave='+centroid, true);
    ajax.onreadystatechange=function()
    {
        if(ajax.readyState==4)  {
             var vale=ajax.responseText;
            if (parseInt(vale)==0){
                alertmsg ("No se pudo obtener la Mz");
            }else{
                var cveconca=vale.trim().substring(0,14);
                 //console.log(valestr);
                eval ('document.getElementById("cve_ent_'+ id+'").value="'+cveconca.substring(0,2)+'";');
                eval ('document.getElementById("cve_mun_'+ id+'").value="'+cveconca.substring(2,5)+'";');
                eval ('document.getElementById("cve_loc_'+ id+'").value="'+cveconca.substring(5,9)+'";');
                eval ('document.getElementById("cve_ageb_'+ id+'").value="'+cveconca.substring(9,14)+'";');
            }
        }
    }
    ajax.send(null);
}



//FUNCION HACE UN UPDATE DE LOS DATOS DE MANZANA// ****************************************************************************************************************
function updateAttributesCd(id,temp){
    var feature = wfs.getFeatureBy('id', id);
    //var banant = feature.attributes.ban;
        eval ('ban = document.getElementById("ban_'+ id+'").value;');
        eval ('cve_ent = document.getElementById("cve_ent_'+ id+'").value;');
        eval ('cve_mun = document.getElementById("cve_mun_'+ id+'").value;');
        eval ('cve_loc = document.getElementById("cve_loc_'+ id+'").value;');
        eval ('cve_ageb = document.getElementById("cve_ageb_'+ id+'").value;');
        eval ('cve_mza = document.getElementById("cve_mza_'+ id+'").value;');
        eval ('proy = document.getElementById("proy_'+ id+'").value;');
        cve_ageb=cve_ageb.toUpperCase();

// validaciones de campos segun el codigo
if (ban=='4'){
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
            }else if (cve_mza=='000' || cve_mza.length<3){
                alertmsg("Clave de manzana no debe estar vacia");
                return false;
            }
              feature.attributes.inv_fte  = '2';    //le estoy poniendo uno para la EIC; pero debe ir 0 normalmente

}
        cod_mz=ban;
    feature.attributes.cve_ent  = cve_ent;
    feature.attributes.cve_mun  = cve_mun;
    feature.attributes.cve_loc  = cve_loc;
    feature.attributes.cve_ageb  = cve_ageb;
    feature.attributes.cve_mza  = cve_mza;
    feature.attributes.ban  = ban;
    feature.attributes.img  = baseimg;
    feature.attributes.proy  = proy;
    feature.attributes.usuario  = iduser;
    map.removePopup(feature.popup);
}



// FUNCION DESELECCIONA LA MANZANA// ****************************************************************************************************************
function onFeatureUnSelectcd(event){
var feature = event.feature;
    if (feature.modified){
        alertmsg("Movido");
        feature.attributes.img  = baseimg;
        feature.attributes.usuario  = iduser;
    }
    if (feature.popup){
        map.removePopup(feature.popup);
    }
}

function eliminacd(cve_def){
    var feature;
    var l=wfs.features.length-1;
    for(var i=0; i<=l; i++) {
        if (wfs.features[i].state!=OpenLayers.State.DELETE){
            cve=wfs.features[i].attributes.cve_ent+wfs.features[i].attributes.cve_mun+wfs.features[i].attributes.cve_loc+wfs.features[i].attributes.cve_ageb+wfs.features[i].attributes.cve_mza;
            if (cve==cve_def){
                feature = wfs.getFeatureBy('fid', wfs.features[i].fid);
                if(feature.fid == undefined) {
                    this.layer.destroyFeatures([feature]);
                } else {
                    feature.renderIntent = "select";
                    //this.layer.drawFeature(feature);
                    feature.state = OpenLayers.State.UPDATE;
                    feature.attributes.ban  = 'X';
                    feature.attributes.img  = baseimg;
                    feature.attributes.usuario  = iduser;
                    feature.attributes.vienede  = vienedegid;
                    feature.attributes.proy=obtProy;
                    //voy a usar el campo pry de bandera para saber los que son 45
                    wfs.eraseFeatures(feature);
                }
                //break;
            }
       }//if != delete
    }//for
}


//FUNCION QUE ELIMINA UNA MANZANA// ****************************************************************************************************************
var DeleteFeatureCd = OpenLayers.Class(OpenLayers.Control, {
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
            feature.state = OpenLayers.State.UPDATE;
            feature.attributes.ban  = 'X';
            feature.attributes.img  = baseimg;
            feature.attributes.usuario  = iduser;
        }

    },
    setMap: function(map) {
        this.handler.setMap(map);
        OpenLayers.Control.prototype.setMap.apply(this, arguments);
    },
    CLASS_NAME: "OpenLayers.Control.DeleteFeature"
});


//FUNCION QUE ELIMINA UNA MANZANA// ****************************************************************************************************************
var DeleteFeatureCdPol = OpenLayers.Class(OpenLayers.Control, {
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
    CLASS_NAME: "OpenLayers.Control.DeleteFeaturePEM"
});

// FUNCIONES QUE OCURREN AL GUARDAR CORRECTAMENTE O INCORRECTAMENTE LA CAPA DE MANANAS **********************************
function saveSuccessCd(){
    borra();
    alertmsg("Cambios guardados correctamente");
    // refresco la capa al guardar los cambios
    //wfs_cdpol.refresh({force: true});
    //wfs_cdpol.redraw(true);
    if (caserio_gen.getVisibility()){caserio_gen.redraw(true);}
    wfs.refresh({force: true});
    wfs.redraw(true);
    var ajax=nuevoAjax();
    ajax.open("GET",'valida_teCD.jsp?tipo=2&id='+iduser+'&filterid='+filterid, true);
    ajax.onreadystatechange=function()
    {
        if(ajax.readyState==4)  {
             var vale=ajax.responseText;
            if (parseInt(vale)==999){
                alertmsg ("No se pudo validar la TE");
            }else{
                if (parseInt(vale)>0){
                    document.getElementById('framecapas_te').src = "mostrar_te.jsp?&id="+iduser;
                    document.getElementById('ventana-flotante_te').className = 'mostrar_te';
                    setTimeout(function(){
                        document.getElementById('ventana-flotante_te').className = 'oculto_te';
                    }, 5000);
                }
            }
        }
    }
    ajax.send(null);
}



function saveSuccessCdpol(){
    // refresco la capa al guardar los cambios
    wfs_cdpol.refresh({force: true});
    wfs_cdpol.redraw(true);
}


function saveSuccessCdsimplify(){
    borra();
    alertmsg("Cambios guardados correctamente");
    // refresco la capa al guardar los cambios
    wfs.refresh({force: true});
    wfs.redraw(true);
    if (caserio_gen.getVisibility()){caserio_gen.redraw(true);}
}



function saveFailCd(e){
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
    alertmsg("Error al "+msg1+" caserio, no se guardo");
}

function saveFailCdpol(e){
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
    alertmsg("Error al "+msg1+" poligono, no se guardo");
}


////////// FUNCION PARA LOS CASOS ESPECIALES DE LA MANZANA //// ******************************************************************************************************
 function onFeatureSelectcdcasos(event){
// registrar el id del seleccionado para regresar movimientos

if (map.popups.length>0){
    onPopupClosemzCd();
}
var feature = event.feature;
idpop=feature.id;
var  theHTML = '<center>';
theHTML += '<table><tr><th colspan=2 class=label style="text-align:center">CASOS ESPECIALES';
theHTML += '<tr><th colspan=2 class=label style="text-align:center">-> Multiples Caserios <-';
theHTML += '<tr><td colspan=2>&nbsp;';
var theHTMLextra ='';
theHTML += '<tr><td style="text-align:center" colspan=2 class=label style="text-align:right">Codigo:&nbsp;<select onChange="cambiaCgoCd(\'' + feature.id + '\');" class=input id="ban_'+feature.id+'">';
theHTML += '<option value="0">Seleccione...';
theHTML += '<option value="2">2-Subdivision de Caserio';
theHTML += '<option value="3">3-Baja de Caserio';
theHTML += '<option value="5">5-Cambio de ageb';
theHTML += '<option value="6">6-Cambio de loc';
theHTML += '<option value="E">E-Conurbacion de loc';
theHTML += '<option value="D">D-Fusion de loc';
theHTML += '<option value="H">H-Cambio de mun';
theHTML += '<option value="G">G-Cambio de ageb';
theHTML += '<option value="I">I-Cambio de ent';
theHTML += '<option value="M">M-Creacion de mun';
theHTML += '<option value="N">N-Desconubracion de loc';
theHTML += '<option value="O">O-Desfusion loc';
//theHTML += '<option value="R">R-Baja de loc INEXISTENTE';
//theHTML += '<option value="T">T-Baja de loc TAPIAS/RUINAS';
//theHTML += '<option value="C">C-Baja de loc POR SERVICIO';
theHTML += '</select>';
theHTML += '<tr><td class=label style="text-align:right">Clave entidad:&nbsp;<td><input class=input id="cve_ent_'+feature.id+'" type="text" size="6" maxlength="2"  value="'+cve_ent+'" onkeypress="return datonumat(event)">';
theHTML += '<tr><td class=label style="text-align:right">Clave municipio:&nbsp;<td><input class=input id="cve_mun_'+feature.id+'" type="text" size="6" maxlength="3"  value="'+cve_mun+'" onkeypress="return datonumat(event)">';
theHTML += '<tr><td class=label style="text-align:right">Clave localidad:&nbsp;<td><input class=input id="cve_loc_'+feature.id+'" type="text" size="6" maxlength="4"  value="'+cve_loc+'" onkeypress="return datonumat(event)">';
theHTML += '<tr><td class=label style="text-align:right" nowrap>Clave ageb (con -):&nbsp;<td><input class=input id="cve_ageb_'+feature.id+'" type="text" size="6" maxlength="5"  value="'+cve_ageb+'" onkeypress="return datonumatageb(event)" onkeyup="return datonumatageb2(event)">';
theHTML += '<tr><td class=label style="text-align:right">Clave manzana:&nbsp;<td><input class=input id="cve_mza_'+feature.id+'" type="text" size="6" maxlength="4"  value="800" onkeypress="return datonumat(event)" readonly>';
theHTML += '<tr><td class=label style="text-align:right">Proyecto:&nbsp;<td><select class=input id="proy_'+feature.id+'">';
//theHTML += '<option value="0" title="Sin Proyecto">Seleccione...';
//theHTML += '<option value="1" title="Censos Economicos 2024">CE2024';
//theHTML += '<option value="2" title="Recorrido de Act del MGN 2014">RA2014';
//theHTML += '<option value="3" title="Encuesta Intercensal 2025">EI2025';
//theHTML += '<option value="4" title="Cartografia Participativa">CP';
//theHTML += '<option value="5" title="Carta Topografica">CT';
//theHTML += '<option value="6" title="Censos de Escuelas Maestros y Alumnos de Educacion Basica y Especial">CEMABE2013';
//theHTML += '<option value="7" title="Actualizacion Permanente del MG 2016">AP2016';
//theHTML += '<option value="8" title="Registro Unico de Viviendas 2016">RUV2016';
//theHTML += '<option value="9" title="Registro Unico de Viviendas 2014">RUV';
//theHTML += '<option value="10" title="Actualizacion Permanente del MG 2015">AP';
//theHTML += '<option value="11" title="Registro Unico de Viviendas 2015">RUV2015';
//theHTML += '<option value="12" title="Instituto Nacional Electoral 2016">INE';
//theHTML += '<option value="13" title="Marco Nacional de Viviendas">MNV';
//theHTML += '<option value="14"  selected title="Actualizacion Permanente del MG 2025">AP2025';
//theHTML += '<option value="15" title="Actualizacion por BCUU">BCUU';
theHTML += '<option value="16" selected title="Actualizacion Integral">ACI';
//theHTML += '<option value="17" title="Censo Agropecuario">CA22';

theHTML += '</select>';
theHTML += '<tr><td colspan=2>&nbsp;<tr><td style="text-align:center" colspan=2><input id="updatecasosinput'+feature.id+'" onclick="updateCasosCd(\'' + feature.id + '\');" class=input type="button" name="enviar" value="Agregar a TE">';
theHTML += '</center>';
var botcierra=true;
if (map.getExtent().containsLonLat(feature.geometry.getBounds().getCenterLonLat())){
    var varcent=feature.geometry.getBounds().getCenterLonLat();
}else{
    var varcent=map.getCenter();
}

    feature.popup = new OpenLayers.Popup.AnchoredBubble
    ("pop", varcent, new OpenLayers.Size(280,210),
    theHTML,    null,   botcierra    //este false es el boton de cerrar
       ,onPopupClosemzCd                //funcion al cerrar
    );
    feature.popup.opacity=0.9;
    feature.popup.backgroundColor="#FE642E";
    map.addPopup(feature.popup);
    document.getElementById("pop").style.zIndex = "999";
}

//FUNCION HACE UN UPDATE DE LOS CASES ESPECIALES DE MANZANA// ****************************************************************************************************************
function updateCasosCd(id){
    alertmsg ("Espere hasta que se cierre la ventana");
    var feature = wfs.getFeatureBy('id', id);
    eval ('ban = document.getElementById("ban_'+ id+'").value;');
    eval ('cve_ent = document.getElementById("cve_ent_'+ id+'").value;');
    eval ('cve_mun = document.getElementById("cve_mun_'+ id+'").value;');
    eval ('cve_loc = document.getElementById("cve_loc_'+ id+'").value;');
    eval ('cve_ageb = document.getElementById("cve_ageb_'+ id+'").value;');
    eval ('cve_mza = document.getElementById("cve_mza_'+ id+'").value;');
    eval ('proy = document.getElementById("proy_'+ id+'").value;');
    cve_ageb=cve_ageb.toUpperCase();

    if (!(ban=='R' || ban=='T' || ban=='C' || ban=='3')){
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

    if (ban==0){
         alertmsg("Seleccione un codigo");
         return false;
    }
    eval ('document.getElementById("updatecasosinput'+id+'").disabled=true;');
    var ajax=nuevoAjax();
    ajax.open("GET",'mod_casosCd.jsp?cgo='+ban+'&cve_ent='+cve_ent+'&cve_mun='+cve_mun+'&cve_loc='+cve_loc+'&cve_mza='+cve_mza+'&cve_ageb='+cve_ageb+'&img='+baseimg+'&proy='+proy+'&us='+iduser+'&geom='+feature.geometry.toString(), true);
    ajax.onreadystatechange=function()
    {
        if(ajax.readyState==4)  {
             var vale=parseInt(ajax.responseText);
               map.removePopup(feature.popup);
                switch (vale){ //casos en que regresa mod_casos que segun el codigo si genera error o no aqui lo controlo
                    case 0:   //error
                            alertmsg ("No se pudo obtener la Mz");
                            wfs.destroyFeatures([feature]);
                            break;
                    case 1:   //codigos 5,6,E,D,H,I,,M,N,O,Y
                            saveSuccessMz();
                            break;
                    case 2:   //K,R,T,C
                            saveSuccessMz();
                            break;
                    case 9:   //no existe la clave de localidad
                            alertmsg ("No existe la clave de localidad");
                            wfs.destroyFeatures([feature]);
                            break;
                }
        }
    }
    ajax.send(null);
}

//funcion al cerrar el popup de cualquier tipo
function onPopupClosemzCd(){
    var feature = wfs.getFeatureBy('id', idpop);
    if (feature!=null){
        map.removePopup(feature.popup);
        if (drawmz.active || drawmzcasos.active){
            wfs.destroyFeatures([feature]);
        }
    }
}

function cambiaCgoCd(id){
    eval ('ban = document.getElementById("ban_'+ id+'").value;');
    if (ban=='3' || ban=='R' || ban=='T' || ban=='C'){
        eval ('document.getElementById("cve_ent_'+ id+'").value="00";');
        eval ('document.getElementById("cve_mun_'+ id+'").value="000";;');
        eval ('document.getElementById("cve_loc_'+ id+'").value="0000";;');
        eval ('document.getElementById("cve_ageb_'+ id+'").value="000-0";;');
        eval ('document.getElementById("cve_ent_'+ id+'").disabled=true;');
        eval ('document.getElementById("cve_mun_'+ id+'").disabled=true;');
        eval ('document.getElementById("cve_loc_'+ id+'").disabled=true;');
        eval ('document.getElementById("cve_ageb_'+ id+'").disabled=true;');
    }else{
        eval ('var val=document.getElementById("cve_ent_'+ id+'").disabled;');
        if (val){
            eval ('document.getElementById("cve_ent_'+ id+'").value="'+cve_ent+'";');
            eval ('document.getElementById("cve_mun_'+ id+'").value="'+cve_mun+'";;');
            eval ('document.getElementById("cve_loc_'+ id+'").value="'+cve_loc+'";;');
            eval ('document.getElementById("cve_ageb_'+ id+'").value="'+cve_ageb+'";;');
            eval ('document.getElementById("cve_ent_'+ id+'").disabled=false;');
            eval ('document.getElementById("cve_mun_'+ id+'").disabled=false;');
            eval ('document.getElementById("cve_loc_'+ id+'").disabled=false;');
            eval ('document.getElementById("cve_ageb_'+ id+'").disabled=false;');
        }
    }
}

function buscazoomtecd(val,geom){
var geometry = OpenLayers.Geometry.fromWKT(geom);
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
    s0=geometry.x-500;    //ccl , merctor
    s1=geometry.y-500;
    s2=geometry.x+500;
    s3=geometry.y+500;
bounds = new OpenLayers.Bounds(s0,s1,s2,s3);
map.zoomToExtent(bounds);
//map.zoomToExtent(geometry.bounds);
//map.zoomTo(12);
map.controls[0].redraw;
}



//FUNCIONES QUE AGREGA MANZANAS DEL MCC// ****************************************************************************************************************


function agregacd(tip,cgo,geom,conviv){
    var tipoproy=0;
    var feature;
    var geompol = OpenLayers.Geometry.fromWKT(geom);
    //var geompol = new OpenLayers.Geometry.MultiPolygon(OpenLayers.Geometry.fromWKT(geom));
            mcc=1;
            agrmz=1;   //agrmz= 1 creacion, 2 subdivision , 3 suvidivide de varias 
            cve_ent=cvedef.substring(0, 2);
            cve_mun=cvedef.substring(2, 5);
            cve_loc=cvedef.substring(5, 9);
            cve_ageb=cvedef.substring(9, 14);
            cve_mza=cvedef.substring(14, 17);
            wfs.addFeatures([new OpenLayers.Feature.Vector(geompol)]);
            var n=wfs.features.length-1;
            wfs.features[n].state=OpenLayers.State.INSERT;
            feature = wfs.getFeatureBy('fid', wfs.features[n].fid);
            feature.attributes.vienede=vienedegid;
            feature.attributes.proy=obtProy;
            feature.attributes.ban='4';
            mcc=0;
            onFeatureSelectcd(feature);
            //modiatmz.selectControl.select(feature);*/

//agrmz=0;
}



function casigna_cd1(cgo,point){
    var feature;
    var geompoint = OpenLayers.Geometry.fromWKT(point);
    var intersects12,ban,i;
    var l=wfs.features.length-1;
    var jsts_parser = new jsts.io.OpenLayersParser();


   var jsts_geomA  = jsts_parser.read(geompoint);

   for(var i=0; i<=l; i++) {
    if (wfs.features[i].state!=OpenLayers.State.DELETE){
        var jsts_geomB  = jsts_parser.read(wfs.features[i].geometry);
        intersects12 = jsts_geomA.intersects(jsts_geomB.buffer(50));
          if(intersects12){
            feature = wfs.getFeatureBy('fid', wfs.features[i].fid);
            feature.attributes.usuario  = iduser;
            feature.attributes.vienede=vienedegid;
            feature.attributes.proy=obtProy;
            if (feature.state!=OpenLayers.State.INSERT){
                feature.state = OpenLayers.State.UPDATE;
            }
            break;
        }//if intersect
    }//if != delete
  }//for
}





 function onFeatureSelectCdsimplify(event){
// registrar el id del seleccionado para regresar movimientos

if (map.popups.length>0){
    onPopupClosemzCdsimplify();
}
var feature = event.feature;
idpop=feature.id;
var  theHTML = '<center>';
theHTML += '<table><tr><th colspan=2 class=label style="text-align:center">SIMPLIFICAR CASERIOS';
theHTML += '<tr><td colspan=2>&nbsp;';
var theHTMLextra ='';
theHTML += '<tr><td style="text-align:center" colspan=2 class=label style="text-align:right">Tolerancia:&nbsp;<select class=input id="tole_'+feature.id+'">';
theHTML += '<option value="0">Reiniciar';
theHTML += '<option value="250">250 Metros';
theHTML += '<option value="500" selected>500 Metros';
//theHTML += '<option value="1000">1000</select>';
theHTML += '<tr><td class=label colspan=2 style="text-align:center">&nbsp;';
theHTML += '<tr><td class=label style="text-align:right">Clave entidad:&nbsp;<td><input class=input id="cve_ent_'+feature.id+'" type="text" size="6" maxlength="2"  value="'+feature.attributes.cve_ent+'" readonly>';
theHTML += '<tr><td class=label style="text-align:right">Clave municipio:&nbsp;<td><input class=input id="cve_mun_'+feature.id+'" type="text" size="6" maxlength="3"  value="'+feature.attributes.cve_mun+'" readonly>';
theHTML += '<tr><td class=label style="text-align:right">Clave localidad:&nbsp;<td><input class=input id="cve_loc_'+feature.id+'" type="text" size="6" maxlength="4"  value="'+feature.attributes.cve_loc+'" readonly>';
theHTML += '<tr><td colspan=2>&nbsp;<tr><td style="text-align:center" colspan=2><input id="updateCdsimplify'+feature.id+'" onclick="updateCdsimplify(\'' + feature.id + '\');" class=input type="button" name="enviar" value="Procesar">';
theHTML += '</center>';
var botcierra=true;
if (map.getExtent().containsLonLat(feature.geometry.getBounds().getCenterLonLat())){
    var varcent=feature.geometry.getBounds().getCenterLonLat();
}else{
    var varcent=map.getCenter();
}

    feature.popup = new OpenLayers.Popup.AnchoredBubble
    ("pop", varcent, new OpenLayers.Size(280,180),
    theHTML,    null,   botcierra    //este false es el boton de cerrar
       ,onPopupClosemzCdsimplify                //funcion al cerrar
    );
    feature.popup.opacity=0.9;
    feature.popup.backgroundColor="#BBCCFF";
    map.addPopup(feature.popup);
    document.getElementById("pop").style.zIndex = "999";
    obtCvePelocsimplify(feature);
}

//FUNCION HACE UN UPDATE DE LOS CASES ESPECIALES DE MANZANA// ****************************************************************************************************************
function updateCdsimplify(id){
    alertmsg ("Espere hasta que se cierre la ventana");
    var feature = pointLayeralt.getFeatureBy('id', id);
    eval ('cve_ent = document.getElementById("cve_ent_'+ id+'").value;');
    eval ('cve_mun = document.getElementById("cve_mun_'+ id+'").value;');
    eval ('cve_loc = document.getElementById("cve_loc_'+ id+'").value;');
    eval ('tole = document.getElementById("tole_'+ id+'").value;');
    eval ('document.getElementById("updateCdsimplify'+id+'").disabled=true;');
    var ajax=nuevoAjax();
    ajax.open("GET",'cd_simplify.jsp?cve_ent='+cve_ent+'&cve_mun='+cve_mun+'&cve_loc='+cve_loc+'&us='+iduser+'&tole='+tole, true);
    ajax.onreadystatechange=function()
    {
        if(ajax.readyState==4)  {
             var vale=parseInt(ajax.responseText);
               map.removePopup(feature.popup);
                switch (vale){ //
                    case 0:   //error
                            alertmsg ("No se pudo simplificar el CD");
                            break;
                    case 1:
                            saveSuccessCdsimplify();
                            break;
                }
        }
    }
    ajax.send(null);
}



function obtCvePelocsimplify(feature){
    var id=feature.id;
    var geom=feature.geometry.toString();
    var ajax=nuevoAjax();
    eval ('cve_ent = document.getElementById("cve_ent_'+ id+'").value;');
    eval ('cve_mun = document.getElementById("cve_mun_'+ id+'").value;');
    eval ('cve_loc = document.getElementById("cve_loc_'+ id+'").value;');
    var cveconca=cve_ent+cve_mun+cve_loc;
    ajax.open("GET",'obtcve.jsp?tipo=pesimplify&geom='+geom+'&clave='+cveconca, true);
    ajax.onreadystatechange=function()
    {
        if(ajax.readyState==4)  {
             var vale=String(ajax.responseText).trim();
            if (vale=="0" || vale==0){
                alertmsg ("No se pudo obtener la clave de Loc");
                eval ("document.getElementById('cve_ent_"+ id+"').value='00';");
                eval ("document.getElementById('cve_mun_"+ id+"').value='000';");
                eval ("document.getElementById('cve_loc_"+ id+"').value='0000';");

            }else{
                eval ('document.getElementById("cve_ent_'+ id+'").value="'+(vale.substring(0,2))+'";');
                eval ('document.getElementById("cve_mun_'+ id+'").value="'+(vale.substring(2,5))+'";');
                eval ('document.getElementById("cve_loc_'+ id+'").value="'+(vale.substring(5,9))+'";');
            }
        }
    }
    ajax.send(null);
}


function onPopupClosemzCdsimplify(){
    var feature = pointLayeralt.getFeatureBy('id', idpop);
    if (feature!=null){
        map.removePopup(feature.popup);
        if (cdsimplify.active){
            pointLayeralt.destroyFeatures([feature]);
        }
    }
}
