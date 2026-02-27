

////////// FUNCION PARA LA SELECCION DE LA MANZANA //// ******************************************************************************************************
var obtProy=14;

var modifm,modifm2,wfsfm,panelfm;

 function onFeatureSelectmz(event){


// registrar el id del seleccionado para regresar movimientos
  if (map.popups.length>0){
    onPopupClosemzall();
}
 var feature = event.feature;
 idpop=feature.id;
//reviso si esta seleccionado el boton de frentes de manzana
if (editarfm.active){
    trbuteditarfm(feature);
    return false;
}

//reviso si esta seleccionado el boton de fusion de manzana y ejecuto el trigger
if (fusmz.active){
    fusiona();
    return false;
}




//console.log(feature);
/*if (wfsmov.length>0){
    if (wfsmov.indexOf(feature.id)<0){
     wfsmov.push(feature.id);
    }
}else{
    wfsmov.push(feature.id);
}
*/
    var temp_cve=feature.attributes.cve_temp;
if (feature.attributes.ban!='0' && feature.attributes.ban!=undefined){
    //// aqui valido segun el codigo que trae ya no se pueden hacer ciertos codigos posteriores.
    //drawmz.active = 4,A,B        modiatmz.active = 5,6,E,D,H,I,M,N,O ,Y           submz.active = 2            drawsub.active = 2
    // los codigos 3 y 1, baja y fusion como ya no existe la manzana ya no debe entrar aqui.
    switch (feature.attributes.ban){
        case '4':
        case 'A':
        case 'B':
        case '2':
            if (modiatmz.active){
                alertmsg("La manzana tiene codigo "+feature.attributes.ban + " no se puede cambiar");
                return false;
            }
            break;
        case '5':
        case '6':
        case 'Y':
        case 'E':
        case 'D':
        case 'H':
        case 'G':
        case 'I':
        case 'M':
        case 'N':
        case 'O':
            if (modiatmz.active){
                alertmsg("La manzana tiene codigo "+feature.attributes.ban + " no se puede cambiar");
                return false;
            }
            break;
    }

}
if (drawmz.active || modiatmz.active || submz.active || drawsub.active || butagmz.active){
    if (modiatmz.active || submz.active || butagmz.active){
        if (!(feature.state == OpenLayers.State.INSERT && feature.attributes.ban=='2')){   //ban 2
            if (feature.state != OpenLayers.State.INSERT){
                temp_cve=feature.data.cve_ent+feature.data.cve_mun+feature.data.cve_loc+feature.data.cve_ageb+feature.data.cve_mza;
            }else{
                temp_cve=feature.attributes.cve_ent+feature.attributes.cve_mun+feature.attributes.cve_loc+feature.attributes.cve_ageb+feature.attributes.cve_mza;
            }
        }// ban 2
    }
if (!(feature.state == OpenLayers.State.INSERT && feature.attributes.ban=='2')){   //ban 2
    if (feature.fid==null){   //insert
        feature.attributes.cve_ent=cve_ent;
        feature.attributes.cve_mun=cve_mun;
        feature.attributes.cve_loc=cve_loc;
        feature.attributes.cve_ageb=cve_ageb;
        if (agrmz==1 && mcc==1){
            feature.attributes.cve_mza=cve_mza;
            mcc=0;
        }else{
            feature.attributes.cve_mza='000';
        }
    }
}
var  theHTML = '<center>';
theHTML += '<table><tr><th colspan=2 class=label style="text-align:center">ATRIBUTOS';
theHTML += '<tr><td colspan=2>&nbsp;';
var theHTMLextra ='';
var theHTMLextra2 ='';
if (modiatmz.active){
    var opt5='',opt6='',optE='',optD='',optH='',optI='',optM='',optN='',optO='',optY='',optG='';
    var arrban = ["5","6","E","D","H","G","I","M","N","O","Y"];
    if (arrban.indexOf(feature.attributes.ban)>-1){
        switch (feature.attributes.ban){
            case '5':opt5=' selected ';break;
            case '6':opt6=' selected ';break;
            case 'E':optE=' selected ';break;
            case 'D':optD=' selected ';break;
            case 'H':optH=' selected ';break;
            case 'G':optH=' selected ';break;
            case 'I':optI=' selected ';break;
            case 'M':optM=' selected ';break;
            case 'N':optN=' selected ';break;
            case 'O':optO=' selected ';break;
            case 'Y':optY=' selected ';break;
        }
    }else{
        switch (cod_mz){
            case '5':opt5=' selected ';break;
            case '6':opt6=' selected ';break;
            case 'E':optE=' selected ';break;
            case 'D':optD=' selected ';break;
            case 'H':optH=' selected ';break;
            case 'G':optG=' selected ';break;
            case 'I':optI=' selected ';break;
            case 'M':optM=' selected ';break;
            case 'N':optN=' selected ';break;
            case 'O':optO=' selected ';break;
            case 'Y':optY=' selected ';break;
        }
    }
    if (feature.state != OpenLayers.State.INSERT){
        theHTML += '<tr><td class=label style="text-align:right">Codigo:&nbsp;<td><select class=input id="ban_'+feature.id+'">';
        theHTML += '<option value="0">Seleccione...';
        theHTML += '<option value="5" '+opt5+'>5-Cambio ageb U';
        theHTML += '<option value="6" '+opt6+'>6-Cambio loc';
        theHTML += '<option value="E" '+optE+'>E-Conurba loc';
        theHTML += '<option value="D" '+optD+'>D-Fusion loc';
        theHTML += '<option value="H" '+optH+'>H-Cambio mun';
        theHTML += '<option value="G" '+optG+'>G-Cambio ageb';
        theHTML += '<option value="I" '+optI+'>I-Cambio ent';
        theHTML += '<option value="M" '+optM+'>M-Creacion mun';
        theHTML += '<option value="N" '+optN+'>N-Desconurba loc';
        theHTML += '<option value="O" '+optO+'>O-Desfusion loc';
        theHTML += '<option value="Y" '+optY+'>Y-Consolida ageb';
        theHTML += '</select>';
    }else{
        if (feature.attributes.ban=='2'){ //subdivision
            theHTML += '<tr><td class=label style="text-align:right">Codigo:&nbsp;<td><input class=input id="ban_'+feature.id+'" type="text" size=2 readOnly value="2" >';
        //}else if (feature.attributes.ban=='4' || feature.attributes.ban=='A' || feature.attributes.ban=='B'){ //creacion

            //TEMPORALMENTE AGREGO EL CODIGO 1 FUSION EL NUEVO POLIGONO CUBRE LAS MANZANAS A FUSIONAR
          }else if (feature.attributes.ban=='1' || feature.attributes.ban=='4' || feature.attributes.ban=='A' || feature.attributes.ban=='B'){ //creacion
            var opt1='', opt4='',optA='',optB='';
            switch (cod_mz){
                case '1':opt1=' selected ';break;
                case '4':opt4=' selected ';break;
                case 'A':optA=' selected ';break;
                case 'B':optB=' selected ';break;
            }
            theHTML += '<tr><td class=label style="text-align:right">Codigo:&nbsp;<td><select class=input id="ban_'+feature.id+'">';
            theHTML += '<option value="4" '+opt4+'>Creacion de Mz';
            //theHTML += '<option value="A" '+optA+'>A-Creacion de Ageb';
            //theHTML += '<option value="B" '+optB+'>B-Creacion de Loc';
            theHTML += '</select>';
        }else if (feature.attributes.ban=='S'){  //subdivision de varias manzanas
            theHTML += '<tr><td class=label style="text-align:right">Codigo:&nbsp;<td><input class=input id="ban_'+feature.id+'" type="text" size=2 readOnly value="S">';
            theHTML += '&nbsp;&nbsp;&nbsp;<input onclick="crearHueco(\'' + feature.id + '\');" class=input type="button" name="enviar" value="Hueco">';
            theHTMLextra = '&nbsp;Buffer:&nbsp;<input class=input id="buf_'+feature.id+'" type="text" size=2 value="1" title="Buffer en metros">&nbsp;&nbsp;&nbsp;'
        }
    }
}else if (submz.active){  //ban=2  //subdivision
    theHTML += '<tr><td class=label style="text-align:right">Codigo:&nbsp;<td><input class=input id="ban_'+feature.id+'" type="text" size=2 readOnly value="2">';
    theHTML += '&nbsp;&nbsp;&nbsp;<input onclick="cearCorte(\'' + feature.id + '\');" class=input type="button" name="enviar" value="Corte">';
    theHTMLextra = '<input onclick="switchMza()" class=input type="button" name="Switch" value="Switch">&nbsp;&nbsp;&nbsp;';
    //theHTMLextra2 += '&nbsp;&nbsp;&nbsp;<input onclick="updateAttributes(\'' + feature.id + '\',2);" class=input type="button" name="enviar" value="Temporal">';
}else if (drawmz.active){  // ban=4  //creacion
    theHTML += '<tr><td class=label style="text-align:right">Codigo:&nbsp;<td><select class=input id="ban_'+feature.id+'">';
    theHTML += '<option value="4">Creacion de Mz';
    //theHTML += '<option value="A">A-Creacion de Ageb';
    //theHTML += '<option value="B">B-Creacion de Loc';
    theHTML += '</select>';
}else if ((butagmz.active) && agrmz==1){  // ban=4  //creacion por medio de mcc
    var opt1='', opt4='',optA='',optB='';
            switch (String(feature.attributes.ban)){
                case '1':opt1=' selected ';break;
                case '4':opt4=' selected ';break;
                case 'A':optA=' selected ';break;
                case 'B':optB=' selected ';break;
            }
            theHTML += '<tr><td class=label style="text-align:right">Codigo:&nbsp;<td><select class=input id="ban_'+feature.id+'">';
            theHTML += '<option value="4" '+opt4+'>Creacion de Mz';
            //theHTML += '<option value="A" '+optA+'>A-Creacion de Ageb';
            //theHTML += '<option value="B" '+optB+'>B-Creacion de Loc';
    theHTML += '</select>';
}else if ((butagmz.active) && agrmz==2){  // ban=2   //subdivision medio de mcc
    theHTML += '<tr><td class=label style="text-align:right">Codigo:&nbsp;<td><input class=input id="ban_'+feature.id+'" type="text" size=2 readOnly value="2">';
    theHTML += '&nbsp;&nbsp;&nbsp;<input onclick="cearCorte(\'' + feature.id + '\');" class=input type="button" name="enviar" value="Corte">';
    //theHTMLextra = '<input onclick="switchMza()" class=input type="button" name="Switch" value="Switch">&nbsp;&nbsp;&nbsp;';
    //theHTMLextra2 += '&nbsp;&nbsp;&nbsp;<input onclick="updateAttributes(\'' + feature.id + '\',2);" class=input type="button" name="enviar" value="Temporal">';
}else if ((butagmz.active) && agrmz==3){  // ban=S   //subdivision de varias manzanas
    theHTML += '<tr><td class=label style="text-align:right">Codigo:&nbsp;<td><input class=input id="ban_'+feature.id+'" type="text" size=2 readOnly value="S">';
    theHTML += '&nbsp;&nbsp;&nbsp;<input onclick="crearHueco(\'' + feature.id + '\');" class=input type="button" name="enviar" value="Hueco">';
    theHTMLextra = '&nbsp;Buffer:&nbsp;<input class=input id="buf_'+feature.id+'" type="text" size=2 value="1" title="Buffer en metros">&nbsp;&nbsp;&nbsp;'
    theHTMLextra2 += '&nbsp;&nbsp;&nbsp;<input onclick="cambia_codigo2(\'' + feature.id + '\');" class=input type="button" name="enviar" value="Codigo 2">';
}else if (drawsub.active){  // ban=S   //subdivision de varias manzanas
    theHTML += '<tr><td class=label style="text-align:right">Codigo:&nbsp;<td><input class=input id="ban_'+feature.id+'" type="text" size=2 readOnly value="S">';
    theHTML += '&nbsp;&nbsp;&nbsp;<input onclick="crearHueco(\'' + feature.id + '\');" class=input type="button" name="enviar" value="Hueco">';
    theHTMLextra = '&nbsp;Buffer:&nbsp;<input class=input id="buf_'+feature.id+'" type="text" size=2 value="1" title="Buffer en metros">&nbsp;&nbsp;&nbsp;'
    theHTMLextra2 += '&nbsp;&nbsp;&nbsp;<input onclick="cambia_codigo2(\'' + feature.id + '\');" class=input type="button" name="enviar" value="Codigo 2">';
}
theHTML += '<tr><td class=label style="text-align:right">Clave entidad:&nbsp;<td><input class=input id="cve_ent_'+feature.id+'" type="text" size="6" maxlength="2"  value="'+feature.attributes.cve_ent+'" onkeypress="return datonumat(event)">';
theHTML += '<tr><td class=label style="text-align:right">Clave municipio:&nbsp;<td><input class=input id="cve_mun_'+feature.id+'" type="text" size="6" maxlength="3"  value="'+feature.attributes.cve_mun+'" onkeypress="return datonumat(event)">';
theHTML += '<tr><td class=label style="text-align:right">Clave localidad:&nbsp;<td><input class=input id="cve_loc_'+feature.id+'" type="text" size="6" maxlength="4"  value="'+feature.attributes.cve_loc+'" onkeypress="return datonumat(event)">';
theHTML += '<tr><td class=label style="text-align:right" nowrap>Clave ageb (con -):&nbsp;<td><input class=input id="cve_ageb_'+feature.id+'" type="text" size="6" maxlength="5"  value="'+feature.attributes.cve_ageb+'" onkeypress="return datonumatageb(event)" onkeyup="return datonumatageb2(event)">';
theHTML += '<tr><td class=label style="text-align:right">Clave manzana:&nbsp;<td><input class=input id="cve_mza_'+feature.id+'" type="text" size="3" maxlength="3"  value="'+feature.attributes.cve_mza+'" onkeypress="return datonumat(event)">';
theHTML += '&nbsp;<input title="Obtener siguiente clave de manzana POR CLAVE" onclick="obtCveMza(\'' + feature.id + '\');" class="input" type="button" id="obtcvemza'+feature.id+'" name="obtcvemza'+feature.id+'" value="Cve">';
theHTML += '&nbsp;<input title="Obtener siguiente clave de manzana POR SOBREPOSICION" onclick="obtCveMzaGeo(\'' + feature.geometry.getCentroid() + '\',\'' + feature.id + '\');" class="input" type="button" id="obtcvemzageo'+feature.id+'" name="obtcvemzageo'+feature.id+'" value="Geo">';
if (feature.attributes.tipomza==undefined){
    feature.attributes.tipomza=4;
}else{
    if (feature.attributes.tipomza==''){
        feature.attributes.tipomza=4;
    }
}
for (j=0;j<=12;j++){
    eval ('var timz'+j+'="";');
    if (parseInt(feature.attributes.tipomza)==j){
        eval ('var timz'+j+'=" selected ";');
    }
}




theHTML += '<tr><td class=label style="text-align:right">Tipo Manzana:&nbsp;<td><select class=input id="tipomza_'+feature.id+'">';
        theHTML += '<option value="0" '+timz0+' title="Sin Tipo">Seleccione...';
        theHTML += '<option value="1" '+timz1+' title="Contenedora">Contenedora';
        theHTML += '<option value="2" '+timz2+' title="Contenida">Contenida';
        theHTML += '<option value="3" '+timz3+' title="Edificio-Manzana">Edificio-Manzana';
        theHTML += '<option value="4" '+timz4+' title="Tipica">Tipica';
        theHTML += '<option value="5" '+timz5+' title="Parque o Jardin">Parque o Jardin';
        theHTML += '<option value="6" '+timz6+' title="Glorieta">Glorieta';
        theHTML += '<option value="7" '+timz7+' title="Camellon">Camellon';
        theHTML += '<option value="8" '+timz8+' title="Bajo Puente">Bajo Puente';
        //theHTML += '<option value="9" '+timz9+' title="Caserio Disperso">Caserio Disperso';
        //theHTML += '<option value="10" '+timz10+' title="Proyectada">Proyectada';
        theHTML += '<option value="11" '+timz11+' title="Atipica">Atipica';
        theHTML += '<option value="12" '+timz12+' title="Economica">Economica';
        theHTML += '</select>';

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
//theHTML += '<option value="14" '+opy14+' title="Actualizacion Permanente del MG 2025">AP2025';
//theHTML += '<option value="15" '+opy15+' title="Actualizacion por BCUU">BCUU';
theHTML += '<option value="16" '+opy16+' title="Actualizacion Integral">ACI';

//if (!(drawmz.active)){   //solo para el MNV
//theHTML += '<option value="17" '+opy17+' title="Censo Agropecuario">CA22';
//}
theHTML += '</select>';
//theHTML += '<tr><td class=label style="text-align:right"># Inmuebles:';
//if (feature.attributes.inv==undefined || feature.attributes.inv==''){
 //       feature.attributes.inv=0;
   // }
//theHTML += '<td class=label style="text-align:left"><input class=input type="number" style="width: 4em;" id="inv_'+feature.id+'" value="'+feature.attributes.inv+'">';
if ((drawmz.active)){   //solo para el MNV
    //theHTML += '<tr><td class=label style="text-align:right">Id SILAVAC:&nbsp;<td><input class=input id="vienedeMNV_'+feature.id+'" type="text" size="6" maxlength="6"  value="0" onkeypress="return datonumat(event)">';

}else{
    //theHTML += '<input id="vienedeMNV_'+feature.id+'" type="hidden" value="">';

}
theHTML += '<input id="cve_temp_'+feature.id+'" type="hidden" value="'+temp_cve+'">';
theHTML += '<tr><td class=label colspan=2 style="text-align:center">&nbsp;';
theHTML += '<tr><td class=label colspan=2 style="text-align:center">';
if (feature.fid==null){   //insert
    feature.fid=feature.id;
}
theHTML += theHTMLextra;
theHTML += '<input onclick="updateAttributes(\'' + feature.id + '\',1);" class=input type="button" name="enviar" value="Guardar">';
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
    ("pop", varcent, new OpenLayers.Size(280,240),
    theHTML,    null,   botcierra    //este false es el boton de cerrar
       ,onPopupClosemz                //funcion al cerrar
    );
    feature.popup.opacity=0.9;
    feature.popup.backgroundColor="#BBCCFF";
    map.addPopup(feature.popup);
    document.getElementById("pop").style.zIndex = "999";
}
}

//FUNCION HACE UN UPDATE DE LOS DATOS DE MANZANA// ****************************************************************************************************************
function updateAttributes(id,temp){
    var feature = wfs.getFeatureBy('id', id);
    //var banant = feature.attributes.ban;
        eval ('ban = document.getElementById("ban_'+ id+'").value;');
        eval ('cve_ent = document.getElementById("cve_ent_'+ id+'").value;');
        eval ('cve_mun = document.getElementById("cve_mun_'+ id+'").value;');
        eval ('cve_loc = document.getElementById("cve_loc_'+ id+'").value;');
        eval ('cve_ageb = document.getElementById("cve_ageb_'+ id+'").value;');
        eval ('cve_mza = document.getElementById("cve_mza_'+ id+'").value;');
        eval ('cve_temp = document.getElementById("cve_temp_'+ id+'").value;');
        eval ('tipomza = document.getElementById("tipomza_'+ id+'").value;');
        eval ('proy = document.getElementById("proy_'+ id+'").value;');
        //eval ('vienedeMNV = document.getElementById("vienedeMNV_'+ id+'").value;');
        //eval ('inv = document.getElementById("inv_'+ id+'").value;');
        // uso inv para que active lo de los frentes
        cve_ageb=cve_ageb.toUpperCase();
        if (temp==2){
            cve_mza = "TTT";
        }

var inve=1; //variable para cambiar los frentes solo lo cambio a cero cuando no escojen un codigo que en teoria es cambio de tipo o poryecto
// validaciones de campos segun el codigo
if (ban=='4' || ban=='1' || ban=='A' || ban=='B' || ban=='2' || ban=='S' || ban=='5' || ban=='6' || ban=='Y' || ban=='E' || ban=='D' || ban=='H' || ban=='G' || ban=='M' || ban=='I' || ban=='N' || ban=='O'){
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
            }else if (cve_mza=='800'){
                alertmsg("Clave de manzana no debe ser 800");
                return false;
            }
}
switch (ban){
    case '4':
    case 'A':
    case 'B':
            /*if ((drawmz.active)){   //solo para el MNV
                 if (vienedeMNV=='0' || vienedeMNV==null || vienedeMNV==''){
                    alertmsg("El GID del MNV no debe ser 0 o vacio");
                    return false;
                }else{
                    cve_temp  = "mnv"+vienedeMNV;
                }
            }*/

        cod_mz=ban;break;
    case '1':
        cod_mz=ban;break;
        //validacion codigo 4
    case '2':
        //validacion codigo 2
        break;
    case 'S':
        //validacion codigo S
         //eval ('cve_temp = document.getElementById("cve_temp_'+ id+'").value;');
         eval ('cve_temp = document.getElementById("buf_'+ id+'").value;');
        break;
    case '5':
        if (cve_temp.substring(0,9)!=cve_ent+cve_mun+cve_loc){
            alertmsg("Clave de localidad debe ser igual");
            return false;
        }else if (cve_temp.substring(9,14)==cve_ageb){
            alertmsg("Clave de ageb debe ser diferente");
            return false;
        }
        cod_mz=ban;break;
    case 'Y':
        if (cve_temp.substring(0,14)==cve_ent+cve_mun+cve_loc+cve_ageb){
            alertmsg("Clave de ageb debe ser diferente");
            return false;
        }
        cod_mz=ban;break;
    case '6':
    case 'E':
    case 'D':
    case 'N':
    case 'O':
        if (cve_temp.substring(0,9)==cve_ent+cve_mun+cve_loc){
            alertmsg("Clave de localidad debe ser diferente");
            return false;
        }
        cod_mz=ban;break;
    case 'H':
    case 'M':
        if (cve_temp.substring(0,5)==cve_ent+cve_mun){
            alertmsg("Clave de municipio debe ser diferente");
            return false;
        }
        cod_mz=ban;break;
    case 'G':
        if (cve_temp.substring(0,14)==cve_ent+cve_mun+cve_loc+cve_ageb){
            alertmsg("Clave de ageb debe ser diferente");
            return false;
        }
        cod_mz=ban;break;
    case 'I':
        if (cve_temp.substring(0,5)==cve_ent+cve_mun){
            alertmsg("Clave de entidad debe ser diferente");
            return false;
        }
        cod_mz=ban;break;
    default:
        cve1= feature.attributes.cve_ent+feature.attributes.cve_mun+feature.attributes.cve_loc+feature.attributes.cve_ageb+feature.attributes.cve_mza;
        cve2= cve_ent+cve_mun+cve_loc+cve_ageb+cve_mza;
        if (cve1!=cve2){
            alertmsg("Seleccione un codigo");
            feature.state=null;
            return false;
        }else{
            inve=0;
        }
        break;
}
if(feature.state != OpenLayers.State.INSERT) {
        feature.state = OpenLayers.State.UPDATE;
}else{   //si es inseert
  feature.attributes.inv_fte  = '2';     //le estoy poniendo 2 para la EIC pero debe ir 0
}
    feature.attributes.cve_ent  = cve_ent;
    feature.attributes.cve_mun  = cve_mun;
    feature.attributes.cve_loc  = cve_loc;
    feature.attributes.cve_ageb  = cve_ageb;
    feature.attributes.cve_mza  = cve_mza;
    feature.attributes.ban  = ban;
    feature.attributes.img  = baseimg;
    feature.attributes.tipomza  = tipomza;
    feature.attributes.proy  = proy;
    feature.attributes.usuario  = iduser;
    feature.attributes.cve_temp  = cve_temp;
    //feature.attributes.inv = inv;
    feature.attributes.inv = inve;
    //feature.attributes.inv_us = iduser;
    feature.attributes.inv_img  = map.getScale();
    //feature.attributes.inv_fte  = 'C';
    map.removePopup(feature.popup);
     if(modiatmz.active || submz.active || butagmz.active) {
        modiatmz.selectControl.unselect(feature);
    }
    if (temp==2){
            alertmsg ("Debe de guardar el cambio temporal antes de fusionar");
    }
    /*mzamax=parseInt(cve_mza);
    cvemax=cve_ent+cve_mun+cve_loc+cve_ageb;*/
    cvemax=cvemax+',\''+mztemp+'\'';
    if (cambiacod2==1 ){
        cambiacod2=0;
        submz.deactivate();
        drawsub.activate();
    }
}

//FUNCION QUE OBTIENE LA ULTIMA CLAVE DE MANZANA DEL AGEB POR CLAVE
function obtCveMza(id){
    mztemp='';
    var ajax=nuevoAjax();
    eval ('cve_ent = document.getElementById("cve_ent_'+ id+'").value;');
    eval ('cve_mun = document.getElementById("cve_mun_'+ id+'").value;');
    eval ('cve_loc = document.getElementById("cve_loc_'+ id+'").value;');
    eval ('cve_ageb = document.getElementById("cve_ageb_'+ id+'").value;');
    var cveconca=cve_ent+cve_mun+cve_loc+cve_ageb;
    ajax.open("GET",'obtcve.jsp?tipo=mza&clave='+cveconca+'&cvemax='+cvemax, true);
    ajax.onreadystatechange=function()
    {
        if(ajax.readyState==4)  {
             var vale=parseInt(ajax.responseText);
            if (parseInt(vale)==0){
                alertmsg ("No se pudo obtener la Mz");
            }else{
                /*if (cvemax!=cveconca){
                    mzamax=vale;
                    cvemax=cveconca;
                }else{
                    if (vale>mzamax){
                        mzamax=vale;
                    }else{
                        mzamax+=1;
                        vale=mzamax;
                    }
                }*/
                var valestr='';
                if (String(vale).length<3){
                    valestr=pad("0"+vale, 3);
                }else{
                    valestr=String(vale);
                }
                if (valestr.length>3){
                    valestr=valestr.substring(valestr.length-3,valestr.length);
                }
                eval ('document.getElementById("cve_mza_'+ id+'").value="'+valestr+'";');
                //eval ('document.getElementById("obtcvemza'+id+'").disabled=true;');
                //eval ('document.getElementById("obtcvemzageo'+id+'").disabled=true;');
                mztemp=cveconca+valestr;
            }
        }
    }
    ajax.send(null);
}

//FUNCION QUE OBTIENE LA ULTIMA CLAVE DE MANZANA DEL AGEB POR SOBREPOSICION
function obtCveMzaGeo(centroid,id){
    var ajax=nuevoAjax();
    ajax.open("GET",'obtcve.jsp?tipo=mzageo&clave='+centroid+'&cvemax='+cvemax, true);
    ajax.onreadystatechange=function()
    {
        if(ajax.readyState==4)  {
             var vale=ajax.responseText;
            if (parseInt(vale)==0){
                alertmsg ("Debe estar sobre AgebU o Localidad");
            }else{
                var cveconca=vale.trim().substring(0,14);
                vale=parseInt(vale.trim().substring(14,18));
                /*if (cvemax!=cveconca){
                    mzamax=vale;
                    cvemax=cveconca;
                }else{
                    if (vale>mzamax){
                        mzamax=vale;
                    }else{
                        mzamax+=1;
                        vale=mzamax;
                    }
                }*/
                var valestr='';
                if (String(vale).length<3){
                    valestr=pad("0"+vale, 3);
                }else{
                    valestr=String(vale);
                }
                if (valestr.length>3){
                    valestr=valestr.substring(valestr.length-3,valestr.length);
                }
                eval ('document.getElementById("cve_ent_'+ id+'").value="'+cveconca.substring(0,2)+'";');
                eval ('document.getElementById("cve_mun_'+ id+'").value="'+cveconca.substring(2,5)+'";');
                eval ('document.getElementById("cve_loc_'+ id+'").value="'+cveconca.substring(5,9)+'";');
                eval ('document.getElementById("cve_ageb_'+ id+'").value="'+cveconca.substring(9,14)+'";');
                eval ('document.getElementById("cve_mza_'+ id+'").value="'+valestr+'";');
                //eval ('document.getElementById("obtcvemza'+id+'").disabled=true;');
                //eval ('document.getElementById("obtcvemzageo'+id+'").disabled=true;');
                mztemp=cveconca+valestr;
            }
        }
    }
    ajax.send(null);
}

// FUNCION DESELECCIONA LA MANZANA// ****************************************************************************************************************
function onFeatureUnSelectmz(event){
var feature = event.feature;
    if (feature.modified){
        alertmsg("Movido");
        feature.attributes.img  = baseimg;
        feature.attributes.usuario  = iduser;
        feature.attributes.inv_img  = map.getScale();

    }
    if (feature.popup){
        map.removePopup(feature.popup);
    }
}

//FUNCIONES QUE AGREGA MANZANAS DEL MCC// ****************************************************************************************************************


function agregamz(tip,cgo,geom,conviv){
    var tipoproy=0;
    var feature;
    var geompol = OpenLayers.Geometry.fromWKT(geom);
    //var geompol = new OpenLayers.Geometry.MultiPolygon(OpenLayers.Geometry.fromWKT(geom));
    switch (cgo){  //cgo
        case '2':
        case 2:
            mcc=1;
            agrmz=2;   //agrmz= 1 creacion, 2 subdivision , 3 suvidivide de varias
            subdividemz(geompol,tipoproy,1,cvedef,vienedegid);
            break;
        case '4':
        case 4:
        case 'A':
        case 'B':
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
            feature.attributes.ban=cgo;
            feature.attributes.tipomza=mcctipomza;
            feature.attributes.proy=obtProy;
            //feature.attributes.inv = conviv;
            feature.attributes.inv = 1;
            modiatmz.selectControl.select(feature);
            /*if (wfsmov.length>0){
            if (wfsmov.indexOf(feature.id)<0){
             wfsmov.push(feature.id);
            }
            }else{
                wfsmov.push(feature.id);
            }*/
            break;
    }
mcc=0;
//agrmz=0;
}

function fusionamz(cve_def,geom){
    var geompol = OpenLayers.Geometry.fromWKT(geom);
    //var geompol = new OpenLayers.Geometry.MultiPolygon(OpenLayers.Geometry.fromWKT(geom));
    var feature;
    var l=wfs.features.length-1;
    var c1=0;
    var c2=0;
    for(var i=0; i<=l; i++) {
        if (wfs.features[i].state!=OpenLayers.State.DELETE){
            cve=wfs.features[i].attributes.cve_ent+wfs.features[i].attributes.cve_mun+wfs.features[i].attributes.cve_loc+wfs.features[i].attributes.cve_ageb+wfs.features[i].attributes.cve_mza;
            if (cve==cve_def){
                c1=1;
                feature = wfs.getFeatureBy('fid', wfs.features[i].fid);
                var polant=feature.geometry;
                if (feature.geometry.intersects(geompol)){
                    wfs.eraseFeatures(feature);
                    feature.geometry=geompol;
                    setTimeout(function(){ wfs.drawFeature(feature); }, 500);
                }else{
                    alertmsg("No intersectan el poligono definitivo con la clave");
                    return false;

                }
                var intersects12,t=0;
                var feature1;
                for(var j=0; j<wfs.features.length; j++) {
                    if (wfs.features[j].state!=OpenLayers.State.DELETE){
                        intersects12 = feature.geometry.intersects(wfs.features[j].geometry);
                        //tipomza==9, contenedora
                        if(intersects12 && feature.fid!=wfs.features[j].fid && wfs.features[j].attributes.tipomza!='9' && wfs.features[j].attributes.ban!='1' && wfs.features[j].attributes.ban!='3'
                             && wfs.features[j].attributes.ban!='X' && wfs.features[j].attributes.ban!='5' && wfs.features[j].attributes.ban!='6' && wfs.features[j].attributes.ban!='Y' && wfs.features[j].attributes.ban!='E'
                              && wfs.features[j].attributes.ban!='D' && wfs.features[j].attributes.ban!='H' && wfs.features[j].attributes.ban!='G' && wfs.features[j].attributes.ban!='M' && wfs.features[j].attributes.ban!='I'
                               && wfs.features[j].attributes.ban!='N' && wfs.features[j].attributes.ban!='O' && wfs.features[j].attributes.ban!='K' && wfs.features[j].attributes.ban!='R'
                                && wfs.features[j].attributes.ban!='T' && wfs.features[j].attributes.ban!='C'){
                            feature1 = wfs.getFeatureBy('fid', wfs.features[j].fid);
                            t=1;
                            break;
                        }//intersect
                    }//delete
                }//for
                if (t==1){ //si intersecto con algo
                    if (feature.attributes.cve_mza.substring(0,1)=='T'){
                        alertmsg("No se puede fusionar hacia una manzana temporal");
                    }else{
                        if(feature.state != OpenLayers.State.INSERT) {
                            feature.state = OpenLayers.State.UPDATE;
                        }
                        if (feature1.state!=OpenLayers.State.INSERT){
                        feature1.state = OpenLayers.State.UPDATE;
                        }
                        feature1.attributes.ban  = '1';
                        feature1.attributes.img  = baseimg;
                        feature1.attributes.inv_img  = map.getScale();
                        feature1.attributes.usuario  = iduser;
                        feature1.attributes.vienede  = vienedegid;
                        feature1.attributes.proy=obtProy;
                        feature1.attributes.cve_temp  = feature.data.cve_ent+feature.data.cve_mun+feature.data.cve_loc+feature.data.cve_ageb+feature.data.cve_mza;
                        wfs.eraseFeatures(feature1);
                        feature.attributes.img  = baseimg;
                        feature.attributes.inv_img  = map.getScale();
                        feature.attributes.usuario  = iduser;
                        feature.attributes.tipomza  = mcctipomza;
                        feature.attributes.proy=obtProy;
                        // registro en el vector los que se modificaron
                        /*if (wfsmov.length>0){
                            if (wfsmov.indexOf(feature.id)<0){
                             wfsmov.push(feature.id);
                             wfsmov.push(feature1.id);
                            }
                        }else{
                            wfsmov.push(feature.id);
                            wfsmov.push(feature1.id);
                        }*/
                        }
                        if (feature.modified==null){
                            feature.modified={};
                            feature.modified.geometry= polant;
                        }
                }else{
                    alertmsg("No intersecta con otra manzana");
                    wfs.eraseFeatures(feature);
                    feature.geometry=polant;
                    setTimeout(function(){ wfs.drawFeature(feature); }, 500);
                }
                break;
            }
       }//if != delete
    }//for
    if (c1==0){
        alertmsg("No se encontro la clave definitiva");
    }
}



function eliminamz(cve_def){
    var feature;
    var l=wfs.features.length-1;
    for(var i=0; i<=l; i++) {
        if (wfs.features[i].state!=OpenLayers.State.DELETE){
            cve=wfs.features[i].attributes.cve_ent+wfs.features[i].attributes.cve_mun+wfs.features[i].attributes.cve_loc+wfs.features[i].attributes.cve_ageb+wfs.features[i].attributes.cve_mza;
            if (cve==cve_def){
                feature = wfs.getFeatureBy('fid', wfs.features[i].fid);
                /*var geomtemp=feature.geometry;
                if (wfsmov.length>0){
                    if (wfsmov.indexOf(feature.id)<0){
                     wfsmov.push(feature.id);
                    }
                }else{
                    wfsmov.push(feature.id);
                }
                if (feature.modified==null){
                    feature.modified={};
                    feature.modified.geometry= geomtemp;
                }*/
                // if feature doesn't have a fid, destroy it
                if(feature.fid == undefined) {
                    this.layer.destroyFeatures([feature]);
                } else {
                    if(feature.state != OpenLayers.State.INSERT) {
                        feature.state = OpenLayers.State.UPDATE;
                    }
                    feature.renderIntent = "select";
                    //this.layer.drawFeature(feature);
                    feature.attributes.ban  = '3';
                    feature.attributes.img  = baseimg;
                    feature.attributes.usuario  = iduser;
                    feature.attributes.proy=obtProy;
                    feature.attributes.inv_img  = map.getScale();

                    //uso este para quitar los frentes
                    feature.attributes.inv  = 1;
                    //feature.attributes.cve_mza  = 'XXX';
                    feature.attributes.vienede  = vienedegid;
                    wfs.eraseFeatures(feature);
                }
                break;
            }
       }//if != delete
    }//for
}


//cambia de geometria la manzanas
function cambiageom(cgo,geom,point,cvemza,clavecon){
    var feature;
    var geompol = OpenLayers.Geometry.fromWKT(geom);
    //var geompol = new OpenLayers.Geometry.MultiPolygon(OpenLayers.Geometry.fromWKT(geom));
    var geompoint = OpenLayers.Geometry.fromWKT(point);

    var intersects12,ban,i;
    var l=wfs.features.length-1;
    var jsts_parser = new jsts.io.OpenLayersParser();
            if (cvemza>900){ // manzana 900 que quieren cambiar de forma una manzana original si se puede
                for(var i=0; i<=l; i++) {
                    if (wfs.features[i].state!=OpenLayers.State.DELETE){
                        intersects12 = geompoint.intersects(wfs.features[i].geometry);
                        if(intersects12 && wfs.features[i].attributes.ban!='1' && wfs.features[i].attributes.ban!='3'
                             && wfs.features[i].attributes.ban!='X' && wfs.features[i].attributes.ban!='5' && wfs.features[i].attributes.ban!='6' && wfs.features[i].attributes.ban!='Y' && wfs.features[i].attributes.ban!='E'
                              && wfs.features[i].attributes.ban!='D' && wfs.features[i].attributes.ban!='H' && wfs.features[i].attributes.ban!='G' && wfs.features[i].attributes.ban!='M' && wfs.features[i].attributes.ban!='I'
                               && wfs.features[i].attributes.ban!='N' && wfs.features[i].attributes.ban!='O' && wfs.features[i].attributes.ban!='K' && wfs.features[i].attributes.ban!='R'
                                && wfs.features[i].attributes.ban!='T' && wfs.features[i].attributes.ban!='C'){
                                    feature = wfs.getFeatureBy('fid', wfs.features[i].fid);
                                    var geomtemp=feature.geometry;
                                    feature.attributes.img  = baseimg;
                                    feature.attributes.inv_img  = map.getScale();
                                    feature.attributes.usuario  = iduser;
                                    feature.attributes.vienede=vienedegid;
                                    feature.attributes.proy=obtProy;
                                    //feature.attributes.inv = conviv;     //<- ESTOY USANDO ESTE =1 CUANDO SEA QUE VIENEN DEL MCC 
                                    feature.attributes.inv =1;
                                    wfs.eraseFeatures(feature);
                                    feature.geometry=geompol;
                                    if (feature.state!=OpenLayers.State.INSERT){
                                        feature.state = OpenLayers.State.UPDATE;
                                    }
                                    wfs.drawFeature(feature);
                                     if (feature.modified==null){
                                        feature.modified={};
                                        feature.modified.geometry= geomtemp;
                                    }
                                    break;
                        }//if intersect
                    }//if != delete
                }//for
            }else{
                //si es menor a manzana 900 el que queire cambiar la forma, debe ser de la misma clave
                /// METI AQUI LA COMPARACION DE CVE_ENT+CVE_MUN+CVE_LOC   +  CVE_MZA
                for(var i=0; i<=l; i++) {
                    if (wfs.features[i].state!=OpenLayers.State.DELETE){
                        cve=wfs.features[i].attributes.cve_ent+wfs.features[i].attributes.cve_mun+wfs.features[i].attributes.cve_loc+wfs.features[i].attributes.cve_ageb+wfs.features[i].attributes.cve_mza;
                          //aqui truqueo que sean sin ageb
                          //cve=wfs.features[i].attributes.cve_ent+wfs.features[i].attributes.cve_mun+wfs.features[i].attributes.cve_loc+wfs.features[i].attributes.cve_mza;
                          //clavecon=clavecon.substring(0, 9)+cvemza;
                            if(cve==clavecon && wfs.features[i].attributes.ban!='1' && wfs.features[i].attributes.ban!='3'
                                 && wfs.features[i].attributes.ban!='X' && wfs.features[i].attributes.ban!='5' && wfs.features[i].attributes.ban!='6' && wfs.features[i].attributes.ban!='Y' && wfs.features[i].attributes.ban!='E'
                                  && wfs.features[i].attributes.ban!='D' && wfs.features[i].attributes.ban!='H' && wfs.features[i].attributes.ban!='G' && wfs.features[i].attributes.ban!='M' && wfs.features[i].attributes.ban!='I'
                                   && wfs.features[i].attributes.ban!='N' && wfs.features[i].attributes.ban!='O' && wfs.features[i].attributes.ban!='K' && wfs.features[i].attributes.ban!='R'
                                    && wfs.features[i].attributes.ban!='T' && wfs.features[i].attributes.ban!='C'){
                                        feature = wfs.getFeatureBy('fid', wfs.features[i].fid);
                                        var geomtemp=feature.geometry;
                                        feature.attributes.img  = baseimg;
                                        feature.attributes.inv_img  = map.getScale();
                                        feature.attributes.usuario  = iduser;
                                        feature.attributes.vienede=vienedegid;
                                        feature.attributes.proy=obtProy;
                                        //feature.attributes.inv = conviv;     //<- ESTOY USANDO ESTE =1 CUANDO SEA QUE VIENEN DEL MCC 
                                        feature.attributes.inv =1;
                                        wfs.eraseFeatures(feature);
                                        feature.geometry=geompol;
                                        if (feature.state!=OpenLayers.State.INSERT){
                                            feature.state = OpenLayers.State.UPDATE;
                                        }
                                        wfs.drawFeature(feature);
                                         if (feature.modified==null){
                                            feature.modified={};
                                            feature.modified.geometry= geomtemp;
                                        }
                                        alertmsg("Se cambia de forma la manzana: "+cvemza);
                                        break;
                            }//if cve=
                    }//if != delete
                }//for
            }
            /*if (wfsmov.length>0){
                if (wfsmov.indexOf(feature.id)<0){
                 wfsmov.push(feature.id);
                }
            }else{
                wfsmov.push(feature.id);
            }*/

}


function casigna(cgo,point){
    var feature;
    var geompoint = OpenLayers.Geometry.fromWKT(point);

    var intersects12,ban,i;
    var l=wfs.features.length-1;
    var jsts_parser = new jsts.io.OpenLayersParser();

   for(var i=0; i<=l; i++) {
    if (wfs.features[i].state!=OpenLayers.State.DELETE){
        intersects12 = geompoint.intersects(wfs.features[i].geometry);
          if(intersects12 && wfs.features[i].attributes.ban!='1' && wfs.features[i].attributes.ban!='3'
                             && wfs.features[i].attributes.ban!='X' && wfs.features[i].attributes.ban!='5' && wfs.features[i].attributes.ban!='6' && wfs.features[i].attributes.ban!='Y' && wfs.features[i].attributes.ban!='E'
                              && wfs.features[i].attributes.ban!='D' && wfs.features[i].attributes.ban!='H' && wfs.features[i].attributes.ban!='G' && wfs.features[i].attributes.ban!='M' && wfs.features[i].attributes.ban!='I'
                               && wfs.features[i].attributes.ban!='N' && wfs.features[i].attributes.ban!='O' && wfs.features[i].attributes.ban!='K' && wfs.features[i].attributes.ban!='R'
                                && wfs.features[i].attributes.ban!='T' && wfs.features[i].attributes.ban!='C'){
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

//funcion que envia a tras la manzana contenedora// ****************************************************************************************************************
function enviar_atras(){
    if (wfs.selectedFeatures.length>0){
        var ccl = new OpenLayers.Projection("EPSG:32800");
        var arrfid=[]
        var feature = wfs.selectedFeatures[0];
        var fid=wfs.selectedFeatures[0].fid;
        var geom=feature.geometry.transform(new OpenLayers.Projection('EPSG:900913'),new OpenLayers.Projection('EPSG:32800'));
        var filtro = new OpenLayers.Filter.Spatial({
            type: OpenLayers.Filter.Spatial.INTERSECTS,
            value: feature.geometry
        });
        //ESTILOS PARA WFS
        var style1 = new OpenLayers.StyleMap({"default": new OpenLayers.Style(null, {
            rules: [
                new OpenLayers.Rule({
                    symbolizer: {
                    "Polygon": {strokeWidth: 0,fillOpacity:0}
                    }})]
            })});
        var inter =   new OpenLayers.Layer.Vector("inter",{
                    strategies: [new OpenLayers.Strategy.BBOX()],
                    protocol: new OpenLayers.Protocol.WFS({
                    srsName: "EPSG:32800", url:  "http://"+hostnew+"/geoserver/INEGI"+idreggeo+"/wfs",
                    featureType: "cat_manz",featureNS: "http://"+hostnew+"/INEGI"+idreggeo+""}),
                    projection: ccl, styleMap: style1
                    ,filter: filtro
                });
        inter.displayInLayerSwitcher= false;inter.isBaseLayer=false;map.addLayers ([inter]);
        var geom=feature.geometry.transform(new OpenLayers.Projection('EPSG:32800'),new OpenLayers.Projection('EPSG:900913'));
        if(modimz1.active) {
            modimz1.selectControl.unselectAll();
        }else if(modimz2.active) {
            modimz2.selectControl.unselectAll();
        }else if(modiatmz.active) {
            modiatmz.selectControl.unselectAll();
        }
            setTimeout(function(){
                for (i=0;i<inter.features.length;i++){
                    arrfid.push(inter.features[i].fid);
                }
                inter.removeAllFeatures();
                inter.visibility=false;
                inter.removeMap();
                var intersects12,ban,i,t;
               for(var j=0; j<arrfid.length; j++) {
                        if(arrfid[j]!=fid){
                            var feature1 = wfs.getFeatureBy('fid', arrfid[j]);
                            if (feature1!=null){
                                wfs.eraseFeatures(feature1);
                                wfs.drawFeature(feature1);
                            }
                        }//intersect
                }//for
                alertmsg ("Manzana enviada al fondo");
            }, 1000);

    }else{
        alertmsg("No hay manzana seleccionada")
    }
}


//funcion que crea el corte de manzana despues de la subdivision// ****************************************************************************************************************
function cearCorte(id){
    var feature = wfs.getFeatureBy('id', id);
      map.removePopup(feature.popup);
      modiatmz.selectControl.unselect(feature);
        if(feature.fid == undefined) {
            wfs.destroyFeatures([feature]);
        } else {
            feature.state = OpenLayers.State.DELETE;
            wfs.events.triggerEvent("afterfeaturemodified",{feature: feature});
            feature.renderIntent = "select";
            wfs.drawFeature(feature);
        }
}


//funcion para crear un hueco despues de la subdivision entre manzanas// ****************************************************************************************************************
function crearHueco(id){
    var feature = wfs.getFeatureBy('id', id);
      map.removePopup(feature.popup);
      modiatmz.selectControl.unselect(feature);
        var jsts_parser = new jsts.io.OpenLayersParser();
        var intersects12,ban,i,t,sal=0,area1=0,area2=0;
       for(var j=0; j<wfs.features.length; j++) {
                if (wfs.features[j].state!=OpenLayers.State.DELETE){
                    intersects12 = feature.geometry.intersects(wfs.features[j].geometry);
                    if(intersects12 && feature.fid!=wfs.features[j].fid && wfs.features[j].attributes.ban!='1' && wfs.features[j].attributes.ban!='3'
                             && wfs.features[j].attributes.ban!='X' && wfs.features[j].attributes.ban!='5' && wfs.features[j].attributes.ban!='6' && wfs.features[j].attributes.ban!='Y' && wfs.features[j].attributes.ban!='E'
                              && wfs.features[j].attributes.ban!='D' && wfs.features[j].attributes.ban!='H' && wfs.features[j].attributes.ban!='G' && wfs.features[j].attributes.ban!='M' && wfs.features[j].attributes.ban!='I'
                               && wfs.features[j].attributes.ban!='N' && wfs.features[j].attributes.ban!='O' && wfs.features[j].attributes.ban!='K' && wfs.features[j].attributes.ban!='R'
                                && wfs.features[j].attributes.ban!='T' && wfs.features[j].attributes.ban!='C'){
                        sal++;
                        if (sal==1){
                            t=j;
                            area1 = wfs.features[j].geometry.getArea();
                        }else{
                            area2 = wfs.features[j].geometry.getArea();
                            if (parseFloat(area2)<parseFloat(area1)){
                                t=j;
                            }
                        }
                    }//intersect
                }//delete
            }//for
        // continua si solo es una manzana, i es el seleccionado y t es el que intersecta
        if (sal==0){
            alertmsg("Debe de hacerlo dentro de una manzanas");
             if(feature.fid == undefined) {
                wfs.destroyFeatures([feature]);
            } else {
                feature.state = OpenLayers.State.DELETE;
                wfs.events.triggerEvent("afterfeaturemodified",{feature: feature});
                feature.renderIntent = "select";
                wfs.drawFeature(feature);
            }
        }else{
            var jsts_geomA  = jsts_parser.read(feature.geometry);
            var jsts_geomB  = jsts_parser.read(wfs.features[t].geometry);
            var jsts_result_geom = jsts_geomB.difference(jsts_geomA);
            var area1=0;
            var area2=0;
            if (jsts_result_geom.geometries!=undefined){
                if (jsts_result_geom.geometries.length>0){ //mas de un poligono
                    area1 = jsts_result_geom.geometries[0].getArea(); //obtengo el area del primer poligono
                    var polarea=0;
                    for(var j=1; j<jsts_result_geom.geometries.length; j++) {
                        area2 = jsts_result_geom.geometries[j].getArea();
                        if (parseFloat(area2)>parseFloat(area1)){
                            polarea=j;
                            area1 = jsts_result_geom.geometries[j].getArea();
                        }
                    }
                    jsts_result_geom=jsts_result_geom.geometries[polarea];
                }
            }
            var geomtemp=wfs.features[t].geometry;
            var geompol = new OpenLayers.Geometry.MultiPolygon(OpenLayers.Geometry.fromWKT(jsts_result_geom.toString()));
            wfs.eraseFeatures(wfs.features[t]);
            wfs.features[t].geometry=geompol;
            if (wfs.features[t].state!=OpenLayers.State.INSERT){
                wfs.features[t].state = OpenLayers.State.UPDATE;
            }
            wfs.drawFeature(wfs.features[t]);
            if(feature.fid == undefined) {
                wfs.destroyFeatures([feature]);
            } else {
                feature.state = OpenLayers.State.DELETE;
                wfs.events.triggerEvent("afterfeaturemodified",{feature: feature});
                feature.renderIntent = "select";
                wfs.drawFeature(feature);
            }
            /*if (wfsmov.length>0){
                if (wfsmov.indexOf(wfs.features[t].id)<0){
                    wfsmov.push(wfs.features[t].id);
                }
            }else{
                wfsmov.push(wfs.features[t].id);

            }*/
            if (wfs.features[t].modified==null){
                wfs.features[t].modified={};
                wfs.features[t].modified.geometry=geomtemp;
            }
        }
}


// FUNCION QUE SWITCHEA LA MANZANA EN LA SUBDIVISION // ***********************************************************************************************
function switchMza(){
    var feature1=wfs.selectedFeatures[0];
    var feature2=switmza.clone();
    wfs.eraseFeatures(feature1);
    wfs.eraseFeatures(switmza);
    switmza.geometry=feature1.geometry;
    feature1.geometry=feature2.geometry;
    wfs.drawFeature(feature1);
    wfs.drawFeature(switmza);
    modiatmz.selectControl.unselectAll();
    modiatmz.selectControl.select(feature1);
}

//FUNCION QUE SUBDIVIDE UNA MANZANA // ****************************************************************************************************************
//meter if (revisa_idmax_noborra(feature.fid,feature.attributes.cve_mza,2)){

function subdivide(e){
//console.log(e);
var intersects12,ban,i;
var l=wfs.features.length-1;
//var attributes = {clave: "000", filtro: clavefil};
   for(var i=0; i<=l; i++) {
    if (wfs.features[i].state!=OpenLayers.State.DELETE){
        intersects12 = e.intersects(wfs.features[i].geometry);
          // i es igual al numero de poligonos que va a subdividir... hay que comparar que solo sea el primero
                // los de baja y los de nueva creacion (4,A,B, no se puede subdividir)
             if(intersects12 && wfs.features[i].attributes.ban!='1' && wfs.features[i].attributes.ban!='3' 
                             && wfs.features[i].attributes.ban!='X' && wfs.features[i].attributes.ban!='5' && wfs.features[i].attributes.ban!='6' && wfs.features[i].attributes.ban!='Y' && wfs.features[i].attributes.ban!='E'
                              && wfs.features[i].attributes.ban!='D' && wfs.features[i].attributes.ban!='H' && wfs.features[i].attributes.ban!='G' && wfs.features[i].attributes.ban!='M' && wfs.features[i].attributes.ban!='I'
                               && wfs.features[i].attributes.ban!='N' && wfs.features[i].attributes.ban!='O' && wfs.features[i].attributes.ban!='K' && wfs.features[i].attributes.ban!='R'
                                && wfs.features[i].attributes.ban!='T' && wfs.features[i].attributes.ban!='C'
                    && wfs.features[i].attributes.ban!='2' && wfs.features[i].attributes.ban!='4' && wfs.features[i].attributes.ban!='A' && wfs.features[i].attributes.ban!='B'){
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
                var polarea=0;
                area1 = polygons.array[0].getArea(); //obtengo el numero de array del poligono mayor (se quedara con la clave)
                for(var j=0; j<polygons.array.length-1; j++) {
                    area2 = polygons.array[j+1].getArea();
                    if (parseFloat(area2)>parseFloat(area1)){
                        polarea=j+1;
                        area1 = polygons.array[j+1].getArea();
                    }
                }
                // primero valido que se divida en 2 solo 1
                for(var j=0; j<polygons.array.length; j++) {  //aqui solo debe entrar 2 veces si no hace un relajo
                    if (j>1){
                        alertmsg("Solo se puede subdividir en 2 la manzana");
                        return false;
                    }
                }
                var feature1 = wfs.getFeatureBy('fid', wfs.features[i].fid);
                    feature1.attributes.img  = baseimg;
                    feature1.attributes.inv_img  = map.getScale();
                    feature1.attributes.usuario  = iduser;
                    feature1.attributes.proy=obtProy;
                var feature;
                var geomtemp=feature1.geometry;
                for(var j=0; j<polygons.array.length; j++) {
                    var geompol = new OpenLayers.Geometry.MultiPolygon(OpenLayers.Geometry.fromWKT(polygons.array[j].toString()));
                    if (j==polarea){
                        wfs.eraseFeatures(feature1);
                        feature1.geometry=geompol;
                        if (feature1.state!=OpenLayers.State.INSERT){
                            feature1.state = OpenLayers.State.UPDATE;
                        }
                        wfs.drawFeature(feature1);
                        switmza=feature1;
                    }else{
                          //wfs.addFeatures([new OpenLayers.Feature.Vector(geompol, attributes)]);
                         wfs.addFeatures([new OpenLayers.Feature.Vector(geompol)]);
                          var n=wfs.features.length-1;
                         wfs.features[n].state=OpenLayers.State.INSERT;
                            feature = wfs.getFeatureBy('fid', wfs.features[n].fid);
                            feature.attributes.cve_ent  = feature1.attributes.cve_ent;
                            feature.attributes.cve_mun  = feature1.attributes.cve_mun;
                            feature.attributes.cve_loc  = feature1.attributes.cve_loc;
                            feature.attributes.cve_ageb  = feature1.attributes.cve_ageb;
                            feature.attributes.cve_mza  = '000';
                            feature.attributes.ban  = '2';
                            feature.attributes.img  = baseimg;
                            feature.attributes.inv_img  = map.getScale();
                            feature.attributes.usuario  = iduser;
                            feature.attributes.proy=obtProy;
                            feature.attributes.cve_temp = feature1.attributes.cve_ent+feature1.attributes.cve_mun+feature1.attributes.cve_loc+
                                                     feature1.attributes.cve_ageb+feature1.attributes.cve_mza
                    }
                // registro en el vector los que se modificaron
                }//for
                    // registro en el vector los que se modificaron
                    /*if (wfsmov.length>0){
                        if (wfsmov.indexOf(feature1.id)<0){
                            wfsmov.push(feature1.id);
                            wfsmov.push(feature.id);
                        }
                    }else{
                        wfsmov.push(feature1.id);
                        wfsmov.push(feature.id);
                    }*/
                    if (feature1.modified==null){
                        feature1.modified={};
                        feature1.modified.geometry=geomtemp;
                    }
                    modiatmz.selectControl.select(feature);
                    return false; //finaliza correctamente con el primero que cumpla las condiciones y se sale
            }//else linea afuera
        }//if intersect
    }//if != delete
  }//for
}//funcion

var cambiacod2=0;
function cambia_codigo2(id){
    cambiacod2=1;
    eval ('buf = document.getElementById("buf_'+ id+'").value;');
    var feature = wfs.getFeatureBy('id', id);
    feature.attributes.ban='2';
    map.removePopup(feature.popup);
    drawsub.deactivate();
    submz.activate();
    subdividemz(feature.geometry,0,buf,"","");
}

//Funcion que subdivide una manzana desde un poligono // ****************************************************************************************************************
function subdividemz(e,tipoproy,buf,cve_def,vienedegid){
var intersects12,ban,i;
var l=wfs.features.length-1;
var jsts_parser = new jsts.io.OpenLayersParser();
//var attributes = {clave: "000", filtro: clavefil};
   for(var i=0; i<=l; i++) {
    if (wfs.features[i].state!=OpenLayers.State.DELETE){
        intersects12 = e.intersects(wfs.features[i].geometry);
          // i es igual al numero de poligonos que va a subdividir... hay que comparar que solo sea el primero
          //console.log(wfs.features[i])
          // los codigos de nueva creacion A,B,B no se puede subdividir
          if(intersects12 && wfs.features[i].attributes.ban!='1' && wfs.features[i].attributes.ban!='3'
                             && wfs.features[i].attributes.ban!='X' && wfs.features[i].attributes.ban!='5' && wfs.features[i].attributes.ban!='6' && wfs.features[i].attributes.ban!='Y' && wfs.features[i].attributes.ban!='E'
                              && wfs.features[i].attributes.ban!='D' && wfs.features[i].attributes.ban!='H' && wfs.features[i].attributes.ban!='G' && wfs.features[i].attributes.ban!='M' && wfs.features[i].attributes.ban!='I'
                               && wfs.features[i].attributes.ban!='N' && wfs.features[i].attributes.ban!='O' && wfs.features[i].attributes.ban!='K' && wfs.features[i].attributes.ban!='R'
                                && wfs.features[i].attributes.ban!='T' && wfs.features[i].attributes.ban!='C'
                && wfs.features[i].attributes.ban!='2' && wfs.features[i].attributes.ban!='4' && wfs.features[i].attributes.ban!='A' 
                && wfs.features[i].attributes.ban!='B' 
                //&& wfs.features[i].attributes.tipomza!='1'
                ){  //1=contenedora
            var jsts_geomA  = jsts_parser.read(wfs.features[i].geometry);
            var jsts_geomB  = jsts_parser.read(e);
            var jsts_result_geom = jsts_geomA.difference(jsts_geomB.buffer(buf));
            var area1=0;
            var area2=0;
            if (jsts_result_geom.geometries!=undefined){
                if (jsts_result_geom.geometries.length>0){ //mas de un poligono
                    area1 = jsts_result_geom.geometries[0].getArea(); //obtengo el area del primer poligono
                    var polarea=0;
                    for(var j=1; j<jsts_result_geom.geometries.length; j++) {
                        area2 = jsts_result_geom.geometries[j].getArea();
                        if (parseFloat(area2)>parseFloat(area1)){
                            polarea=j;
                            area1 = jsts_result_geom.geometries[j].getArea();
                        }
                    }
                    jsts_result_geom=jsts_result_geom.geometries[polarea];
                }
            }
            // primero valido que se divida en 2 solo 1
            /*for(var j=0; j<polygons.array.length; j++) {  //aqui solo debe entrar 2 veces si no hace un relajo
                if (j>1){
                    alertmsg("Solo se puede subdividir en 2 la manzana");
                    return false;
                }
            }*/
            var feature1 = wfs.getFeatureBy('fid', wfs.features[i].fid);
            feature1.attributes.img  = baseimg;
            feature1.attributes.inv_img  = map.getScale();
            feature1.attributes.usuario  = iduser;
            feature1.attributes.proy=obtProy;
            var geomtemp=feature1.geometry;
            var geompol = new OpenLayers.Geometry.MultiPolygon(OpenLayers.Geometry.fromWKT(jsts_result_geom.toString()));
            wfs.eraseFeatures(feature1);
            feature1.geometry=geompol;
            if (feature1.state!=OpenLayers.State.INSERT){
                feature1.state = OpenLayers.State.UPDATE;
            }
            wfs.drawFeature(feature1);
            switmza=feature1;
            var feature;
            wfs.addFeatures([new OpenLayers.Feature.Vector(e)]);
            var n=wfs.features.length-1;
            wfs.features[n].state=OpenLayers.State.INSERT;
            feature = wfs.getFeatureBy('fid', wfs.features[n].fid);
            if (cve_def==""){
                feature.attributes.cve_ent  = feature1.attributes.cve_ent;
                feature.attributes.cve_mun  = feature1.attributes.cve_mun;
                feature.attributes.cve_loc  = feature1.attributes.cve_loc;
                feature.attributes.cve_ageb  = feature1.attributes.cve_ageb;
                feature.attributes.cve_mza  = '000';
            }else{
                feature.attributes.cve_ent  = cvedef.substring(0, 2);
                feature.attributes.cve_mun  = cvedef.substring(2, 5);
                feature.attributes.cve_loc  = cvedef.substring(5, 9);
                feature.attributes.cve_ageb  = cvedef.substring(9, 14);
                feature.attributes.cve_mza  = cvedef.substring(14, 17);
            }
            feature.attributes.ban  = '2';
            feature.attributes.img  = baseimg;
            feature.attributes.inv_img  = map.getScale();
            feature.attributes.usuario  = iduser;
            feature.attributes.proy=obtProy;
            feature.attributes.cve_temp = feature1.attributes.cve_ent+feature1.attributes.cve_mun+feature1.attributes.cve_loc+
                                     feature1.attributes.cve_ageb+feature1.attributes.cve_mza
            feature.attributes.proy  = tipoproy;
            if (vienedegid!=""){feature.attributes.vienede=vienedegid;}
            // registro en el vector los que se modificaron
            /*if (wfsmov.length>0){
                if (wfsmov.indexOf(feature1.id)<0){
                    wfsmov.push(feature1.id);
                    wfsmov.push(feature.id);
                }
            }else{
                wfsmov.push(feature1.id);
                wfsmov.push(feature.id);
            }*/
            if (feature1.modified==null){
                feature1.modified={};
                feature1.modified.geometry=geomtemp;
            }
            modiatmz.selectControl.select(feature);
            return false; //finaliza correctamente con el primero que cumpla las condiciones y se sale
        }//if intersect
    }//if != delete
  }//for
}//funcion


//FUNCION QUE FUSIONA UNA MANZANA // ****************************************************************************************************************
function fusiona() {
    var sal=0;
if (wfs.selectedFeatures.length==0){
    alertmsg ("Debe seleccionar la manzana a permanecer");
    return false;
}else{
        var feature = wfs.getFeatureBy('id', wfs.selectedFeatures[0].id);
        if (feature.attributes.ban=='4' || feature.attributes.ban=='A' || feature.attributes.ban=='B'){
            alertmsg("No se puede fusionar una manzana de nueva creacion");
            return false;
        }
        var jsts_parser = new jsts.io.OpenLayersParser();
        var jsts_geomA  = jsts_parser.read(feature.geometry);
        //deselecciono la manzana
        if(modimz1.active) {
            modimz1.selectControl.unselectAll();
        }else if(modimz2.active) {
            modimz2.selectControl.unselectAll();
        }else if(modiatmz.active) {
            modiatmz.selectControl.unselectAll();
        }
        var intersects12,ban,i,t;
        if (feature.state!=OpenLayers.State.DELETE){
           for(var j=0; j<wfs.features.length; j++) {
                if (wfs.features[j].state!=OpenLayers.State.DELETE){
                    var jsts_geomB  = jsts_parser.read(wfs.features[j].geometry);
                    intersects12 = feature.geometry.intersects(wfs.features[j].geometry);
                    //que la que tengo seleccionada no este dentro de la otra
                    //if(jsts_geomB.contains(jsts_geomA)==false && jsts_geomA.contains(jsts_geomB)==false && intersects12 && feature.fid!=wfs.features[j].fid && wfs.features[j].attributes.ban!='1' && wfs.features[j].attributes.ban!='3'){
                    // pongo la tipo 9 que es la contened
                    if(intersects12 && feature.fid!=wfs.features[j].fid && wfs.features[j].attributes.tipomza!='9' && wfs.features[j].attributes.ban!='1' && wfs.features[j].attributes.ban!='3'
                             && wfs.features[j].attributes.ban!='X' && wfs.features[j].attributes.ban!='5' && wfs.features[j].attributes.ban!='6' && wfs.features[j].attributes.ban!='Y' && wfs.features[j].attributes.ban!='E'
                              && wfs.features[j].attributes.ban!='D' && wfs.features[j].attributes.ban!='H' && wfs.features[j].attributes.ban!='G' && wfs.features[j].attributes.ban!='M' && wfs.features[j].attributes.ban!='I'
                               && wfs.features[j].attributes.ban!='N' && wfs.features[j].attributes.ban!='O' && wfs.features[j].attributes.ban!='K' && wfs.features[j].attributes.ban!='R'
                                && wfs.features[j].attributes.ban!='T' && wfs.features[j].attributes.ban!='C'){
                        t=j;
                        //console.log (feature.attributes.cve_mza + " intersecta con " + wfs.features[t].attributes.cve_mza);
                        sal++;
                        if (sal>1){
                            alertmsg("Solo se puede fusionar una manzana a la vez");
                            break;
                            //return false;
                        }
                    }//intersect
                }//delete
            }//for
        // continua si solo es una manzana, i es el seleccionado y t es el que intersecta
        if (sal==0){
            alertmsg("Debe de sobreponer las manzanas");
        }else{
            if (feature.attributes.cve_mza.substring(0,1)=='T'){
                alertmsg("No se puede fusionar hacia una manzana temporal");
            }else{
                if ((feature.attributes.cve_ent+feature.attributes.cve_mun+feature.attributes.cve_loc+feature.attributes.cve_ageb==
                wfs.features[t].attributes.cve_ent+wfs.features[t].attributes.cve_mun+wfs.features[t].attributes.cve_loc+wfs.features[t].attributes.cve_ageb) &&
                (parseInt(feature.attributes.cve_mza)>parseInt(wfs.features[t].attributes.cve_mza))
                && (!(cons==44 || cons==60 || cons==234 || cons==496 || cons==1705))
                ){
                    alertmsg("Debe de seleccionar la clave menor");
                }else{
                    if (revisa_idmax_noborra(wfs.features[t].fid,wfs.features[t].attributes.cve_mza,1)){
                        alertmsg ("No se puede borrar una manzana agregada");
                        return false;
                    }
                    //var jsts_geomA  = jsts_parser.read(feature.geometry);
                    var jsts_geomB  = jsts_parser.read(wfs.features[t].geometry);
                    var jsts_result_geom = jsts_geomA.union(jsts_geomB);
                    var geompol = new OpenLayers.Geometry.MultiPolygon(OpenLayers.Geometry.fromWKT(jsts_result_geom.toString()));
                    wfs.eraseFeatures(feature);
                    feature.geometry=geompol;
                    if (feature.state!=OpenLayers.State.INSERT){
                        feature.state = OpenLayers.State.UPDATE;
                    }
                    //quita la manzana eliminada
                    //wfs.features[t].state = OpenLayers.State.DELETE;
                    // para la fusion no se elimina se update con ban=1
                    var feature1 = wfs.getFeatureBy('fid', wfs.features[t].fid);
                    if(feature1.state != OpenLayers.State.INSERT) {
                        feature1.state = OpenLayers.State.UPDATE;
                    }
                    feature1.attributes.ban  = '1';
                    feature1.attributes.img  = baseimg;
                    feature1.attributes.inv_img  = map.getScale();
                    feature1.attributes.usuario  = iduser;
                    feature1.attributes.proy=obtProy;
                    feature.attributes.img  = baseimg;
                    feature.attributes.inv_img  = map.getScale();
                    feature.attributes.usuario  = iduser;
                    feature.attributes.proy=obtProy;
                    feature1.attributes.cve_temp  = feature.data.cve_ent+feature.data.cve_mun+feature.data.cve_loc+feature.data.cve_ageb+feature.data.cve_mza;
                    feature1.attributes.inv  = 1;
                    //wfs.features[t].renderIntent = "select";
                    wfs.eraseFeatures(wfs.features[t]);
                    wfs.drawFeature(feature);
                    // registro en el vector los que se modificaron
                    /*if (wfsmov.length>0){
                        if (wfsmov.indexOf(feature1.id)<0){
                         wfsmov.push(feature1.id);
                         wfsmov.push(feature.id);
                        }
                    }else{
                        wfsmov.push(feature1.id);
                        wfsmov.push(feature.id);
                    }*/
                } //else clave menor
            }//clave temporal
        }//sal=0
    } //if delete
}//1er if
}//function
////////// TERMINA PARTE DE LA EDICION DE LAS MANZNA//////////////// // ****************************************************************************************************************



//FUNCION QUE REVISA EL MAXIMO ID DE LA TABLA DE MANZANAS SI ES POSTERIOR NO SE PUEDE ELIMINAR LA MANZANA
// ESTE DATO LO TENGO QUE CAMBIAR CON LA AGREGACION DE NUEVA INFORMACION DE MANZANAS
function revisa_idmax_noborra(gid,cve,tipo){
    //console.log(gid);
if (tipo==3){  //baja
    if ((parseInt(gid.substring(9,gid.length))>max_mz || gid.substring(0,1)=='O')){
        return true;
    }else{
        return false;
    }
}else if (tipo==2){  //subdivision
    if ((parseInt(gid.substring(9,gid.length))>max_mz || gid.substring(0,1)=='O')){
        return true;
    }else{
        return false;
    }
}else{  //fusion
    if ((parseInt(gid.substring(9,gid.length))>max_mz || gid.substring(0,1)=='O')){
        if (cve.substring(0,1)=='T'){
            return false;
        }else{
            return true;
        }
    }else{
        return false;
    }

}
}


//FUNCION QUE ELIMINA UNA MANZANA// ****************************************************************************************************************
var DeleteFeatureMz = OpenLayers.Class(OpenLayers.Control, {
    initialize: function(layer, options) {
        OpenLayers.Control.prototype.initialize.apply(this, [options]);
        this.layer = layer;
        this.handler = new OpenLayers.Handler.Feature(
            this, layer, {click: this.clickFeature}
        );
    },
    clickFeature: function(feature) {
                if (revisa_idmax_noborra(feature.fid,feature.attributes.cve_mza,3)){
                    alertmsg ("No se puede borrar una manzana agregada");
                    return false;
                }
               /* var geomtemp=feature.geometry;
                setTimeout(function(){
                    if (wfsmov.length>0){
                        if (wfsmov.indexOf(feature.id)<0){
                         wfsmov.push(feature.id);
                        }
                    }else{
                        wfsmov.push(feature.id);
                    }
                    if (feature.modified==null){
                        feature.modified={};
                        feature.modified.geometry= geomtemp;
                    }
                }, 1000);*/
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
            feature.attributes.ban  = '3';
            feature.attributes.img  = baseimg;
            feature.attributes.inv_img  = map.getScale();
            feature.attributes.usuario  = iduser;
            feature.attributes.proy=obtProy;
            feature.attributes.inv  = 1;
            //feature.attributes.cve_mza  = 'XXX';
        }

    },
    setMap: function(map) {
        this.handler.setMap(map);
        OpenLayers.Control.prototype.setMap.apply(this, arguments);
    },
    CLASS_NAME: "OpenLayers.Control.DeleteFeature"
});


var DeleteFeatureMzcas = OpenLayers.Class(OpenLayers.Control, {
    initialize: function(layer, options) {
        OpenLayers.Control.prototype.initialize.apply(this, [options]);
        this.layer = layer;
        this.handler = new OpenLayers.Handler.Feature(
            this, layer, {click: this.clickFeature}
        );
    },
    clickFeature: function(feature) {
                if (revisa_idmax_noborra(feature.fid,feature.attributes.cve_mza,3)){
                    alertmsg ("No se puede borrar una manzana agregada");
                    return false;
                }
                /*var geomtemp=feature.geometry;
                setTimeout(function(){
                    if (wfsmov.length>0){
                        if (wfsmov.indexOf(feature.id)<0){
                         wfsmov.push(feature.id);
                        }
                    }else{
                        wfsmov.push(feature.id);
                    }
                    if (feature.modified==null){
                        feature.modified={};
                        feature.modified.geometry= geomtemp;
                    }
                }, 1000);*/
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
            feature.attributes.ban  = 'S';
            feature.attributes.img  = baseimg;
            feature.attributes.inv_img  = map.getScale();
            feature.attributes.usuario  = iduser;
            feature.attributes.proy=obtProy;
            feature.attributes.inv  = 1;
            //feature.attributes.cve_mza  = 'XXX';
        }

    },
    setMap: function(map) {
        this.handler.setMap(map);
        OpenLayers.Control.prototype.setMap.apply(this, arguments);
    },
    CLASS_NAME: "OpenLayers.Control.DeleteFeaturecas"
});

// FUNCIONES QUE OCURREN AL GUARDAR CORRECTAMENTE O INCORRECTAMENTE LA CAPA DE MANANAS **********************************
function saveSuccessMz(){
        borra();
    alertmsg("Cambios guardados correctamente");
    // refresco la capa al guardar los cambios
    wfs.refresh({force: true});
    wfs.redraw(true);
    if (mza_gen.getVisibility()){mza_gen.redraw(true);}
    //if (mza_genet.getVisibility()){mza_genet.redraw(true);}
    // por el momento solo valida despues de guardar correctamente las manzanas
    // ya que las localidades se hace por medio del trigger despues del update de coordenadas,
    // las manzanas se validaba ANTES del insert o update por eso se tardaba y asi es mejor
    // agregue un trigger en la tabla de geometria despues de insertar se valida lo geometrico
    var ajax=nuevoAjax();
    ajax.open("GET",'valida_te.jsp?tipo=2&id='+iduser+'&filterid='+filterid, true);
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




function saveFailMz(e){
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
    alertmsg("Error al "+msg1+", revisar duplicados, no se guardo");
}




//FUNCION QUE BUSCA DESDE LA TABLA DE EQUIVALENCIA DE  LAS MANZANAS// ****************************************************************************************************************
function buscazoomtemz(val,geom){
var geometry = OpenLayers.Geometry.fromWKT(geom);
 if (parseInt(val)==0){
var feature = new OpenLayers.Feature.Vector(geometry, {}, {
        strokeColor: '#000000',
        strokeOpacity: 1,
        strokeWidth: 1,
        fillColor: '#FF0000',
        fillOpacity: 0.5
    });
 }else{
var feature = new OpenLayers.Feature.Vector(geometry, {}, {
        strokeColor: '#000000',
        strokeOpacity: 1,
        strokeWidth: 1,
        fillColor: '#000000',
        fillOpacity: 0.5
    });
 }
  if (parseInt(val)==2){  //MCC
    feature.style.fillColor='#'+document.getElementById('colorin').value;
 }
 s0=geometry.getCentroid().x-500;    //ccl , merctor
 s1=geometry.getCentroid().y-500;
 s2=geometry.getCentroid().x+500;
 s3=geometry.getCentroid().y+500;
puntogen.addFeatures([feature]);
bounds = new OpenLayers.Bounds(s0,s1,s2,s3);
map.zoomToExtent(bounds);
//map.zoomToExtent(geometry.bounds);
//map.zoomTo(12);
map.controls[0].redraw;
}




////////// FUNCION PARA LOS CASOS ESPECIALES DE LA MANZANA //// ******************************************************************************************************
 function onFeatureSelectmzcasos(event){
// registrar el id del seleccionado para regresar movimientos
if (map.popups.length>0){
    onPopupClosemz();
}
var feature = event.feature;
idpop=feature.id;
var  theHTML = '<center>';
theHTML += '<table><tr><th colspan=2 class=label style="text-align:center">CASOS ESPECIALES';
theHTML += '<tr><th colspan=2 class=label style="text-align:center">-> Multiples Manzanas <-';
theHTML += '<tr><td colspan=2>&nbsp;';
var theHTMLextra ='';
theHTML += '<tr><td style="text-align:center" colspan=2 class=label style="text-align:right">Codigo:&nbsp;<select onChange="cambiaCgo(\'' + feature.id + '\');" class=input id="ban_'+feature.id+'">';
theHTML += '<option value="0">Seleccione...';
theHTML += '<option value="5">5-Cambio de ageb';
theHTML += '<option value="6">6-Cambio de loc';
theHTML += '<option value="E">E-Conurbacion de loc';
theHTML += '<option value="D">D-Fusion de loc';
theHTML += '<option value="H">H-Cambio de mun';
theHTML += '<option value="G">G-Cambio de ageb';
theHTML += '<option value="I">I-Cambio de ent';
theHTML += '<option value="M">M-Creacion de mun';
theHTML += '<option value="N">N-Desconurba loc';
theHTML += '<option value="O">O-Desfusion loc';
theHTML += '<option value="Y">Y-Consolidacion de ageb';
//theHTML += '<option value="K">K-Baja de ageb';
//theHTML += '<option value="R">R-Baja de loc INEXISTENTE';
//theHTML += '<option value="T">T-Baja de loc TAPIAS/RUINAS';
//theHTML += '<option value="C">C-Baja de loc POR SERVICIO';
theHTML += '</select>';
theHTML += '<tr><td class=label style="text-align:right">Clave entidad:&nbsp;<td><input class=input id="cve_ent_'+feature.id+'" type="text" size="6" maxlength="2"  value="'+cve_ent+'" onkeypress="return datonumat(event)">';
theHTML += '<tr><td class=label style="text-align:right">Clave municipio:&nbsp;<td><input class=input id="cve_mun_'+feature.id+'" type="text" size="6" maxlength="3"  value="'+cve_mun+'" onkeypress="return datonumat(event)">';
theHTML += '<tr><td class=label style="text-align:right">Clave localidad:&nbsp;<td><input class=input id="cve_loc_'+feature.id+'" type="text" size="6" maxlength="4"  value="'+cve_loc+'" onkeypress="return datonumat(event)">';
theHTML += '<tr><td class=label style="text-align:right" nowrap>Clave ageb (con -):&nbsp;<td><input class=input id="cve_ageb_'+feature.id+'" type="text" size="6" maxlength="5"  value="'+cve_ageb+'" onkeypress="return datonumatageb(event)" onkeyup="return datonumatageb2(event)">';
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
//theHTML += '<option value="14" selected title="Actualizacion Permanente del MG 2025">AP2025';
//theHTML += '<option value="15" selected title="Actualizacion por BCUU">BCUU';
theHTML += '<option value="16" selected title="Actualizacion Integral">ACI';
//theHTML += '<option value="17" title="Censo Agropecuario">CA22';
theHTML += '</select>';
theHTML += '<tr><td colspan=2>&nbsp;<tr><td style="text-align:center" colspan=2><input id="updatecasosinput'+feature.id+'" onclick="updateCasos(\'' + feature.id + '\');" class=input type="button" name="enviar" value="Agregar a TE">';
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
       ,onPopupClosemz                //funcion al cerrar
    );
    feature.popup.opacity=0.9;
    feature.popup.backgroundColor="#FE642E";
    map.addPopup(feature.popup);
    document.getElementById("pop").style.zIndex = "999";
}

//FUNCION HACE UN UPDATE DE LOS CASES ESPECIALES DE MANZANA// ****************************************************************************************************************
function updateCasos(id){
    alertmsg ("Espere hasta que se cierre la ventana");
    var feature = wfs.getFeatureBy('id', id);
    eval ('ban = document.getElementById("ban_'+ id+'").value;');
    eval ('cve_ent = document.getElementById("cve_ent_'+ id+'").value;');
    eval ('cve_mun = document.getElementById("cve_mun_'+ id+'").value;');
    eval ('cve_loc = document.getElementById("cve_loc_'+ id+'").value;');
    eval ('cve_ageb = document.getElementById("cve_ageb_'+ id+'").value;');
    eval ('proy = document.getElementById("proy_'+ id+'").value;');
    cve_ageb=cve_ageb.toUpperCase();

    if (!(ban=='K' || ban=='R' || ban=='T' || ban=='C')){
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
    ajax.open("GET",'mod_casos.jsp?cgo='+ban+'&cve_ent='+cve_ent+'&cve_mun='+cve_mun+'&cve_loc='+cve_loc+'&cve_ageb='+cve_ageb+'&img='+baseimg+'&proy='+proy+'&us='+iduser+'&geom='+feature.geometry.toString(), true);
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



function cambiaCgo(id){
    eval ('ban = document.getElementById("ban_'+ id+'").value;');
    if (ban=='K' || ban=='R' || ban=='T' || ban=='C'){
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



//funcion al cerrar el popup de cualquier tipo
function onPopupClosemz(){
    var feature = wfs.getFeatureBy('id', idpop);
    if (feature!=null){
        if (feature.popup!=null){
            map.removePopup(feature.popup);
        }
         //if (drawmz.active || drawsub.active || drawmzcasos.active || drawmzcasos_chgform.active){
         if (drawmz.active || drawsub.active || drawmzcasos.active){
            wfs.destroyFeatures([feature]);
        }
    }
}


//funcion al cerrar el popup de cualquier tipo
function onPopupClosemzall(){
   for( var i = 0; i <= map.popups.length; ++i ) {
            if (!(map.popups[i]==undefined || map.popups[i]==null) && map.popups[i].id=="pop"){
                map.removePopup(map.popups[i]);
            }
 };
}







/////////////comienzo a probar lo de los frentes de manzana
var clavegeofm='';
function trbuteditarfm(feature){
    editarfm.selectControl.unselect(feature);
    editarfm.deactivate();
    if (modifm!=undefined ){
        if (modifm.active){
            return false;
        }
    }

/*   RESTRINGIR CAMBIO DE FORMA SI LA MANZANA VIENE DE LA CUR
if (!(feature.attributes.vienede==undefined)){
    alertmsg("No se puede cambiar la forma de una manzana procedente de la CUR");
    return false;
}
*/

var stylefm = new OpenLayers.StyleMap({
"default": new OpenLayers.Style(null, {
rules: [
    new OpenLayers.Rule({    //color de la edicion de manzanas
        symbolizer: {
           "Line": {   //color de edicion de los frentes y ejes
                        strokeOpacity: .7,
                        strokeWidth: 3,
                        strokeColor: "#FFD700",
                },
     }}),
    new OpenLayers.Rule({
        filter: new OpenLayers.Filter.Logical({
            type: OpenLayers.Filter.Logical.OR,
                filters: [
                    new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.EQUAL_TO,property: "ban", value: "0"})]}),
        symbolizer: {
            "Line": {strokeWidth: 3,strokeColor: "#0000FF",
            label : "${cve_ft}",fontColor: "#0000FF",fontSize: 10,fontFamily: "Arial",fontWeight: "bold",labelAlign: "cm"}}}),
    new OpenLayers.Rule({
        filter: new OpenLayers.Filter.Logical({
            type: OpenLayers.Filter.Logical.OR,
                filters: [
                    new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.EQUAL_TO,property: "ban", value: "1"})]}),
        symbolizer: {
            "Line": {strokeWidth: 3,strokeColor: "#FF0000",
            label : "${cve_ft}",fontColor: "#FF0000",fontSize: 10,fontFamily: "Arial",fontWeight: "bold",labelAlign: "cm"}}})
]}),
"select": new OpenLayers.Style({strokeColor: "#FFD700",strokeWidth: 4})});


var ccl = new OpenLayers.Projection("EPSG:32800");
    var saveStrategyfm = new OpenLayers.Strategy.Save();
            saveStrategyfm.events.register('success', null, saveSuccessFm);
            saveStrategyfm.events.register('fail', null, saveFailFm);
    clavegeofm=feature.attributes.cve_ent+feature.attributes.cve_mun+feature.attributes.cve_loc+(feature.attributes.cve_ageb.replace('-',''))+feature.attributes.cve_mza;

     var filtroed = new OpenLayers.Filter.Logical({type: OpenLayers.Filter.Logical.AND,filters: [
                new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.EQUAL_TO,property: "cvegeo",value: clavegeofm})]});
     wfsfm =   new OpenLayers.Layer.Vector("MODIFICAR",{
        strategies: [new OpenLayers.Strategy.BBOX(), saveStrategyfm],protocol: new OpenLayers.Protocol.WFS({
        srsName: "EPSG:32800", url:  "http://"+hostnew+"/geoserver/INEGI"+idreggeo+"/wfs",
        featureType: "cat_fm",featureNS: "http://"+hostnew+"/INEGI"+idreggeo+""}),
        projection: ccl, styleMap: stylefm
        ,filter: filtroed
    });
    wfsfm.displayInLayerSwitcher= false;wfsfm.isBaseLayer=false;map.addLayers ([wfsfm]);


    modifm = new OpenLayers.Control.ModifyFeature(
        wfsfm, {displayClass: "olControlModifymzFeature",title: "Modificar Frente por vertices"}
    );

/*
    splitfm = new OpenLayers.Control.Split({
        layer: wfsfm,
        deferDelete: true,
        tolerance :  0.1 });



    butsnap = new OpenLayers.Control.Button({displayClass: 'olControlButSnap', trigger: function (){
        if (split.active!=undefined && split.active==true){
                avsplit=avsplit+1;
                if (avsplit==4){
                    avsplit=0;
                }
                split.tolerance=avsplit;
                alertmsg("Split tolerancia a "+avsplit+" metros");
        }else{
                avsnap=avsnap+10;
                if (avsnap==60){
                    avsnap=0;
                }
                if (ban1==1){  //si la herramienta esta activa
                    if (editardigF.active){
                        //snap.defaults.tolerance=avsnap;
                        snap.options.targets[0].nodeTolerance=avsnap;
                        //snap.options.targets[0].vertexTolerance=avsnap;
                        //snap.options.targets[0].tolerance=avsnap;
                    }else if (editardigE.active){
                        //snap.defaults.tolerance=avsnap;
                        snap.options.targets[0].nodeTolerance=avsnap;
                        snap.options.targets[0].vertexTolerance=avsnap;
                        //snap.options.targets[0].tolerance=avsnap;
                    }
                }
                alertmsg("Snap al "+((avsnap*2))+"%");
        }
        },title: 'Aumentar/Disminuir Snap - Tolerancia subdivide frentes'}
        );
*/

    modifm2 = new OpenLayers.Control.ModifyFeature(wfsfm, {displayClass: "olControlModify2Feature", title: "Mover, rotar, tama\xF1o Frente"});
    modifm2.mode  = OpenLayers.Control.ModifyFeature.DRAG | OpenLayers.Control.ModifyFeature.ROTATE | OpenLayers.Control.ModifyFeature.RESIZE ;

        wfsfm.events.on({
            featureselected:onFeatureSelectFM
        });

     snapfm = new OpenLayers.Control.Snapping({layer: wfsfm,
                targets: [{
                    layer:wfsfm,
                    tolerance: 20,
                    edge: false,
                    filter: new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "surface",value: "dirt"})
                        }]
                });
    savefm = new OpenLayers.Control.Button({
        title: "Regenerar Manzana",
        trigger: function() {
            if(modifm.feature || modifm2.feature) {
                modimz1.selectControl.unselectAll();
            }
            saveStrategyfm.save();
            savemz.trigger();
                },
        displayClass: "olControlSaveFeatures"
    });

    cierrafm = new OpenLayers.Control.Button ({
                displayClass: 'olControlClose',
                trigger: function() {
                   modifm.deactivate();
                   modifm2.deactivate();
                    wfsfm.removeAllFeatures();
                    wfsfm.visibility=false;
                    wfsfm.removeMap();
                    wfsfm.destroy();
                    modifm.destroy();
                    modifm2.destroy();
                    savefm.destroy();
                    cierrafm.destroy();
                    snapfm.destroy();
                    panelfm.destroy();
                    panelfm=undefined;
                    editarfm.activate();               },
                title: 'Cerrar sin guardar'
            });
    panelfm = new OpenLayers.Control.Panel({displayClass: 'panelfmToolbar'});
    panelfm.addControls([modifm,modifm2,savefm,cierrafm,snapfm]);
    map.addControl(panelfm);
    modifm.activate();
       // wfsfm.setZIndex(maxzindex()+1);
        //console.log(wfsfm.getZIndex());
}




//------------------------- MOVER MANZANA POR FRENTES PERO DANDO CLICK  --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


function trbuteditarfm2(claveen){
    clavegeofm=claveen
    //editarfm.selectControl.unselect(feature);
    editarfm.deactivate();
    if (modifm!=undefined ){
        if (modifm.active){
            return false;
        }
    }

/*   RESTRINGIR CAMBIO DE FORMA SI LA MANZANA VIENE DE LA CUR
if (!(feature.attributes.vienede==undefined)){
    alertmsg("No se puede cambiar la forma de una manzana procedente de la CUR");
    return false;
}
*/

var stylefm = new OpenLayers.StyleMap({
"default": new OpenLayers.Style(null, {
rules: [
    new OpenLayers.Rule({    //color de la edicion de manzanas
        symbolizer: {
           "Line": {   //color de edicion de los frentes y ejes
                        strokeOpacity: .7,
                        strokeWidth: 3,
                        strokeColor: "#FFD700",
                },
     }}),
    new OpenLayers.Rule({
        filter: new OpenLayers.Filter.Logical({
            type: OpenLayers.Filter.Logical.OR,
                filters: [
                    new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.EQUAL_TO,property: "ban", value: "0"})]}),
        symbolizer: {
            "Line": {strokeWidth: 3,strokeColor: "#0000FF",
            label : "${cve_ft}",fontColor: "#0000FF",fontSize: 10,fontFamily: "Arial",fontWeight: "bold",labelAlign: "cm"}}}),
    new OpenLayers.Rule({
        filter: new OpenLayers.Filter.Logical({
            type: OpenLayers.Filter.Logical.OR,
                filters: [
                    new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.EQUAL_TO,property: "ban", value: "1"})]}),
        symbolizer: {
            "Line": {strokeWidth: 3,strokeColor: "#FF0000",
            label : "${cve_ft}",fontColor: "#FF0000",fontSize: 10,fontFamily: "Arial",fontWeight: "bold",labelAlign: "cm"}}})
]}),
"select": new OpenLayers.Style({strokeColor: "#FFD700",strokeWidth: 4})});


var ccl = new OpenLayers.Projection("EPSG:32800");
    var saveStrategyfm = new OpenLayers.Strategy.Save();
            saveStrategyfm.events.register('success', null, saveSuccessFm);
            saveStrategyfm.events.register('fail', null, saveFailFm);
    //clavegeofm=feature.attributes.cve_ent+feature.attributes.cve_mun+feature.attributes.cve_loc+(feature.attributes.cve_ageb.replace('-',''))+feature.attributes.cve_mza;

     var filtroed = new OpenLayers.Filter.Logical({type: OpenLayers.Filter.Logical.AND,filters: [
                new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.EQUAL_TO,property: "cvegeo",value: clavegeofm})]});
     wfsfm =   new OpenLayers.Layer.Vector("MODIFICAR",{
        strategies: [new OpenLayers.Strategy.BBOX(), saveStrategyfm],protocol: new OpenLayers.Protocol.WFS({
        srsName: "EPSG:32800", url:  "http://"+hostnew+"/geoserver/INEGI"+idreggeo+"/wfs",
        featureType: "cat_fm",featureNS: "http://"+hostnew+"/INEGI"+idreggeo+""}),
        projection: ccl, styleMap: stylefm
        ,filter: filtroed
    });
    wfsfm.displayInLayerSwitcher= false;wfsfm.isBaseLayer=false;map.addLayers ([wfsfm]);


    modifm = new OpenLayers.Control.ModifyFeature(
        wfsfm, {displayClass: "olControlModifymzFeature",title: "Modificar Frente por vertices"}
    );



    modifm2 = new OpenLayers.Control.ModifyFeature(wfsfm, {displayClass: "olControlModify2Feature", title: "Mover, rotar, tama\xF1o Frente"});
    modifm2.mode  = OpenLayers.Control.ModifyFeature.DRAG | OpenLayers.Control.ModifyFeature.ROTATE | OpenLayers.Control.ModifyFeature.RESIZE ;

        wfsfm.events.on({
            featureselected:onFeatureSelectFM
        });

     snapfm = new OpenLayers.Control.Snapping({layer: wfsfm,
                targets: [{
                    layer:wfsfm,
                    tolerance: 20,
                    edge: false,
                    filter: new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "surface",value: "dirt"})
                        }]
                });
    savefm = new OpenLayers.Control.Button({
        title: "Regenerar Manzana",
        trigger: function() {
            if(modifm.feature || modifm2.feature) {
                modimz1.selectControl.unselectAll();
            }
            saveStrategyfm.save();
            savemz.trigger();
                },
        displayClass: "olControlSaveFeatures"
    });

    cierrafm = new OpenLayers.Control.Button ({
                displayClass: 'olControlClose',
                trigger: function() {
                   modifm.deactivate();
                   modifm2.deactivate();
                    wfsfm.removeAllFeatures();
                    wfsfm.visibility=false;
                    wfsfm.removeMap();
                    wfsfm.destroy();
                    modifm.destroy();
                    modifm2.destroy();
                    savefm.destroy();
                    cierrafm.destroy();
                    snapfm.destroy();
                    panelfm.destroy();
                    panelfm=undefined;
                    editarfm.activate();               },
                title: 'Cerrar sin guardar'
            });
    panelfm = new OpenLayers.Control.Panel({displayClass: 'panelfmToolbar'});
    panelfm.addControls([modifm,modifm2,savefm,cierrafm,snapfm]);
    map.addControl(panelfm);
    modifm.activate();
       // wfsfm.setZIndex(maxzindex()+1);
        //console.log(wfsfm.getZIndex());
}


//------------------------- MOVER MANZANA POR FRENTES PERO DANDO CLICK  --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------






function onFeatureSelectFM(event){
    alertmsg("Frente: "+event.feature.attributes.cve_ft);
    snapfm.activate();
}



function saveSuccessFm(){
        borra();
    // refresco la capa al guardar los cambios
    var ajax=nuevoAjax();
    ajax.open("GET",'valida_fm.jsp?cve='+clavegeofm+'&baseimg='+baseimg+'&iduser='+iduser+'&escala='+map.getScale(), true);
    ajax.onreadystatechange=function()
    {
        if(ajax.readyState==4)  {
             var vale=ajax.responseText;
            if (parseInt(vale)==1){
                alertmsg ("Error al generar la manzana");
                wfsfm.refresh({force: true});
                wfsfm.redraw(true);
            }else if (parseInt(vale)==2){
                alertmsg ("Debe de cerrar los frentes");
                wfsfm.refresh({force: true});
                wfsfm.redraw(true);
            }else{
                alertmsg("Cambios guardados correctamente");
                wfs.refresh({force: true});
                wfs.redraw(true);
                if (mza_gen.getVisibility()){mza_gen.redraw(true);}

                    modifm.deactivate();
                    modifm2.deactivate();
                    wfsfm.removeAllFeatures();
                    wfsfm.visibility=false;
                    wfsfm.removeMap();
                    wfsfm.destroy();
                    modifm.destroy();
                    modifm2.destroy();
                    savefm.destroy();
                    cierrafm.destroy();
                    snapfm.destroy();
                    panelfm.destroy();
                    panelfm=undefined;
                    editarfm.activate();
            }
        }
    }
    ajax.send(null);
}




function saveFailFm(e){
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






////////// FUNCION PARA LOS CODIGO J //// ******************************************************************************************************
 function onFeatureSelectmzcasosJ(event){
// registrar el id del seleccionado para regresar movimientos
if (map.popups.length>0){
    onPopupClosemz();
}


var feature = event.feature;
var bandera=0;
var cveconca='';
 var ajax=nuevoAjax();
    ajax.open("GET",'obtcve.jsp?tipo=codigoj&clave='+feature.geometry.getCentroid()+'&cvemax=', true);
    ajax.onreadystatechange=function()
    {
        if(ajax.readyState==4)  {
             var vale=ajax.responseText;
            if (parseInt(vale)==0){
                alertmsg ("Debe estar sobre AgebU nueva");
                wfs.destroyFeatures([feature]);
            }else{
                cveconca=vale.trim().substring(0,14);
                vale=parseInt(vale.trim().substring(14,18));

                var valestr='';
                if (String(vale).length<3){
                    valestr=pad("0"+vale, 3);
                }else{
                    valestr=String(vale);
                }
                if (valestr.length>3){
                    valestr=valestr.substring(valestr.length-3,valestr.length);
                }
                idpop=feature.id;
                var  theHTML = '<center>';
                theHTML += '<table><tr><th colspan=2 class=label style="text-align:center">CAMBIO DE AMBITO';
                theHTML += '<tr><td colspan=2>&nbsp;';
                var theHTMLextra ='';
                theHTML += '<tr><td style="text-align:center" colspan=2 class=label style="text-align:right">Codigo:&nbsp;<select onChange="cambiaCgo(\'' + feature.id + '\');" class=input id="ban_'+feature.id+'">';
                theHTML += '<option value="J">J-Cambio de ambito';
                theHTML += '</select><br>';
                theHTML += '<tr><td class=label style="text-align:right">Clave entidad:&nbsp;<td><input class=input id="cve_ent_'+feature.id+'" type="text" size="6" maxlength="2"  value="'+cveconca.substring(0,2)+'" readOnly>';
                theHTML += '<tr><td class=label style="text-align:right">Clave municipio:&nbsp;<td><input class=input id="cve_mun_'+feature.id+'" type="text" size="6" maxlength="3"  value="'+cveconca.substring(2,5)+'" readOnly>';
                theHTML += '<tr><td class=label style="text-align:right">Clave localidad:&nbsp;<td><input class=input id="cve_loc_'+feature.id+'" type="text" size="6" maxlength="4"  value="'+cveconca.substring(5,9)+'" readOnly>';
                theHTML += '<tr><td class=label style="text-align:right" nowrap>Clave ageb (con -):&nbsp;<td><input class=input id="cve_ageb_'+feature.id+'" type="text" size="6" maxlength="5"  value="'+cveconca.substring(9,14)+'" onkeypress="return datonumatageb(event)" onkeyup="return datonumatageb2(event)">';

                theHTML += '</select>';
                theHTML += '<tr><td colspan=2>&nbsp;<tr><td style="text-align:center" colspan=2><input id="updatecasosinput'+feature.id+'" onclick="updateCasosJ(\'' + feature.id + '\');" class=input type="button" name="enviar" value="Comenzar TE">';
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
                       ,onPopupClosemz                //funcion al cerrar
                    );
                    feature.popup.opacity=0.9;
                    feature.popup.backgroundColor="#FE642E";
                    map.addPopup(feature.popup);
                    document.getElementById("pop").style.zIndex = "999";
            }
        }
    }
    ajax.send(null);
}

//FUNCION HACE UN UPDATE DE LOS CASES ESPECIALES DE MANZANA// ****************************************************************************************************************
function updateCasosJ(id){
    alertmsg ("Espere hasta que se cierre la ventana");
    var feature = wfs.getFeatureBy('id', id);
    eval ('ban = document.getElementById("ban_'+ id+'").value;');
    eval ('cve_ent = document.getElementById("cve_ent_'+ id+'").value;');
    eval ('cve_mun = document.getElementById("cve_mun_'+ id+'").value;');
    eval ('cve_loc = document.getElementById("cve_loc_'+ id+'").value;');
    eval ('cve_ageb = document.getElementById("cve_ageb_'+ id+'").value;');
    cve_ageb=cve_ageb.toUpperCase();
    eval ('document.getElementById("updatecasosinput'+id+'").disabled=true;');
    var ajax=nuevoAjax();
    ajax.open("GET",'mod_casosJ.jsp?tipo=1&cgo='+ban+'&cve_ent='+cve_ent+'&cve_mun='+cve_mun+'&cve_loc='+cve_loc+'&cve_ageb='+cve_ageb+'&us='+iduser, true);
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





////////// FUNCION PARA LOS CODIGO J //// ******************************************************************************************************
 function onFeatureSelectmzcasosJC(event){
// registrar el id del seleccionado para regresar movimientos
if (map.popups.length>0){
    onPopupClosemz();
}


var feature = event.feature;
var bandera=0;
var cveconca='';
 var ajax=nuevoAjax();
    ajax.open("GET",'obtcve.jsp?tipo=codigocj&clave='+feature.geometry.getCentroid()+'&cvemax=', true);
    ajax.onreadystatechange=function()
    {
        if(ajax.readyState==4)  {
             var vale=ajax.responseText;
            if (parseInt(vale)==0){
                alertmsg ("Debe estar sobre AgebU nueva");
                wfs.destroyFeatures([feature]);
            }else{
                cveconca=vale.trim().substring(0,14);
                vale=parseInt(vale.trim().substring(14,18));

                var valestr='';
                if (String(vale).length<3){
                    valestr=pad("0"+vale, 3);
                }else{
                    valestr=String(vale);
                }
                if (valestr.length>3){
                    valestr=valestr.substring(valestr.length-3,valestr.length);
                }
                idpop=feature.id;
                var  theHTML = '<center>';
                theHTML += '<table><tr><th colspan=2 class=label style="text-align:center">CAMBIO DE AMBITO';
                theHTML += '<tr><td colspan=2>&nbsp;';
                var theHTMLextra ='';
                theHTML += '<tr><td style="text-align:center" colspan=2 class=label style="text-align:right">Codigo:&nbsp;<select onChange="cambiaCgo(\'' + feature.id + '\');" class=input id="ban_'+feature.id+'">';
                theHTML += '<option value="J">J-Cambio de ambito';
                theHTML += '</select><br>';
                theHTML += '<tr><td class=label style="text-align:right">Clave entidad:&nbsp;<td><input class=input id="cve_ent_'+feature.id+'" type="text" size="6" maxlength="2"  value="'+cveconca.substring(0,2)+'" readOnly>';
                theHTML += '<tr><td class=label style="text-align:right">Clave municipio:&nbsp;<td><input class=input id="cve_mun_'+feature.id+'" type="text" size="6" maxlength="3"  value="'+cveconca.substring(2,5)+'" readOnly>';
                theHTML += '<tr><td class=label style="text-align:right">Clave localidad:&nbsp;<td><input class=input id="cve_loc_'+feature.id+'" type="text" size="6" maxlength="4"  value="'+cveconca.substring(5,9)+'" readOnly>';
                theHTML += '<tr><td class=label style="text-align:right" nowrap>Clave ageb (con -):&nbsp;<td><input class=input id="cve_ageb_'+feature.id+'" type="text" size="6" maxlength="5"  value="'+cveconca.substring(9,14)+'" onkeypress="return datonumatageb(event)" onkeyup="return datonumatageb2(event)">';

                theHTML += '</select>';
                theHTML += '<tr><td colspan=2>&nbsp;<tr><td style="text-align:center" colspan=2><input id="updatecasosinput'+feature.id+'" onclick="updateCasosJC(\'' + feature.id + '\');" class=input type="button" name="enviar" value="Comenzar TE">';
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
                       ,onPopupClosemz                //funcion al cerrar
                    );
                    feature.popup.opacity=0.9;
                    feature.popup.backgroundColor="#FE642E";
                    map.addPopup(feature.popup);
                    document.getElementById("pop").style.zIndex = "999";
            }
        }
    }
    ajax.send(null);
}

//FUNCION HACE UN UPDATE DE LOS CASES ESPECIALES DE MANZANA// ****************************************************************************************************************
function updateCasosJC(id){
    alertmsg ("Espere hasta que se cierre la ventana");
    var feature = wfs.getFeatureBy('id', id);
    eval ('ban = document.getElementById("ban_'+ id+'").value;');
    eval ('cve_ent = document.getElementById("cve_ent_'+ id+'").value;');
    eval ('cve_mun = document.getElementById("cve_mun_'+ id+'").value;');
    eval ('cve_loc = document.getElementById("cve_loc_'+ id+'").value;');
    eval ('cve_ageb = document.getElementById("cve_ageb_'+ id+'").value;');
    cve_ageb=cve_ageb.toUpperCase();
    eval ('document.getElementById("updatecasosinput'+id+'").disabled=true;');
    var ajax=nuevoAjax();
    ajax.open("GET",'mod_casosJ.jsp?tipo=2&cgo='+ban+'&cve_ent='+cve_ent+'&cve_mun='+cve_mun+'&cve_loc='+cve_loc+'&cve_ageb='+cve_ageb+'&us='+iduser+'&geom='+feature.geometry.toString(), true);

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




////////// FUNCION PARA LOS CASOS ESPECIALES DE LA MANZANA //// ******************************************************************************************************
 function onFeatureSelectmzChgform(event){
// registrar el id del seleccionado para regresar movimientos
if (map.popups.length>0){
    onPopupClosemz();
}
var feature = event.feature;
idpop=feature.id;
var  theHTML = '<center>';
theHTML += '<table><tr><th colspan=2 class=label style="text-align:center">Cambio de forma';
theHTML += '<tr><th colspan=2 class=label style="text-align:center">-> Multiples Manzanas <-';
theHTML += '<tr><th colspan=2 class=label style="text-align:center"><br><br>';

theHTML += '<tr><th colspan=2 class=label style="text-align:center"><n>Solo se modificaran las manzanas con codigos F que empalmen con el poligono</n>';

theHTML += '<tr><th colspan=2 class=label style="text-align:center"><br>';
theHTML += '<tr><td colspan=2>&nbsp;<tr><td style="text-align:center" colspan=2><input id="updatecasosinput'+feature.id+'" onclick="updateCasos_Chgform(\'' + feature.id + '\');" class=input type="button" name="enviar" value="Cambiar de forma">';
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
       ,onPopupClosemz                //funcion al cerrar
    );
    feature.popup.opacity=0.9;
    feature.popup.backgroundColor="#F489E9";
    map.addPopup(feature.popup);
    document.getElementById("pop").style.zIndex = "999";
}

//FUNCION HACE UN UPDATE DE LOS CASES ESPECIALES DE cambio de forma varios // ****************************************************************************************************************
function updateCasos_Chgform(id){
    alertmsg ("Espere hasta que se cierre la ventana");
    var feature = wfs.getFeatureBy('id', id);
    eval ('document.getElementById("updatecasosinput'+id+'").disabled=true;');
    var ajax=nuevoAjax();
    ajax.open("GET",'mod_casos_chgform.jsp?img='+baseimg+'&proy=16&us='+iduser+'&geom='+feature.geometry.toString(), true);
    ajax.onreadystatechange=function()
    {
        if(ajax.readyState==4)  {
             var vale=parseInt(ajax.responseText);
               map.removePopup(feature.popup);
                switch (vale){ //casos en que regresa mod_casos que segun el codigo si genera error o no aqui lo controlo
                    case 0:   //error
                            alertmsg ("Ocurrio algun error");
                            wfs.destroyFeatures([feature]);
                            break;
                    case 1:   //codigos 5,6,E,D,H,I,,M,N,O,Y
                            saveSuccessMz();
                            break;
                }
        }
    }
    ajax.send(null);
}

