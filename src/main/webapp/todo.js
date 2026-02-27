// codigo para que funcione el WFS en IE11 pinche IE
var _class = OpenLayers.Format.XML;
var originalWriteFunction = _class.prototype.write;
var patchedWriteFunction = function()
{
    var child = originalWriteFunction.apply( this, arguments );
    child = child.replace(new RegExp('xmlns:NS\\d+="" NS\\d+:', 'g'), '');
    return child;
}
_class.prototype.write = patchedWriteFunction;
// codigo para que funcione el WFS en IE11

//var escalacapa=[]
//var escalatext=[]

var zooms = [0.07464553542435169,0.14929107084870338,0.29858214169740677,0.5971642833948135,1.194328566789627,2.388657133579254,4.777314267158508,9.554628534317017,19.109257068634033,38.218514137268066,76.43702827453613,152.87405654907226,305.74811309814453,611.4962261962891,1222.9924523925781,2445.9849047851562,4891.9698095703125];
var escalatope;
var basesel="";edmz=0;edloc=0,edpre=0,edagpr=0;
var capasel=[0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
var textsel=[0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
var puntosel_ce=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
var puntotxt_ce=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
var wfsmov=[];
var styles;
var clicx,clicy;
var pointLayeralt,wfs,wfs_cdpol,wfs_punto,wfs_pe,ban1=0,map,fondovacio,fondo,spot5,spot6,gooimg,bingimg,gooimgStatic,esri,diglob,diglob2,capatema,vectema=[],baseimg='';
var spot6a;
var spot6b;
var spot6c;
var orto,geoeye1,geoeye2,imgex1,gsat,cartas,cartaset,cartas20,cartaset20,cartas5,cartas5rep,estados,estadoset,municipios,municipioset,agebs,agebset,municipios_ant,municipioset_ant;
var agebs_ant,agebset_ant,agebsur,agebsuret,locurb_ant,locurbet_ant,locrur_ant,locruret_ant,locurb,locurbet,locrurpol_ext,locrurpol,locrurpolet,locrur1,locruret1;
var locrur0,locruret0,locrurmov1,locrurmov0,asen,asenet,mza,mzaet,mza_gen,caserio_gen,mza_genet,servs,predig,mza_bcuu,vial,vialine,highlight,puntogen,bd_loc,caserio,polr_gen,polr_genet,agebu_gen,agebu_genet,mza_inv,mza_mod,mza_acu,mza_mod_rech,mza_mod_locrur;
var censo,ni_gen;
var shp_asen_ss='INEGI:asentamiento_2017_12';
var modify,modify2,valida,pendiente;
var cdsimplify,drawmz,drawsub,drawmulti,modimz1,fusmz,submz,modimz2,modiatmz,delmz,savemz,cod_mz,selectmz='';
var cve_ent='00',cve_mun='000',cve_loc='0000',cve_ageb='000-0',cve_mza='000',cve_temp='',banfid=0;
var editar0,editar1,editarmz,editarcd,editarpr,editarpe,editarau,refr,switmza,butagmz,butagmzpre,butfedg,snap,cierramz,cierra,cierraban=0,splitolerance;
var but_repdig_lista,veravancepredig,but_repdig_agrega,butsnap,editardigE,editardigF,editardigM,avdig,butCoverSv,butCoverInegiv,inegiview,denue,ce_c1,ce_c2,ce_c3,ce_c4,viviendas,anota,verdenue,vercobpob,vercobpobcenso,avcobce,avcobpob,coberturace,coberturapob,ventanaerror;
var agrmz=0,ediloc=1;
var arrhost=[];
var arrserv=[];var arrservw=[];
var arrreg=[];
var filterid='';
var mzamax=0,cvemax='';
var cvedef='';
var vienedegid='';
var mcctipomza='';
var mcc=0;
var max_au=0,max_pr=0,max_mz=0,max_pe=0;
var streetmap,streetview;
var markers,porpoligono,inv_punto;
var idpop,featureg;
var c1;
var split=false;
var avsnap=10;
var avsplit=2;
var ca_ac;var ca_ni, tiporeg,cutpol,cutpolvar=0;
var nivelcapa;
var cadenapoyo='',cadenapredig='',addsaptipo=0,addsapgid=0,addsapclas=0,addsapfigura='';
var addsap,regaddsap;
var panelDig;
var mztemp='';
var editarfm;
// filtros imagen dg
var filfe="",filnu='100';
//ventanas
var ventanaobtmza;
var brincamza=0;
var ventanaobtcd;
var brincacd=0;
var ventanasap,relacionafr,gidfr;
var mousecount=0;

var draw_cdpol ,modimz1_cdpol , modimz2_cdpol ,delmz_cdpol;
var idxpasa=0,idxcdmax=0,idxcdmin=0,idxcdmed=0;
var pre_mza , pre_pol ,pre_pun, draw_point,modi_point,del_point,bajaloc,obtmzF;
var vw_carga_tcar,crecimientos;
var cve_pe_temp="";
var cve_pe_tipo=0;
var ventana;
var predios_ne;
var dgwms=0;
var dgwms2=0;



 function init(nivel,filtroid,edicion,edicionmz,edicionpre,edicionagpr){
    if (nivel==1){
        cve_ent=filtroid;
    }
    tamanoVentana();
    nivelcapa=nivel;
    edloc=edicion;
    edmz=edicionmz;
    edagpr=edicionagpr;
    edpre=edicionpre;
    filterid=filtroid;
    document.getElementById('framecapas').src = document.getElementById('framecapas').src;
     sts=0;
     if(/sts=1/.test(location.search)){
        var sts=1;
     }
        var panel,paneloculto,c2,c3;
        var panel1,panel2,panel3,panel4,panel5,panel6,panel7;
        OpenLayers.ProxyHost = 'cgi-bin/proxy.cgi?url=';

        var bounds = new OpenLayers.Bounds(
        //661900.256,238231.923,
        //4317111.930,2444146.841
        //-120.80,13.56,
        //-84.15,33.23
        //-14122073,1332364,-8281061,4199058
        -13459673.0276619,1232095.46159631,-9281930.46183394,4109451.87806631
                );
        var res1 = restric.split(",");
        var bounds = new OpenLayers.Bounds(res1[0],res1[1],res1[2],res1[3]);
        var options = {
            controls: [],
            //maxExtent: bounds,
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

        //map.addControl(new OpenLayers.Control.LayerSwitcher({ascending:true,roundedCornerColor:'#EAE9E3'}));
        map.addControl(new OpenLayers.Control.Navigation());
        map.addControl(new OpenLayers.Control.MousePosition());
        //map.addControl(new OpenLayers.Control.NavToolbar());
        map.addControl(new OpenLayers.Control.ScaleLine());
        map.addControl(new OpenLayers.Control.PanZoomBar());
        map.addControl(new OpenLayers.Control.Scale());
//              nav = new OpenLayers.Control.NavigationHistory();
        nav = new OpenLayers.Control.NavigationHistory({
                previousOptions: {
                title: "Vista anterior"
            },
                nextOptions: {
                title: "Siguiente vista"
            }
        });

        // parent control must be added to the map
        map.addControl(nav);
        // parent control must be added to the map
        //map.addControl(new OpenLayers.Control.OverviewMap());
        //map.addControl(new OpenLayers.Control.KeyboardDefaults());
        //map.addControl(new OpenLayers.Contro3l.EditingToolbar(vlayer));
        //deshabilito este para mercator
        //map.fractionalZoom = true;

//CONTROL DE CAPAS PARA LA COMPARTICION DE USUARIOS ********************************************************************
//localhost=window.location.hostname;
//var servimg='';
arrhost.push(localhost);arrservw.push('-');arrserv.push('NEATIL.CEBALLOS');
arrhost.push('geogat045732d');arrservw.push('-');arrserv.push('MARIA.LOZANO');   //anterior geoigb042180d
arrhost.push('geogat046166d');arrservw.push('-');arrserv.push('ISRAEL.NAVARRO'); //anterior  geoigb042489d
arrhost.push('geogat046025d');arrservw.push('-');arrserv.push('LILIANA.RAMOS');   // anterior geoigb042167d
arrhost.push('geogat046078d');arrservw.push('-');arrserv.push('RAMON.MARQUEZ');  //anterior geoigb042485d
arrhost.push('geogat046050d');arrservw.push('-');arrserv.push('JOSE.CALZADA');   //anterior geoigb042534d
arrhost.push('geogat045677d');arrservw.push('-');arrserv.push('LUDIM.CASTILLO');
arrhost.push('geogat045713d');arrservw.push('-');arrserv.push('SEBASTIAN.CASTRO');    //anterior  geogat046087d (abdiel)
arrhost.push('geogat046028d');arrservw.push('-');arrserv.push('ARACELI.NIEVES'); 
arrhost.push('geogat045744d');arrservw.push('-');arrserv.push('MARTHA.ROJAS');  //ANTERIOR  geoigb042526d

//arrhost.push('geogat045676d');arrserv.push('ARMANDO.PARRA');
//arrhost.push('geogat046066d');arrserv.push('CARLOS.BRIANO');  //geoigb042486d

//host=localhost;servimg='NEATIL.CEBALLOS';

        /*setTimeout(function(){ 
            var a= map.getZoom();
            escalatope=a;
            }, 1000);
        */

//document.getElementById('geoserv').innerHTML = "<img onclick='javascript:verservers();'  src='images/geoserver.png' valign='top' width=14px Title='Proveedor de imagenes vectoriales: "+servimg+"'></img>";
document.getElementById('chgpass').innerHTML = "<img onclick='javascript:verchgpass();'  src='images/user.png' valign='top' width=14px Title='Cambiar password de SIGMA'></img>";
// CAPAS ****************************************************************************************************************
     cartas = new OpenLayers.Layer.WMS( "CARTAS",                       "http://"+hostnew+"/geoserver/INEGI/wms", {layers: 'INEGI:CARTAS',transparent: true},{visibility:false,singleTile: false,maxScale: 0,minScale: 3000000});
     cartaset = new OpenLayers.Layer.WMS( " - Etiquetas",               "http://"+hostnew+"/geoserver/INEGI/wms", {layers: 'INEGI:CARTAS',STYLES: 'cartaset',transparent: true},{visibility:false,singleTile: true,maxScale: 0,minScale: 1000000});
     cartas20 = new OpenLayers.Layer.WMS( "CARTAS20",                   "http://"+hostnew+"/geoserver/INEGI/wms", {layers: 'INEGI:CARTAS20',transparent: true},{visibility:false,singleTile: false,maxScale: 0,minScale: 3000000});
     cartaset20 = new OpenLayers.Layer.WMS( " - Etiquetas",             "http://"+hostnew+"/geoserver/INEGI/wms", {layers: 'INEGI:CARTAS20',STYLES: 'cartaset20',transparent: true},{visibility:false,singleTile: true,maxScale: 0,minScale: 1000000});

     estados = new OpenLayers.Layer.WMS( "ESTADOS",                     "http://"+hostnew+"/geoserver/INEGI/wms", {layers: 'INEGI:ESTADOS',transparent: true},{visibility:true,singleTile: false});
     estadoset = new OpenLayers.Layer.WMS( " - Etiquetas",              "http://"+hostnew+"/geoserver/INEGI/wms", {layers: 'INEGI:ESTADOS',STYLES: 'estadoset_sig',transparent: true},{visibility:true,singleTile: true});

     municipios = new OpenLayers.Layer.WMS( "MUNICIPIOS",               "http://"+hostnew+"/geoserver/INEGI/wms", {layers: 'INEGI:MUNICIPIOS',transparent: true},{visibility: false,singleTile: false,maxScale: 0,minScale: 3000000});
     municipioset = new OpenLayers.Layer.WMS( " - Etiquetas",           "http://"+hostnew+"/geoserver/INEGI/wms", {layers: 'INEGI:MUNICIPIOS',STYLES: 'municipioset_sig',transparent: true},{visibility: false,singleTile: true,maxScale: 0,minScale: 1000000});

     agebs = new OpenLayers.Layer.WMS( "AGEBS",                         "http://"+hostnew+"/geoserver/INEGI/wms", {layers: 'INEGI:AGEB',transparent: true},{visibility: false,singleTile: false,maxScale: 0,minScale: 1000000});
     agebset = new OpenLayers.Layer.WMS( " - Etiquetas",                "http://"+hostnew+"/geoserver/INEGI/wms", {layers: 'INEGI:AGEB',STYLES: 'agebset',transparent: true},{visibility: false,singleTile: true,maxScale: 0,minScale: 600000});

     agebsur = new OpenLayers.Layer.WMS( "AGEBS UR",                    "http://"+hostnew+"/geoserver/INEGI/wms", {layers: 'INEGI:AGEBURB',transparent: true},{visibility: false,singleTile: false,maxScale: 0,minScale: 60000});
     agebsuret = new OpenLayers.Layer.WMS( " - Etiquetas",              "http://"+hostnew+"/geoserver/INEGI/wms", {layers: 'INEGI:AGEBURB',STYLES: 'agebset',transparent: true},{visibility: false,singleTile: true,maxScale: 0,minScale: 60000});
     agebu_gen= new OpenLayers.Layer.WMS( "AGEBU_GEN",                  "http://"+hostnew+"/geoserver/INEGI"+idreggeo+"/wms", {layers: 'INEGI'+idreggeo+':v_agebu_gen',transparent: true},{visibility: false,singleTile: true,maxScale: 0,minScale: 60000});

     locurb= new OpenLayers.Layer.WMS( "LOC. URB.",                     "http://"+hostnew+"/geoserver/INEGI/wms", {layers: 'INEGI:POLIGONOS_URBANOS',transparent: true},{visibility: false,singleTile: false,maxScale: 0,minScale: 500000});
     locurbet= new OpenLayers.Layer.WMS( " - Etiquetas",                "http://"+hostnew+"/geoserver/INEGI/wms", {layers: 'INEGI:POLIGONOS_URBANOS',STYLES: 'urbanaset',transparent: true},{visibility: false,singleTile: true,maxScale: 0,minScale: 100000});

     locrurpol= new OpenLayers.Layer.WMS( "LOC. RUR. (POL)",            "http://"+hostnew+"/geoserver/INEGI/wms", {layers: 'INEGI:POLIGONOS_RURALES',STYLES: 'porur_ca',transparent: true},{visibility: false,singleTile: false,maxScale: 0,minScale: 300000});
     locrurpolet= new OpenLayers.Layer.WMS( " - Etiquetas",             "http://"+hostnew+"/geoserver/INEGI/wms", {layers: 'INEGI:POLIGONOS_RURALES',STYLES: 'poruret',transparent: true},{visibility: false,singleTile: true,maxScale: 0,minScale: 100000});
     polr_gen= new OpenLayers.Layer.WMS( "LOCPR_GEN",                   "http://"+hostnew+"/geoserver/INEGI"+idreggeo+"/wms", {layers: 'INEGI'+idreggeo+':v_locpr_gen',transparent: true},{visibility: false,singleTile: true,maxScale: 0,minScale: 300000});

     locrurpol_ext= new OpenLayers.Layer.WMS( "LOC. RUR. EXT. (POL)",   "http://"+hostnew+"/geoserver/INEGI/wms", {layers: 'INEGI:POL_RUR_EXT',transparent: true},{visibility: false,singleTile: false,maxScale: 0,minScale: 300000});
     locrurpol_ext_gen= new OpenLayers.Layer.WMS( "PE_GEN",             "http://"+hostnew+"/geoserver/INEGI"+idreggeo+"/wms", {layers: 'INEGI'+idreggeo+':v_locpe_gen',transparent: true},{visibility: false,singleTile: true,maxScale: 0,minScale: 300000});

     locrur0= new OpenLayers.Layer.WMS( "LOC. RUR. BAJA",               "http://"+hostnew+"/geoserver/INEGI/wms", {layers: 'INEGI:locs_puntuales_b',transparent: true},{visibility: false,singleTile: false,maxScale: 0,minScale: 200000});
     locruret0= new OpenLayers.Layer.WMS( " - Etiquetas",               "http://"+hostnew+"/geoserver/INEGI/wms", {layers: 'INEGI:locs_puntuales_b',STYLES: 'locsruret0',transparent: true},{visibility: false,singleTile: true,maxScale: 0,minScale: 100000});
     locrurmov0= new OpenLayers.Layer.WMS( " - Movidas",                "http://"+hostnew+"/geoserver/INEGI/wms", {layers: 'INEGI:shp_locr_coord',STYLES: 'locs_rur_movidas_gen',transparent: true,CQL_FILTER: 'ok=true and status=0'},{visibility: false,singleTile: false,maxScale: 0,minScale: 200000});

     locrur1= new OpenLayers.Layer.WMS( "LOC. RUR. VIGENTE",            "http://"+hostnew+"/geoserver/INEGI/wms", {layers: 'INEGI:locs_puntuales_v',transparent: true},{visibility: false,singleTile: false,maxScale: 0,minScale: 200000});
     locruret1= new OpenLayers.Layer.WMS( " - Etiquetas",               "http://"+hostnew+"/geoserver/INEGI/wms", {layers: 'INEGI:locs_puntuales_v',STYLES: 'locsruret1',transparent: true},{visibility: false,singleTile: true,maxScale: 0,minScale: 100000});
     locrurmov1= new OpenLayers.Layer.WMS( " - Movidas",                "http://"+hostnew+"/geoserver/INEGI/wms", {layers: 'INEGI:shp_locr_coord',STYLES: 'locs_rur_movidas_gen',transparent: true,CQL_FILTER: 'ok=true and status=1'},{visibility: false,singleTile: false,maxScale: 0,minScale: 200000});

     asen= new OpenLayers.Layer.WMS( "ASENTAMIENTOS",                   "http://"+hostnew+"/geoserver/INEGI/wms", {layers: shp_asen_ss,STYLES: 'asen1',transparent: true},{visibility: false,singleTile: false,maxScale: 0,minScale: 100000});
     asenet= new OpenLayers.Layer.WMS( " - Etiquetas",                  "http://"+hostnew+"/geoserver/INEGI/wms", {layers: shp_asen_ss,STYLES: 'asen1et',transparent: true},{visibility: false,singleTile: true,maxScale: 0,minScale: 50000});

     //mza= new OpenLayers.Layer.WMS( "MANZANAS",                         "http://"+hostnew+"/geoserver/INEGI/wms", {layers: 'INEGI:manz,INEGI:mza_muestra',transparent: true,CQL_FILTER: 'INCLUDE;rasgo=\'manzana\''},{visibility: false,singleTile: false,maxScale: 0,minScale: 60000});
    mza= new OpenLayers.Layer.WMS( "MANZANAS",                         "http://"+hostnew+"/geoserver/INEGI/wms", {layers: 'INEGI:manz',transparent: true,CQL_FILTER: 'INCLUDE'},{visibility: false,singleTile: false,maxScale: 0,minScale: 60000});


/*

var sizeWMS80 = 9783.939619140625;//este lo saco de geoserver exactamente para que de imagenes generadoas
var resolutionswms80 = [];
var matrixIdswms80 = [];
for (let z = 0; z < 22; ++z) {
    resolutionswms80[z] = sizeWMS80 / Math.pow(2, z);
    matrixIdswms80[z] = "EPSG:900913:" + z;
}


    mza = new OpenLayers.Layer.WMTS({
    name: "MANZANAS",
    url: "http://"+hostnew+"/geoserver/gwc/service/wmts",
    layer: "INEGI:manz",style: "",                            // estilo, deja vacío si quieres el default
    matrixSet: "EPSG:900913",               // TileMatrixSet
    matrixIds: matrixIdswms80,
    format: "image/png",                  // formato de teselas
    isBaseLayer: false,
    visibility: false,
    zoomOffset: 5,
    resolutions: resolutionswms80 // Agregar resoluciones correctas
//,    tileOrigin: new OpenLayers.LonLat(-13957260.605835227, 4062626.0) // 

});


*/





     mzaet= new OpenLayers.Layer.WMS( " - Etiquetas",                   "http://"+hostnew+"/geoserver/INEGI/wms", {layers: 'INEGI:manz',STYLES: 'mzaet',transparent: true},{visibility: false,singleTile: true,maxScale: 0,minScale: 20000});
     mza_gen= new OpenLayers.Layer.WMS( "MANZANAS_GEN",                 "http://"+hostnew+"/geoserver/INEGI"+idreggeo+"/wms", {layers: 'INEGI'+idreggeo+':v_cat_mza_gen',transparent: true},{visibility: false,singleTile: true,maxScale: 0,minScale: 60000});

     caserio= new OpenLayers.Layer.WMS( "CASERIO",                      "http://"+hostnew+"/geoserver/INEGI/wms", {layers: 'INEGI:caserio,INEGI:pem',transparent: true},{visibility: false,singleTile: false,maxScale: 0,minScale: 60000});
     caserio_gen= new OpenLayers.Layer.WMS( "CASERIO_GEN",              "http://"+hostnew+"/geoserver/INEGI"+idreggeo+"/wms", {layers: 'INEGI'+idreggeo+':v_cat_cd_gen,INEGI'+idreggeo+':cd_polext',transparent: true,CQL_FILTER: "INCLUDE;INCLUDE"},{visibility: false,singleTile: false,maxScale: 0,minScale: 60000});

     servs= new OpenLayers.Layer.WMS( "SERVICIOS",                      "http://"+hostnew+"/geoserver/INEGI/wms", {layers: 'servs',transparent: true},{visibility: false,singleTile: false,maxScale: 0,minScale: 20000});
     vial= new OpenLayers.Layer.WMS( "VIALIDADES",                      "http://"+hostnew+"/geoserver/INEGI/wms", {layers: 'INEGI:vialidades',STYLES: "vialet",transparent: true},{visibility: false,singleTile: true,maxScale: 0,minScale: 10000});
     vialine= new OpenLayers.Layer.WMS( " - Etiquetas",                 "http://"+hostnew+"/geoserver/INEGI/wms", {layers: 'INEGI:vialidades',STYLES: "vial",transparent: true},{visibility: false,singleTile: false,maxScale: 0,minScale: 10000});
     bd_loc= new OpenLayers.Layer.WMS( "*CAPTURA",                      "http://"+hostnew+"/geoserver/INEGI/wms", {layers: 'INEGI:a_bd_loc',STYLES: "a_bd_loc",transparent: true},{visibility: false,singleTile: false,maxScale: 0,minScale: 0});

    //// CAPAS DE REFERENCIA DE MANZANAS ****************************************************************************************************************
//     mza_mod= new OpenLayers.Layer.WMS( "MZ MOD",                       "http://"+hostnew+"/geoserver/INEGI"+idreggeo+"/wms", {layers: 'INEGI'+idreggeo+':cat_manz_modcar,INEGI'+idreggeo+':frentes,INEGI'+idreggeo+':mcc_loc_rur',transparent: true,CQL_FILTER: 'mal=0;INCLUDE;INCLUDE'},{visibility: false,singleTile: false,maxScale: 0,minScale: 60000});
     //mza_mod_locrur= new OpenLayers.Layer.WMS( "MZ MOD1",               "http://"+hostnew+"/geoserver/INEGI"+idreggeo+"/wms", {layers: 'INEGI'+idreggeo+':modcar_loc_rur',transparent: true},{visibility: false,singleTile: false,maxScale: 0,minScale: 1000000});
     //mza_mod_rech= new OpenLayers.Layer.WMS( "MZ MOD2",                 "http://"+hostnew+"/geoserver/INEGI"+idreggeo+"/wms", {layers: 'INEGI'+idreggeo+':cat_manz_modcar_rech',STYLES:"manz_modcar_rech",transparent: true},{visibility: false,singleTile: true,maxScale: 0,minScale: 60000});



     //mza_mod= new OpenLayers.Layer.WMS( "MZ MOD",                       "http://"+hostnew+"/geoserver/INEGI"+idreggeo+"/wms", {layers: 'INEGI'+idreggeo+':cat_manz_modcar,INEGI'+idreggeo+':modcar_frentes,INEGI'+idreggeo+':modcar_ejes,INEGI'+idreggeo+':modcar_inmuebles',transparent: true},{visibility: false,singleTile: true,maxScale: 0,minScale: 60000});

     //voy a usar esta capa para la cur
     mza_acu= new OpenLayers.Layer.WMS( "MZ ACU",                       "http://"+hostnew+"/geoserver/INEGI"+idreggeo+"/wms", {layers: 'INEGI'+idreggeo+':act_cu_manzana,INEGI'+idreggeo+':act_cu_frentes,INEGI'+idreggeo+':act_cu_vialidad,INEGI'+idreggeo+':act_cu_inmuebles',transparent: true},{visibility: false,singleTile: true,maxScale: 0,minScale: 60000});

     //voy a usar esta para los pe y lpr para separarlos 
     mza_mod_locrur= new OpenLayers.Layer.WMS( "MZ ACU",                       "http://"+hostnew+"/geoserver/INEGI"+idreggeo+"/wms", {layers: 'INEGI'+idreggeo+':act_cu_loc_rur,INEGI'+idreggeo+':act_cu_pe',transparent: true},{visibility: false,singleTile: true,maxScale: 0,minScale: 60000});


     //voy a usar esta capa para el MCC
     mza_mod= new OpenLayers.Layer.WMS( "MZ MOD",                       "http://"+hostnew+"/geoserver/INEGI"+idreggeo+"/wms", {layers: 'INEGI'+idreggeo+':cat_manz_modcar,INEGI'+idreggeo+':cat_manz_modcar_rech,INEGI'+idreggeo+':modcar_frentes,INEGI'+idreggeo+':modcar_ejes,INEGI'+idreggeo+':modcar_loc_rur',transparent: true},{visibility: false,singleTile: true,maxScale: 0,minScale: 60000});

     //mza_inv= new OpenLayers.Layer.WMS( "MZ INV",                       "http://"+hostnew+"/geoserver/INEGI"+idreggeo+"/wms", {layers: 'INEGI'+idreggeo+':v_cat_mza_inv',transparent: true},{visibility: false,singleTile: true,maxScale: 0,minScale: 60000});
     predig= new OpenLayers.Layer.WMS( "PREDIG",                        "http://"+hostnew+"/geoserver/INEGI"+idreggeo+"/wms", {layers: 'INEGI'+idreggeo+':z_digpe,INEGI'+idreggeo+':z_digmp,INEGI'+idreggeo+':z_digmz',transparent: true,CQL_FILTER:"INCLUDE;INCLUDE;INCLUDE"},{visibility: false,singleTile: true,maxScale: 0,minScale: 60000});
     //mz_ruvine= new OpenLayers.Layer.WMS( "MZ RUV",                     "http://"+hostnew+"/geoserver/INEGI"+idreggeo+"/wms", {layers: 'INEGI:manzanabcu_res',transparent: true},{visibility: false,singleTile: false,maxScale: 0,minScale: 60000});
     mza_bcuu= new OpenLayers.Layer.WMS( "MZ BCUU",                     "http://"+hostnew+"/geoserver/INEGI/wms", {layers: 'INEGI:manzanabcu_res',transparent: true},{visibility: false,singleTile: true,maxScale: 0,minScale: 60000});

// capade frentes
     cat_frentes= new OpenLayers.Layer.WMS( "frentes",                  "http://"+hostnew+"/geoserver/INEGI"+idreggeo+"/wms", {layers: 'INEGI'+idreggeo+':cat_fm',STYLES: "cat_frentes",transparent: true},{visibility: false,singleTile: true,maxScale: 0,minScale: 5000});

     vw_carga_tcar = new OpenLayers.Layer.WMS( "CARTAS-5rep",           "http://"+hostnew+"/geoserver/INEGI/wms", {layers: 'INEGI:vw_carga_tcar_masivo',transparent: true,CQL_FILTER:"estatus_en_paquete <>3 and estatus_en_paquete is not null"},{visibility:false,singleTile: true,maxScale: 0,minScale: 60000});


     //cartas5 = new OpenLayers.Layer.WMS( "CARTAS-5",                    "http://"+hostnew+"/geoserver/INEGI"+idreggeo+"/wms", {layers: 'INEGI'+idreggeo+':cartas5',transparent: true},{visibility:false,singleTile: false,maxScale: 0,minScale: 1000000});
     //cartas5rep = new OpenLayers.Layer.WMS( "CARTAS-5rep",              "http://"+localhost+":8070/geoserver/INEGI/wms", {layers: 'INEGI:cartas5rep',transparent: true},{visibility:false,singleTile: false,maxScale: 0,minScale: 1000000});
     cartas5rep = new OpenLayers.Layer.WMS( "CARTAS-5rep",              "http://"+hostnew+"/geoserver/INEGI/wms", {layers: 'INEGI:a_rep_mun',transparent: true},{visibility:false,singleTile: false});
     //coberturace = new OpenLayers.Layer.WMS( "coberturace",             "http://"+hostnew+"/geoserver/INEGI"+idreggeo+"/wms", {layers: 'INEGI'+idreggeo+':cob_ce19',transparent: true},{visibility:false,singleTile: false});
     //coberturace  = new OpenLayers.Layer.WMS( "coberturace",           "http://"+hostnew+"/geoserver/INEGI/wms", {layers: 'INEGI:poligonos_cm,INEGI:bufferpob',transparent: true},{visibility:false,singleTile: false});
     coberturapob = new OpenLayers.Layer.WMS( "coberturapob",           "http://"+hostnew+"/geoserver/INEGI/wms", {layers: 'INEGI:mza_muestra',STYLES: "mza_muestra2",transparent: true},{visibility:false,singleTile: false,maxScale: 0,minScale: 1000000});
     inegiview= new OpenLayers.Layer.WMS( "RUTAS",                      "http://"+hostnew+"/geoserver/INEGI/wms", {layers: 'INEGI:rutas',transparent: true},{visibility: false,maxScale: 0,minScale: 100000});

     //ca_ac= new OpenLayers.Layer.WMS( "AC",                              "http://"+hostnew+"/geoserver/INEGI/wms", {layers: 'INEGI:NAC_AC',transparent: true},{visibility: false,singleTile: false,maxScale: 0,minScale: 100000});
     ca_ni= new OpenLayers.Layer.WMS( "NI",                              "http://"+hostnew+"/geoserver/INEGI/wms", {layers: 'INEGI:NAL_NI,INEGI:NAC_AC',transparent: true},{visibility: false,singleTile: false,maxScale: 0,minScale: 100000});
     ni_gen= new OpenLayers.Layer.WMS( "NI_GEN",                         "http://"+hostnew+"/geoserver/INEGI"+idreggeo+"/wms", {layers: 'INEGI'+idreggeo+':modcar_terrenos',transparent: true},{visibility: false,singleTile: true,maxScale: 0,minScale: 100000});

     //denue= new OpenLayers.Layer.WMS( "DENUE",                           "http://"+hostnew+"/geoserver/INEGI/wms", {layers: 'INEGI:denue',transparent: true},{visibility: false,singleTile: false,maxScale: 0,minScale: 20000});
     viviendas= new OpenLayers.Layer.WMS( "VIVIENDAS",                    "http://"+hostnew+"/geoserver/INEGI"+idreggeo+"/wms", {layers: 'INEGI'+idreggeo+':viviendas',transparent: true},{visibility: false,singleTile: false,maxScale: 0,minScale: 20000});
     anota= new OpenLayers.Layer.WMS( "ANOTA",                            "http://"+hostnew+"/geoserver/INEGI"+idreggeo+"/wms", {layers: 'INEGI'+idreggeo+':cat_marks,INEGI'+idreggeo+':v_instalacion_diversa',transparent: true},{visibility: false,singleTile: false,maxScale: 0,minScale: 200000});

     //SHAPE
     //crecimientos= new OpenLayers.Layer.WMS( "CRECIMIENTOS",                    "http://"+hostnew+"/geoserver/INEGI/wms", {layers: 'INEGI:C_BASCRECI',transparent: true},{visibility: false,singleTile: false,maxScale: 0,minScale: 500000});
     // BD
     crecimientos= new OpenLayers.Layer.WMS( "CRECIMIENTOS",                    "http://"+hostnew+"/geoserver/INEGI/wms", {layers: 'INEGI:crec_google',transparent: true},{visibility: false,singleTile: false,maxScale: 0,minScale: 150000});


     // manzanas
     //censo= new OpenLayers.Layer.WMS( "Censo",   "https://censo2020.inegi.org.mx/NLBCPV/balancer.do?map=/opt/map/censo_poblacion_Ene2020.map&FORMAT=image%2Fpng&MAXRESOLUTION=4891.969809375&MINZOOMLEVEL=5&ZOOMOFFSET=5&TATO=0&LAYERNAME=&SERVICE=WMS&VERSION=1.1.1&REQUEST=GetMap&STYLES=&CVE_OPE=00&PERFIL_AVANCE=1&FILTRO_OPER=&FILTRO=0&CVE_BUSQUEDA=&ETAPA=2&EDO=00&CVEGEO=&CE=1&CM=1&RA=1&FIRM=137&SRS=EPSG%3A900913", 
      //{layers: 'c107v',transparent: true},{visibility: false,singleTile: false});
     // puntos
     //censo= new OpenLayers.Layer.WMS( "Censo",   "https://censo2020.inegi.org.mx/NLBCPV/balancer.do?map=/opt/map/censo_poblacion_Ene2020.map&transparent=true&FORMAT=image%2Fpng&MAXRESOLUTION=4891.969809375&MINZOOMLEVEL=5&ZOOMOFFSET=5&TATO=0&LAYERNAME=&SERVICE=WMS&VERSION=1.1.1&REQUEST=GetMap&STYLES=&CVE_OPE=00&PERFIL_AVANCE=2&FILTRO_OPER=&FILTRO=0&CVE_BUSQUEDA=&ETAPA=2&EDO=00&CVEGEO=&CE=0&CM=0&RA=0&FIRM=36&SRS=EPSG%3A900913&ESTATUS_VIV=",
      //{layers: 'c108',transparent: true},{visibility: false,singleTile: false});


     ce_c1= new OpenLayers.Layer.WMS( "DENUE1",                           "http://"+hostnew+"/geoserver/INEGI/wms", {layers: 'INEGI:locs_eco',transparent: true},{visibility: false,singleTile: false,maxScale: 0,minScale: 200000});
     ce_c2= new OpenLayers.Layer.WMS( "DENUE2",                           "http://"+hostnew+"/geoserver/INEGI/wms", {layers: 'INEGI:PAR_IND',transparent: true},{visibility: false,singleTile: false,maxScale: 0,minScale: 200000});
     ce_c3= new OpenLayers.Layer.WMS( "DENUE3",                           "http://"+hostnew+"/geoserver/INEGI/wms", {layers: 'INEGI:servpa',transparent: true},{visibility: false,singleTile: false,maxScale: 0,minScale: 200000});
     ce_c4= new OpenLayers.Layer.WMS( "DENUE4",                           "http://"+hostnew+"/geoserver/INEGI"+idreggeo+"/wms", {layers: 'INEGI'+idreggeo+':denue',transparent: true},{visibility: false,singleTile: false,maxScale: 0,minScale: 20000});


     predios_ne= new OpenLayers.Layer.WMS( "PREDIOSNE",                   "http://10.210.140.70:9080/geoserver/catastro/wms", {layers: 'predios_ne',transparent: true},{visibility: false,singleTile: false,maxScale: 0,minScale: 30000});




    highlight = new OpenLayers.Layer.Vector("INFORMACION", {
        displayInLayerSwitcher: false,
        isBaseLayer: false,
        renderers: ["Canvas", "SVG", "VML"],
    });
     puntogen = new OpenLayers.Layer.Vector("PUNTO", {
        displayInLayerSwitcher: false,
        isBaseLayer: false
    });

//Red Nacional de Caminos 
rnc = new OpenLayers.Layer.WMS("rnc", "https://antares.inegi.org.mx/geoserver/AnalisisEspacial/wms?format=image/png",{layers: 'RedCarretera2024',transparent: true},{visibility: false,singleTile: false,maxScale: 0,minScale: 500000} );



// REGISTRO DE ARRAYS DE ESCALAS Y TEXTOS
//escalacapa=[Math.round(cartas.minScale),Math.round(estados.minScale),Math.round(municipios.minScale),Math.round(agebs.minScale),Math.round(agebsur.minScale),Math.round(locurb.minScale),Math.round(locrurpol.minScale),Math.round(locrurpol_ext.minScale),Math.round(locrur1.minScale),Math.round(locrur0.minScale),Math.round(asen.minScale),Math.round(mza.minScale),Math.round(mza_gen.minScale),Math.round(servs.minScale),Math.round(vial.minScale),Math.round(bd_loc.minScale),Math.round(municipios_ant.minScale),Math.round(agebs_ant.minScale),Math.round(locurb_ant.minScale),Math.round(locrur_ant.minScale)]
//escalatext=[Math.round(cartaset.minScale),Math.round(estadoset.minScale),Math.round(municipioset.minScale),Math.round(agebset.minScale),Math.round(agebsuret.minScale),Math.round(locurbet.minScale),Math.round(locrurpolet.minScale),0,Math.round(locruret1.minScale),Math.round(locruret0.minScale),Math.round(asenet.minScale),Math.round(mzaet.minScale),Math.round(mza_genet.minScale),0,0,0,Math.round(municipioset.minScale),Math.round(agebset.minScale),Math.round(locurbet_ant.minScale),Math.round(locruret_ant.minScale)]

//CAPAS BASE  ****************************************************************************************************************
fondovacio = new OpenLayers.Layer.OSM("0-VACIO","images/blank.png",{numZoomLevels:17,minZoomLevel:5,maxZoomLevel:21,maxResolution: 4891.969809375});
fondo = new OpenLayers.Layer.WMS("99-VACIO","http://gaiamapas3.inegi.org.mx/mdmCache/service/wms?format=image/jpeg",{layers: 'MapaBaseTopograficov61_sinsombreado',transparent: true},{isBaseLayer:true,displayInLayerSwitcher: true, opacity: 0.3} );



//fondo = new OpenLayers.Layer.WMS("0-VACIO","http://"+localhost+":8070/geoserver/INEGI/wms?format=image/jpeg", {layers: 'INEGI:FONDO',transparent: true},{isBaseLayer:true,displayInLayerSwitcher: true} );
//spot5 = new OpenLayers.Layer.WMS("2-SPOT-5","http://"+localhost+":8070/geoserver/INEGI/wms?format=image/jpeg", {layers: 'INEGI:spot5',transparent: true},{isBaseLayer:true,displayInLayerSwitcher: true} );
//spot6 = new OpenLayers.Layer.WMS("3-SPOT-6","http://10.152.11.51:82/spot_2014_2015?srs=EPSG:3857", {layers: 'spot_2014_2015',transparent: true},{isBaseLayer:true,displayInLayerSwitcher: true} );
//ESTE LO VOY A USAR PARA ONE ATLAS
/*
 spot6 = new OpenLayers.Layer.WMS(
            "3-SPOT-6", // Nombre de la capa
            "",
            {
                layers: "layer_0", // Nombre de la capa
                format: "image/png", // Formato de imagen
                //style: "rgb",
                //dpiMode: "7",
                transparent: true, // Fondo transparente
                version: "1.1.1", // Versión WMS
                srs: "EPSG:3857", // Sistema de referencia
                //username: "APIKEY",
                //password: "MR5HgAOug-KXxmDS5kzwrW85HIuKqDAgY2vWmthZQWuUDcYfPTsrPCXr2P93-w-pJQVA014f7wLvohn9cqlEpw==" // Token de autenticación
            },
            {
                isBaseLayer:true,
                displayInLayerSwitcher: true,
                //tileSize: new OpenLayers.Size(512, 512), // Aumenta el tamaño de los tiles
                //maxExtent: new OpenLayers.Bounds(spot6extent0, spot6extent1, spot6extent2, spot6extent3),
                //buffer: 10, // Aumenta el buffer para reducir el corte de imágenes
                //singleTile: true, // Obtiene una sola imagen en lugar de múltiples tiles
            }
           );


spot6a = new OpenLayers.Layer.WMS("3-SPOT-6a", "",{layers: "layer_0", format: "image/png",transparent: true, version: "1.1.1", srs: "EPSG:3857",},{visibility: false,displayInLayerSwitcher: false,
        //tileSize: new OpenLayers.Size(512, 512),
        //buffer: 10,
    });

*/

spot6 = new OpenLayers.Layer.XYZ(
    "3-SPOT-6",
    (window.location.origin.replace('8070','3001'))+"/wmts/tiles/img/tok/1.0.0/default/rgb/EPSG3857/${z}/${x}/${y}.png",
    {
      sphericalMercator: true,
      isBaseLayer: true,
      visibility: false,
      numZoomLevels:22,

    }
  );



spot6a = new OpenLayers.Layer.XYZ(
    "3-SPOT-6a",
    (window.location.origin.replace('8070','3001'))+"/wmts/tiles/img/tok/1.0.0/default/rgb/EPSG3857/${z}/${x}/${y}.png",
    {
      sphericalMercator: true,
      isBaseLayer: false,
      numZoomLevels:22,
      visibility: false

    }
  );




/*
spot6b = new OpenLayers.Layer.WMS("3-SPOT-6b", "https://access.foundation.api.oneatlas.airbus.com/api/v1/items/6f490654-49ec-477a-aa9f-7f91e967c05d/wms",{layers: "layer_0", format: "image/png",transparent: true, version: "1.1.1", srs: "EPSG:3857",},{visibility: false,displayInLayerSwitcher: false,
        //tileSize: new OpenLayers.Size(512, 512),
        //buffer: 10,
    });
spot6c = new OpenLayers.Layer.WMS("3-SPOT-6c", "https://access.foundation.api.oneatlas.airbus.com/api/v1/items/6f490654-49ec-477a-aa9f-7f91e967c05d/wms",{layers: "layer_0", format: "image/png",transparent: true, version: "1.1.1", srs: "EPSG:3857",},{visibility: false,displayInLayerSwitcher: false,
        //tileSize: new OpenLayers.Size(512, 512),
        //buffer: 10,
    });
*/

/*
var optionsGoogleStatic = {
    singleTile: true,
    ratio: 1,
    isBaseLayer: true,
    wrapDateLine: true,
    getURL: function() {
        var center = this.map.getCenter().transform("EPSG:900913", "EPSG:4326"),
            size = this.map.getSize();
        return [
            this.url, "&center=", center.lat, ",", center.lon,
            "&zoom=", this.map.getZoom()+4, "&size=", size.w, "x", size.h
        ].join("");
    }
};

gooimgStatic = new OpenLayers.Layer.Grid(
            "7-GOOGLE",
            "http://maps.googleapis.com/maps/api/staticmap?sensor=false&key=AIzaSyAL8-CvaNgh7c1C7Zh7X4AFxrLxsXZNDO4&maptype=satellite&scale=2", 
            null, OpenLayers.Util.applyDefaults({
                getURL: function() {
                    var center = this.map.getCenter().transform("EPSG:900913", "EPSG:4326"),
                        size = this.map.getSize();
                    return [
                        this.url, "&center=", center.lat, ",", center.lon,
                        "&zoom=", (this.map.getZoom() +4),
                        "&size=", Math.floor(size.w / 2), "x", Math.floor(size.h / 2)
                    ].join("");
                }
            }, optionsGoogleStatic)
        );
*/
if (nored==0){
   //gooimg = new OpenLayers.Layer.Google("5-GOOGLE",{type: google.maps.MapTypeId.ROADMAP,minZoomLevel:5,maxZoomLevel:21,transparent: 'true', alpha: true,transitionEffect: "resize"});
   //capa de mapa de calles de google maps

    gooimg = new OpenLayers.Layer.XYZ("5-GOOGLE",["https://mt0.google.com/vt/lyrs=s&w=256&h=256&hl=en&style=40,18&x=${x}&y=${y}&z=${z}"],
    {
        zoomOffset: 5,
        visibility: false,
        isBaseLayer : true
    });

/*
    bingimg = new OpenLayers.Layer.Bing({
                name: "12-BING",
                key: "AmX1FVgGILJ-v3nO2tttFP5-CrYrAIip7w0Uzd9T_UfQqZz6ZoDrmgyv2rnhxO9z",
                type: "Aerial"
            });
*/
   /*
   streetmap = new OpenLayers.Layer.Google("8-GOOGLESM", {type: google.maps.MapTypeId.ROADMAP,minZoomLevel:5,maxZoomLevel:21,transparent: 'true', alpha: true,transitionEffect: "resize"});
   setTimeout(function(){ 
        streetmap.mapObject.setTilt(0);
        //gooimg.mapObject.setTilt(0);
    }, 10000);
}else{
    gooimg = new OpenLayers.Layer.WMS( "0-GOOGLE (VACIO)",  {isBaseLayer:true,displayInLayerSwitcher: true} );
    //capa de mapa de calles de google maps
    streetmap = new OpenLayers.Layer.Google("0-GOOGLE (VACIO)", {isBaseLayer:true,displayInLayerSwitcher: true} );
*/
}
esri = new OpenLayers.Layer.ArcGIS93Rest("6-ESRI","http://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/export?f=image",{sphericalMercator: true} );
orto = new OpenLayers.Layer.WMS( "1-ORTOFOTOS","http://gaiamapas1.inegi.org.mx/mdmCache/service/wms?format=image/jpeg", {layers: 'MapaBaseOrtofoto',transparent: true},{isBaseLayer:true,displayInLayerSwitcher: true} );
//geoeye1 son las del 2016 para atraz y el geoeye2 son las supuetas 2017

//geoeye1 = new OpenLayers.Layer.WMS("9-GEOEYE","http://10.152.11.51:6080/arcgis/services/alta_res/cpc/ImageServer/WMSServer?srs=EPSG:3857", {layers: 'cpc',transparent: true},{isBaseLayer:true,displayInLayerSwitcher: true} );
//geoeye2 = new OpenLayers.Layer.WMS("10-GEOEYE","http://10.152.11.51:6080/arcgis/services/alta_res/ortorec_bcuu/MapServer/WMSServer?srs=EPSG:3857", {layers: 'Imagen',transparent: true},{isBaseLayer:true,displayInLayerSwitcher: true} );


//imgex1 = new OpenLayers.Layer.WMS("11-IMGEX1","http://10.152.11.51:82/mod_catastral_edomex?srs=EPSG:3857", {layers: 'Mpios_edomex',transparent: true},{isBaseLayer:true,displayInLayerSwitcher: true} );


//capa de cobertura de open street map
streetview = new OpenLayers.Layer.XYZ("GoogleStreetView",["https://mts2.google.com/mapslt?lyrs=svv&w=256&h=256&hl=en&style=40,18&x=${x}&y=${y}&z=${z}"],
{
    //sphericalMercator: true,
    zoomOffset: 5,
    visibility: false,
    //minZoomLevel:5,maxZoomLevel:21,
    //transparent: 'true',
    isBaseLayer : false,
    opacity : 0.5
});




////WMS
//diglob = new OpenLayers.Layer.WMS( "4-DIG. GLOBE",
    //"https://services.digitalglobe.com/mapservice/wmsaccess?connectid=ed19600c-7fe8-471c-bde0-2708e95149a1&SRS=EPSG%3A3857", {layers: 'DigitalGlobe:Imagery',transparent: true},{isBaseLayer:true,displayInLayerSwitcher: true} );
////WMTS - esta mejor con esta ya que guarda las imagenes en la compu cliente
/*
var matrixIds = new Array(21);
    for (var i=0; i<21; ++i) {
        matrixIds[i] = "EPSG:3857:" + (i);
    }


diglob = new OpenLayers.Layer.WMTS({name: "4-DIG. GLOBE",
        //url: "https://access.maxar.com/earthservice/wmtsaccess?connectid=e9f730a6-bc7b-4c79-89bd-67b4c17d557d",
        url: "https://securewatch.maxar.com/earthservice/wmtsaccess?connectid=d00cf4ef-159e-4abe-bc7b-816599f09238",
        layer: "DigitalGlobe:ImageryTileService",matrixSet: "EPSG:3857",matrixIds: matrixIds,
        zoomOffset: 5,
        format: "image/png",style: "_null",isBaseLayer: true});
*/




var urldg='';
    //urldg="https://"+userdg+":"+passdg+"@services.digitalglobe.com/mapservice/wmsaccess?connectid=e9f730a6-bc7b-4c79-89bd-67b4c17d557d&SRS=EPSG:3857&format=image/png";
    //urldg="https://services.digitalglobe.com/mapservice/wmsaccess?connectid=e9f730a6-bc7b-4c79-89bd-67b4c17d557d&SRS=EPSG:3857&format=image/png";
    urldg="https://securewatch.maxar.com/earthservice/wmtsaccess?connectid=d00cf4ef-159e-4abe-bc7b-816599f09238&SRS=EPSG:3857&format=image/png";

//diglob = new OpenLayers.Layer.WMS( "4-DIG. GLOBE",urldg,  ,
// {layers: 'DigitalGlobe:ImageryTileService',transparent: true},
// {isBaseLayer:true,
//    displayInLayerSwitcher: true} );



/*
var projectionExtentMosDG = [-16065354.0000000000000000,16598.0000000007639755 , -6241025.0000000074505806,6273235.9999999981373549];
//var size = 8455.624650410158;//ol.extent.getWidth(projectionExtentMosDG) / 256;
//var resolutionsMosDG = [];
var matrixIdsMosDG = [];
//var projectionMosDG=OpenLayers.Projection('EPSG:3857');
   for (var z = 0; z < 21; ++z) {
//                resolutionsMosDG[z] = size / Math.pow(2, z);
                matrixIdsMosDG[z] = "EPSG:900913:" + (z);
            }

diglob2 = new OpenLayers.Layer.WMTS({name: "13-DIG. GLOBE2",
        url: "https://ce2024.inegi.org.mx/mdmCacheSatCE24/service/wmts",
        layer: "Mapa%20imagenes%20CE2024",matrixSet: "EPSG:900913",matrixIds: matrixIdsMosDG,
        zoomOffset: 5,
        format: "image/jpeg",style: "_null",isBaseLayer: true});
*/

var size2 = 9936.2215;//ol.extent.getWidth(projectionExtentMosDG) / 256;  --saco el dato de QGIS la capa cargada

//var size2 = 9783.939619140625;//este es el de wms geoserver8080 capa manz wmts

const resolutionsMosSI = [];
const matrixIdsMosSI = [];
for (let z = 0; z < 17; ++z) {
    resolutionsMosSI[z] = size2 / Math.pow(2, z);
    matrixIdsMosSI[z] = "EPSG:3857:" + z;
}



// Crear la capa WMTS en OpenLayers 2
diglob2 = new OpenLayers.Layer.WMTS({
    name: "13-DIG. GLOBE2",
    url: "http://10.153.3.20:85/geowebcache/service/wmts", // QUITAR "?crs=EPSG:3857"
    layer: "SIDAISAR",
    matrixSet: "EPSG:3857",
    matrixIds: matrixIdsMosSI,
    format: "image/png",
    style: "_null",
    isBaseLayer: true,
    resolutions: resolutionsMosSI, // Agregar resoluciones correctas
    tileOrigin: new OpenLayers.LonLat(-13957260.6058352272957563, 4062626.0), // Revisar en GetCapabilities
});




geoeye1 = new OpenLayers.Layer.WMTS({name: "9-GEOEYE",
        url: "https://eic2025.inegi.org.mx/mdmCacheSatelite/service/wmts",
        layer: "CPV_2020",
        matrixSet: "EPSG:3857",
        matrixIds: matrixIdsMosSI,
        //zoomOffset: 7,
        format: "image/png",
        style: "_null",
        isBaseLayer: true,resolutions: resolutionsMosSI, // Agregar resoluciones correctas
    tileOrigin: new OpenLayers.LonLat(-13957260.6058352272957563, 4062626.0), // Revisar en GetCapabilities
});


const matrixIdsMosBM = [];
for (let z = 0; z < 15; ++z) {
    matrixIdsMosBM[z] = `${(z+5)}`;
}

diglob= new OpenLayers.Layer.WMTS({
    name: "3-SPOT-6", // Nombre de la capa
    url: "", // URL base del WMTS
    layer: "OneAtlas_Basemap", // Nombre de la capa en el servidor
    matrixSet: "OneAtlas_Basemap-3857", // Matriz de teselas (según el GetCapabilities)
    matrixIds: matrixIdsMosBM,
    format: "image/jpeg", // Formato de imagen
    style: "", // Algunos servicios no requieren un estilo
    isBaseLayer: false, // Si es una capa base
    tileSize: new OpenLayers.Size(256, 256), // Tamaño de los tiles
    maxExtent: new OpenLayers.Bounds(-20037508, -20037508, 20037508, 20037508), // Extensión máxima en EPSG:3857
    projection: "EPSG:3857", // Sistema de referencia
    visibility: false
});



var info = new OpenLayers.Control.WMSGetFeatureInfo({
    layers: [ca_ni,viviendas,anota,ce_c1,ce_c2,ce_c3,ce_c4,servs,vial,caserio,caserio_gen,mza_mod,mza_mod_locrur,mza_acu,mza,mza_gen,mza_bcuu,locrurpol_ext,locrurpol_ext_gen,asen,locrur1,locrur0,locrurpol,locurb,polr_gen,agebsur,agebs,agebu_gen,municipios,estados,cartas20,cartas,bd_loc],
    drillDown:true ,
    queryVisible: true ,
     maxFeatures:20,
     displayClass: "olControlSelectFeature", title: "Informacion" });
 
  //then i declare a variable that help me to handle more than 1 request.....
 info.responses  = [];
 info.handleResponse=function(xy, request) {
    var doc = request.responseXML;
    if(!doc || !doc.documentElement) {   
        doc = request.responseText; 
    }
    var features = this.format.read(doc);
    if (this.drillDown === false) {
        this.triggerGetFeatureInfo(request, xy, features);
    } else {
        this._requestCount++;
        this._features = (this._features || []).concat(features);
        if( this._numRequests > 1){
                          //if the num of RQ, (I mean more than 1 resource ), i put the Request in array, this is for maybe in a future i could be need other properties or methods from RQ, i dont know.
            this.responses.push(request);
        }else{
            this.responses = request;
        }
        if (this._requestCount === this._numRequests) {
            //here i change the code....
            //this.triggerGetFeatureInfo(request, xy, this._features.concat());
            this.triggerGetFeatureInfo(this.responses, xy, this._features.concat());
            delete this._features;
            delete this._requestCount;
            delete this._numRequests;
            // I Adding this when the all info is done 4 reboot
            this.responses=[];
        }
    }
  }

 info.triggerGetFeatureInfo= function( request , xy , features) {
//finally i added this code for get all request.responseText's
if( (request instanceof Array)  ){
    text_rq = '';
    for(i in request ){
        text_rq += request[i].responseText;
        //console.log (text_rq);
    }
}else{
            text_rq = request.responseText;
}

    this.events.triggerEvent("getfeatureinfo", {
       //text: request.responseText,
       text : text_rq,
        features: features,
        request: request,
        xy: xy
    }
    );

// Reset the cursor.
    OpenLayers.Element.removeClass(this.map.viewPortDiv, "olCursorWait");
    this.addPopup(map, text_rq, xy);

}

info.addPopup = function(map, text, xy) {
    //if(map.popups.length > 0) {
    //    map.removePopup(map.popups[0]);
    //}
    var infocld = new OpenLayers.Popup.FramedCloud(
        "chicken",
        map.getLonLatFromPixel(xy),
        null,
        text,
        null,
        true
    );
    map.addPopup(infocld);
    document.getElementById("chicken").style.zIndex = maxzindex()+1;

    }



//------------------------------------------------
    var sketchSymbolizers = {
                "Point": {pointRadius: 3,graphicName: "circle",strokeWidth: 1,strokeOpacity: 1,strokeColor: "#333333"},
                "Line": {strokeWidth: 1,strokeOpacity: 1,strokeColor: "#666666",strokeDashstyle: "dash"},
                "Polygon": {strokeWidth: 2,strokeOpacity: 1,strokeColor: "#666666",fillColor: "white",fillOpacity: 0.3}            };
    var style = new OpenLayers.Style();
            style.addRules([new OpenLayers.Rule({symbolizer: sketchSymbolizers})]);
    var styleMap = new OpenLayers.StyleMap({"default": style});

    var renderer = OpenLayers.Util.getParameters(window.location.href).renderer;
            renderer = (renderer) ? [renderer] : OpenLayers.Layer.Vector.prototype.renderers;

            control = new OpenLayers.Control.Measure(
                OpenLayers.Handler.Path, {
                        persist: true,handlerOptions: {layerOptions: {renderers: renderer,styleMap: styleMap}},
                    displayClass: "olControlMeasure",title: "Medir"});

                control.events.on({
                    "measure": handleMeasurements,"measurepartial": handleMeasurements
                });
                control.setImmediate(true);

    var stylesvp = new OpenLayers.StyleMap({pointRadius: 10,externalGraphic: 'images/streetv.png'});
    var stylesinegip = new OpenLayers.StyleMap({pointRadius: 10,externalGraphic: 'images/inegiv.png'});
    var pointLayer = new OpenLayers.Layer.Vector("PointSV",{styleMap:stylesvp});
    var pointLayerinegi = new OpenLayers.Layer.Vector("PointSV",{styleMap:stylesinegip});

    markers = new OpenLayers.Layer.Markers( "Markers" );

    var butsv = new OpenLayers.Control.DrawFeature(
            pointLayer,
            OpenLayers.Handler.Point,
            {eventListeners: {
                featureadded: function(e) {
                        /*
                        map.addLayer(markers);
                        var size = new OpenLayers.Size(23,25);
                        var icon = new OpenLayers.Icon('images/streetv_0.png',size);
                        if (markers.markers.length>0){  //si ya existe solo la muevo
                            markers.clearMarkers();
                        }
                        markers.addMarker(new OpenLayers.Marker(new OpenLayers.LonLat( e.feature.geometry.x, e.feature.geometry.y),icon));
                        */
                        var ll = e.feature.geometry.transform(new OpenLayers.Projection('EPSG:900913'), new OpenLayers.Projection('EPSG:4326'));
                        ventana = window.open("streetview.html?lon="+ll.x+"&lat="+ll.y,"Street","scrollbars=no,toolbar=no,resizable=no");
                        //document.getElementById('framecapas_sv').src = "streetview_dentro.html?lon="+ll.x+"&lat="+ll.y;
                        //document.getElementById('ventana-flotante_sv').className = 'mostrar';
                        //ventana.focus();
                        }
                },
            displayClass: "olControlStreetv",
            title: "Ver Street Map"
            }
        );


var butinegiv = new OpenLayers.Control.DrawFeature(
            pointLayerinegi,
            OpenLayers.Handler.Point,
            {eventListeners: {
                featureadded: function(e) {
                        map.addLayer(markers);
                        var size = new OpenLayers.Size(13,20);
                        var icon = new OpenLayers.Icon('images/inegiv.png',size);
                        if (markers.markers.length>0){  //si ya existe solo la muevo
                            markers.clearMarkers();
                        }
                        markers.addMarker(new OpenLayers.Marker(new OpenLayers.LonLat( e.feature.geometry.x, e.feature.geometry.y),icon));
                        var ll=e.feature.geometry;
                        //var ll = e.feature.geometry.transform(new OpenLayers.Projection('EPSG:900913'), new OpenLayers.Projection('EPSG:32800'));
                        //ventana = window.open("streetview.html?lon="+ll.x+"&lat="+ll.y,"Street","scrollbars=no,toolbar=no,resizable=no");
                        document.getElementById('framecapas_inegiv').src = "inegiview_dentro.html?lon="+ll.x+"&lat="+ll.y;
                        document.getElementById('ventana-flotante_inegiv').className = 'mostrar';
                        //ventana.focus();
                        }
                },
            displayClass: "olControlInegiv",
            title: "Ver Inegi Map"
            }
        );

    pointLayeralt = new OpenLayers.Layer.Vector("PointSV",{});
    var butalt = new OpenLayers.Control.DrawFeature(
            pointLayeralt,
            OpenLayers.Handler.Point,
            {eventListeners: {
                featureadded: function(e) {
                        var ll = e.feature.geometry.transform(new OpenLayers.Projection('EPSG:900913'), new OpenLayers.Projection('EPSG:4326'));
                        // esto es para un api rest
                        async function obtenerAltitudApi() {
                          const responal = await fetch("http://10.153.3.26:8000/elevation/api/location/"+ll.x+"/"+ll.y);
                          const val = await responal.json();
                          var alt=val.elev;
                            if (alt==32767 || alt<-100 || alt==''){
                                alt=0;
                            }
                            alertmsg ("Altitud: "+alt);
                        }
                        try {
                            obtenerAltitudApi();
                        }catch (error) {
                            alertmsg ("No se pudo obtener la altura");
                        }
                    }
                },
            displayClass: "olControlAltitud",
            title: "Altitud (MDE)"
            }
        );

   var bookmark = new OpenLayers.Control.DrawFeature(
            pointLayeralt,
            OpenLayers.Handler.Point,
            {eventListeners: {
                featureadded: function(e) {
                        var xx = e.feature.geometry.x;
                        var yy = e.feature.geometry.y;
                        var  theHTML = '<center>';
                        theHTML += '<table><tr><th class=label style="text-align:center">DESCRIPCION';
                        theHTML += '<tr><td >&nbsp;';
                        theHTML += '<tr><td >&nbsp;';
                        theHTML += '<textarea id="descripcionbookmark" cols="30" rows="5"></textarea>';
                        theHTML += '<tr><td class=label style="text-align:center">&nbsp;';
                        theHTML += '<tr><td class=label style="text-align:center">';
                        theHTML += '<input onclick="addBookmarks('+xx+','+yy+');" class=input type="button" name="enviar" value="Agregar">';
                        theHTML += '</table></center>';
                        if (map.getExtent().containsLonLat(e.feature.geometry.getBounds().getCenterLonLat())){
                            var varcent=e.feature.geometry.getBounds().getCenterLonLat();
                        }else{
                            var varcent=map.getCenter();
                        }
                        var botcierra=true;
                        e.feature.popup = new OpenLayers.Popup.AnchoredBubble
                        ("pop", varcent, new OpenLayers.Size(280,160),
                        theHTML,    null,   botcierra    //este false es el boton de cerrar
                          // ,onPopupClose                //funcion al cerrar
                        );
                        e.feature.popup.opacity=0.9;
                        e.feature.popup.backgroundColor="#BBCCFF";
                        map.addPopup(e.feature.popup);
                        document.getElementById("pop").style.zIndex = "999";
                    }
                },
            displayClass: "olControlBookmarks",title: "Agregar anotacion"
            }
        );


var agshape = new OpenLayers.Control.Button ({displayClass: 'olControlShape', trigger: trbutshape, title: 'Subir shape de referencia'});
var verqr = new OpenLayers.Control.Button ({displayClass: 'olControlQR', trigger: trbutqr, title: 'Ver QR para Google Maps'});


    var obtcoord = new OpenLayers.Control.DrawFeature(
            pointLayeralt,
            OpenLayers.Handler.Point,
            {eventListeners: {
                featureadded: function(e) {
                        var pad = "0000"
                        var ll = e.feature.geometry.transform(new OpenLayers.Projection('EPSG:900913'), new OpenLayers.Projection('EPSG:4326'));
                        var lll=ll;
                        var xx = togms(ll.x,'x');
                        var yy = togms(ll.y,'y');
                        var ajax=nuevoAjax();
                        ajax.open("GET",'regcoord.jsp?x='+xx+'&y='+yy+'&ent='+filtroid, true);
                        ajax.onreadystatechange=function()
                        {
                            if(ajax.readyState==4)  {
                                var val=ajax.responseText;
                                if (val=='1'){
                                    alertmsg ("No se pudo copiar las coordenadas");
                                }else{
                                    alertmsg('x='+xx+'  y='+yy);
                                }
                            }
                        }
                        ajax.send(null);

                        //incluyo en el mismo boton el de opcion de captura
                        /*
                        var capa=0;
                        if (mza_mod.getVisibility()==true){
                            capa=1;
                            ventanasap = window.open('opcion.jsp?capa='+capa+'&x='+lll.x+'&y='+lll.y,'AgregarMz','toolbar=no,Resizable=1,scrollbars=1');
                            ventanasap.focus();
                        }else{
                            //alertmsg ("No tiene capa seleccionada");
                            return false;
                        }
                        */


                    }
                },
            displayClass: "olControlCoords",title: "Copiar coordenadas para el modulo de captura"
            }
        );

    addsap  = new OpenLayers.Control.DrawFeature(
            pointLayeralt,
            OpenLayers.Handler.Point,
            {eventListeners: {
                featureadded: function(e) {
                        var ll = e.feature.geometry.transform(new OpenLayers.Projection('EPSG:900913'), new OpenLayers.Projection('EPSG:4326'));
                        var capa=0;
                        if (mza_mod.getVisibility()==true || mza_mod_locrur.getVisibility()==true){
                            capa=1;
                        }else{
                            alertmsg ("No tiene capa MCC seleccionada");
                            return false;
                        }
                        ventanasap = window.open('opcion.jsp?capa='+capa+'&x='+ll.x+'&y='+ll.y,'AgregarMz','toolbar=no,Resizable=1,scrollbars=1');
                        ventanasap.focus();
                    }
                },
            displayClass: "olControlAddsap",title: "Agregar localidades MCC->SAP"            }
        );

    regaddsap  = new OpenLayers.Control.DrawFeature(
            pointLayeralt,
            OpenLayers.Handler.Point,
            {
            eventListeners: {
                featureadded: function(e) {
                        var ll = e.feature.geometry.transform(new OpenLayers.Projection('EPSG:900913'), new OpenLayers.Projection('EPSG:4326'));
                        var ajax=nuevoAjax();
                        ajax.open("GET",'obtregsap.jsp?x='+ll.x+'&y='+ll.y+'&tipo='+addsaptipo+'&gid='+addsapgid+'&clas='+addsapclas+'&figura='+addsapfigura+'&clave='+cvedef, true);
                        ajax.onreadystatechange=function()
                        {
                            if(ajax.readyState==4)  {
                                 var val=ajax.responseText;
                                if (val==0){
                                    alertmsg ("Error al obtener la relacion");
                                }else if (val==1){
                                    alertmsg ("No hay nada que relacionar");
                                }else{
                                    alertmsg ("Se relaciona a la clave: "+val);
                                    switch (addsapclas){
                                        case 1:
                                            if (ventanaobtmza != null && !ventanaobtmza.isclosed){
                                                ventanaobtmza.close();
                                                 ventanaobtmza=null;
                                                 brincamza=1;
                                            }
                                            break;
                                        case 2:
                                            if (ventanaobtcd != null && !ventanaobtcd.isclosed){
                                                ventanaobtcd.close();
                                                 ventanaobtcd=null;
                                                 brincacd=1
                                            }
                                            break;
                                        case 3:
                                            if (ventanasap != null && !ventanasap.isclosed){
                                                ventanasap.close();
                                                 ventanasap=null;
                                            }
                                            break;
                                    }
                                }
                            }
                            regaddsap.deactivate();
                            map.removeControl([regaddsap]);
                            if (addsapclas==3){
                                addsap.activate();
                            }else{
                                butagmz.activate();
                            }
                        }
                        ajax.send(null);
                    }
                },
            title: "Relacionar localidad"
            }
        );


//obtiene la fecha de la imagen de digital globe
butfedg = new OpenLayers.Control.DrawFeature(
            pointLayeralt,
            OpenLayers.Handler.Point,
            {
            eventListeners: {
                featureadded: function(e) {
                        var ll = e.feature.geometry.transform(new OpenLayers.Projection('EPSG:900913'), new OpenLayers.Projection('EPSG:4326'));
                        var ajax=nuevoAjax();
                        ajax.open("GET",'obtfedg.jsp?x='+ll.x+'&y='+ll.y+'&filfe='+filfe+'&filnu='+filnu+'&baseimg='+baseimg, true);
                        ajax.onreadystatechange=function()
                        {
                            if(ajax.readyState==4)  {
                                 var val=ajax.responseText;
                                if (val=='x'){
                                    alertmsg ("Error al obtener la fecha");
                                }else{
                                    alertmsg ("Fecha de imagen: "+val);
                                }
                            }
                        }
                        ajax.send(null);
                    }
                }
            ,displayClass: "olControlFechadg",
            title: "Obtener fecha de actualizacion de imagen de Digital Globe"
            }
        );


var butmp = new OpenLayers.Control.Button ({displayClass: 'olControlButmp', trigger: trbutmp, title: 'Vista en Mapa Digital'});
var butge = new OpenLayers.Control.Button ({displayClass: 'olControlButge', trigger: trbutge, title: 'Vista en Google Earth'});
var imprpdf = new OpenLayers.Control.Button ({displayClass: 'olControlprintMappdf', trigger: printMappdf, title: 'Guardar vista en PDF'});
var imprjpg = new OpenLayers.Control.Button ({displayClass: 'olControlprintMapjpg', trigger: printMapjpg, title: 'Ver en JPG con/sin actualizacion'});
var imprplano = new OpenLayers.Control.Button ({displayClass: 'olControlprintMaplano', trigger: printMaplano, title: 'Imprimir plano base con predigitalizacion'});

var imprplanoact = new OpenLayers.Control.Button ({displayClass: 'olControlprintMaplanoact', trigger: printMaplanoact, title: 'Imprimir plano actualizado'});
var butcapas = new OpenLayers.Control.Button ({displayClass: 'olControlCapas', trigger: trbutcapas, title: 'Selector de capas'});
var butmanual = new OpenLayers.Control.Button ({displayClass: 'olControlManual', trigger: trbutmanual, title: 'Manuales y videos de ayuda'});


if (edicion==1){
      editar = new OpenLayers.Control.Button ({displayClass: 'olControleditar',trigger: trbuteditar, title: 'Editar coordenadas de Localidad'});
}else{
      editar = new OpenLayers.Control.Button ({displayClass: 'olControleditarCancel',  title: 'Editar coordenadas de Localidad sin permiso'});
}

if (edicionmz==1){
      editarmz = new OpenLayers.Control.Button ({displayClass: 'olControleditarmz', trigger: trbuteditarmz, title: 'Editar manzanas'});
      editarcd = new OpenLayers.Control.Button ({displayClass: 'olControleditarcd', trigger: trbuteditarcd, title: 'Editar caserios'});
}else{
      editarmz = new OpenLayers.Control.Button ({displayClass: 'olControleditarmzCancel', title: 'Editar manzanas sin permiso '});
      editarcd = new OpenLayers.Control.Button ({displayClass: 'olControleditarcdCancel', title: 'Editar caserios sin permiso '});
}

if (edicionagpr==1){
      editarau = new OpenLayers.Control.Button ({displayClass: 'olControleditarau', trigger: trbuteditarau, title: 'Editar Agebs urbanas'});
      editarpr = new OpenLayers.Control.Button ({displayClass: 'olControleditarpr', trigger: trbuteditarpr, title: 'Editar Pol rurales'});
      editarpe = new OpenLayers.Control.Button ({displayClass: 'olControleditarpr', trigger: trbuteditarpe, title: 'Editar Pol externos'});
}else{
      editarau = new OpenLayers.Control.Button ({displayClass: 'olControleditarauCancel', title: 'Editar Agebs urbanas sin permiso'});
      editarpr = new OpenLayers.Control.Button ({displayClass: 'olControleditarprCancel', title: 'Editar Pol rurales sin permiso'});
      editarpe = new OpenLayers.Control.Button ({displayClass: 'olControleditarprCancel', title: 'Editar Pol externos sin permiso'});
}



editardigF = new OpenLayers.Control.Button ({displayClass: 'olControleditarF', trigger: function (){trbuteditardig(1);}, title: 'Pre-digitalizar Frentes'});
editardigE = new OpenLayers.Control.Button ({displayClass: 'olControleditarE', trigger: function (){trbuteditardig(2);}, title: 'Pre-digitalizar Vialidades'});
editardigM = new OpenLayers.Control.Button ({displayClass: 'olControleditarO', trigger: function (){trbuteditardig(3);}, title: 'Pre-digitalizar Manzanas / Localidades'});

editar_tef = new OpenLayers.Control.Button ({displayClass: 'olControleditarF', trigger: function (){trbuttef();}, title: 'Tabla de frentes'});


panel = new OpenLayers.Control.Panel({displayClass: 'customEditingToolbar'});
paneloculto = new OpenLayers.Control.Panel({displayClass: 'panelOculto'});
c1=new OpenLayers.Control.Navigation({title: "Desplazar"});
c1.zoomWheelEnabled=false;
c2=new OpenLayers.Control.ZoomBox({title: "Acercar"});
c3=new OpenLayers.Control.ZoomToMaxExtent({title: "Inicio"});


if (nivel!=5){
        if (nivel==1 || nivel==3){  // si es estatal o nacional (quitamos las marcas para las regionales, solo pueden ver)
            panel.addControls([butcapas,butmanual,nav.next, nav.previous,c1,c2,info,control,butalt,butsv]);
            if (iduser==44){
                    panel.addControls([butinegiv]);
                }
            panel.addControls([butmp,butge,imprjpg,imprplanoact,imprplano,bookmark,agshape,obtcoord,addsap]);

        }else{
            panel.addControls([butcapas,butmanual,nav.next, nav.previous,c1,c2,info,control,butalt,butsv]);
            panel.addControls([butmp,butge,imprjpg,imprplanoact,imprplano,agshape,obtcoord]);
        }
}else{
    panel.addControls([butcapas,butmanual,nav.next, nav.previous,c1,c2,info,control,butalt,butsv]);
}


 //,addsap
 //panel.addControls([butcapas,butmanual,nav.next, nav.previous,c1,c2,info,control,butalt,butsv,butinegiv,butmp,butge,imprpdf,imprjpg,imprplano,bookmark,obtcoord]);
//paneloculto.addControls([editar,editarmz,editarcd,editarpr,editarpe,editarau,butfedg]);

paneloculto.addControls([butfedg]);
//setTimeout(function(){ }, 1000);


panel.defaultControl = c1;
map.addControl(panel);
map.addControl(paneloculto);



    map.addLayers([fondovacio,fondo,spot6a,spot6,diglob2,diglob,geoeye1,gooimg,
    //aqui va el orden de las capas de mas abajo a mas arriba
    //cartas5,
    rnc,cartas5rep,
    locrurpol_ext,locrurpol_ext_gen,locrurpol,locrurpolet,polr_gen,locurb,locurbet,
    agebsur,agebsuret,agebu_gen,asen,asenet,mza,mzaet,mza_gen,caserio,caserio_gen,mza_mod,mza_mod_locrur,mza_acu,predig,mza_bcuu,inegiview,servs,vialine,vial,agebs,agebset,ca_ni,ni_gen,
    municipios,municipioset,estados,estadoset,cartas20,cartaset20,cartas,cartaset,locrur0,locruret0,locrurmov0,locrur1,locruret1,locrurmov1,crecimientos,predios_ne,
        ce_c1,ce_c2,ce_c3,ce_c4,
    bd_loc,anota,viviendas,highlight,puntogen,streetview,cat_frentes
   //coberturapob
   //vw_carga_tcar
    ]);



// REGISTRO DE MOVIMIENTOS DEL MOUSE Y CAMBIO DE CAPA BASE
map.zoomToExtent(bounds);
map.events.register("moveend", null, capescala);
map.events.register("mousemove", null, onMouseMove);
map.events.register("changebaselayer",null, mapBaseLayerChanged);


//FUNCIONES// ****************************************************************************************************************

//verefica cada que se activan si esta la edicion desactiva las herramientas.....
c1.events.register('activate',null,valCtrl);          //paneo
c2.events.register('activate',null,valCtrl);          //acercar por cuadro
info.events.register('activate',null,valCtrl);        //informacion
control.events.register('activate',null,valCtrl);     //medir
butalt.events.register('activate',null,valCtrl);      //altura
butfedg.events.register('deactivate',null,valCtrldeActivatebutfedg);    //digital globe
butfedg.events.register('activate',null,valCtrl);      //digital globe
butsv.events.register('activate',null,valCtrl);       //streetview
butsv.events.register('deactivate',null,valCtrldeActivatebusv);       //streetview
butinegiv.events.register('activate',null,valCtrl);       //streetview
butinegiv.events.register('deactivate',null,valCtrldeActivatebuinegiv);       //streetview
obtcoord.events.register('activate',null,valCtrl);    //obtenercoordenadas
addsap.events.register('activate',null,valCtrl);    //obtenercoordenadas
bookmark.events.register('activate',null,valCtrl);    //agregar anotaciones

function valCtrldeActivatebutfedg(event){
    document.getElementById("framecapas").contentWindow.document.capas.img4.checked=false;
    document.getElementById("framecapas").contentWindow.document.capas.img13.checked=false;
}

function valCtrldeActivatebusv(event){
    markers.clearMarkers();
    panelStreetView.destroy();
    //actsv=0;
    //streetview.setVisibility(false);
    panelact=0;
}

var panelStreetView;
var actsv=0;
var panelact=0;

function valCtrldeActivatebuinegiv(event){
    markers.clearMarkers();
    panelInegiView.destroy();
    //actinegiv=0;
    //inegiview.setVisibility(false);
    panelactinegi=0;
}


var panelInegiView;
var actinegiv=0;
var panelactinegi=0;

function valCtrl(event){
if (event.object.title!='Registrar NO PROCEDEN por poligono'){
    porpoligono.deactivate();
}
/*if (event.object.title!='Conteo de viviendas por imagen MZ/LOC'){
    inv_punto.deactivate();
    ver_inv_punto.deactivate();
    ver_inv=0;
}*/
if (event.object.title!='Agregar/Quitar bloqueo de municipios'){
    but_repdig_agrega.deactivate();
    ver_but_repdig_agrega.deactivate();
    ver_repdig=0;
}else{
    veravancepredig.activate();
    avdig=1;
    cartas5rep.setVisibility(true);
}
//aqui validamos que si esta activa la capa de edicion se desactive cualquier boton
//al seleccionar posteriormente cualquier boton de la digitalizacfion debemos activar la capa c1 que es el pan
/*
if (butfedg.active==true){
    document.getElementById("framecapas").contentWindow.document.capas.img4.checked=true;
}
if (butfedg.active==true && baseimg!='DG'){
    butfedg.deactivate(); //fecha de digital globe
    document.getElementById("framecapas").contentWindow.document.capas.img4.checked=false;
    alertmsg("No tiene activada la capa BASE de Digital Globe");
}
*/
if (butsv.active==true && panelact==0){
        panelact=1;
        butCoverSv = new OpenLayers.Control.Button({displayClass: 'olControlCoversv', trigger: function (){
        if (actsv==0){
            butCoverSv.activate();
            actsv=1;
            streetview.setVisibility(true);
        }else{
            butCoverSv.deactivate();
            actsv=0;
            streetview.setVisibility(false);
        }
        },title: 'Ver cobertura de Street View'}
        );

        panelStreetView = new OpenLayers.Control.Panel({displayClass: 'panelStreetView'});
        panelStreetView.addControls([butCoverSv]);
        map.addControl(panelStreetView);
        if (actsv==1){
            butCoverSv.activate();
        }
}else{
    streetview.setVisibility(false);
    actsv=0;
}
if (butinegiv.active==true && panelactinegi==0){
        panelactinegi=1;
        butCoverInegiv = new OpenLayers.Control.Button({displayClass: 'olControlCoversv', trigger: function (){
        if (actinegiv==0){
            butCoverInegiv.activate();
            actinegiv=1;
            inegiview.setVisibility(true);
        }else{
            butCoverInegiv.deactivate();
            actinegiv=0;
            inegiview.setVisibility(false);
        }
        },title: 'Ver cobertura de INEGI View'}
        );

        panelInegiView = new OpenLayers.Control.Panel({displayClass: 'panelInegiView'});
        panelInegiView.addControls([butCoverInegiv]);
        map.addControl(panelInegiView);
        if (actinegiv==1){
            butCoverInegiv.activate();
        }
}

    if (ban1==1){
        if (event.object.title=="Acercar"){
            alertmsg("No se puede activar mientras esta editando");
            //c1.activate();
            c2.deactivate();
        }else{

            setTimeout(function(){
            if (editar.active==true && panel2!=undefined){
                for (var i=0;i<panel2.controls.length-1;i++){
                    panel2.controls[i].deactivate();
                }
            }else if (editarmz.active==true && panel3!=undefined){
                for (var i=0;i<panel3.controls.length;i++){
                    panel3.controls[i].deactivate();
                }
            }else if (editarcd.active==true && panel6!=undefined){
                for (var i=0;i<panel6.controls.length;i++){
                    panel6.controls[i].deactivate();
                }
            }else if (editarpr.active==true && panel4!=undefined){
                for (var i=0;i<panel4.controls.length;i++){
                    panel4.controls[i].deactivate();
                }
            }else if (editarpe.active==true && panel7!=undefined){
                for (var i=0;i<panel7.controls.length;i++){
                    panel7.controls[i].deactivate();
                }
            }else if (editarau.active==true && panel5!=undefined){
                for (var i=0;i<panel5.controls.length;i++){
                    panel5.controls[i].deactivate();
                }
            }else if (editardigM.active==true && panelDig2!=undefined){
                for (var i=0;i<panelDig2.controls.length;i++){
                    panelDig2.controls[i].deactivate();
                }
            }
             }, 1000); //settime
        }
    }
}



// SI CAMBIA LA CAPA BASE CAMBIA LA VARIABLE base img
function mapBaseLayerChanged(event) {
switch (parseInt(event.layer.name.substring(0,2).replace('-',''))){
        case 0: baseimg='';break;       // VACIO
        //case 1: baseimg='OR';break;           //ORTOFOTO  --DESACTIVADA
        //case 2: baseimg='S5';break;           //SPOT5     --DESACTIVADA
        case 3: baseimg='DG';break;     //estoy usando DG para las de openatlas para que funcione los triggers igual que digitalglobe
        //case 4: baseimg='DG';break;            //digital --DESACTIVADA
        case 5: baseimg='GO';break;     // google maps
        case 6: baseimg='ES';break;     //ESRI
        //case 7: baseimg='GO';break;           //GOOLE ESTATICA --DESACTIVADA
        //case 8: baseimg='GS';break;           //GOOGLE STREET MAP --DESACTIVADA
        //case 9: baseimg='G1';break;           // GEOEYE  --DESACTIVADA
        //case 10: baseimg='G2';break;          // GEOEYE --DESACTIVADA
        //case 11: baseimg='XX';break;          //COMODIN IMAGEN SPOT DE MEXICO ---DESACIVADA
        case 12: baseimg='BI';break;    //bing
        case 13: baseimg='D2';break;    //mosaico
        case 99: baseimg='MD';break;    //mapa digita
        // con el movimiento manual se pone "MA"
}

//if ((baseimg!='DG' && baseimg!='D2') && butfedg.active==true){
    butfedg.deactivate(); //fecha de digital globe
//}
}

// FUNCION DE MOVIMIENTO DE MOUSE PARA MOSTRAR LAS COORDENADAS
 function onMouseMove(event){
    var element = document.getElementById('coords');
    //var ll = map.getLonLatFromPixel(event.xy).transform(new OpenLayers.Projection('EPSG:32800'), new OpenLayers.Projection('EPSG:4326'));
    //var out = "LON/LAT ("+ll.lon.toFixed(5) + ", " + ll.lat.toFixed(5)+")"; // no more detail than meters.
    //var ll = map.getLonLatFromPixel(event.xy).transform(new OpenLayers.Projection('EPSG:4326'), new OpenLayers.Projection('EPSG:32800'));
    // convertir a grados minutos y segundos
    var ll = map.getLonLatFromPixel(event.xy).transform(new OpenLayers.Projection('EPSG:900913'), new OpenLayers.Projection('EPSG:4326'));
    var out0 = transformToDegrees(ll.lon)+ 'W'+', '+transformToDegrees(ll.lat)+'N';
    var ll = map.getLonLatFromPixel(event.xy).transform(new OpenLayers.Projection('EPSG:900913'), new OpenLayers.Projection('EPSG:32800'));
    var out1 = "CCL ("+ll.lon.toFixed(5) + ", " + ll.lat.toFixed(5)+")"; // no more detail than meters.
    element.innerHTML = out0+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+out1;
    if (mousecount==0){
        var ajax=nuevoAjax();
        ajax.open("GET",'mousecount.jsp', true);
        ajax.onreadystatechange=function()
        {
                if(ajax.readyState==4)  {
                    var val=ajax.responseText;
                    if (val==0){
                        cerrarSesion();
                    }else{   //sesion activa
                                gtag('event', 'mouse', {
                                'event_category': 'sesion',
                                'event_label': 'activo',
                                'value': iduser
                                });
                    }
               }
        }
        ajax.send(null);
            setTimeout(function(){
                    mousecount=0;
        //}, 600000);
        }, 60000);
        mousecount=1;
    }
}

//FUNCION PARA MEDIR
function handleMeasurements(event) {
            var units = event.units;
            var measure = event.measure;
            var element = document.getElementById('output');
            var out = '';
            out += measure.toFixed(3) + " " + units;
            element.innerHTML = out;
        }


//FUNCION CADA QUE CAMBIA LA ESCALA
function capescala(){
var a= map.getZoom();
var escala=map.getScale();   //si es mayor a 30000 sale de la edicion

if (escalatope>a){
    nav.previous.trigger();
    return false;
}
 

var valcap=parseInt(map.baseLayer.name.substring(0,1));

    if (escala<230000){
        document.getElementById('framecapas').contentWindow.document.capas.base[2].disabled=false;     //2 es openlatlas
    }else{
        document.getElementById('framecapas').contentWindow.document.capas.base[2].disabled=true;
        if (valcap==3){  //SPOT6 <-- OpenAtlas
                nav.previous.trigger();
        }
    }


if (valcap==5 || valcap==7 || valcap==8){  //google
    //    var b= gooimg.getMapObjectZoom()-5;  //esto para google maps sin XYZ
    //if (a!=b){
     //   nav.previous.trigger();
    //}
}else if (valcap==6){  //ESRI
    if (a>12){
       // nav.previous.trigger();   //ME VALIO QUE SE VIERAN LAS ROZAS A VARIOS ZOOM DIFERENTES ZONAS
    }
}else if (valcap==4){   ////DIG. GLOBE
    if (a>15){
        nav.previous.trigger();
    }
}
if ( editarpr.active==true ||editarpe.active==true || editarau.active==true){
    if (escala > 30000 && ban1==1){
                        alertmsg ("La escala debe ser < a 30,000 para editar");
                        cierraban=1;
                        if (editarpr.active==true){cierramz.trigger();}
                        if (editarpe.active==true){cierramz.trigger();}
                        if (editarau.active==true){cierramz.trigger();}
                        cierraban=0;
    }
}else  if (editarcd.active==true || editarmz.active==true){
    if (escala > 10000 && ban1==1){
                        alertmsg ("La escala debe ser < a 10,000 para editar");
                        cierraban=1;
                        if (editarmz.active==true){cierramz.trigger();}
                        if (editarcd.active==true){cierramz.trigger();}
                        cierraban=0;
    }
}else  if (editar.active==true  || editardigM.active==true || editardigF.active==true || editardigE.active==true){
    if (escala > 20000 && ban1==1){
                        alertmsg ("La escala debe ser < a 20,000 para editar");
                        cierraban=1;
                        if (editar.active==true){cierra.trigger();}
                        if (editardigM.active==true){cierra.trigger();}
                        if (editardigF.active==true){cierra.trigger();}
                        if (editardigE.active==true){cierra.trigger();}
                        cierraban=0;
    }
}
}

//ESTILOS PARA WFS
stylespr = new OpenLayers.StyleMap({
"default": new OpenLayers.Style(null, {
rules: [
    new OpenLayers.Rule({
        symbolizer: {
            "Point": {pointRadius: 4,fillColor: "#F7FE2E",fillOpacity: 1,strokeWidth: 3,strokeColor: "#000000"},
            "Line": {strokeWidth: 3},
            "Polygon": {strokeWidth: 3}}}),
    new OpenLayers.Rule({    //color de la edicion de manzanas
        symbolizer: {
            "Polygon": {fillColor: '#F5ECCE',
                        fillOpacity: .5,
                        strokeOpacity: .7,
                        strokeWidth: 2,
                        strokeColor: "#FFFFFF",
                        label : "("+"${cve_loc}"+")",
                        fontColor: "#000000",
                        fontOpacity: .7,
                        fontSize: 10,
                        fontFamily: "Arial",
                        fontWeight: "bold"},
                        }}),
]}),
"select": new OpenLayers.Style({strokeColor: "#FF0000",strokeWidth: 4})});

stylesau = new OpenLayers.StyleMap({
"default": new OpenLayers.Style(null, {
rules: [
    new OpenLayers.Rule({
        symbolizer: {
            "Point": {pointRadius: 4,fillColor: "#F7FE2E",fillOpacity: 1,strokeWidth: 3,strokeColor: "#000000"},
            "Line": {strokeWidth: 3},
            "Polygon": {strokeWidth: 3}}}),
    new OpenLayers.Rule({    //color de la edicion de manzanas
        symbolizer: {
            "Polygon": {fillColor: '#F5ECCE',
                        fillOpacity: .5,
                        strokeOpacity: .7,
                        strokeWidth: 2,
                        strokeColor: "#FFFFFF",
                        label : "("+"${cve_ageb}"+")",
                        fontColor: "#000000",
                        fontOpacity: .7,
                        fontSize: 10,
                        fontFamily: "Arial",
                        fontWeight: "bold"},
                        }}),
]}),
"select": new OpenLayers.Style({strokeColor: "#FF0000",strokeWidth: 4})});

stylescd = new OpenLayers.StyleMap({
"default": new OpenLayers.Style(null, {
rules: [
 new OpenLayers.Rule({
        symbolizer: {
            //"Point": {pointRadius: 4,fillColor: "#F7FE2E",fillOpacity: 1,strokeWidth: 3,strokeColor: "#000000"},
            "Line": {strokeWidth: 3},
            "Polygon": {strokeWidth: 3}}}),
    new OpenLayers.Rule({    //color de la edicion de caserios
        symbolizer: {
            "Point": {pointRadius: 3.5,
                        fillColor: '#F5ECCE',
                        fillOpacity: 1,
                        strokeOpacity: 1,
                        strokeWidth: 1,
                        strokeColor: "#000000",
                        label : "${cve_ageb} "+"${cve_loc}"+"",
                        labelYOffset: -12,
                        fontColor: "#000000",
                        fontOpacity: 1,
                        fontSize: 10,
                        fontFamily: "Arial",
                        fontWeight: "bold"},
            "Polygon": {fillColor: '#F5ECCE',
                        fillOpacity: .5,
                        strokeOpacity: .7,
                        strokeWidth: 2,
                        strokeColor: "#FFFFFF"},
                        }}),
]}),
"select": new OpenLayers.Style({strokeColor: "#FF0000",strokeWidth: 4})});

stylescdpol = new OpenLayers.StyleMap({
"default": new OpenLayers.Style(null, {
rules: [
 new OpenLayers.Rule({
        symbolizer: {
            "Point": {pointRadius: 4,fillColor: "#F7FE2E",fillOpacity: 1,strokeWidth: 3,strokeColor: "#000000"},
            "Line": {strokeWidth: 3},
            "Polygon": {strokeWidth: 3}}}),
    new OpenLayers.Rule({    //color de la edicion de caserios
        symbolizer: {
            "Polygon": {fillColor: '#F5ECCE',
                        fillOpacity: .5,
                        strokeOpacity: .7,
                        strokeWidth: 2,
                        strokeColor: "#FFFFFF"},
                        }}),
]}),
"select": new OpenLayers.Style({strokeColor: "#FF0000",strokeWidth: 4})});



styles = new OpenLayers.StyleMap({
"default": new OpenLayers.Style(null, {
rules: [
    new OpenLayers.Rule({
        symbolizer: {
            "Point": {pointRadius: 4,fillColor: "#F7FE2E",fillOpacity: 1,strokeWidth: 3,strokeColor: "#000000"},
            "Line": {strokeWidth: 3},
            "Polygon": {strokeWidth: 3}}}),
    new OpenLayers.Rule({    //color de la edicion de manzanas
        symbolizer: {
            "Polygon": {fillColor: '#F5ECCE',
                        fillOpacity: .5,
                        strokeOpacity: .7,
                        strokeWidth: 2,
                        strokeColor: "#FFFFFF",
                        label : "("+"${cve_mza}"+")",
                        fontColor: "#000000",
                        fontOpacity: .7,
                        fontSize: 10,
                        fontFamily: "Arial",
                        fontWeight: "bold"},
           "Line": {   //color de edicion de los frentes y ejes
                        strokeOpacity: .7,
                        strokeWidth: 3,
                        strokeColor: "#F5ECCE",
                },
     }}),
    new OpenLayers.Rule({
        filter: new OpenLayers.Filter.Logical({
            type: OpenLayers.Filter.Logical.OR,
                filters: [
                    new OpenLayers.Filter.Comparison({
                        type: OpenLayers.Filter.Comparison.EQUAL_TO,property: "ban", value: "0"})]}),
        symbolizer: {
            "Point": {pointRadius: 3.5,fillColor: "#FFFFFF",fillOpacity: 1,strokeWidth: 1,strokeColor: "#000000",
            label : "("+"${cve_loc}"+")",fontColor: "#000000",fontSize: 10,fontFamily: "Arial",fontWeight: "bold",labelXOffset: 22}}}),
    new OpenLayers.Rule({
        filter: new OpenLayers.Filter.Logical({
            type: OpenLayers.Filter.Logical.OR,
                filters: [
                    new OpenLayers.Filter.Comparison({
                        type: OpenLayers.Filter.Comparison.EQUAL_TO,property: "ban", value: "1"})]}),
        symbolizer: {
            "Point": {pointRadius: 3.5,fillColor: "#FFFF00",fillOpacity: 1,strokeWidth: 1,strokeColor: "#AEB404",
            label : "("+"${cve_loc}"+")",fontColor: "#AEB404",fontSize: 10,fontFamily: "Arial",fontWeight: "bold",labelXOffset: 22}}}),
    new OpenLayers.Rule({
        filter: new OpenLayers.Filter.Logical({
            type: OpenLayers.Filter.Logical.OR,
                filters: [
                    new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.EQUAL_TO,property: "ban", value: "2"})]}),
        symbolizer: {
            "Point": {pointRadius: 3.5,fillColor: "#2EFE2E",fillOpacity: 1,strokeWidth: 1,strokeColor: "#04B404",
            label : "("+"${cve_loc}"+")",fontColor: "#04B404",fontSize: 10,fontFamily: "Arial",fontWeight: "bold",labelXOffset: 22}}}),
    new OpenLayers.Rule({
        filter: new OpenLayers.Filter.Logical({
            type: OpenLayers.Filter.Logical.OR,
                filters: [
                    new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.EQUAL_TO,property: "ban", value: "3"})]}),
        symbolizer: {
            "Point": {pointRadius: 3.5,fillColor: "#2E9AFE",fillOpacity: 1,strokeWidth: 1,strokeColor: "#0000FF",
            label : "("+"${cve_loc}"+")",fontColor: "#0000FF",fontSize: 10,fontFamily: "Arial",fontWeight: "bold",labelXOffset: 22}}}),
    new OpenLayers.Rule({
        filter: new OpenLayers.Filter.Logical({
            type: OpenLayers.Filter.Logical.OR,
                filters: [
                    new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.EQUAL_TO,property: "ban", value: "4"})]}),
        symbolizer: {
            "Point": {pointRadius: 3.5,fillColor: "#F78181",fillOpacity: 1,strokeWidth: 1,strokeColor: "#FA5882",
            label : "("+"${cve_loc}"+")",fontColor: "#FA5882",fontSize: 10,fontFamily: "Arial",fontWeight: "bold",labelXOffset: 22}}})
]}),
"select": new OpenLayers.Style({strokeColor: "#FF0000",strokeWidth: 4})});




stylespre = new OpenLayers.StyleMap({
"default": new OpenLayers.Style(null, {
rules: [
    new OpenLayers.Rule({
        symbolizer: {
            "Point": {pointRadius: 4},
            "Line": {strokeWidth: 3},
            "Polygon": {strokeWidth: 3}}}),
    new OpenLayers.Rule({    //color de la edicion de manzanas
        symbolizer: {
            "Polygon": {fillColor: '#F5ECCE',
                        fillOpacity: .5,
                        strokeOpacity: .7,
                        strokeWidth: 2,
                        strokeColor: "#FFFFFF"},
           "Line": {   //color de edicion de los frentes y ejes
                        strokeOpacity: .7,
                        strokeWidth: 3,
                        strokeColor: "#F5ECCE",
                },
            "Point": {   //color de edicion de los puntos
                        strokeOpacity: .7,
                        fillColor: "#F5ECCE",
                        fillOpacity: 1,
                        strokeWidth: 2,
                        strokeColor: "#000000"
                },
     }}),
]}),
"select": new OpenLayers.Style({strokeColor: "#FF0000",strokeWidth: 4})});

function desactivar_botones(){
    regaddsap.deactivate();
    c2.deactivate();
    info.deactivate();
    control.deactivate();
    butalt.deactivate();
    butsv.deactivate();;
    butinegiv.deactivate();
    obtcoord.deactivate();
    addsap.deactivate();
    bookmark.deactivate();
    butfedg.deactivate();
    but_repdig_agrega.deactivate();
    ver_but_repdig_agrega.deactivate();
    ver_repdig=0;
    porpoligono.deactivate();
    //inv_punto.deactivate();
    //ver_inv_punto.deactivate();
    ver_inv=0;
    editardigM.deactivate();
    c1.activate();
}


///////FUNCIONES PARA EDITAR LOS AGEBS URBANOS
function trbuteditarau(){
    obtener_maximos_au_pr_mz();
var geographic = new OpenLayers.Projection("EPSG:4326");
var mercator = new OpenLayers.Projection("EPSG:900913");
var ccl = new OpenLayers.Projection("EPSG:32800");
var escala=map.getScale();
if (escala < 30000){
    if (ban1==0){
        ban1=1;
    }else{
        alertmsg ("Ya tiene activada la herramienta de edicion");
        return false;
    }
    //nav.clear();
    mzamax=0,cvemax='';
    desactivar_rueda_raton();
    desactivar_botones();
        var saveStrategy = new OpenLayers.Strategy.Save();
            saveStrategy.events.register('success', null, saveSuccessAu);
            saveStrategy.events.register('fail', null, saveFailAu);


 if (nivel==1){
                var filtroed = new OpenLayers.Filter.Logical({type: OpenLayers.Filter.Logical.AND,filters: [
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.EQUAL_TO,property: "cve_ent",value: filtroid}),
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "ban",value: 3}),
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "ban",value: 4})
                        ]});
    }else{
                var filtroed = new OpenLayers.Filter.Logical({type: OpenLayers.Filter.Logical.AND,filters: [
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "cve_ent",value: '00'}),
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "ban",value: 3}),
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "ban",value: 4})   //codigo 4 en ageb es que cambio de clave y se da de baja con codigo 4
                        ]});
    }


            wfs =   new OpenLayers.Layer.Vector("MODIFICAR",{
                strategies: [new OpenLayers.Strategy.BBOX(), saveStrategy],protocol: new OpenLayers.Protocol.WFS({
                srsName: "EPSG:32800", url:  "http://"+hostnew+"/geoserver/INEGI"+idreggeo+"/wfs",
                featureType: "edit_agebu",featureNS: "http://"+hostnew+"/INEGI"+idreggeo+""}),
                projection: ccl, styleMap: stylesau
                ,filter: filtroed
            });
           wfs.displayInLayerSwitcher= false;wfs.isBaseLayer=false;map.addLayers ([wfs]);


            // configure the snapping agent
            snap = new OpenLayers.Control.Snapping({layer: wfs,
                targets: [{
                    layer:wfs,
                    tolerance: 10,
                    edge: false,
                    filter: new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "surface",value: "dirt"})
                        }]
                });
            map.addControl(snap);
            snap.activate();


             drawmz = new OpenLayers.Control.DrawFeature(
                wfs, OpenLayers.Handler.Polygon, {title: "Agregar", displayClass: "olControlDrawFeaturePolygon" , multi: true}
            );
             drawmz.events.register('featureadded', drawmz, onFeatureSelectAu);
             modimz1 = new OpenLayers.Control.ModifyFeature(
                wfs, {displayClass: "olControlModifymzFeature",title: "Modificar",enforceTopology: true}
            );
            modimz2 = new OpenLayers.Control.ModifyFeature(
                wfs, {displayClass: "olControlModify2Feature", title: "Mover, rotar, tama\xF1o"}
            );
            modimz2.mode  = OpenLayers.Control.ModifyFeature.DRAG | OpenLayers.Control.ModifyFeature.ROTATE | OpenLayers.Control.ModifyFeature.RESIZE ;
            modiatmz = new OpenLayers.Control.ModifyFeature(
                wfs, {displayClass: "olControlText", title: "Atributos"}
            );
            modiatmz.mode  = null ;
            delmz = new DeleteFeatureAu(wfs, {title: "Borrar"});

        wfs.events.on({
            featureselected:onFeatureSelectAu,
            featureunselected: onFeatureUnSelectAu
        });


         savemz = new OpenLayers.Control.Button({
                title: "Salvar Cambios",
                trigger: function() {
                    if(modimz1.feature) {
                        modimz1.selectControl.unselectAll();
                    }
                    if(modimz2.feature) {
                        modimz2.selectControl.unselectAll();
                    }
                    if(modiatmz.feature) {
                        modiatmz.selectControl.unselectAll();
                    }
                    if(drawmz.feature) {
                        drawmz.selectControl.unselectAll();
                    }
                    saveStrategy.save();
                    //wfsmov=[];
                    mzamax=0,cvemax='';

                },
                displayClass: "olControlSaveFeatures"
            });

         cutpol = new OpenLayers.Control.Button({
                title: "Activar Cortado",
                trigger: function() {
                    if (cutpolvar==0){
                        cutpolvar=1;
                        cutpol.activate();
                    }else{
                        cutpolvar=0;
                        cutpol.deactivate();
                    }
                },
                displayClass: "olControlcutpol"
            });

        cierramz = new OpenLayers.Control.Button ({
                displayClass: 'olControlClose',
                trigger: function() {
                    if (cierraban==0){
                       //if (confirm("Desea cerrar la edicion??")){
                            cierraban=1;
                        //}
                    }
                    if (cierraban==1){
                        cierraban=0;
                        drawmz.deactivate();
                        modimz1.deactivate();
                        modimz2.deactivate();
                        modiatmz.deactivate();
                        desactivar_botones();
                        ban1=0;
                        wfs.removeAllFeatures();
                        wfs.visibility=false;
                        wfs.removeMap();
                        cierramz.destroy();
                        savemz.destroy();
                        modiatmz.destroy();
                        drawmz.destroy();
                        modimz1.destroy();
                        modimz2.destroy();
                        delmz.destroy();
                        cutpol.destroy();
                        panel5.destroy();
                        panel5=undefined;
                        editarau.deactivate();
                        //wfsmov=[];
                        cutpolvar=0;
                        //document.getElementById('framecapas').src = document.getElementById('framecapas').src;
                               for (var i = map.popups.length - 1; i >= 0; i--) {
                                  map.removePopup(map.popups[i]);
                        }
                        activar_rueda_raton();
                        edita_off('au');
                    }
                },
                title: 'Cerrar editor'
            });

        panel5 = new OpenLayers.Control.Panel({displayClass: 'panel5Toolbar'});
        panel5.addControls([cierramz,savemz,modiatmz,drawmz,modimz1,modimz2,delmz,cutpol]);
        //panel5.addControls([cierramz,savemz,drawmz,modimz1,modimz2,cutpol]);

        map.addControl(panel5);
        editarau.activate();
        //drawmz.activate();

        delmz.events.register('activate',null,valCtrleditmz);
        modimz1.events.register('activate',null,valCtrleditmz);
        modimz2.events.register('activate',null,valCtrleditmz);
        drawmz.events.register('activate',null,valCtrleditmz);
        modiatmz.events.register('activate',null,valCtrleditmz);

        //document.getElementById('framecapas').src = document.getElementById('framecapas').src;
}else{ //escala
    alertmsg ("La escala debe ser < a 30,000 para editar");
    edita_off('au');
}}


///////FUNCIONES PARA EDITAR LOS POLIGONOS RURALES AMANZANADOS
function trbuteditarpr(){
    obtener_maximos_au_pr_mz();
var geographic = new OpenLayers.Projection("EPSG:4326");
var mercator = new OpenLayers.Projection("EPSG:900913");
var ccl = new OpenLayers.Projection("EPSG:32800");
var escala=map.getScale();
if (escala < 30000){
    if (ban1==0){
        ban1=1;
    }else{
        alertmsg ("Ya tiene activada la herramienta de edicion");
        return false;
    }
    //nav.clear();
    desactivar_rueda_raton();
    desactivar_botones();
        var saveStrategy = new OpenLayers.Strategy.Save();
            saveStrategy.events.register('success', null, saveSuccessPr);
            saveStrategy.events.register('fail', null, saveFailPr);

    if (nivel==1){
                var filtroed = new OpenLayers.Filter.Logical({type: OpenLayers.Filter.Logical.AND,filters: [
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.EQUAL_TO,property: "cve_ent",value: filtroid}),
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "ban",value: 3}),
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "ban",value: 4})
                        ]});
    }else{
                var filtroed = new OpenLayers.Filter.Logical({type: OpenLayers.Filter.Logical.AND,filters: [
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "cve_ent",value: '00'}),
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "ban",value: 3}),
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "ban",value: 4})     //codigo 4 en es que cambio de clave y se da de baja con codigo 4
                        ]});
    }

            wfs =   new OpenLayers.Layer.Vector("MODIFICAR",{
                strategies: [new OpenLayers.Strategy.BBOX(), saveStrategy],protocol: new OpenLayers.Protocol.WFS({
                srsName: "EPSG:32800", url:  "http://"+hostnew+"/geoserver/INEGI"+idreggeo+"/wfs",
                featureType: "edit_locr",featureNS: "http://"+hostnew+"/INEGI"+idreggeo+""}),
                projection: ccl, styleMap: stylespr
                ,filter: filtroed
            });
           wfs.displayInLayerSwitcher= false;wfs.isBaseLayer=false;map.addLayers ([wfs]);

  // configure the snapping agent
            snap = new OpenLayers.Control.Snapping({layer: wfs,
                targets: [{
                    layer:wfs,
                    tolerance: 10,
                    edge: false,
                    filter: new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "surface",value: "dirt"})
                        }]
                });
            map.addControl(snap);
            snap.activate();

             drawmz = new OpenLayers.Control.DrawFeature(
                wfs, OpenLayers.Handler.Polygon, {title: "Agregar", displayClass: "olControlDrawFeaturePolygon" , multi: true}
            );
             drawmz.events.register('featureadded', drawmz, onFeatureSelectPr);
             modimz1 = new OpenLayers.Control.ModifyFeature(
                wfs, {displayClass: "olControlModifymzFeature",title: "Modificar"}
            );
            modimz2 = new OpenLayers.Control.ModifyFeature(
                wfs, {displayClass: "olControlModify2Feature", title: "Mover, rotar, tama\xF1o"}
            );
            modimz2.mode  = OpenLayers.Control.ModifyFeature.DRAG | OpenLayers.Control.ModifyFeature.ROTATE | OpenLayers.Control.ModifyFeature.RESIZE ;
            modiatmz = new OpenLayers.Control.ModifyFeature(
                wfs, {displayClass: "olControlText", title: "Atributos"}
            );
            modiatmz.mode  = null ;
            delmz = new DeleteFeaturePr(wfs, {title: "Borrar"});

        wfs.events.on({
            featureselected:onFeatureSelectPr,
            featureunselected: onFeatureUnSelectPr
        });


         savemz = new OpenLayers.Control.Button({
                title: "Salvar Cambios",
                trigger: function() {
                    if(modimz1.feature) {
                        modimz1.selectControl.unselectAll();
                    }
                    if(modimz2.feature) {
                        modimz2.selectControl.unselectAll();
                    }
                    if(modiatmz.feature) {
                        modiatmz.selectControl.unselectAll();
                    }
                    if(drawmz.feature) {
                        drawmz.selectControl.unselectAll();
                    }
                    if(drawmulti.feature) {
                        drawmulti.selectControl.unselectAll();
                    }
                    saveStrategy.save();
                    //wfsmov=[];
                },
                displayClass: "olControlSaveFeatures"
            });

         cutpol = new OpenLayers.Control.Button({
                title: "Activar Cortado",
                trigger: function() {
                    if (cutpolvar==0){
                        cutpolvar=1;
                        cutpol.activate();
                    }else{
                        cutpolvar=0;
                        cutpol.deactivate();
                    }
                },
                displayClass: "olControlcutpol"
            });

        cierramz = new OpenLayers.Control.Button ({
                displayClass: 'olControlClose',
                trigger: function() {
                    if (cierraban==0){
                        //if (confirm("Desea cerrar la edicion??")){
                            cierraban=1;
                        //}
                    }
                    if (cierraban==1){
                        cierraban=0;
                        drawmz.deactivate();
                        drawmulti.deactivate();
                        del_multi.deactivate();
                        modimz1.deactivate();
                        modimz2.deactivate();
                        modiatmz.deactivate();
                        ban1=0;
                        wfs.removeAllFeatures();
                        wfs.visibility=false;
                        wfs.removeMap();
                        cierramz.destroy();
                        savemz.destroy();
                        modiatmz.destroy();
                        drawmz.destroy();
                        modimz1.destroy();
                        modimz2.destroy();
                        delmz.destroy();
                        cutpol.destroy();
                        drawmulti.destroy();
                        del_multi.destroy();
                        panel4.destroy();
                        panel4=undefined;
                        editarpr.deactivate();
                        //wfsmov=[];
                        cutpolvar=0;
                        //document.getElementById('framecapas').src = document.getElementById('framecapas').src;
                               for (var i = map.popups.length - 1; i >= 0; i--) {
                                  map.removePopup(map.popups[i]);
                        }
                        activar_rueda_raton();
                        edita_off('pr');
                    }
                },
                title: 'Cerrar editor'
            });




        var del_multi = new OpenLayers.Control.DrawFeature(
            pointLayeralt,
            OpenLayers.Handler.Point,
            {eventListeners: {
                featureadded: function(e) {
                            var sal=0;
                            var feature = e.feature;
                            var jsts_parser = new jsts.io.OpenLayersParser();
                            var jsts_geomA  = jsts_parser.read(feature.geometry);
                            var intersects12,ban,i,t,intersects2,val,poly2;
                            var reader = new jsts.io.WKTReader();
                               for(var j=0; j<wfs.features.length; j++) {
                                    if (sal==1){
                                        return false;
                                    }
                                        var jsts_geomB  = jsts_parser.read(wfs.features[j].geometry);
                                        intersects12 = feature.geometry.intersects(wfs.features[j].geometry);
                                        if(intersects12){
                                            sal++;
                                            n=0;
                                            if (wfs.features[j].geometry.components.length>1){
                                                    for (c in wfs.features[j].geometry.components) {
                                                            var poly = wfs.features[j].geometry.components[c];
                                                            intersects2 = feature.geometry.intersects(poly);
                                                            if(intersects2){
                                                                break;
                                                            }
                                                       }
                                                        var jsts_result_geom = jsts_geomB.difference(jsts_parser.read(poly));
                                                        var val=jsts_result_geom.toString();
                                                        if (val.substring(0,1)=='P'){
                                                            //console.log(val.substring(0,1));
                                                                val=val.replace('POLYGON','MULTIPOLYGON(')+')';
                                                        }
                                                        var geompol = OpenLayers.Geometry.fromWKT(val);
                                                        //var geompol = new OpenLayers.Geometry.MultiPolygon(OpenLayers.Geometry.fromWKT(jsts_result_geom.toString()));
                                                        //console.log(geompol);
                                                        wfs.eraseFeatures(wfs.features[j]);
                                                        wfs.features[j].geometry=geompol;
                                                        if (wfs.features[j].state!=OpenLayers.State.INSERT){
                                                            wfs.features[j].state = OpenLayers.State.UPDATE;
                                                        }
                                                        wfs.drawFeature(wfs.features[j]);
                                            }else{
                                                alertmsg("Ningun multipoligono");
                                                return false;
                                            }
                                        }//intersect
                                }//for
                            if (sal==0){
                                alertmsg("Ningun multipoligono");
                            }//sal=0
                    }
                },
            displayClass: "olControlDeletemultiFeature",
            title: "Borrar multipoligono"
            }
        );


        drawmulti = new OpenLayers.Control.DrawFeature(
                wfs, OpenLayers.Handler.Polygon, {title: "Agregar multipoligono", displayClass: "olControlDrawmultiFeaturePolygon" , multi: true}
            );
        drawmulti.events.register('featureadded', drawmulti, onFeatureSelectPr);


        panel4 = new OpenLayers.Control.Panel({displayClass: 'panel4Toolbar'});
        panel4.addControls([cierramz,savemz,modiatmz,drawmz,modimz1,modimz2,delmz,cutpol,drawmulti,del_multi]);
        //panel4.addControls([cierramz,savemz,drawmz,modimz1,delmz,cutpol]);

        map.addControl(panel4);
        editarpr.activate();
        //drawmz.activate();

        delmz.events.register('activate',null,valCtrleditmz);
        modimz1.events.register('activate',null,valCtrleditmz);
        modimz2.events.register('activate',null,valCtrleditmz);
        drawmz.events.register('activate',null,valCtrleditmz);
        drawmulti.events.register('activate',null,valCtrleditmz);
        del_multi.events.register('activate',null,valCtrleditmz);
        modiatmz.events.register('activate',null,valCtrleditmz);

        //document.getElementById('framecapas').src = document.getElementById('framecapas').src;
}else{ //escala
    alertmsg ("La escala debe ser < a 30,000 para editar");
    edita_off('pr');
}
}


///////FUNCIONES PARA EDITAR LOS POLIGONOS RURALES AMANZANADOS
function trbuteditarpe(){
    obtener_maximos_au_pr_mz();
var geographic = new OpenLayers.Projection("EPSG:4326");
var mercator = new OpenLayers.Projection("EPSG:900913");
var ccl = new OpenLayers.Projection("EPSG:32800");
var escala=map.getScale();
if (escala < 30000){
    if (ban1==0){
        ban1=1;
    }else{
        alertmsg ("Ya tiene activada la herramienta de edicion");
        return false;
    }
    //nav.clear();
    desactivar_rueda_raton();
    desactivar_botones();
        var saveStrategy = new OpenLayers.Strategy.Save();
            saveStrategy.events.register('success', null, saveSuccessPe);
            saveStrategy.events.register('fail', null, saveFailPe);

    if (nivel==1){
                var filtroed = new OpenLayers.Filter.Logical({type: OpenLayers.Filter.Logical.AND,filters: [
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.EQUAL_TO,property: "cve_ent",value: filtroid}),
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "ban",value: 3}),
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "ban",value: 4})
                        ]});
    }else{
                var filtroed = new OpenLayers.Filter.Logical({type: OpenLayers.Filter.Logical.AND,filters: [
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "cve_ent",value: '00'}),
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "ban",value: 3}),
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "ban",value: 4})     //codigo 4 en es que cambio de clave y se da de baja con codigo 4
                        ]});
    }

            wfs =   new OpenLayers.Layer.Vector("MODIFICAR",{
                strategies: [new OpenLayers.Strategy.BBOX(), saveStrategy],protocol: new OpenLayers.Protocol.WFS({
                srsName: "EPSG:32800", url:  "http://"+hostnew+"/geoserver/INEGI"+idreggeo+"/wfs",
                featureType: "edit_pe",featureNS: "http://"+hostnew+"/INEGI"+idreggeo+""}),
                projection: ccl, styleMap: stylespr
                ,filter: filtroed
            });
           wfs.displayInLayerSwitcher= false;wfs.isBaseLayer=false;map.addLayers ([wfs]);

  // configure the snapping agent
            snap = new OpenLayers.Control.Snapping({layer: wfs,
                targets: [{
                    layer:wfs,
                    tolerance: 10,
                    edge: false,
                    filter: new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "surface",value: "dirt"})
                        }]
                });
            map.addControl(snap);
            snap.activate();

             drawmz = new OpenLayers.Control.DrawFeature(
                wfs, OpenLayers.Handler.Polygon, {title: "Agregar", displayClass: "olControlDrawFeaturePolygon" , multi: true}
            );
             drawmz.events.register('featureadded', drawmz, onFeatureSelectPe);
             modimz1 = new OpenLayers.Control.ModifyFeature(
                wfs, {displayClass: "olControlModifymzFeature",title: "Modificar"}
            );
            modimz2 = new OpenLayers.Control.ModifyFeature(
                wfs, {displayClass: "olControlModify2Feature", title: "Mover, rotar, tama\xF1o"}
            );
            modimz2.mode  = OpenLayers.Control.ModifyFeature.DRAG | OpenLayers.Control.ModifyFeature.ROTATE | OpenLayers.Control.ModifyFeature.RESIZE ;
            modiatmz = new OpenLayers.Control.ModifyFeature(
                wfs, {displayClass: "olControlText", title: "Atributos"}
            );
            modiatmz.mode  = null ;
            delmz = new DeleteFeaturePe(wfs, {title: "Borrar"});

        wfs.events.on({
            featureselected:onFeatureSelectPe,
            featureunselected: onFeatureUnSelectPe
        });


         savemz = new OpenLayers.Control.Button({
                title: "Salvar Cambios",
                trigger: function() {
                    if(modimz1.feature) {
                        modimz1.selectControl.unselectAll();
                    }
                    if(modimz2.feature) {
                        modimz2.selectControl.unselectAll();
                    }
                    if(modiatmz.feature) {
                        modiatmz.selectControl.unselectAll();
                    }
                    if(drawmz.feature) {
                        drawmz.selectControl.unselectAll();
                    }
                    if(drawmulti.feature) {
                        drawmulti.selectControl.unselectAll();
                    }
                    saveStrategy.save();
                    //wfsmov=[];
                },
                displayClass: "olControlSaveFeatures"
            });

         cutpol = new OpenLayers.Control.Button({
                title: "Activar Cortado",
                trigger: function() {
                    if (cutpolvar==0){
                        cutpolvar=1;
                        cutpol.activate();
                    }else{
                        cutpolvar=0;
                        cutpol.deactivate();
                    }
                },
                displayClass: "olControlcutpol"
            });

        cierramz = new OpenLayers.Control.Button ({
                displayClass: 'olControlClose',
                trigger: function() {
                    if (cierraban==0){
                        //if (confirm("Desea cerrar la edicion??")){
                            cierraban=1;
                        //}
                    }
                    if (cierraban==1){
                        cierraban=0;
                        drawmz.deactivate();
                        drawmulti.deactivate();
                        del_multi.deactivate();
                        modimz1.deactivate();
                        modimz2.deactivate();
                        modiatmz.deactivate();
                        butagmzpre.deactivate();
                        ban1=0;
                        wfs.removeAllFeatures();
                        wfs.visibility=false;
                        wfs.removeMap();
                        cierramz.destroy();
                        savemz.destroy();
                        modiatmz.destroy();
                        drawmz.destroy();
                        modimz1.destroy();
                        modimz2.destroy();
                        delmz.destroy();
                        cutpol.destroy();
                        drawmulti.destroy();
                        del_multi.destroy();
                        panel7.destroy();
                        panel7=undefined;
                        editarpe.deactivate();
                        //wfsmov=[];
                        cutpolvar=0;
                        //document.getElementById('framecapas').src = document.getElementById('framecapas').src;
                               for (var i = map.popups.length - 1; i >= 0; i--) {
                                  map.removePopup(map.popups[i]);
                        }
                        activar_rueda_raton();
                        edita_off('pe');
                    }
                },
                title: 'Cerrar editor'
            });




        var del_multi = new OpenLayers.Control.DrawFeature(
            pointLayeralt,
            OpenLayers.Handler.Point,
            {eventListeners: {
                featureadded: function(e) {
                            var sal=0;
                            var feature = e.feature;
                            var jsts_parser = new jsts.io.OpenLayersParser();
                            var jsts_geomA  = jsts_parser.read(feature.geometry);
                            var intersects12,ban,i,t,intersects2,val,poly2;
                            var reader = new jsts.io.WKTReader();
                               for(var j=0; j<wfs.features.length; j++) {
                                    if (sal==1){
                                        return false;
                                    }
                                        var jsts_geomB  = jsts_parser.read(wfs.features[j].geometry);
                                        intersects12 = feature.geometry.intersects(wfs.features[j].geometry);
                                        if(intersects12){
                                            sal++;
                                            n=0;
                                            if (wfs.features[j].geometry.components.length>1){
                                                    for (c in wfs.features[j].geometry.components) {
                                                            var poly = wfs.features[j].geometry.components[c];
                                                            intersects2 = feature.geometry.intersects(poly);
                                                            if(intersects2){
                                                                break;
                                                            }
                                                       }
                                                        var jsts_result_geom = jsts_geomB.difference(jsts_parser.read(poly));
                                                        var val=jsts_result_geom.toString();
                                                        if (val.substring(0,1)=='P'){
                                                            //console.log(val.substring(0,1));
                                                                val=val.replace('POLYGON','MULTIPOLYGON(')+')';
                                                        }
                                                        var geompol = OpenLayers.Geometry.fromWKT(val);
                                                        //var geompol = new OpenLayers.Geometry.MultiPolygon(OpenLayers.Geometry.fromWKT(jsts_result_geom.toString()));
                                                        //console.log(geompol);
                                                        wfs.eraseFeatures(wfs.features[j]);
                                                        wfs.features[j].geometry=geompol;
                                                        if (wfs.features[j].state!=OpenLayers.State.INSERT){
                                                            wfs.features[j].state = OpenLayers.State.UPDATE;
                                                        }
                                                        wfs.drawFeature(wfs.features[j]);
                                            }else{
                                                alertmsg("Ningun multipoligono");
                                                return false;
                                            }
                                        }//intersect
                                }//for
                            if (sal==0){
                                alertmsg("Ningun multipoligono");
                            }//sal=0
                    }
                },
            displayClass: "olControlDeletemultiFeature",
            title: "Borrar multipoligono"
            }
        );


        drawmulti = new OpenLayers.Control.DrawFeature(
                wfs, OpenLayers.Handler.Polygon, {title: "Agregar multipoligono", displayClass: "olControlDrawmultiFeaturePolygon" , multi: true}
            );
        drawmulti.events.register('featureadded', drawmulti, onFeatureSelectPe);


       butagmzpre = new OpenLayers.Control.DrawFeature(
            pointLayeralt,
            OpenLayers.Handler.Point,
            {eventListeners: {
                featureadded: function(e) {
                        var ll = e.feature.geometry.transform(new OpenLayers.Projection('EPSG:900913'), new OpenLayers.Projection('EPSG:4326'));
                        var capa=0;
                        cve_pe_temp="";
                        cve_pe_tipo=0;
                        //if (predig.getVisibility()==true){
                        //    capa=1;
                        //}else{
                        //    alertmsg ("Capa de predigitalizacion debe estar activa");
                        //    return false;
                        //}
                                var ajax=nuevoAjax();
                                ajax.open("GET",'obtgeo_pe.jsp?x='+ll.x+'&y='+ll.y+'&ent='+filtroid, true);
                                ajax.onreadystatechange=function()
                                {
                                    if(ajax.readyState==4)  {
                                        var val=ajax.responseText.trim();
                                        if (val=='1'){
                                            alertmsg ("No se pudo extraer el poligono");
                                        }else{
                                            //console.log(val);
                                            var pe_tipo=val.substring(0,1);
                                            var pe_ent=val.substring(1,3);
                                            var pe_mun=val.substring(3,6);
                                            var pe_loc=val.substring(6,10);
                                            val=val.substring(10,val.length);
                                            var geompol = OpenLayers.Geometry.fromWKT(val);
                                            cve_pe_temp=pe_ent+pe_mun+pe_loc;
                                            cve_pe_tipo=pe_tipo;      //1=CUR, 2=PRE
                                            if (parseInt(pe_loc)>=9000 || cve_pe_tipo==2){ // es 9000 se trabaja como nueva
                                                    wfs.addFeatures([new OpenLayers.Feature.Vector(geompol)]);
                                                    var n=wfs.features.length-1;
                                                    wfs.features[n].state=OpenLayers.State.INSERT;
                                                    feature = wfs.getFeatureBy('fid', wfs.features[n].fid);
                                                    onFeatureSelectPe(feature,1);
                                            }else{   // no es 9000 reemplaza poligono
                                                    var l=wfs.features.length-1;
                                                    var n=0;
                                                    for(var i=0; i<=l; i++) {
                                                            if (wfs.features[i].state!=OpenLayers.State.DELETE){
                                                                    if (wfs.features[i].attributes.cve_ent+wfs.features[i].attributes.cve_mun+wfs.features[i].attributes.cve_loc==pe_ent+pe_mun+pe_loc){
                                                                        //console.log(wfs.features[i]);
                                                                        wfs.eraseFeatures(wfs.features[i]);
                                                                        wfs.features[i].geometry=geompol;
                                                                        wfs.features[i].attributes.img  = baseimg;
                                                                        wfs.features[i].attributes.us  = iduser;
                                                                        wfs.features[i].state = OpenLayers.State.UPDATE;
                                                                        wfs.drawFeature(wfs.features[i]);
                                                                        alertmsg("Se ajusta el poligono");
                                                                        wfs.features[i].attributes.obsoc=cve_pe_temp;
                                                                        wfs.features[i].attributes.err=1;
                                                                        n=1;
                                                                        return false;
                                                                    }
                                                            }
                                                    }
                                                    if (n==0){
                                                        alertmsg ("No hay coincidencia de clave");
                                                        return false;
                                                    }
                                            }
                                        }
                                    }
                                }
                                ajax.send(null);
                    }
                },
            displayClass: "olControlAgmz_pre",
            title: "Agregar poligono externo desde CUR/PREDIG"
            }
        );




        panel7 = new OpenLayers.Control.Panel({displayClass: 'panel4Toolbar'});
        panel7.addControls([cierramz,savemz,modiatmz,butagmzpre,drawmz,modimz1,modimz2,delmz,cutpol,drawmulti,del_multi]);

        //panel7.addControls([cierramz,savemz,drawmz,modimz1,delmz,cutpol]);

        map.addControl(panel7);
        editarpe.activate();
        //drawmz.activate();

        delmz.events.register('activate',null,valCtrleditmz);
        butagmzpre.events.register('activate',null,valCtrleditmz);
        modimz1.events.register('activate',null,valCtrleditmz);
        modimz2.events.register('activate',null,valCtrleditmz);
        drawmz.events.register('activate',null,valCtrleditmz);
        drawmulti.events.register('activate',null,valCtrleditmz);
        del_multi.events.register('activate',null,valCtrleditmz);
        modiatmz.events.register('activate',null,valCtrleditmz);

        //document.getElementById('framecapas').src = document.getElementById('framecapas').src;
}else{ //escala
    alertmsg ("La escala debe ser < a 30,000 para editar");
    edita_off('pe');
}
}

///// funcion para envolver manzanas y asignarle un codigo

    var porpoligono = new OpenLayers.Control.DrawFeature(
            pointLayeralt,
            OpenLayers.Handler.Polygon,
            {eventListeners: {
                featureadded: function(e) {
                    var escala=map.getScale()
                    tiporeg=2;  ///aqui registro el 2 ya que para esta ocasion solo hay el numero 2.
                      featureg='';
                    if (escala < 30000){
                        featureg=e.feature;
                        var feature = e.feature;
                        var  theHTML = '<center>';
                        //var geom=e.feature.geometry.toString();
                        theHTML += '<table border=1><tr><th class=label style="text-align:center">CLASIFICACION DE';
                        theHTML += '<tr><td class=label style="text-align:center" bgcolor="#FAD4F0">MANZANAS NO EN MG DESDE';
                        theHTML += '<tr><td class=label style="text-align:left"><!--<input type="radio" name="tiporegradio" value="1" onclick="seguireg2(1);"> PRE-DIGITALIZADAS-->';
                        theHTML += '<input type="radio" name="tiporegradio" value="2" onclick="seguireg2(2);" checked > CUR - CARTOGRAFIA U y R';
                        theHTML += '<tr><td><hr>';
                        theHTML += '<tr><td class=label style="text-align:left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" id="rad1" name="noprocede" value="2" onclick="seguireg(2);"> Por criterios MG';
                        theHTML += '<tr><td class=label style="text-align:left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" id="rad2" name="noprocede" value="3" onclick="seguireg(3);"> Por ser caserio';
                        theHTML += '<tr><td class=label style="text-align:left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" id="rad3" name="noprocede" value="4" onclick="seguireg(4);"> # de Mzs < 3'
                        theHTML += '<tr><td class=label style="text-align:left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" id="rad4" name="noprocede" value="5" onclick="seguireg(5);"> Ya existe en MG'
                        //reguireg esta al final
                        theHTML += '<tr><td><hr>';theHTML += '<tr><th class=label style="text-align:center" bgcolor="#FAD4F0">POLIGONOS EXTERNOS';
                        theHTML += '<tr><td><input type="radio" name="tiporegradio" value="2" onclick="seguireg2(3);""> NO PROCEDE';
                        theHTML += '<tr><td><br>';

                        theHTML += '<tr><td><hr>';theHTML += '<tr><th class=label style="text-align:center" bgcolor="#FAD4F0">LOCALIDAD PUNTUAL RURAL';
                        theHTML += '<tr><td><input type="radio" name="tiporegradio" value="2" onclick="seguireg2(4);""> NO PROCEDE';
                        theHTML += '<tr><td><br>';

                        theHTML += '<tr><td><hr>';theHTML += '<tr><th class=label style="text-align:center" bgcolor="#FFFFBA">MANZANA PREDIGITALIZADA ';
                        theHTML += '<tr><td><input type="radio" name="tiporegradio" value="2" onclick="seguireg2(5);""> NO PROCEDE (CUR , MG)';
                        theHTML += '<tr><td><br>';

                        theHTML += '<tr><td class=label style="text-align:center">';
                        theHTML += '</center>';
                        if (map.getExtent().containsLonLat(feature.geometry.getBounds().getCenterLonLat())){
                            var varcent=feature.geometry.getBounds().getCenterLonLat();
                        }else{
                            var varcent=map.getCenter();
                        }
                        feature.popup = new OpenLayers.Popup.AnchoredBubble
                        ("pop", varcent, new OpenLayers.Size(260,360),
                        theHTML,    null,   true    //este false es el boton de cerrar
                        );
                        feature.popup.opacity=0.9;
                        feature.popup.backgroundColor="#BBCCFF";
                        map.addPopup(feature.popup);
                        document.getElementById("pop").style.zIndex = "999";
                    }else{
                         alertmsg ("La escala debe ser < a 30,000 para digitalizar");
                    }
                    }
                },
            displayClass: "olControlDrawFeaturePolygonRegistra",title: "Registrar NO PROCEDEN por poligono"
            }
        );
porpoligono.events.register('activate',null,valCtrl);    //agregar anotaciones


///// funcion para registrar numero de viviendas

  /*var inv_punto = new OpenLayers.Control.DrawFeature(
            pointLayeralt,
            OpenLayers.Handler.Point,
            {eventListeners: {
                featureadded: function(e) {
                        if (mza_inv.getVisibility()==true || predig.getVisibility()==true){
                            featureg='';
                            var escala=map.getScale()
                            if (escala < 30000){
                                if (map.popups.length>0){
                                        onPopupCloseprall();
                                }
                                featureg=e.feature;
                                var feature = e.feature;
                                var theHTML = '<center>';
                                //var geom=e.feature.geometry.toString();
                                theHTML += '<table border=1>';
                                theHTML += '<tr><td class=label style="text-align:center"><br>';
                                theHTML += '<tr><th class=label style="text-align:center" colspan=2>CONTEO VISUAL DE VIVIENDAS';
                                theHTML += '<tr><td colspan=2><hr>';
                                theHTML += '<tr><td class=label style="text-align:right"># Inmuebles:';
                                theHTML += '<td class=label style="text-align:left"><input type="number" value=0 style="width: 4em;" id=numerodeviviendas>';
                                theHTML += '<tr><td class=label style="text-align:center"><br>';
                                theHTML += '<tr><td class=label style="text-align:center" colspan="2"><input type="radio" id="numvivfte1" name="numvivfte" value="G" checked>Gabinete&nbsp;&nbsp;<input type="radio" name="numvivfte" id="numvivfte2" value="C">Campo';
                                theHTML += '<tr><td class=label style="text-align:center"><br>';
                                theHTML += '<tr><td colspan=2 class=boton"><center><input type=button value=" Registrar " onClick="seguireinv()">';
                                theHTML += '</center>';
                                if (map.getExtent().containsLonLat(e.feature.geometry.getBounds().getCenterLonLat())){
                                    var varcent=e.feature.geometry.getBounds().getCenterLonLat();
                                }else{
                                    var varcent=map.getCenter();
                                }
                                feature.popup = new OpenLayers.Popup.AnchoredBubble
                                ("pop", varcent, new OpenLayers.Size(250,170),
                                theHTML,    null,   true    //este false es el boton de cerrar
                                );
                                feature.popup.opacity=0.9;
                                feature.popup.backgroundColor="#BBCCFF";
                                map.addPopup(feature.popup);
                                document.getElementById("pop").style.zIndex = "999";
                            }else{
                                 alertmsg ("La escala debe ser < a 30,000 para digitalizar");
                            }
                        }else{
                            alertmsg ("No tiene la capa Mz INV / Predig activa");
                            return false;
                        }
                    }
                },
            //displayClass: "olControlInv_punto", 
            title: "Conteo de viviendas por imagen MZ/LOC"
            }
        );
inv_punto.events.register('activate',null,valCtrl);    //agregar inv manzanas y localidades
*/

////// FUNCION PARA EDICION DE MANZANAS****************************************************************************************************************

function trbuteditarmz(){
    obtener_maximos_au_pr_mz();
//alertmsg ("Herramienta en pruebas, no es definitiva");
var geographic = new OpenLayers.Projection("EPSG:4326");
var mercator = new OpenLayers.Projection("EPSG:900913");
var ccl = new OpenLayers.Projection("EPSG:32800");
var escala=map.getScale();   //si es menor a 30000 entra a la edicion
if (escala < 10000){
    if (ban1==0){
        ban1=1;
    }else{
        alertmsg ("Ya tiene activada la herramienta de edicion");
        return false;
    }
    //nav.clear();
    mzamax=0,cvemax='';
    desactivar_rueda_raton();
    desactivar_botones();
        var saveStrategy = new OpenLayers.Strategy.Save();
            saveStrategy.events.register('success', null, saveSuccessMz);
            saveStrategy.events.register('fail', null, saveFailMz);

    if (nivel==1){
                var filtroed = new OpenLayers.Filter.Logical({type: OpenLayers.Filter.Logical.AND,filters: [
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.EQUAL_TO,property: "cve_ent",value: filtroid}),
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "ban",value: "5"}),
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "ban",value: "6"}),
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "ban",value: "E"}),
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "ban",value: "J"}),
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "ban",value: "D"}),
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "ban",value: "H"}),
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "ban",value: "G"}),
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "ban",value: "I"}),
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "ban",value: "N"}),
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "ban",value: "O"}),
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "ban",value: "M"}),
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "ban",value: "1"}),
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "ban",value: "Y"}),
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "ban",value: "K"}),
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "ban",value: "T"}),
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "ban",value: "R"}),
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "ban",value: "C"}),
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "ban",value: "3"}),
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.EQUAL_TO,property: "inv_fte",value: "2"})             //aqui le ponemos para que solo prenda las que vengan de la encuesta  o sean actualizacioens ya activas

                    ]});
    }else{
                var filtroed = new OpenLayers.Filter.Logical({type: OpenLayers.Filter.Logical.AND,filters: [
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "cve_ent",value: '00'}),
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "ban",value: "5"}),
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "ban",value: "6"}),
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "ban",value: "E"}),
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "ban",value: "J"}),
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "ban",value: "D"}),
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "ban",value: "H"}),
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "ban",value: "G"}),
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "ban",value: "I"}),
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "ban",value: "N"}),
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "ban",value: "O"}),
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "ban",value: "M"}),
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "ban",value: "1"}),
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "ban",value: "Y"}),
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "ban",value: "K"}),
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "ban",value: "T"}),
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "ban",value: "R"}),
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "ban",value: "C"}),
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "ban",value: "3"}),
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.EQUAL_TO,property: "inv_fte",value: "2"})              //aqui le ponemos para que solo prenda las que vengan de la encuesta  o sean actualizacioens ya activas
                    ]});
    }

            wfs =   new OpenLayers.Layer.Vector("MODIFICAR",{
                strategies: [new OpenLayers.Strategy.BBOX(), saveStrategy],protocol: new OpenLayers.Protocol.WFS({
                srsName: "EPSG:32800",url:  "http://"+hostnew+"/geoserver/INEGI"+idreggeo+"/wfs",
                featureType: "cat_manz",featureNS: "http://"+hostnew+"/INEGI"+idreggeo+""}),
                projection: ccl, styleMap: styles
                ,filter: filtroed
            });
           wfs.displayInLayerSwitcher= false;wfs.isBaseLayer=false;map.addLayers ([wfs]);
             //drawmz = new OpenLayers.Control.DrawFeature(
               // wfs, OpenLayers.Handler.Polygon, {title: "Agregar", displayClass: "olControlDrawFeaturePolygon" , multi: true}
            //);
             drawmz = new OpenLayers.Control.DrawFeature(
                //wfs, OpenLayers.Handler.Polygon, {title: "Agregar de MNV", displayClass: "olControlDrawFeaturePolygon" , multi: true}
                wfs, OpenLayers.Handler.Polygon, {title: "Agregar MZ, no del CUR", displayClass: "olControlDrawFeaturePolygon" , multi: true}
            );
             drawmz.events.register('featureadded', drawmz, onFeatureSelectmz);
             modimz1 = new OpenLayers.Control.ModifyFeature(
                wfs, {displayClass: "olControlModifymzFeature",title: "Modificar"}
            );


             submz = new OpenLayers.Control.DrawFeature(
                wfs, OpenLayers.Handler.Path, {title: "Subdivide / Cortes", displayClass: "olControlSplit" , multi: false,
                        callbacks : {
                            "done": function (e){
                                subdivide(e);
                                }}});

            drawsub = new OpenLayers.Control.DrawFeature(
                wfs, OpenLayers.Handler.Polygon, {title: "Subdivide desde multiples manzanas / Huecos", displayClass: "olControlSubmul" , multi: true}
            );
            drawsub.events.register('featureadded', drawsub, onFeatureSelectmz);

            modimz2 = new OpenLayers.Control.ModifyFeature(
                wfs, {displayClass: "olControlModify2Feature", title: "Mover, rotar, tama\xF1o"}
            );
            modimz2.mode  = OpenLayers.Control.ModifyFeature.DRAG | OpenLayers.Control.ModifyFeature.ROTATE | OpenLayers.Control.ModifyFeature.RESIZE ;
             modiatmz = new OpenLayers.Control.ModifyFeature(
                wfs, {displayClass: "olControlText", title: "Atributos"}
            );
            modiatmz.mode  = null ;
            delmz = new DeleteFeatureMz(wfs, {title: "Borrar"});
            delmzcas = new DeleteFeatureMzcas(wfs, {title: "Baja Manzana/Crear Caserio"});


            //fusmz = new OpenLayers.Control.Button ({displayClass: 'olControlMerge', trigger: fusiona, title: 'Fusiona'});

            fusmz = new OpenLayers.Control.ModifyFeature(
                wfs, {displayClass: "olControlMerge", title: "Fusiona Manzana"}
            );
            fusmz.mode  = null ;


            // casos especiales deshabilitado temporalmentecons==44 || cons==60 || cons==234 || cons==496 || cons==1705

            if (iduser==44 || iduser==60 || iduser==234 || iduser==1705 || iduser==496 || 1==1){ //cambia datos de la tabla de eq){
                drawmzcasos = new OpenLayers.Control.DrawFeature(
                      wfs, OpenLayers.Handler.Polygon, {title: "Casos especiales (Multiples Mz)", displayClass: "olControlmzcasos" , multi: true}
                );
                drawmzcasos.events.register('featureadded', drawmzcasos, onFeatureSelectmzcasos);

                drawmzcasosJ = new OpenLayers.Control.DrawFeature(
                      wfs, OpenLayers.Handler.Point, {title: "Cambio de ambito (Desde ageb nuevo)", displayClass: "olControlmzcasosJ" }
                );
                drawmzcasosJ.events.register('featureadded', drawmzcasosJ, onFeatureSelectmzcasosJ);
            }else{
                drawmzcasos = new OpenLayers.Control.Button({title: "Casos especiales (Multiples Mz) (DESHABILITADO TEMPORALMENTE)", displayClass: "olControlmzcasos"});
                drawmzcasosJ = new OpenLayers.Control.Button({title: "Cambio de ambito (Desde ageb nuevo) (DESHABILITADO TEMPORALMENTE)", displayClass: "olControlmzcasosJ"});
            }


                drawmzcasos_chgform = new OpenLayers.Control.DrawFeature(
                      wfs, OpenLayers.Handler.Polygon, {title: "Cambio Forma (Multiples Mz)", displayClass: "olControlmzcasosChgForm" , multi: true}
                );
                drawmzcasos_chgform.events.register('featureadded', drawmzcasos_chgform, onFeatureSelectmzChgform);

    

/*
        editarfm = new OpenLayers.Control.ModifyFeature(
            wfs, {displayClass: "olControlModifymzFeature", title: "Mover manzana por medio de frentes"});
        editarfm.mode  = null ;
*/


editarfm = new OpenLayers.Control.DrawFeature(
            pointLayeralt,
            OpenLayers.Handler.Point,
            {eventListeners: {
                featureadded: function(e) {
                        var ll = e.feature.geometry.transform(new OpenLayers.Projection('EPSG:900913'), new OpenLayers.Projection('EPSG:4326'));
                        var capa=0;
                        cve_pe_temp="";
                        cve_pe_tipo=0;
                        //if (predig.getVisibility()==true){
                        //    capa=1;
                        //}else{
                        //    alertmsg ("Capa de predigitalizacion debe estar activa");
                        //    return false;
                        //}
                                var ajax=nuevoAjax();
                                ajax.open("GET",'obtcve_fm.jsp?x='+ll.x+'&y='+ll.y+'&ent='+filtroid, true);
                                ajax.onreadystatechange=function()
                                {
                                    if(ajax.readyState==4)  {
                                        var val=ajax.responseText.trim();
                                        if (val=='1'){
                                            alertmsg ("No se pudo extraer los frentes");
                                        }else if (val=='0'){
                                            alertmsg ("No hay manzana seleccionada (SOLO SE PUEDE MOVER LA QUE FUSIONA)");
                                        }else{
                                            alertmsg ("Mover manzana: "+val);
                                            trbuteditarfm2(val);
                                        }
                                    }
                                }
                                ajax.send(null);
                    }
                },
            displayClass: "olControlModifymzFeature",
            title: "Mover manzana por medio de frentes "
            }
        );



        wfs.events.on({
            featureselected:onFeatureSelectmz,
            featureunselected: onFeatureUnSelectmz
        });

        atras = new OpenLayers.Control.Button ({displayClass: 'olControlAtras',
                trigger: enviar_atras, title: 'Enviar al fondo (Contenedora)'});



         savemz = new OpenLayers.Control.Button({
                title: "Salvar Cambios",
                trigger: function() {
                    if(modimz1.feature) {
                        modimz1.selectControl.unselectAll();
                    }
                    if(modimz2.feature) {
                        modimz2.selectControl.unselectAll();
                    }
                    if(modiatmz.feature) {
                        modiatmz.selectControl.unselectAll();
                    }
                    if(drawmz.feature) {
                        drawmz.selectControl.unselectAll();
                    }
                    if(drawsub.feature) {
                        drawsub.selectControl.unselectAll();
                    }
                    saveStrategy.save();
                    //wfsmov=[];
                    mzamax=0,cvemax='';
                },
                displayClass: "olControlSaveFeatures"
            });


        refr = new OpenLayers.Control.Button({
                title: "Regresa el ultimo movimiento no guardado",
                trigger: function() {
                    if (wfsmov.length>0){
                        if(modimz1.feature) {
                            modimz1.selectControl.unselectAll();
                        }
                        if(modimz2.feature) {
                            modimz2.selectControl.unselectAll();
                        }
                        if(modiatmz.feature) {
                            modiatmz.selectControl.unselectAll();
                        }
                        if(drawmz.feature) {
                            drawmz.selectControl.unselectAll();
                        }
                        if(drawsub.feature) {
                            drawsub.selectControl.unselectAll();
                        }
                        var ult=wfsmov.length-1;
                        var feature = wfs.getFeatureBy('id', wfsmov[ult]);
                        wfs.eraseFeatures(feature);
                        if (feature.modified!=null){
                            feature.geometry=feature.modified.geometry;
                            feature.modified=null
                        }
                        wfsmov.splice(ult, 1);
                        feature.attributes.ban = feature.data.ban;
                        feature.attributes.cve_ent = feature.data.cve_ent;
                        feature.attributes.cve_mun = feature.data.cve_mun;
                        feature.attributes.cve_loc = feature.data.cve_loc;
                        feature.attributes.cve_ageb = feature.data.cve_ageb;
                        feature.attributes.img = feature.data.img;
                        feature.attributes.tipomza = feature.data.tipomza;
                        feature.attributes.proy = feature.data.proy;
                        feature.attributes.usuario = feature.data.usuario;
                        if (feature.state == OpenLayers.State.INSERT){
                            wfs.destroyFeatures(feature);
                        }else if (feature.state == OpenLayers.State.UPDATE && feature.attributes.cve_mza=='XXX'){     //XXX lo usaba en jsmanzana, para controlar el deshacer movimiento
                            feature.attributes.cve_mza = feature.data.cve_mza;
                            feature.renderIntent = "";
                            feature.state=null;
                            wfs.drawFeature(feature);
                        }else{
                            feature.attributes.cve_mza = feature.data.cve_mza;
                           feature.state=null;
                           wfs.drawFeature(feature);
                        }
                        alertmsg("Ultimo movimiento regresado");
                    }
                },
                displayClass: "olControlRecargar"
            });


        cierramz = new OpenLayers.Control.Button ({
                displayClass: 'olControlClose',
                trigger: function() {
                    if (cierraban==0){
                        //if (confirm("Desea cerrar la edicion??")){
                            cierraban=1;
                        //}
                    }
                    if (cierraban==1){
                        cierraban=0;
                        if (panelfm){
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
                        }
                        drawmz.deactivate();
                        modimz1.deactivate();
                        modimz2.deactivate();
                        modiatmz.deactivate();
                        submz.deactivate();
                        drawsub.deactivate();
                        drawmzcasos.deactivate();
                        drawmzcasosJ.deactivate();
                        drawmzcasos_chgform.deactivate();
                        butagmz.deactivate();
                        desactivar_botones();
                        ban1=0;
                        wfs.removeAllFeatures();
                        wfs.visibility=false;
                        wfs.removeMap();
                        //wfs.destroy();
                        cierramz.destroy();
                        savemz.destroy();
                        butagmz.destroy();
                        atras.destroy();
                        drawmzcasos.destroy();
                        drawmzcasosJ.destroy();
                        drawmzcasos_chgform.destroy();
                        drawsub.destroy();
                        fusmz.destroy();
                        modiatmz.destroy();
                        editarfm.destroy();
                        panel3.destroy();
                        panel3=undefined;
                        editarmz.deactivate();
                        //wfsmov=[];
                        //document.getElementById('framecapas').src = document.getElementById('framecapas').src;
                                   for (var i = map.popups.length - 1; i >= 0; i--) {
                                      map.removePopup(map.popups[i]);
                            }
                        activar_rueda_raton();
                        edita_off('mz');
                    }
                },
                title: 'Cerrar editor'
            });

       //var modcar = new OpenLayers.Control.Button ({displayClass: 'olControlModcar', trigger: trbutmodcar, title: 'Modulo cartografico'});

       butagmz = new OpenLayers.Control.DrawFeature(
            pointLayeralt,
            OpenLayers.Handler.Point,
            {eventListeners: {
                featureadded: function(e) {
                        if (brincamza==0){
                            var ll = e.feature.geometry.transform(new OpenLayers.Projection('EPSG:900913'), new OpenLayers.Projection('EPSG:4326'));
                            var capa1=0;
                            var capa2=0;
                            var capa3=0;
                            var capa4=0;
                            if (mza_mod.getVisibility()==true){capa1=1;}
                            if (mza_acu.getVisibility()==true){capa2=1;}
                            if (predig.getVisibility()==true){capa3=1;}
                            if (mza_bcuu.getVisibility()==true){capa4=1;}
                            if (capa1+capa2+capa3+capa4==0){
                                alertmsg ("No tiene capa visible");
                                return false;
                            }
                            ventanaobtmza = window.open('obtmza.jsp?c='+iduser+'&capa1='+capa1+'&capa2='+capa2+'&capa3='+capa3+'&capa4='+capa4+'&x='+ll.x+'&y='+ll.y,'AgregarMz','toolbar=no,Resizable=1,scrollbars=1');
                            ventanaobtmza.focus();
                        }else{
                            brincamza=0;
                        }
                    }
                },
            displayClass: "olControlAgmz",
            title: "Agregar Manzana desde MCC"
            }
        );


///////COMIENZO A PROBAR LO DE LOS FRENTES DE MANZANA

        panel3 = new OpenLayers.Control.Panel({displayClass: 'panel3Toolbar'});
        //panel3.addControls([editarfm,cierramz,savemz,butagmz,butagmzpre,atras,drawmzcasos,drawsub,submz,fusmz,modiatmz,drawmz,modimz1,modimz2,delmz,delmzcas]);

        panel3.addControls([cierramz,savemz,butagmz,atras,drawmzcasos,drawsub,submz,fusmz,modiatmz,delmzcas,editarfm,drawmzcasos_chgform

        ]);


        //panel3.addControls([cierramz,savemz,butagmz,atras,drawmzcasosJ,drawmzcasos,drawsub,,modiatmz,editarfm,submz]);
        //panel3.addControls([cierramz,savemz,atras,drawmzcasosJ,drawmzcasos,editarfm]);

        map.addControl(panel3);
        editarmz.activate();
        //modimz1.activate();
        //butagmz.activate();

        delmz.events.register('activate',null,valCtrleditmz);
        delmzcas.events.register('activate',null,valCtrleditmz);
        modimz2.events.register('activate',null,valCtrleditmz);
        modimz1.events.register('activate',null,valCtrleditmz);
        drawmz.events.register('activate',null,valCtrleditmz);
        fusmz.events.register('activate',null,valCtrleditmz);
        modiatmz.events.register('activate',null,valCtrleditmz);
        submz.events.register('activate',null,valCtrleditmz);
        drawsub.events.register('activate',null,valCtrleditmz);
        butagmz.events.register('activate',null,valCtrleditmz);
        drawmzcasos.events.register('activate',null,valCtrleditmz);
        drawmzcasosJ.events.register('activate',null,valCtrleditmz);
        drawmzcasos_chgform.events.register('activate',null,valCtrleditmz);
        editarfm.events.register('activate',null,valCtrleditmz);

        //document.getElementById('framecapas').src = document.getElementById('framecapas').src;
}else{ //escala
    alertmsg ("La escala debe ser < a 10,000 para editar");
    edita_off('mz');
}
}




// FUNCION VIENE DE EDICION DE MANZANAS
function valCtrleditmz(event){
    desactivar_botones();
    if (event.object.title=="Mover manzana por medio de frentes"){
        alertmsg("Seleccionar manzana");
        //wfs.setZIndex(maxzindex()+1);
        //console.log(wfs.getZIndex());
    }else{
        if (event.object.title=="Fusiona Manzana"){
            alertmsg("Seleccionar manzana a permanecer");
        }
    }
    //mensaje de cuando es codigo J
    if (event.object.title=="Cambio de ambito (Desde ageb nuevo)"){
        ventana = window.open('vercodigoJ.jsp?capa=1','AgregarJ','toolbar=no,Resizable=1,scrollbars=1');
    }else if (event.object.title=="Cambio de ambito (Multiples Caserios)"){
        ventana = window.open('vercodigoJ.jsp?capa=2','AgregarJ','toolbar=no,Resizable=1,scrollbars=1');
    }
    //console.log(map.controls);
}



////// FUNCION PARA EDICION DE CASERIOS****************************************************************************************************************

function trbuteditarcd(){
    obtener_maximos_au_pr_mz();
//alertmsg ("Herramienta en pruebas, no es definitiva");
var geographic = new OpenLayers.Projection("EPSG:4326");
var mercator = new OpenLayers.Projection("EPSG:900913");
var ccl = new OpenLayers.Projection("EPSG:32800");
var escala=map.getScale();   //si es menor a 30000 entra a la edicion
if (escala < 10000){
    if (ban1==0){
        ban1=1;
    }else{
        alertmsg ("Ya tiene activada la herramienta de edicion");
        return false;
    }
    //nav.clear();
    desactivar_rueda_raton();
    desactivar_botones();
        var saveStrategy = new OpenLayers.Strategy.Save();
            saveStrategy.events.register('success', null, saveSuccessCd);
            saveStrategy.events.register('fail', null, saveFailCd);

    if (nivel==1){
                var filtroed = new OpenLayers.Filter.Logical({type: OpenLayers.Filter.Logical.AND,filters: [
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.EQUAL_TO,property: "cve_ent",value: filtroid}),
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.EQUAL_TO,property: "inv_fte",value: "0"})]});
    }else{
                var filtroed = new OpenLayers.Filter.Logical({type: OpenLayers.Filter.Logical.AND,filters: [
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "cve_ent",value: '00'}),
                        new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.EQUAL_TO,property: "inv_fte",value: "0"})
                    ]});
    }
            wfs =   new OpenLayers.Layer.Vector("MODIFICAR",{
                strategies: [new OpenLayers.Strategy.BBOX(), saveStrategy],protocol: new OpenLayers.Protocol.WFS({
                srsName: "EPSG:32800", url:  "http://"+hostnew+"/geoserver/INEGI"+idreggeo+"/wfs",
                featureType: "cat_cd",featureNS: "http://"+hostnew+"/INEGI"+idreggeo+""}),
                projection: ccl, styleMap: stylescd
                ,filter: filtroed
            });


           wfs.displayInLayerSwitcher= false;wfs.isBaseLayer=false;map.addLayers ([wfs]);
            drawmz = new OpenLayers.Control.DrawFeature(
                wfs, OpenLayers.Handler.Point, {title: "Agregar", displayClass: "olControlDrawFeaturePoint" }
            );
             drawmz.events.register('featureadded', drawmz, onFeatureSelectcd);

            modimz2 = new OpenLayers.Control.ModifyFeature(
                wfs, {displayClass: "olControlModify2Feature", title: "Mover"}
            );
            modimz2.mode  = OpenLayers.Control.ModifyFeature.DRAG;

            delmz = new DeleteFeatureCd(wfs, {title: "Borrar"});

            // casos especiales deshabilitado temporalmente

             if (iduser==44 || iduser==60 || iduser==234 || iduser==1705 || iduser==496 || 1==1){ //cambia datos de la tabla de eq){
                drawmzcasos = new OpenLayers.Control.DrawFeature(
                    wfs, OpenLayers.Handler.Polygon, {title: "Casos especiales (Multiples Caserios)", displayClass: "olControlmzcasos" , multi: true}
                );
                drawmzcasos.events.register('featureadded', drawmzcasos, onFeatureSelectcdcasos);


                drawmzcasosJ = new OpenLayers.Control.DrawFeature(
                      wfs, OpenLayers.Handler.Polygon, {title: "Cambio de ambito (Multiples Caserios)", displayClass: "olControlmzcasosJ", multi: true }
                );
                drawmzcasosJ.events.register('featureadded', drawmzcasosJ, onFeatureSelectmzcasosJC);
            }else{
                drawmzcasos = new OpenLayers.Control.Button({title: "Casos especiales (Multiples Mz) (DESHABILITADO TEMPORALMENTE)", displayClass: "olControlmzcasos"});
                drawmzcasosJ = new OpenLayers.Control.Button({title: "Cambio de ambito (Multiples Caserios) (DESHABILITADO TEMPORALMENTE)", displayClass: "olControlmzcasosJ"});
            }

            // simplificar caserios

            cdsimplify = new OpenLayers.Control.DrawFeature(
                    pointLayeralt, OpenLayers.Handler.Point, {title: "Simplificar Caserios", displayClass: "olControlcdsimplify"}
                );
            cdsimplify.events.register('featureadded', cdsimplify, onFeatureSelectCdsimplify);

        wfs.events.on({
            featureselected:onFeatureSelectcd,
            featureunselected: onFeatureUnSelectcd
        });


//-------------POLIGONO DE CASERIOS----------------------------------------------------------------------------------------------------------------
         var saveStrategypol = new OpenLayers.Strategy.Save();
            saveStrategypol.events.register('success', null, saveSuccessCdpol);
            saveStrategypol.events.register('fail', null, saveFailCdpol);


            wfs_cdpol =   new OpenLayers.Layer.Vector("MODIFICARCDPOL",{
                strategies: [new OpenLayers.Strategy.BBOX(), saveStrategypol],protocol: new OpenLayers.Protocol.WFS({
                srsName: "EPSG:32800", url:  "http://"+hostnew+"/geoserver/INEGI"+idreggeo+"/wfs",
                featureType: "cd_polext",featureNS: "http://"+hostnew+"/INEGI"+idreggeo+""}),
                projection: ccl, styleMap: stylescdpol
                //,filter: filtroed
            });
           wfs_cdpol.displayInLayerSwitcher= false;wfs_cdpol.isBaseLayer=false;map.addLayers ([wfs_cdpol]);
             draw_cdpol = new OpenLayers.Control.DrawFeature(
                wfs_cdpol, OpenLayers.Handler.Polygon, {title: "Agregar POLIGONO", displayClass: "olControlDrawFeaturePolygonPEM" , multi: true}
            );
            draw_cdpol.events.register('featureadded', draw_cdpol, onFeatureSelectCdpol);
             modimz1_cdpol = new OpenLayers.Control.ModifyFeature(
                wfs_cdpol, {displayClass: "olControlModifymzFeaturePEM",title: "Modificar POLIGONO",enforceTopology: true}
            );
             modimz2_cdpol = new OpenLayers.Control.ModifyFeature(
                wfs_cdpol, {displayClass: "olControlModify2FeaturePEM", title: "Mover, rotar, tama\xF1o POLIGONO"}
            );
            modimz2_cdpol.mode  = OpenLayers.Control.ModifyFeature.DRAG | OpenLayers.Control.ModifyFeature.ROTATE | OpenLayers.Control.ModifyFeature.RESIZE ;
             delmz_cdpol = new DeleteFeatureCdPol(wfs_cdpol, {title: "Borrar POLIGONO"});




//-------------POLIGONO DE CASERIOS----------------------------------------------------------------------------------------------------------------


         savemz = new OpenLayers.Control.Button({
                title: "Salvar Cambios",
                trigger: function() {
                    if(modimz2.feature) {
                        modimz2.selectControl.unselectAll();
                    }
                    if(drawmz.feature) {
                        drawmz.selectControl.unselectAll();
                    }
                    if(draw_cdpol.feature) {
                        draw_cdpol.selectControl.unselectAll();
                    }
                    if(modimz1_cdpol.feature) {
                        modimz1_cdpol.selectControl.unselectAll();
                    }
                    if(modimz2_cdpol.feature) {
                        modimz2_cdpol.selectControl.unselectAll();
                    }
                    saveStrategypol.save();
                    saveStrategy.save();
                },
                displayClass: "olControlSaveFeatures"
            });





        cierramz = new OpenLayers.Control.Button ({
                displayClass: 'olControlClose',
                trigger: function() {
                    if (cierraban==0){
                        //if (confirm("Desea cerrar la edicion??")){
                            cierraban=1;
                        //}
                    }
                    if (cierraban==1){
                        cierraban=0;
                        drawmz.deactivate();
                        cdsimplify.deactivate();
                        modimz2.deactivate();
                        draw_cdpol.deactivate();
                        delmz_cdpol.deactivate();
                        modimz2_cdpol.deactivate();
                        modimz1_cdpol.deactivate();
                        drawmzcasos.deactivate();
                        drawmzcasosJ.deactivate();
                        butagmzpre.deactivate();
                        butagmz.deactivate();
                        desactivar_botones();
                        ban1=0;
                        wfs.removeAllFeatures();
                        wfs.visibility=false;
                        wfs.removeMap();
                        wfs_cdpol.removeAllFeatures();
                        wfs_cdpol.visibility=false;
                        wfs_cdpol.removeMap();
                        cierramz.destroy();
                        savemz.destroy();
                        butagmz.destroy();
                        butagmzpre.destroy();
                        cdsimplify.destroy();
                        delmz_cdpol.destroy();
                        modimz2_cdpol.destroy();
                        modimz2_cdpol.destroy();
                        modimz1_cdpol.destroy();
                        draw_cdpol.destroy();
                        drawmzcasos.destroy();
                        drawmzcasosJ.destroy();
                        delmz.destroy();
                        modimz2.destroy();
                        drawmz.destroy();
                        panel6.destroy();
                        panel6=undefined;
                        editarcd.deactivate();
                        //wfsmov=[];
                        //document.getElementById('framecapas').src = document.getElementById('framecapas').src;
                               for (var i = map.popups.length - 1; i >= 0; i--) {
                                  map.removePopup(map.popups[i]);
                        }
                        activar_rueda_raton();
                        edita_off('cd');
                    }
                },
                title: 'Cerrar editor'
            });

  
  butagmz = new OpenLayers.Control.DrawFeature(
            pointLayeralt,
            OpenLayers.Handler.Point,
            {eventListeners: {
                featureadded: function(e) {
                    if (brincacd==0){
                        var ll = e.feature.geometry.transform(new OpenLayers.Projection('EPSG:900913'), new OpenLayers.Projection('EPSG:4326'));
                        var capa=0;
                        if (mza_acu.getVisibility()==true || mza_mod.getVisibility()==true){
                            capa=1;
                        }else{
                            alertmsg ("No tiene capa visible");
                            return false;
                        }
                        ventanaobtcd = window.open('obtmza_cd.jsp?capa='+capa+'&x='+ll.x+'&y='+ll.y,'AgregarMz','toolbar=no,Resizable=1,scrollbars=1');
                        ventanaobtcd.focus();
                    }else{
                        brincacd=0;
                    }
                    }
                },
            displayClass: "olControlAgmz",
            title: "Agregar Caserio desde MCC"
            }
        );



butagmzpre = new OpenLayers.Control.DrawFeature(
            pointLayeralt,
            OpenLayers.Handler.Point,
            {eventListeners: {
                featureadded: function(e) {
                        var ll = e.feature.geometry.transform(new OpenLayers.Projection('EPSG:900913'), new OpenLayers.Projection('EPSG:4326'));
                        var capa=0;
                        cve_pe_temp="";
                        cve_pe_tipo=0;
                        //if (predig.getVisibility()==true){
                        //    capa=1;
                        //}else{
                        //    alertmsg ("Capa de predigitalizacion debe estar activa");
                        //    return false;
                        //}
                                var ajax=nuevoAjax();
                                ajax.open("GET",'obtgeo_pem.jsp?x='+ll.x+'&y='+ll.y+'&ent='+filtroid, true);
                                ajax.onreadystatechange=function()
                                {
                                    if(ajax.readyState==4)  {
                                        var val=ajax.responseText.trim();
                                        if (val=='1'){
                                            alertmsg ("No se pudo extraer el poligono");
                                        }else{
                                            //console.log(val);
                                            var pe_tipo=val.substring(0,1);
                                            var pe_ent=val.substring(1,3);
                                            var pe_mun=val.substring(3,6);
                                            var pe_loc=val.substring(6,10);
                                            val=val.substring(10,val.length);
                                            var geompol = OpenLayers.Geometry.fromWKT(val);
                                            cve_pe_temp=pe_ent+pe_mun+pe_loc;
                                            cve_pe_tipo=pe_tipo;      //1=CUR, 2=PRE
                                            if (parseInt(pe_loc)>=9000 || cve_pe_tipo==2){ // es 9000 se trabaja como nueva
                                                    wfs_cdpol.addFeatures([new OpenLayers.Feature.Vector(geompol)]);
                                                    var n=wfs_cdpol.features.length-1;
                                                    wfs_cdpol.features[n].state=OpenLayers.State.INSERT;
                                                    feature = wfs_cdpol.getFeatureBy('fid', wfs_cdpol.features[n].fid);
                                                     onFeatureSelectCdpol(feature);

                                            }else{   // no es 9000 reemplaza poligono
                                                   alertmsg ("No es clave 9000");
                                                   return false;
                                            }
                                        }
                                    }
                                }
                                ajax.send(null);
                    }
                },
            displayClass: "olControlmzcasosChgForm",
            title: "Agregar poligono externo urbano desde CUR/PREDIG"
            }
        );



        panel6 = new OpenLayers.Control.Panel({displayClass: 'panel6Toolbar'});
        //panel6.addControls([cierramz,savemz,butagmz,delmz_cdpol,modimz2_cdpol,modimz2_cdpol,modimz1_cdpol,draw_cdpol,drawmzcasosJ,drawmzcasos,delmz,modimz2,drawmz]);
        panel6.addControls([cierramz,savemz,cdsimplify,butagmzpre,butagmz,delmz_cdpol,modimz2_cdpol,modimz1_cdpol,
            draw_cdpol,drawmzcasos,delmz,modimz2,drawmz]);
        //panel6.addControls([cierramz,savemz,delmz_cdpol,modimz2_cdpol,modimz2_cdpol,modimz1_cdpol,draw_cdpol,drawmzcasosJ,drawmzcasos,modimz2]);

        map.addControl(panel6);
        editarcd.activate();
        //drawmz.activate();

        delmz.events.register('activate',null,valCtrleditcd);
        modimz2.events.register('activate',null,valCtrleditcd);
        drawmz.events.register('activate',null,valCtrleditcd);
        drawmzcasos.events.register('activate',null,valCtrleditcd);
        //drawmzcasosJ.events.register('activate',null,valCtrleditcd);
        draw_cdpol.events.register('activate',null,valCtrleditcd);
        modimz1_cdpol.events.register('activate',null,valCtrleditcd);
        modimz2_cdpol.events.register('activate',null,valCtrleditcd);
        delmz_cdpol.events.register('activate',null,valCtrleditcd);
        butagmzpre.events.register('activate',null,valCtrleditcd);
        butagmz.events.register('activate',null,valCtrleditcd);
        cdsimplify.events.register('activate',null,valCtrleditcd);

        idxpasa=0;
        //document.getElementById('framecapas').src = document.getElementById('framecapas').src;
}else{ //escala
    alertmsg ("La escala debe ser < a 10,000 para editar");
    edita_off('cd');
}
}


// FUNCION VIENE DE EDICION DE MANZANAS
function valCtrleditcd(event){
    desactivar_botones();
    //mensaje de cuando es codigo J
    if (event.object.title=="Cambio de ambito (Desde ageb nuevo)"){
        ventana = window.open('vercodigoJ.jsp?capa=1','AgregarJ','toolbar=no,Resizable=1,scrollbars=1');
    }else if (event.object.title=="Cambio de ambito (Multiples Caserios)"){
        ventana = window.open('vercodigoJ.jsp?capa=2','AgregarJ','toolbar=no,Resizable=1,scrollbars=1');
    }
    //console.log (wfs_cdpol);
    //console.log (wfs);
        if (idxpasa==0){
            if (wfs.getZIndex()>wfs_cdpol.getZIndex()){
                 idxcdmax=wfs.getZIndex();
                 idxcdmin=wfs_cdpol.getZIndex();
            }else{
                 idxcdmax=wfs_cdpol.getZIndex();
                 idxcdmin=wfs.getZIndex();
            }
            idxpasa=1;
        }
    if (delmz.active==true || modimz2.active==true || 
        //drawmz.active==true ||  <<---- el de agregar no lo pongo porque genera un cuadro
        drawmzcasos.active==true || drawmzcasosJ.active==true){
         //console.log(maxzindex_vector());
            wfs_cdpol.setZIndex(idxcdmin);
            wfs.setZIndex(idxcdmax);

     }else if(modimz1_cdpol.active==true || modimz2_cdpol.active==true || 
        //draw_cdpol.active==true  ||  <<---- el de agregar no lo pongo porque no es necesaroio.
         delmz_cdpol.active==true){
            wfs_cdpol.setZIndex(idxcdmax);
            wfs.setZIndex(idxcdmin);
     }
     //console.log("wfs:"+wfs.getZIndex());
     //console.log("wfs_cdpol:"+wfs_cdpol.getZIndex());
}






//// FUNCION EDICION DE LOCALIDADES  ****************************************************************************************************************
function trbuteditar(){
var geographic = new OpenLayers.Projection("EPSG:4326");
var mercator = new OpenLayers.Projection("EPSG:900913");
var escala=map.getScale();   //si es menor a 30000 entra a la edicion
if (escala < 20000){
if (ban1==0){
    ban1=1;
}else{
    alertmsg ("Ya tiene activada la herramienta de edicion");
    return false;
}
//nav.clear();
desactivar_rueda_raton();
desactivar_botones();
var saveStrategy = new OpenLayers.Strategy.Save();
    saveStrategy.events.register('success', null, saveSuccessLoc);
    saveStrategy.events.register('fail', wfs, saveFailLoc);
      // capa WFS-T servida por GeoServer
    if (nivel==1){
        var filtroed=  new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.EQUAL_TO,property: "cve_ent",value: filtroid});
    }else{
        var filtroed=  new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "cve_ent",value: '00'});
    }

    if (ediloc==1){      //'VIGENTE'
     //alertmsg ("Se cargaron solo los puntos de las Vigentes" );
    wfs =   new OpenLayers.Layer.Vector("MODIFICAR",{
                strategies: [new OpenLayers.Strategy.BBOX(), saveStrategy],protocol: new OpenLayers.Protocol.WFS({
                srsName: "EPSG:4326", url:  "http://"+hostnew+"/geoserver/INEGI/wfs",
                featureType: "shp_locr_coord",featureNS: "http://"+hostnew+"/geoserver"}),
                projection: geographic, styleMap: styles
                ,filter: new OpenLayers.Filter.Logical({        //aplico filtro de solo status=1
                        type: OpenLayers.Filter.Logical.AND,
                        filters: [
                            new OpenLayers.Filter.Comparison({
                                    type: OpenLayers.Filter.Comparison.EQUAL_TO,
                                    property: "status",
                                    value: "1"})
                            ,filtroed
                    ]})
            });
           wfs.displayInLayerSwitcher= false;wfs.isBaseLayer=false;map.addLayers ([wfs]);
    }else{   //ediloc=0
//    alertmsg ("Se cargaron solo los puntos de las Bajas" );
    wfs =   new OpenLayers.Layer.Vector("MODIFICAR",{
                strategies: [new OpenLayers.Strategy.BBOX(), saveStrategy],protocol: new OpenLayers.Protocol.WFS({
                srsName: "EPSG:4326", url:  "http://"+hostnew+"/geoserver/INEGI/wfs",
                featureType: "shp_locr_coord",featureNS: "http://"+hostnew+"/geoserver"}),
                projection: geographic, styleMap: styles
                ,filter: new OpenLayers.Filter.Logical({        //aplico filtro de solo status=1
                        type: OpenLayers.Filter.Logical.AND,
                        filters: [
                            new OpenLayers.Filter.Comparison({
                                    type: OpenLayers.Filter.Comparison.EQUAL_TO,
                                    property: "status",
                                    value: "0"})
                            ,filtroed
                    ]})
            });
           wfs.displayInLayerSwitcher= false;wfs.isBaseLayer=false;map.addLayers ([wfs]);
    }
         wfs.events.on({
              featureselected:onFeatureSelectLoc,
              featureunselected:onFeatureUnSelectLoc
        });
        modify = new OpenLayers.Control.ModifyFeature(
                wfs, {displayClass: "olControlModifyFeature", title: "Mover Localidad"}
            );

        modify2 = new OpenLayers.Control.ModifyFeature(
                wfs, {displayClass: "olControlModifylimFeature", title: "Mover Localidad al limite"}
            );

        valida = new OpenLayers.Control.SelectFeature(
                wfs, {
                    displayClass: "olControlVal",
                    title: "Validar Localidad"
                    //,box:true
                }
            );
        pendiente = new OpenLayers.Control.SelectFeature(
                wfs, {
                    displayClass: "olControlPen",
                    title: "Localidad pendiente"
                    //,box:true
                }
            );
        save = new OpenLayers.Control.Button({
                title: "Salvar Cambios",
                trigger: function() {
                    if(modify.feature) {
                        modify.selectControl.unselectAll();
                    }
                    if(modify2.feature) {
                        modify2.selectControl.unselectAll();
                    }
                    valida.unselectAll();
                    pendiente.unselectAll();
                    saveStrategy.save();
                    //wfsmov=[];
                },
                displayClass: "olControlSaveFeatures"
            });

        refr = new OpenLayers.Control.Button({
                title: "Regresa el ultimo movimiento no guardado",
                trigger: function() {
                    if (wfsmov.length>0){
                        if(modify.feature) {
                            modify.selectControl.unselectAll();
                        }
                        if(modify2.feature) {
                            modify2.selectControl.unselectAll();
                        }
                        valida.unselectAll();
                        pendiente.unselectAll();
                        var ult=wfsmov.length-1;
                        var feature = wfs.getFeatureBy('id', wfsmov[ult]);
                        wfs.eraseFeatures(feature);
                        feature.state=null;
                        feature.attributes.ban = feature.data.ban;
                        feature.attributes.ok = feature.data.ok;
                        if (feature.modified!=null){
                            feature.geometry=feature.modified.geometry;
                            feature.modified=null
                        }
                        wfsmov.splice(ult, 1);
                        wfs.drawFeature(feature);
                        alertmsg("Ultimo movimiento regresado");
                    }
                },
                displayClass: "olControlRecargar"
            });



        editman = new OpenLayers.Control.Button ({
                displayClass: 'olControlEditManual',
                trigger: function (){
                        ventana = window.open('editman.jsp?pass='+pass+'&ent='+filtroid,'Editar','toolbar=no,Resizable=1,scrollbars=1');
                        ventana.focus();
                },
                title: 'Cambio manual'
            });


        cierra = new OpenLayers.Control.Button ({
                displayClass: 'olControlClose',
                trigger: function() {
                    if (cierraban==0){
                        //if (confirm("Desea cerrar la edicion??")){
                            cierraban=1;
                        //}
                    }
                    if (cierraban==1){
                        cierraban=0;
                        desactivar_botones();
                        ban1=0;
                        wfs.removeAllFeatures();
                        wfs.visibility=false;
                        wfs.removeMap();
                        cierra.destroy();
                        //refr.destroy();
                        save.destroy();
                        pendiente.destroy();
                        editman.destroy();
                        modify2.destroy();
                        modify.destroy();
                        valida.destroy();
                        panel2.destroy();
                        panle2=undefined;
                        editar.deactivate();
                        //wfsmov=[];
                        activar_rueda_raton();
                        if (ediloc==1){
                            edita_off('lv');
                        }else{
                            edita_off('lb');
                        }
                    }
                },
                title: 'Cerrar editor'
            });
        panel2 = new OpenLayers.Control.Panel({displayClass: 'panel2Toolbar'});
        //panel2.addControls([valida,modify,modify2,editman,pendiente,save,cierra]);
        panel2.addControls([cierra,save,pendiente,editman,modify2,modify,valida]);
        map.addControl(panel2);
        editar.activate();
        //modify.activate();

        valida.events.register('activate',null,valCtrledit);
        modify.events.register('activate',null,valCtrledit);
        modify2.events.register('activate',null,valCtrledit);
        pendiente.events.register('activate',null,valCtrledit);
}else{
    alertmsg ("La escala debe ser < a 20,000 para editar");
    if (ediloc==1){
        edita_off('lv');
    }else{
        edita_off('lb');
    }

}
}

// FUNCION VIENE DE EDICION DE LOCALIDADES
function valCtrledit(event){
            valida.unselectAll();
            pendiente.unselectAll();
            desactivar_botones();
}


// FUNCION QUE ABRE MAPA DIGITAL ****************************************************************************************************************
function trbutmp(){
//var co = map.getExtent();
var co = map.getExtent().transform(new OpenLayers.Projection('EPSG:900913'),new OpenLayers.Projection('EPSG:4326'));   //CONVERTIR A 4326
co = co.toString();
var coord = co.split(",");
//ventana = window.open('md.jsp?c1='+coord[0]+'&c2='+coord[1]+'&c3='+coord[2]+'&c4='+coord[3],'MD','scrollbars=yes,toolbar=yes,resizable=yes');  //ccl
ventana = window.open('http://gaia.inegi.org.mx/mdm6/?coordinates=['+coord[0]+','+coord[1]+','+coord[2]+','+coord[3]+']&layers=c100,c101,c102,c790,c794,t790,t794','MD','scrollbars=yes,toolbar=yes,resizable=yes');
ventana.focus();
}

//FUCION QUE ABRE GOOGLE EARTH ****************************************************************************************************************
function trbutge(){
    var width   = map.getSize().w;
    var height  = map.getSize().h;
    ventana = window.open('google1.jsp?w='+width+'&h='+height,'Google','toolbar=no,Resizable=1,scrollbars=1');
    ventana.focus();
}

//FUNCION QUE ABRE EL PDF ****************************************************************************************************************
function printMappdf() {
    var width   = map.getSize().w;
    var height  = map.getSize().h;
    ventana = window.open('imprime.jsp?imp=PDF&w='+width+'&h='+height,'Descargar','toolbar=no,Resizable=1,scrollbars=1');
    ventana.focus();
  }


//FUNCION ventana de errores ****************************************************************************************************************
function ventanaErroropen() {
    var width   = map.getSize().w;
    var height  = map.getSize().h;
    ventana = window.open('lista_error.jsp?ent='+filterid+'&ni='+(nivelcapa+10),'Errores','toolbar=no,Resizable=1,scrollbars=1');
    ventana.focus();
  }
  
function ventanaTempopen() {
    var width   = map.getSize().w;
    var height  = map.getSize().h;
    //ventana = window.open('temp_definitiva_cu.jsp?ent='+filterid+'&ni='+(nivelcapa+10),'TempDef','toolbar=no,Resizable=1,scrollbars=1');
    ventana = window.open('temp_definitiva.jsp?ent='+filterid+'&ni='+(nivelcapa+10),'TempDef','toolbar=no,Resizable=1,scrollbars=1');
    ventana.focus();
  }

//FUNCION QUE ABRE EL JPG ****************************************************************************************************************
function printMapjpg() {
    var width   = map.getSize().w;
    var height  = map.getSize().h;
    ventana = window.open('imprime.jsp?imp=JPG&w='+width+'&h='+height,'Descargar','toolbar=no,Resizable=1,scrollbars=1');
    ventana.focus();
}

//FUNCION QUE ABRE EL PLANO ****************************************************************************************************************

function printMaplano() {
        ventana = window.open('planojpg2.jsp?lon='+map.center.lon+'&lat='+map.center.lat+'&bounds='+map.getExtent());
        ventana.focus();
  }

function printMaplanoact() {
        ventana = window.open('planojpg2act.jsp?lon='+map.center.lon+'&lat='+map.center.lat+'&bounds='+map.getExtent());
        ventana.focus();
  }


  // cat es la variable para ejecutar alguna funcion especial que traemos 
  if (cat=='EXCEL'){ /// viene de excel la coordenada a buscar
    document.busqueda.longitud.value=bc1;
    document.busqueda.latitud.value=bc2;
    estados.visibility=true;
    estadoset.visibility=true;
    capasel[1]=1;textsel[1]=1;
    municipios.visibility=true;
    municipioset.visibility=true;
    capasel[2]=1;textsel[2]=1;
    agebs.visibility=true;
    agebset.visibility=true;
    capasel[3]=1;textsel[3]=1;
    locrur1.visibility=true;
    locruret1.visibility=true;
        capasel[8]=1;textsel[8]=1;

    agebsur.visibility=true;
    agebsuret.visibility=true;
    capasel[4]=1;textsel[4]=1;
    locurb.visibility=true;
    locurbet.visibility=true;
    capasel[5]=1;textsel[5]=1;
    locrurpol.visibility=true;
    locrurpolet.visibility=true;
    capasel[6]=1;textsel[6]=1;
    mza.visibility=true;
    capasel[11]=1;textsel[11]=1;
    locrurpol_ext.visibility=true;
    capasel[7]=1;
    caserio.visibility=true;
    capasel[21]=1;
        locrur1.visibility=true;
        locruret1.visibility=true;
        capasel[8]=1;textsel[8]=1;
    ce_c1.visibility=true;puntosel_ce[0]=1;
    ce_c2.visibility=true;puntosel_ce[1]=1;
    ce_c3.visibility=true;puntosel_ce[2]=1;
    ce_c4.visibility=true;puntosel_ce[3]=1;
    setTimeout(function(){ 
        enviar();
        document.getElementById('framecapas').src = document.getElementById('framecapas').src;
     }, 500);
}
  if (cat=='X'){   //VIENE DEL SAP
      //alert (st1+","+capa1+","+bc1+","+bc2+","+bc3+","+bc4);
      buscazoom(st1,capa1,bc1,bc2,bc3,bc4);
  }
  if (cat=='Y'){   //CAMBIO DE REGIONAL
      capasel=selcapa.split(",");
      textsel=seltext.split(",");
      puntosel_ce=selpuntos_ce.split(",");
      //            1               2       3               4           5           6           7           8               9           10          11       12     13      14      15      16        17 18 19 20 21        22          23     24            25          26          27          28          29          30        31     32  33 34     35                36      37            38          39               40   41                42          43           44             45
      var arrayc = ["cartas"  ,"estados", "municipios"   ,"agebs"  ,"agebsur",  "locurb",   "locrurpol","locrurpol_ext","locrur1",   "locrur0",  "asen",  "mza","mza_gen","servs","vialine","bd_loc","","","","","mza_acu","caserio","predig","mza_bcuu","cartas20","agebu_gen","polr_gen","caserio_gen","locrurmov1","locrurmov0","","ca_ni","","","locrurpol_ext_gen","anota","mza_mod","viviendas",     "cat_frentes",      "rnc","vw_carga_tcar","ni_gen","crecimientos","mza_mod_locrur","predios_ne"];
      var arrayt = ["cartaset","estadoset","municipioset","agebset","agebsuret","locurbet","locrurpolet","",            "locruret1","locruret0","asenet","mzaet","",         "",      "vial",     "","","","","",""       ,       "",       "",     "",    "cartaset20",     "",        "",           "",          "",""          ,"",     "","","",       "",               "",    "",           "",       "",              "",""             ,""      ,"",       "",               ""];
      var arrayp = ["ce_c1","ce_c2","ce_c3","ce_c4"];
      //console.log(seltext);
        for (i=0;i<capasel.length;i++){
            //if (capasel[i]==1){
                if (arrayc[i]!='' && arrayc[i]!=undefined){
                    eval (arrayc[i]+'.setVisibility('+capasel[i]+');');
                }
            //}
            //if (textsel[i]==1){
                if (arrayt[i]!='' && arrayt[i]!=undefined){
                    eval (arrayt[i]+'.setVisibility('+textsel[i]+');');
                }
            //}
        }
     for (i=0;i<puntosel_ce.length;i++){
                if (arrayp[i]!='' && arrayp[i]!=undefined){
                    eval (arrayp[i]+'.setVisibility('+puntosel_ce[i]+');');
                }
        }

      buscazoom(st1,capa1,bc1,bc2,bc3,bc4);
      document.getElementById('framecapas').src = document.getElementById('framecapas').src;
  }
document.getElementById('textomsg').innerHTML = '<a class=liga1 href="mailto:neatil.ceballos@inegi.org.mx?subject=MAPA" title="Dudas e informacion (neatil.ceballos)">2025EIC.a</a>';

/////////aqui empieza con la PREDIGITALIZACION///////////////////////////////////////////////

/*
 but_repdig_agrega = new OpenLayers.Control.DrawFeature(
            pointLayeralt,
            OpenLayers.Handler.Point,
            {eventListeners: {
                featureadded: function(e) {
                    var escala=map.getScale();   //si es mayor a 30000 sale de la edicion
                        if (escala < 30000){
                            var ll = e.feature.geometry.transform(new OpenLayers.Projection('EPSG:900913'), new OpenLayers.Projection('EPSG:32800'));
                            var ajax=nuevoAjax();
                            ajax.open("GET",'reg_repdig.jsp?us='+iduser+'&id='+filterid+'&x='+ll.x+'&y='+ll.y, true);
                            ajax.onreadystatechange=function()
                            {
                                if(ajax.readyState==4)  {
                                     var val=String(ajax.responseText).trim();
                                    if (val=='x'){
                                        alertmsg ("No se pudo registrar en reporte");
                                    }else{
                                        var tipo=val.substring(0,1);
                                        var vale=val.substring(1,10);
                                        if (tipo=='1'){
                                            alertmsg (vale+' agregada al reporte');
                                        }else if (tipo=='S'){
                                            alertmsg (vale+' esta validada');
                                        }else if (tipo=='N'){
                                            alertmsg (vale+' reporte de error');
                                        }else if (tipo=='0'){
                                            alertmsg (vale+' eliminada del reporte');
                                        }else if (tipo=='A'){
                                            alertmsg (vale+' validada');
                                        }else if (tipo=='B'){
                                            alertmsg (vale+' reporte de error');
                                        }else if (tipo=='C'){
                                            alertmsg (vale+' sin validar');
                                        }else if (tipo=='D'){
                                            alertmsg (vale+' no esta en el reporte');
                                        }
                                        cartas5rep.redraw(true);
                                    }
                                }
                            }
                            ajax.send(null);
                        }else{
                             alertmsg ("La escala debe ser < a 30,000 para agregar al reporte");
                        }
                    }
                },
            displayClass: "olControlButdiga",
            title: "Agregar/Quitar carta 5 a reporte"
            }
        );
*/

///lo reemplazo para agregar por municipio
but_repdig_agrega = new OpenLayers.Control.DrawFeature(
            pointLayeralt,
            OpenLayers.Handler.Point,
            {eventListeners: {
                featureadded: function(e) {
                    var escala=map.getScale();   //si es mayor a 30000 sale de la edicion
                        if (escala < 1000000){
                            var ll = e.feature.geometry.transform(new OpenLayers.Projection('EPSG:900913'), new OpenLayers.Projection('EPSG:32800'));
                            var ajax=nuevoAjax();
                            ajax.open("GET",'reg_repmun.jsp?us='+iduser+'&id='+filterid+'&x='+ll.x+'&y='+ll.y, true);
                            ajax.onreadystatechange=function()
                            {
                                if(ajax.readyState==4)  {
                                     var val=String(ajax.responseText).trim();
                                    if (val=='x'){
                                        alertmsg ("No se pudo registrar en reporte");
                                    }else{
                                        var tipo=val.substring(0,1);
                                        var vale=val.substring(1,7);
                                        if (tipo=='1'){
                                            alertmsg ('Municipio '+vale+' bloqueado');
                                        }else{
                                            alertmsg ('Municipio '+vale+' desbloqueado');
                                        }
                                        cartas5rep.redraw(true);
                                    }
                                }
                            }
                            ajax.send(null);
                        }else{
                             alertmsg ("La escala debe ser < a 1,000,000 para agregar al reporte");
                        }
                    }
                },
            //displayClass: "olControlButdiga",
            title: "Agregar/Quitar bloqueo de municipios"
            }
        );


but_repdig_agrega.events.register('activate',null,valCtrl);


var ver_repdig=0;
var ver_inv=0;
 ver_but_repdig_agrega  = new OpenLayers.Control.Button ({displayClass: 'olControlButdiga', trigger: function (){
                            if (ver_repdig==0){
                                ver_repdig=1;
                                but_repdig_agrega.activate();
                                ver_but_repdig_agrega.activate();
                            }else{
                                ver_repdig=0;
                                but_repdig_agrega.deactivate();
                                ver_but_repdig_agrega.deactivate();
                            }
                        }, title: 'Agregar/Quitar bloqueo de municipios-2'});
 /*ver_inv_punto  = new OpenLayers.Control.Button ({displayClass: 'olControlInv_punto', trigger: function (){
                            if (ver_inv==0){
                                ver_inv=1;
                                inv_punto.activate();
                                ver_inv_punto.activate();
                            }else{
                                ver_inv=0;
                                inv_punto.deactivate();
                                ver_inv_punto.deactivate();
                            }
                        }, title: 'Conteo de viviendas por imagen MZ/LOC-2'});
 */
 but_repdig_lista  = new OpenLayers.Control.Button ({displayClass: 'olControlButdigq', trigger: function (){replistar();}, title: 'Ver listado de reporte'});

avdig=0;
veravancepredig = new OpenLayers.Control.Button({displayClass: 'olControlButAvDig', trigger: function (){
        if (avdig==0){
            veravancepredig.activate();
            avdig=1;
            //cartas5.setVisibility(true);
            cartas5rep.setVisibility(true);
        }else{
            veravancepredig.deactivate();
            avdig=0;
            //cartas5.setVisibility(false);
            cartas5rep.setVisibility(false);
        }
        },title: 'Ver avance (Escala menor a 1:1,000,000)'}
        );

avcobce=0;
avcobpob=0;
avcobpobcenso=0;
var filterParams;

// Obtén elementos del DOM
const tooltipce = document.getElementById('tooltipce');
const tooltippob = document.getElementById('tooltippob');


vercobpob = new OpenLayers.Control.Button({displayClass: 'olControlButcoberturapob', trigger: function (){
        if (avcobpob==0){
            vercobpob.activate();
            avcobpob=1;
            coberturapob.setVisibility(true);
            //tooltippob.style.display = 'block';
            //setTimeout(function(){ tooltippob.style.display = 'none'; }, 10000);
        }else{
            vercobpob.deactivate();
            avcobpob=0;
            coberturapob.setVisibility(false);
            //tooltippob.style.display = 'none';

        }
        },title: 'Cobertura E25'}
        );

/*vercobce = new OpenLayers.Control.Button({displayClass: 'olControlButcoberturace', trigger: function (){
        if (avcobce==0){
            vercobce.activate();
            avcobce=1;
            coberturace.setVisibility(true);
            tooltipce.style.display = 'block';
            setTimeout(function(){ tooltipce.style.display = 'none'; }, 10000);
        }else{
            vercobce.deactivate();
            avcobce=0;
            coberturace.setVisibility(false);
            tooltipce.style.display = 'none';

        }
        },title: 'Cobertura CE24'}
        );
*/


/*
// Cierra el tooltip si se hace clic en cualquier parte de la página
document.addEventListener('click', (event) => {
    if (event.target !== tooltipce) {
        tooltipce.style.display = 'none';
    }
});
*/

/*
vercobpobcenso = new OpenLayers.Control.Button({displayClass: 'olControlButcoberturapobcenso', trigger: function (){
        if (avcobpobcenso==0){
            vercobpobcenso.activate();
            avcobpobcenso=1;
            censo.setVisibility(true);
            //ventana = window.open('images/censo_reco.jpg','censorec','location=0,menubar,toolbar=no,Resizable=0,scrollbars=0,width=250, height=400');
        ventana.focus();
        }else{
            vercobpobcenso.deactivate();
            avcobpobcenso=0;
            censo.setVisibility(false);
        }
        //},title: 'Ver seguimiento Censo'}
    },title: 'Ver puntos GPS ajustados-Censo'}
        );
*/



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


ventanaerror = new OpenLayers.Control.Button ({displayClass: 'olControlVentanaError', trigger: ventanaErroropen, title: 'Ver errores de Validaciones'});
ventanatemp = new OpenLayers.Control.Button ({displayClass: 'olControlVentanaTemp', trigger: ventanaTempopen, title: 'Ver tabla de provisionales a definitivas'});


panelDig = new OpenLayers.Control.Panel({displayClass: 'panelDigToolbar'});
    tempbar1 = new OpenLayers.Control.Button ();
    tempbar2 = new OpenLayers.Control.Button ();
    tempbar3 = new OpenLayers.Control.Button ();
    tempbar4 = new OpenLayers.Control.Button ();
    tempbar5 = new OpenLayers.Control.Button ();
    tempbar6 = new OpenLayers.Control.Button ();
    tempbar10 = new OpenLayers.Control.Button ();
    tempbar11 = new OpenLayers.Control.Button ();
    tempbar12  = new OpenLayers.Control.Button ();
    tempbar7 = new OpenLayers.Control.Button ({displayClass: 'olControldeshabilitado', title: 'Deshabilitado'});
    tempbar8 = new OpenLayers.Control.Button ({displayClass: 'olControldeshabilitado', title: 'Deshabilitado'});
    tempbar9 = new OpenLayers.Control.Button ({displayClass: 'olControldeshabilitado', title: 'Deshabilitado'});

if (nivel!=5){
        //if (nivel==3 && edicionpre==1 && edicionmz==1 && (iduser==44 || iduser==60 || iduser==234 || iduser==496 || iduser==480 || iduser==481 || iduser==892)){
        if ((iduser==44 || iduser==60 || iduser==234 || iduser==1705 || iduser==496 || iduser==480 || iduser==481 || iduser==892 ||  iduser==746)){
            panelDig.addControls([but_repdig_agrega]);
        }else{
            panelDig.addControls([tempbar1]);
        }
        panelDig.addControls([tempbar4]);

        //if (nivel==3){panelDig.addControls([inv_punto]);}else{panelDig.addControls([tempbar2]);}
        //panelDig.addControls([inv_punto]);
        //panelDig.addControls([verdenue]);
        //panelDig.addControls([tempbar2]);
        //panelDig.addControls([tempbar4]);
        //panelDig.addControls([porpoligono,vercobpobcenso,ventanatemp,ventanaerror,veravancepredig]);

        //panelDig.addControls([vercobce]);
        panelDig.addControls([tempbar6]);
        panelDig.addControls([tempbar10]);

        panelDig.addControls([porpoligono]);   //no procede de la CUR -> MG
        //panelDig.addControls([tempbar5]);

        //panelDig.addControls([ventanatemp]);

        //aqui quite ventanatemp
        panelDig.addControls([ventanaerror,veravancepredig]);

        //if (nivel==3 && edicionpre==1 && edicionmz==1 && (iduser==44 || iduser==60 || iduser==234 || iduser==1705 || iduser==496 || iduser==480 || iduser==481 || iduser==892)){
        if ((iduser==44 || iduser==60 || iduser==234 || iduser==1705 || iduser==496 || iduser==480 || iduser==481 || iduser==892 ||  iduser==746)){
            panelDig.addControls([ver_but_repdig_agrega]);
        }else{
            panelDig.addControls([tempbar7]);
        }

        //if (nivel==3){panelDig.addControls([ver_inv_punto]);}else{panelDig.addControls([tempbar8]);}
        //panelDig.addControls([ver_inv_punto]);
        panelDig.addControls([verqr]);

        if (edicionpre==1){panelDig.addControls([editardigM]);}else{panelDig.addControls([tempbar9]);}

        //panelDig.addControls([editar_tef]);

        map.addControl(panelDig);
}else{ //observador
        panelDig.addControls([tempbar1]);
        panelDig.addControls([tempbar2]);
        panelDig.addControls([tempbar3]);
        panelDig.addControls([tempbar4]);
        panelDig.addControls([tempbar5]);
        panelDig.addControls([tempbar6]);
        panelDig.addControls([tempbar10]);
        panelDig.addControls([tempbar11]);
        //panelDig.addControls([vercobce]);
        panelDig.addControls([tempbar12]);
        panelDig.addControls([verqr]);
        map.addControl(panelDig);

}

function replistar(){
    ventana = window.open('rep_listar.jsp?&pass='+pass,'RepDig','toolbar=no,Resizable=1,scrollbars=1');
    ventana.focus();
}


function trbuttef(){
var geographic = new OpenLayers.Projection("EPSG:4326");
var mercator = new OpenLayers.Projection("EPSG:900913");
var ccl = new OpenLayers.Projection("EPSG:32800");
var escala=map.getScale();   //si es menor a 30000 entra a la edicion
if (escala < 10000){
if (ban1==0){
    ban1=1;
}else{
    alertmsg ("Ya tiene activada la herramienta de edicion");
    return false;
}
//nav.clear();
//desactivar_rueda_raton();
desactivar_botones();
var saveStrategy = new OpenLayers.Strategy.Save();
 
      // capa WFS-T servida por GeoServer
    if (nivel==1){
        var filtroed=  new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.EQUAL_TO,property: "cve_ent",value: filtroid});
    }else{
        var filtroed=  new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "cve_ent",value: 'XX'});
    }

var stylefm = new OpenLayers.StyleMap({
"default": new OpenLayers.Style(null, {
rules: [
    new OpenLayers.Rule({    //color de la edicion de manzanas
        symbolizer: {
           "Line": {   //color de edicion de los frentes y ejes
                        strokeOpacity: .7,
                        strokeWidth: 4,
                        strokeColor: "#FFD700",
                },
     }}),
    new OpenLayers.Rule({
        filter: new OpenLayers.Filter.Logical({
            type: OpenLayers.Filter.Logical.OR,
                filters: [
                    new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "clave_def", value: "0"})]}),
        symbolizer: {
            "Line": {strokeWidth: 3,strokeColor: "#0000FF",
           // label : "${cve_ft}",fontColor: "#0000FF",fontSize: 10,fontFamily: "Arial",fontWeight: "bold",labelAlign: "cm"
        }}}),
]}),
"select": new OpenLayers.Style({strokeColor: "#FF0000",strokeWidth: 4})});



          wfs =   new OpenLayers.Layer.Vector("MODIFICAR",{
                strategies: [new OpenLayers.Strategy.BBOX(), saveStrategy],protocol: new OpenLayers.Protocol.WFS({
                srsName: "EPSG:32800", url:  "http://"+hostnew+"/geoserver/INEGI"+idreggeo+"/wfs",
                featureType: 'te_fr',featureNS: "http://"+hostnew+"/INEGI"+idreggeo+""}),
                projection: ccl, styleMap: stylefm
                ,filter: filtroed
            });


           wfs.displayInLayerSwitcher= false;wfs.isBaseLayer=false;
           map.addLayers ([wfs]);
           wfs.events.on({featureselected:selregistrafr});

           selecciona = new OpenLayers.Control.SelectFeature(
                wfs, {
                    displayClass: "olControlVal",
                    title: "Seleccionar frente"
                    //,box:true
                }
            );

         cierra = new OpenLayers.Control.Button ({
                displayClass: 'olControlClose',
                trigger: function() {
                    if (cierraban==0){
                        //if (confirm("Desea cerrar la edicion??")){
                            cierraban=1;
                        //}
                    }
                    if (cierraban==1){
                        cierraban=0;
                        desactivar_botones();
                        ban1=0;
                        wfs.removeAllFeatures();
                        wfs.visibility=false;
                        wfs.removeMap();
                        selecciona.destroy();
                        relacionafr.destroy();
                        cierra.destroy();
                        panelDig2.destroy();
                        panelDig2=undefined;
                        activar_rueda_raton();
                    }
                },
                title: 'Cerrar editor'
            });


   relacionafr = new OpenLayers.Control.DrawFeature(
            pointLayeralt,
            OpenLayers.Handler.Point,
            {eventListeners: {
                featureadded: function(e) {
                            var ll = e.feature.geometry.transform(new OpenLayers.Projection('EPSG:900913'), new OpenLayers.Projection('EPSG:32800'));
                            var ajax=nuevoAjax();
                            var co = map.getExtent().transform(new OpenLayers.Projection('EPSG:900913'),new OpenLayers.Projection('EPSG:32800'));   //CONVERTIR A 4326
                            co = co.toString();
                            var coord = co.split(",");
                            ajax.open("GET",'reg_te_fr.jsp?c1='+coord[0]+'&c2='+coord[1]+'&c3='+coord[2]+'&c4='+coord[3]+'&gid='+gidfr.fid.replace('te_fr.','')+'&us='+iduser+'&id='+filterid+'&x='+ll.x+'&y='+ll.y, true);
                            ajax.onreadystatechange=function()
                            {
                                if(ajax.readyState==4)  {
                                     var val=String(ajax.responseText).trim();
                                    if (val=='x'){
                                        alertmsg ("No se pudo registrar el frente");
                                    }else{
                                        //var tipo=val.substring(0,1);
                                        //var vale=val.substring(1,7);
                                        alertmsg ('Relacionado al frente '+val);
                                    }
                                        selecciona.activate();
                                        relacionafr.deactivate();
                                        wfs.refresh({force: true});
                                        //wfs.redraw(true);
                                }
                            }
                            ajax.send(null);
                    }
                },
            displayClass: "olControlCoords",
            title: "Relacionar frente"
            }
        );




        panelDig2 = new OpenLayers.Control.Panel({displayClass: 'panelDig2Toolbar'});
        panelDig2.addControls([tempbar1,tempbar2,tempbar3,tempbar4,tempbar5,tempbar6,tempbar7,selecciona,relacionafr,cierra]);
        relacionafr.events.register('activate',null,valCtrlfre);
        selecciona.events.register('activate',null,valCtrlfre);
        map.addControl(panelDig2);
        selecciona.activate();
}else{
    alertmsg ("La escala debe ser < a 10,000 para digitalizar");
}
}


function selregistrafr(event){
    alertmsg ("Seleccione frente a relacionar");
    relacionafr.activate();
    selecciona.deactivate();
    gidfr=event.feature;
}



// FUNCION VIENE DE EDICION DE MANZANAS
function valCtrlfre(event){
    desactivar_botones();
}



function trbuteditardig(tipo){  //funcion para la pre digitalizacion
var geographic = new OpenLayers.Projection("EPSG:4326");
var mercator = new OpenLayers.Projection("EPSG:900913");
var ccl = new OpenLayers.Projection("EPSG:32800");
var escala=map.getScale();   //si es menor a 30000 entra a la edicion
if (escala < 20000){
if (ban1==0){
    ban1=1;
}else{
    alertmsg ("Ya tiene activada la herramienta de edicion");
    return false;
}
//nav.clear();
desactivar_rueda_raton();
desactivar_botones();
var saveStrategy = new OpenLayers.Strategy.Save();
    saveStrategy.events.register('success', null, function (){saveSuccessPredig(tipo);});
    saveStrategy.events.register('fail', null, function (){saveFailPredig(tipo);});
var saveStrategype = new OpenLayers.Strategy.Save();
    saveStrategype.events.register('success', null, function (){saveSuccessPredig(tipo);});
    saveStrategype.events.register('fail', null, function (){saveFailPredig(tipo);});
var saveStrategypunto = new OpenLayers.Strategy.Save();
    saveStrategypunto.events.register('success', null, function (){saveSuccessPredig(tipo);});
    saveStrategypunto.events.register('fail', null, function (){saveFailPredig(tipo);});

      // capa WFS-T servida por GeoServer
    if (nivel==1){
        var filtroed=  new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.EQUAL_TO,property: "cve_ent",value: filtroid});
    }else{
        var filtroed=  new OpenLayers.Filter.Comparison({type: OpenLayers.Filter.Comparison.NOT_EQUAL_TO,property: "cve_ent",value: 'XX'});
    }

          

          wfs =   new OpenLayers.Layer.Vector("MODIFICAR",{
                strategies: [new OpenLayers.Strategy.BBOX(), saveStrategy],protocol: new OpenLayers.Protocol.WFS({
                srsName: "EPSG:32800", url:  "http://"+hostnew+"/geoserver/INEGI"+idreggeo+"/wfs",
                featureType: 'z_digmz',featureNS: "http://"+hostnew+"/INEGI"+idreggeo+""}),
                projection: ccl, styleMap: stylespre
                ,filter: filtroed
            });


          wfs_punto =   new OpenLayers.Layer.Vector("MODIFICARpunto",{
                strategies: [new OpenLayers.Strategy.BBOX(), saveStrategypunto],protocol: new OpenLayers.Protocol.WFS({
                srsName: "EPSG:32800", url:  "http://"+hostnew+"/geoserver/INEGI"+idreggeo+"/wfs",
                featureType: "z_digmp",featureNS: "http://"+hostnew+"/INEGI"+idreggeo+""}),
                projection: ccl, styleMap: stylespre
                ,filter: filtroed
            });
          wfs_pe =   new OpenLayers.Layer.Vector("MODIFICARpe",{
                strategies: [new OpenLayers.Strategy.BBOX(), saveStrategype],protocol: new OpenLayers.Protocol.WFS({
                srsName: "EPSG:32800", url:  "http://"+hostnew+"/geoserver/INEGI"+idreggeo+"/wfs",
                featureType: "z_digpe",featureNS: "http://"+hostnew+"/INEGI"+idreggeo+""}),
                projection: ccl, styleMap: stylespre
                ,filter: filtroed
            });
           wfs_pe.displayInLayerSwitcher= false;wfs_pe.isBaseLayer=false;
           wfs_punto.displayInLayerSwitcher= false;wfs_punto.isBaseLayer=false;
           wfs.displayInLayerSwitcher= false;wfs.isBaseLayer=false;
           map.addLayers ([wfs_pe,wfs_punto,wfs]);

            wfs.events.on({featureselected:selregistra});
            wfs_pe.events.on({featureselected:selregistra_pe});

           ///BOTONES MANZANA

            draw = new OpenLayers.Control.DrawFeature(wfs, OpenLayers.Handler.Polygon, {title: "Agregar Manzana", displayClass: "olControlDrawFeaturePolygon" , multi: true});
            draw.events.register('featureadded', draw, drawdigregistra);
            modify = new OpenLayers.Control.ModifyFeature(wfs, {displayClass: "olControlModifymzFeature",title: "Modificar Manzana",enforceTopology: true});
            modify2 = new OpenLayers.Control.ModifyFeature(wfs, {displayClass: "olControlModify2Feature", title: "Mover, rotar, tama\xF1o Manzana"});
            modify2.mode  = OpenLayers.Control.ModifyFeature.DRAG | OpenLayers.Control.ModifyFeature.ROTATE | OpenLayers.Control.ModifyFeature.RESIZE ;
            del = new DeleteFeatureDig(wfs, {title: "Borrar Manzana"});
            fusmz = new OpenLayers.Control.Button ({displayClass: 'olControlMerge', trigger: fusionapre, title: 'Fusiona Manzana'});
            submz = new OpenLayers.Control.DrawFeature(wfs, OpenLayers.Handler.Path, {title: "Subdivide Manzana", displayClass: "olControlSplit" , multi: false,callbacks : {"done": function (e){subdividepre(e);}}});
            var bajamz = new OpenLayers.Control.DrawFeature(pointLayeralt,OpenLayers.Handler.Point,{eventListeners: {
                featureadded: function(e) {
                        var ll = e.feature.geometry.transform(new OpenLayers.Projection('EPSG:900913'), new OpenLayers.Projection('EPSG:32800'));
                        var ajax=nuevoAjax();
                        ajax.open("GET",'obtgeo_mz_baja.jsp?x='+ll.x+'&y='+ll.y+'&ent='+filtroid, true);
                        ajax.onreadystatechange=function()
                        {
                            if(ajax.readyState==4)  {
                                var val=ajax.responseText.trim();
                                if (val=='1'){
                                    alertmsg ("No se pudo extraer la manzana");
                                }else{
                                    //console.log(val);
                                    var mz=val.substring(0,16);
                                    val=val.substring(16,val.length);
                                    var geompol = OpenLayers.Geometry.fromWKT(val);
                                    wfs.addFeatures([new OpenLayers.Feature.Vector(geompol)]);
                                    var n=wfs.features.length-1;
                                    wfs.features[n].state=OpenLayers.State.INSERT;
                                    wfs.features[n].attributes.cve_ent=filtroid;
                                    wfs.features[n].attributes.us=iduser;
                                    wfs.features[n].attributes.img=baseimg;
                                    wfs.features[n].attributes.baja=1;
                                    wfs.features[n].attributes.cve_baja=mz;
                                    feature = wfs.getFeatureBy('fid', wfs.features[n].fid);
                                    feature.attributes.cve_ent=filtroid;
                                    feature.attributes.us=iduser;
                                    feature.attributes.img=baseimg;
                                    feature.attributes.cod  = 3;
                                    alertmsg('1 Manzana agregada');
                                }
                            }
                        }
                        ajax.send(null);
                    }
                },displayClass: "olControlBajaMz",title: "Posible baja de manzana"
            });

          var obtmz = new OpenLayers.Control.DrawFeature(pointLayeralt,OpenLayers.Handler.Point,{eventListeners: {
                        featureadded: function(e) {
                                var ll = e.feature.geometry.transform(new OpenLayers.Projection('EPSG:900913'), new OpenLayers.Projection('EPSG:32800'));
                                var ajax=nuevoAjax();
                                ajax.open("GET",'obtgeo_mz.jsp?x='+ll.x+'&y='+ll.y+'&ent='+filtroid, true);
                                ajax.onreadystatechange=function()
                                {
                                    if(ajax.readyState==4)  {
                                        var val=ajax.responseText.trim();
                                        if (val=='1'){
                                            alertmsg ("No se pudo extraer la manzana");
                                        }else{
                                            //console.log(val);
                                            var geompol = OpenLayers.Geometry.fromWKT(val);
                                            wfs.addFeatures([new OpenLayers.Feature.Vector(geompol)]);
                                            var n=wfs.features.length-1;
                                            wfs.features[n].state=OpenLayers.State.INSERT;
                                            wfs.features[n].attributes.cve_ent=filtroid;
                                            wfs.features[n].attributes.us=iduser;
                                            wfs.features[n].attributes.img=baseimg;
                                            feature = wfs.getFeatureBy('fid', wfs.features[n].fid);
                                            feature.attributes.cve_ent=filtroid;
                                            feature.attributes.us=iduser;
                                            feature.attributes.img=baseimg;
                                            alertmsg('1 Manzana agregada');
                                        }
                                    }
                                }
                                ajax.send(null);
                            }
                        },displayClass: "olControlCoords",title: "Obtener geometria de manzana base"
                });


       obtmzF = new OpenLayers.Control.DrawFeature(pointLayeralt,OpenLayers.Handler.Point,{eventListeners: {
                        featureadded: function(e) {
                                var ll = e.feature.geometry.transform(new OpenLayers.Projection('EPSG:900913'), new OpenLayers.Projection('EPSG:32800'));
                                var ajax=nuevoAjax();
                                ajax.open("GET",'obtgeo_mz.jsp?x='+ll.x+'&y='+ll.y+'&ent='+filtroid, true);
                                ajax.onreadystatechange=function()
                                {
                                    if(ajax.readyState==4)  {
                                        var val=ajax.responseText.trim();
                                        if (val=='1'){
                                            alertmsg ("No se pudo extraer la manzana");
                                        }else{
                                            //console.log(val);
                                            var geompol = OpenLayers.Geometry.fromWKT(val);
                                            wfs.addFeatures([new OpenLayers.Feature.Vector(geompol)]);
                                            var n=wfs.features.length-1;
                                            wfs.features[n].state=OpenLayers.State.INSERT;
                                            wfs.features[n].attributes.cve_ent=filtroid;
                                            wfs.features[n].attributes.us=iduser;
                                            wfs.features[n].attributes.img=baseimg;
                                            wfs.features[n].attributes.forma=1;
                                            feature = wfs.getFeatureBy('fid', wfs.features[n].fid);
                                            feature.attributes.cve_ent=filtroid;
                                            feature.attributes.us=iduser;
                                            feature.attributes.img=baseimg;
                                            alertmsg('1 Manzana agregada');
                                        }
                                    }
                                }
                                ajax.send(null);
                            }
                        },displayClass: "olControlCoordsF",title: "Obtener geometria de manzana base (CAMBIO DE FORMA)"
                });

            ///BOTONES POLIGONO EXTERNO
            drawmz = new OpenLayers.Control.DrawFeature(wfs_pe, OpenLayers.Handler.Polygon, {title: "Agregar PE", displayClass: "olControlDrawFeaturePolygon" , multi: true});
            drawmz.events.register('featureadded', drawmz, drawdigregistra_pe);
            modimz1 = new OpenLayers.Control.ModifyFeature(wfs_pe, {displayClass: "olControlModifymzFeature",title: "Modificar PE"});
            modimz2 = new OpenLayers.Control.ModifyFeature(wfs_pe, {displayClass: "olControlModify2Feature", title: "Mover, rotar, tama\xF1o PE"});
            modimz2.mode  = OpenLayers.Control.ModifyFeature.DRAG | OpenLayers.Control.ModifyFeature.ROTATE | OpenLayers.Control.ModifyFeature.RESIZE ;
            delmz = new DeleteFeatureDig(wfs_pe, {title: "Borrar PE"});
            cutpol = new OpenLayers.Control.Button({
                    title: "Activar Cortado PE",
                    trigger: function() {
                        if (cutpolvar==0){
                            cutpolvar=1;
                            cutpol.activate();
                        }else{
                            cutpolvar=0;
                            cutpol.deactivate();
                        }
                    },
                    displayClass: "olControlcutpol"
             });


          var obtpe = new OpenLayers.Control.DrawFeature(pointLayeralt,OpenLayers.Handler.Point,{eventListeners: {
                        featureadded: function(e) {
                                var ll = e.feature.geometry.transform(new OpenLayers.Projection('EPSG:900913'), new OpenLayers.Projection('EPSG:32800'));
                                var ajax=nuevoAjax();
                                ajax.open("GET",'obtgeo_pe_pre.jsp?x='+ll.x+'&y='+ll.y+'&ent='+filtroid, true);
                                ajax.onreadystatechange=function()
                                {
                                    if(ajax.readyState==4)  {
                                        var val=ajax.responseText.trim();
                                        if (val=='1'){
                                            alertmsg ("No se pudo extraer el PE");
                                        }else{
                                            //console.log(val);
                                            var geompol = OpenLayers.Geometry.fromWKT(val);
                                            wfs_pe.addFeatures([new OpenLayers.Feature.Vector(geompol)]);
                                            var n=wfs_pe.features.length-1;
                                            wfs_pe.features[n].state=OpenLayers.State.INSERT;
                                            wfs_pe.features[n].attributes.cve_ent=filtroid;
                                            wfs_pe.features[n].attributes.us=iduser;
                                            wfs_pe.features[n].attributes.img=baseimg;
                                            feature = wfs_pe.getFeatureBy('fid', wfs_pe.features[n].fid);
                                            feature.attributes.cve_ent=filtroid;
                                            feature.attributes.us=iduser;
                                            feature.attributes.img=baseimg;
                                            alertmsg('1 PE agregado');
                                        }
                                    }
                                }
                                ajax.send(null);
                            }
                        },displayClass: "olControlCoords",title: "Obtener geometria de PE base"
                });

                        ///BOTONES PUNTOS LOCALIDAD
            draw_point = new OpenLayers.Control.DrawFeature(wfs_punto, OpenLayers.Handler.Point, {title: "Agregar Localidad", displayClass: "olControlDrawFeaturePoint" });
            draw_point.events.register('featureadded', draw_point, drawdigregistra_point);
            modi_point = new OpenLayers.Control.ModifyFeature(wfs_punto, {displayClass: "olControlModify2Feature",title: "Mover Localidad"});
            del_point = new DeleteFeatureDig(wfs_punto, {title: "Borrar Localidad"});
            bajaloc = new OpenLayers.Control.DrawFeature(pointLayeralt,OpenLayers.Handler.Point,{eventListeners: {
                        featureadded: function(e) {
                                var ll = e.feature.geometry.transform(new OpenLayers.Projection('EPSG:900913'), new OpenLayers.Projection('EPSG:32800'));
                                var ajax=nuevoAjax();
                                ajax.open("GET",'obtgeo_loc_baja.jsp?x='+ll.x+'&y='+ll.y+'&ent='+filtroid, true);
                                ajax.onreadystatechange=function()
                                {
                                    if(ajax.readyState==4)  {
                                        var val=ajax.responseText.trim();
                                        if (val=='1'){
                                            alertmsg ("No se pudo extraer la localidad");
                                        }else{
                                            //console.log(val);
                                            var tip=val.substring(0,1);
                                            var mz=val.substring(1,10);
                                            val=val.substring(10,val.length);
                                            var geompol = OpenLayers.Geometry.fromWKT(val);
                                            wfs_punto.addFeatures([new OpenLayers.Feature.Vector(geompol)]);
                                            var n=wfs_punto.features.length-1;
                                            wfs_punto.features[n].state=OpenLayers.State.INSERT;
                                            wfs_punto.features[n].attributes.cve_ent=filtroid;
                                            wfs_punto.features[n].attributes.us=iduser;
                                            wfs_punto.features[n].attributes.img=baseimg;
                                            wfs_punto.features[n].attributes.baja=tip;
                                            wfs_punto.features[n].attributes.cve_baja=mz;
                                            feature = wfs_punto.getFeatureBy('fid', wfs_punto.features[n].fid);
                                            feature.attributes.cve_ent=filtroid;
                                            feature.attributes.us=iduser;
                                            feature.attributes.img=baseimg;
                                            alertmsg('1 Punto agregado');
                                        }
                                    }
                                }
                                ajax.send(null);
                            }
                        },
                    displayClass: "olControlBajaLoc",title: "Posible baja de localidad"
                    });

        save = new OpenLayers.Control.Button({
                title: "Salvar Cambios",
                trigger: function() {
                    if(modify2.feature) {modify2.selectControl.unselectAll();}
                    if(modify.feature) {modify.selectControl.unselectAll();}
                    if(modimz2.feature) {modimz2.selectControl.unselectAll();}
                    if(modimz1.feature) {modimz1.selectControl.unselectAll();}
                    if(modi_point.feature) {modi_point.selectControl.unselectAll();}
                    saveStrategy.save();
                    saveStrategypunto.save();
                    saveStrategype.save();
                },
                displayClass: "olControlSaveFeatures"
            });

         cierra = new OpenLayers.Control.Button ({
                displayClass: 'olControlClose',
                trigger: function() {
                    if (cierraban==0){
                        //if (confirm("Desea cerrar la edicion??")){
                            cierraban=1;
                        //}
                    }
                    if (cierraban==1){
                        cierraban=0;
                        desactivar_botones();
                        ban1=0;
                        wfs.removeAllFeatures();wfs_punto.removeAllFeatures();wfs_pe.removeAllFeatures();
                        wfs_punto.visibility=false;wfs_pe.visibility=false;wfs.visibility=false;
                        wfs_punto.removeMap();wfs.removeMap();wfs_pe.removeMap();
                        cierra.destroy();
                        save.destroy();
                        obtmz.destroy();
                        obtpe.destroy();
                        obtmzF.destroy();
                        submz.destroy();
                        fusmz.destroy();
                        bajamz.destroy();
                        del.destroy();
                        modify2.destroy();
                        modify.destroy();
                        draw.destroy();
                        botonvacio1.destroy();
                        botonvacio2.destroy();
                        botonvacio3.destroy();
                        botonvacio4.destroy();
                        botonvacio5.destroy();
                        cutpol.destroy();
                        delmz.destroy();
                        modimz2.destroy();
                        modimz1.destroy();
                        drawmz.destroy();
                        botonvacio6.destroy();
                        botonvacio7.destroy();
                        botonvacio8.destroy();
                        botonvacio9.destroy();
                        botonvacio10.destroy();
                        botonvacio11.destroy();
                        bajaloc.destroy();
                        del_point.destroy();
                        modi_point.destroy();
                        draw_point.destroy();
                        panelDig2.destroy();
                        panelDig2=undefined;
                        for (var i = map.popups.length - 1; i >= 0; i--) {
                                 map.removePopup(map.popups[i]);
                        }
                        activar_rueda_raton();
                        //obtmz.deactivate();submz.deactivate();bajamz.deactivate();del.deactivate();modify2.deactivate();
                        //modify.deactivate();draw.deactivate();delmz.deactivate();modimz2.deactivate();modimz1.deactivate();
                        //drawmz.deactivate();bajaloc.deactivate();del_point.deactivate();modi_point.deactivate();draw_point.deactivate();
                        editardigM.deactivate();
                    }
                },
                title: 'Cerrar editor'
            });
         for (i=1;i<25;i++){
            eval ('var botonvacio'+i+'=new OpenLayers.Control.Button()');
         }

        pre_mza = new OpenLayers.Control.Button ({displayClass: 'olControlButpremza', title: 'Editar Manzana - Actualizacion'});
        pre_pol = new OpenLayers.Control.Button ({displayClass: 'olControlButprepol', title: 'Editar Poligonos'});
        pre_pun = new OpenLayers.Control.Button ({displayClass: 'olControlButprepun', title: 'Editar Puntos'});

        panelDig2 = new OpenLayers.Control.Panel({displayClass: 'panelDig2Toolbar'});
              panelDig2.addControls([obtmzF,obtmz,submz,fusmz,bajamz,del,modify2,modify,draw,pre_mza,
            botonvacio1,botonvacio2,botonvacio3,obtpe,cutpol,delmz,modimz2,modimz1,drawmz,pre_pol,
            botonvacio5,botonvacio6,botonvacio7,botonvacio8,botonvacio9,bajaloc,del_point,modi_point,draw_point,pre_pun,
            botonvacio10,botonvacio11,botonvacio12,botonvacio13,botonvacio14,botonvacio15,botonvacio16,botonvacio17,cierra,save]);


        obtmz.events.register('activate',null,valCtrleditpre);
        obtpe.events.register('activate',null,valCtrleditpre);
        obtmzF.events.register('activate',null,valCtrleditpre);
        submz.events.register('activate',null,valCtrleditpre);
        bajamz.events.register('activate',null,valCtrleditpre);
        del.events.register('activate',null,valCtrleditpre);
        modify2.events.register('activate',null,valCtrleditpre);
        modify.events.register('activate',null,valCtrleditpre);
        draw.events.register('activate',null,valCtrleditpre);
        delmz.events.register('activate',null,valCtrleditpre);
        modimz2.events.register('activate',null,valCtrleditpre);
        modimz1.events.register('activate',null,valCtrleditpre);
        drawmz.events.register('activate',null,valCtrleditpre);
        bajaloc.events.register('activate',null,valCtrleditpre);
        del_point.events.register('activate',null,valCtrleditpre);
        modi_point.events.register('activate',null,valCtrleditpre);
        draw_point.events.register('activate',null,valCtrleditpre);
        map.addControl(panelDig2);
        editardigM.activate();
        //draw.activate();
        idxpasa=0;
}else{
    alertmsg ("La escala debe ser < a 20,000 para digitalizar");
    editardigM.deactivate();
}
}


// FUNCION VIENE DE EDICION DE MANZANAS
function valCtrleditpre(event){
    desactivar_botones();
    //wfs_punto , wfs, wfs_pe.removeMap();
        if (idxpasa==0){
            if (wfs.getZIndex()>wfs_punto.getZIndex() && wfs.getZIndex()>wfs_pe.getZIndex()){
                idxcdmax=wfs.getZIndex();
                if (wfs_punto.getZIndex()>wfs_pe.getZIndex()){
                    idxcdmed=wfs_punto.getZIndex();   idxcdmin=wfs_pe.getZIndex();
                }else{
                    idxcdmed=wfs_pe.getZIndex();   idxcdmin=wfs_punto.getZIndex();
                }
            }else if (wfs_punto.getZIndex()>wfs.getZIndex() && wfs_punto.getZIndex()>wfs_pe.getZIndex()){
                idxcdmax=wfs_punto.getZIndex();
                if (wfs.getZIndex()>wfs_pe.getZIndex()){
                    idxcdmed=wfs.getZIndex();   idxcdmin=wfs_pe.getZIndex();
                }else{
                    idxcdmed=wfs_pe.getZIndex();   idxcdmin=wfs.getZIndex();
                }
            }else{   //mas alto wfs_pe
                idxcdmax=wfs_pe.getZIndex();
                if (wfs.getZIndex()>wfs_punto.getZIndex()){
                    idxcdmed=wfs.getZIndex();   idxcdmin=wfs_punto.getZIndex();
                }else{
                    idxcdmed=wfs_punto.getZIndex();   idxcdmin=wfs.getZIndex();
                }
            }
            idxpasa=1;
        }
        //mz   del,modify2,modify,draw,
        //pe   delmz,modimz2,modimz1,drawmz
        //punto del_point,modi_point,draw_point

    if (del.active==true || modify2.active==true || modify.active==true || draw.active==true){
            wfs.setZIndex(idxcdmax);
            wfs_pe.setZIndex(idxcdmed);
            wfs_punto.setZIndex(idxcdmin);
     }else if(delmz.active==true || modimz2.active==true || modimz1.active==true || drawmz.active==true){
            wfs_pe.setZIndex(idxcdmax);
            wfs.setZIndex(idxcdmed);
            wfs_punto.setZIndex(idxcdmin);
     }else if(del_point.active==true || modi_point.active==true || draw_point.active==true){
            wfs_punto.setZIndex(idxcdmax);
            wfs.setZIndex(idxcdmed);
            wfs_pe.setZIndex(idxcdmin);
     }
     //console.log("wfs:"+wfs.getZIndex());
     //console.log("wfs_cdpol:"+wfs_cdpol.getZIndex());
}




// REGISTRA EN EL FEATURE LA IMAGEN QUE SE USO
function drawdigregistra_point(event){
    var feature = event.feature;
    feature.attributes.cve_ent=filtroid;
    feature.attributes.us=iduser;
    feature.attributes.img=baseimg;
}

function selregistra_pe(event){
    var feature = event.feature;
    feature.attributes.us=iduser;
    feature.attributes.img=baseimg;
    feature.attributes.obs  = cutpolvar;
}


function drawdigregistra_pe(event){
    console.log(event);
    if (map.popups.length>0){
        onPopupClosepeall();
    }
    //console.log(cutpolvar);
    var feature = event.feature;
    obtCvePe(feature);
    idpop=feature.id;
    feature.attributes.cve_ent=filtroid;
    feature.attributes.us=iduser;
    feature.attributes.img=baseimg;
    feature.attributes.obs  = cutpolvar;

    var theHTML = '<center>';
    //var geom=e.feature.geometry.toString();
    theHTML += '<table border=1>';
    theHTML += '<tr><td class=label style="text-align:center"><br>';
    theHTML += '<tr><th class=label style="text-align:center" colspan=2>CONTEO VISUAL DE VIVIENDAS';
    theHTML += '<tr><td colspan=2><hr>';
    theHTML += '<tr><td class=label style="text-align:right"># Inmuebles:';
    theHTML += '<td class=label style="text-align:left"><input type="number" value=0 style="width: 4em;" id=numerodeviviendaspre>';
    theHTML += '<tr><td class=label style="text-align:center"><br>';
    theHTML += '<tr><td colspan=2 class=boton"><center><input type=button value=" Registrar " onClick="seguireinvpre(\'' + feature.id + '\',2)">';
    theHTML += '</center>';
    if (map.getExtent().containsLonLat(feature.geometry.getBounds().getCenterLonLat())){
        //var varcent=feature.geometry.getBounds().getCenterLonLat();
        var varcent=new OpenLayers.LonLat(feature.geometry.getBounds().right,feature.geometry.getBounds().getCenterLonLat().lat);
    }else{
        var varcent=map.getCenter();
    }
    feature.popup = new OpenLayers.Popup.AnchoredBubble
    ("pop", varcent, new OpenLayers.Size(250,140),
    theHTML,    null,   true    //este false es el boton de cerrar
     ,onPopupClosepe
    );
    feature.popup.opacity=0.9;
    feature.popup.backgroundColor="#BBCCFF";
    feature.popup.relativePosition = "br";
            feature.popup.calculateRelativePosition = function () {
                 return 'br';
            }

    map.addPopup(feature.popup);
    document.getElementById("pop").style.zIndex = "999";
}

function selregistra(event){
    var feature = event.feature;
    feature.attributes.us=iduser;
    feature.attributes.img=baseimg;
}

function drawdigregistra(event){
    if (map.popups.length>0){
        onPopupClosepeall();
    }
    var feature = event.feature;
    feature.attributes.cve_ent=filtroid;
    feature.attributes.us=iduser;
    feature.attributes.img=baseimg;
    feature.attributes.cod=4;
    idpop=feature.id;
    var theHTML = '<center>';
    //var geom=e.feature.geometry.toString();
    theHTML += '<table border=1>';
    theHTML += '<tr><td class=label style="text-align:center"><br>';
    theHTML += '<tr><th class=label style="text-align:center" colspan=2>CONTEO VISUAL DE VIVIENDAS';
    theHTML += '<tr><td colspan=2><hr>';
    theHTML += '<tr><td class=label style="text-align:right"># Inmuebles:';
    theHTML += '<td class=label style="text-align:left"><input type="number" value=0 style="width: 4em;" id=numerodeviviendaspre>';
    theHTML += '<tr><td class=label style="text-align:center"><br>';

        // es manzana CUR
    theHTML += '<tr><td class=label style="text-align:center" colspan=2><input type="radio" name="tipomzcur" value="0" id="radmcur0">MANZANA MG';
    theHTML += '<tr><td class=label style="text-align:center" colspan=2><input type="radio" name="tipomzcur" value="1" id="radmcur1">MANZANA CUR (No MG)';
    theHTML += '<tr><td class=label style="text-align:center"><br>';

    theHTML += '<tr><td class=boton" colspan=2><center><input type=button value=" Registrar " onClick="seguireinvpre(\'' + feature.id + '\',1)">';
    //theHTML += '<tr><td class=boton" colspan=2>&nbsp;';
    //theHTML += '<tr><td class=boton" colspan=2><center><input type=button value=" Registra como 800 " onClick="seguireinvpre(\'' + feature.id + '\',3)">';



    theHTML += '</center>';
    if (map.getExtent().containsLonLat(feature.geometry.getBounds().getCenterLonLat())){
        //var varcent=feature.geometry.getBounds().getCenterLonLat();
        var varcent=new OpenLayers.LonLat(feature.geometry.getBounds().right,feature.geometry.getBounds().getCenterLonLat().lat);
    }else{
        var varcent=map.getCenter();
    }
    feature.popup = new OpenLayers.Popup.AnchoredBubble
    //("pop", varcent, new OpenLayers.Size(250,170),
    ("pop", varcent, new OpenLayers.Size(250,180),
    theHTML,    null,   true    //este false es el boton de cerrar
    ,onPopupClosemzp
    );
    feature.popup.opacity=0.9;
    feature.popup.backgroundColor="#BBCCFF";
    feature.popup.relativePosition = "br";
            feature.popup.calculateRelativePosition = function () {
                 return 'br';
            }
    map.addPopup(feature.popup);
    document.getElementById("pop").style.zIndex = "999";

}

}  //TERMINA FUNCION PRINCIPAL  init();


 // ******************************************************************************************************************************
 // *******************************************************************************************************************************


//document.write("<script type='text/javascript' src='js_manzanas.js?v="+verjs+"'></script>"); //archivo de las manzanas
//document.write("<script type='text/javascript' src='js_caserios.js?v="+verjs+"'></script>"); //archivo de los caserios
//document.write("<script type='text/javascript' src='js_localidades.js?v="+verjs+"'></script>"); //archivo de las localidades
//document.write("<script type='text/javascript' src='js_predig.js?v="+verjs+"'></script>"); //archivo de las predigitalizacion
//document.write("<script type='text/javascript' src='js_agebu.js?v="+verjs+"'></script>"); //archivo de las ageb urbanas
//document.write("<script type='text/javascript' src='js_polrur.js?v="+verjs+"'></script>"); //archivo de las localidades amanzanadas rurales
//document.write("<script type='text/javascript' src='js_polext.js?v="+verjs+"'></script>"); //archivo de las localidades amanzanadas rurales


//FUNCION PARA BUSCAR UNA CAPA VIENE DESDE LA PARTE DE BUSQUEDA // ****************************************************************************************************************
function buscazoom(st,capa,s0,s1,s2,s3){
switch (parseInt(capa)){
case 1:
    cartas.visibility=true;
    cartaset.visibility=true;
    capasel[0]=1;textsel[0]=1;
    break;
case 2:
    estados.visibility=true;
    estadoset.visibility=true;
    capasel[1]=1;textsel[1]=1;
    break;
case 3:
    municipios.visibility=true;
    municipioset.visibility=true;
    capasel[2]=1;textsel[2]=1;
    break;
case 4:
    agebs.visibility=true;
    agebset.visibility=true;
    capasel[3]=1;textsel[3]=1;
    break;
case 41:
    agebsur.visibility=true;
    agebsuret.visibility=true;
    capasel[4]=1;textsel[4]=1;
    break;
case 5: //deshabilitado
    locurb.visibility=true;
    locurbet.visibility=true;
    capasel[5]=1;textsel[5]=1;
    break;
case 6: //deshabilitado
    locrurpol.visibility=true;
    locrurpolet.visibility=true;
    capasel[6]=1;textsel[6]=1;
    break;
case 99:
case 7:
    if (cat=='X'){
        cve_ent=clave.substring(0,2);
        cve_mun=clave.substring(2,5);
        cve_loc=clave.substring(5,9);
        cve_ageb=mandaageb;
        cat='';
    }
    locurb.visibility=true;
    locurbet.visibility=true;
    locrurpol.visibility=true;
    //locrurpolet.visibility=true;
    capasel[5]=1;textsel[5]=1;
    capasel[6]=1;//textsel[6]=1;
    if (st=='ALTA'){
        locrur1.visibility=true;
        locruret1.visibility=true;
        capasel[8]=1;textsel[8]=1;
    }else if(st=='AMBAS'){
        locrur1.visibility=true;
        locruret1.visibility=true;
        locrur0.visibility=true;
        locruret0.visibility=true;
        capasel[8]=1;textsel[8]=1;
        capasel[9]=1;textsel[9]=1;
    } else{
        locrur0.visibility=true;
        locruret0.visibility=true;
        capasel[9]=1;textsel[9]=1;
    }
    if (capa!='99'){
       var c1 = (parseFloat(s0)+parseFloat(s2))/2;
       var c2 = (parseFloat(s1)+parseFloat(s3))/2;
       geometry = new OpenLayers.Geometry.Point(c1,c2);
       var feature = new OpenLayers.Feature.Vector(geometry, {}, {
            strokeColor: '#000000',
            strokeOpacity: 1,
            strokeWidth: 1,
            fillColor: '#9966cc',
            fillOpacity: 0.5,
            pointRadius: 7,
            graphicName: 'star'
        });
        puntogen.addFeatures([feature]);
    }
    break;
case 8:
    var c1 = (parseFloat(s0)+parseFloat(s2))/2;
    var c2 = (parseFloat(s1)+parseFloat(s3))/2;
    geometry = new OpenLayers.Geometry.Point(c1,c2);
    var feature = new OpenLayers.Feature.Vector(geometry, {}, {
        strokeColor: '#000000',
        strokeOpacity: 1,
        strokeWidth: 1,
        fillColor: '#ff0000',
        fillOpacity: 0.5,
        pointRadius: 4,
        graphicName: 'circle'
    });
    asen.visibility=true;
    asenet.visibility=true;
    capasel[10]=1;textsel[10]=1;
    puntogen.addFeatures([feature]);
    break;
case 9:
    var c1 = (parseFloat(s0)+parseFloat(s2))/2;
    var c2 = (parseFloat(s1)+parseFloat(s3))/2;
    geometry = new OpenLayers.Geometry.Point(c1,c2);
    var feature = new OpenLayers.Feature.Vector(geometry, {}, {
        strokeColor: '#000000',
        strokeOpacity: 1,
        strokeWidth: 1,
        fillColor: '#ff0000',
        fillOpacity: 0.5,
        pointRadius: 4,
        graphicName: 'circle'
    });
    //asen.visibility=true;
    //asenet.visibility=true;
    capasel[10]=1;textsel[10]=1;
    puntogen.addFeatures([feature]);
    vial.visibility=true;
    capasel[13]=1;;
    break;
case 10:
    var c1 = (parseFloat(s0)+parseFloat(s2))/2;
    var c2 = (parseFloat(s1)+parseFloat(s3))/2;
    geometry = new OpenLayers.Geometry.Point(c1,c2);
    var feature = new OpenLayers.Feature.Vector(geometry, {}, {
        strokeColor: '#000000',
        strokeOpacity: 1,
        strokeWidth: 1,
        fillColor: '#9966cc',
        fillOpacity: 0.5,
        pointRadius: 7,
        graphicName: 'star'
    });
    bd_loc.visibility=true;
    capasel[14]=1;
    puntogen.addFeatures([feature]);
    break;
case 11:
    agebsur.visibility=true;
    agebsuret.visibility=true;
    capasel[4]=1;textsel[4]=1;
    locurb.visibility=true;
    locurbet.visibility=true;
    capasel[5]=1;textsel[5]=1;
    locrurpol.visibility=true;
    locrurpolet.visibility=true;
    capasel[6]=1;textsel[6]=1;
    mza.visibility=true;
    mzaet.visibility=true;
    capasel[11]=1;textsel[11]=1;
    mza_gen.visibility=true;
    //mza_genet.visibility=true;
    capasel[12]=1;//textsel[12]=1;
case 12:
    agebsur.visibility=true;
    agebsuret.visibility=true;
    capasel[4]=1;textsel[4]=1;
    locurb.visibility=true;
    locurbet.visibility=true;
    capasel[5]=1;textsel[5]=1;
    locrurpol.visibility=true;
    locrurpolet.visibility=true;
    capasel[6]=1;textsel[6]=1;
    mza.visibility=true;
    mzaet.visibility=true;
    capasel[11]=1;textsel[11]=1;
    mza_gen.visibility=true;
    //mza_genet.visibility=true;
    capasel[12]=1;//textsel[12]=1;
       var c1 = (parseFloat(s0)+parseFloat(s2))/2;
       var c2 = (parseFloat(s1)+parseFloat(s3))/2;
       geometry = new OpenLayers.Geometry.Point(c1,c2);
       var feature = new OpenLayers.Feature.Vector(geometry, {}, {
            strokeColor: '#000000',
            strokeOpacity: 1,
            strokeWidth: 1,
            fillColor: '#9966cc',
            fillOpacity: 0.5,
            pointRadius: 7,
            graphicName: 'star'
        });
        puntogen.addFeatures([feature]);
    break;
}
bounds = new OpenLayers.Bounds(s0,s1,s2,s3);
map.zoomToExtent(bounds);
//map.controls[0].redraw;  //?????????????
document.getElementById('framecapas').src = document.getElementById('framecapas').src;
}



//FUNCION QUE ABRE Y BUSCA INFORMACION// ****************************************************************************************************************
function busca(){
    if (document.busqueda.tipo.value==0 && document.busqueda.capa.value!=12){
        document.busqueda.buscar.value=document.busqueda.buscar.value.replace(/ /g, '');
        document.busqueda.buscar.value=document.busqueda.buscar.value.replace(/;/g, '');
        document.busqueda.buscar.value=document.busqueda.buscar.value.replace(/'/g, '');
        document.busqueda.buscar.value=document.busqueda.buscar.value.replace(/\u00a0/g, '');
        document.busqueda.buscar.value=document.busqueda.buscar.value.replace(/\t/g,'');


    }
document.busqueda.buscar.value=removeDiacritics(document.busqueda.buscar.value);
if (document.busqueda.capa.value==0){
    alertmsg ("Debe proporcionar una capa");
    return false;
}
if (document.busqueda.tipo[0].checked && document.busqueda.buscar.value.length==0){
    alertmsg ("Debe proporcionar la clave");
    return false;
}
if (document.busqueda.tipo[1].checked && document.busqueda.buscar.value.length<3){
    alertmsg ("Debe proporcionar un texto (Por lo menos 3 caracteres)");
    return false;
}
var tip=0;
if (document.busqueda.tipo[1].checked){
tip=1;
}
ventana = window.open('buscar.jsp?capa='+document.busqueda.capa.value+'&tipo='+tip+'&buscar='+document.busqueda.buscar.value,'Buscar','toolbar=no,Resizable=1,scrollbars=1');
ventana.focus();
}


//FUNCION PARA ELIMINAR LOS RASGOS AGREGADOS// ****************************************************************************************************************
function borra(){
     puntogen.removeAllFeatures();
    highlight.removeAllFeatures();
}

//REVISA QUE SEA DATO NUMERICO
function datonum(e){
    //alert (e.keyCode+" :: "+e.which);
  var latitud=document.busqueda.latitud.value.replace(/^\s+|\s+$/g, '');
  var longitud=document.busqueda.longitud.value.replace(/^\s+|\s+$/g, '');
  var ctrlDown = e.ctrlKey;
  var bn=navigator.appName;
  key = (document.all) ? e.keyCode : e.which;
  if (ctrlDown && (key==67 || key==86 || key==88 || key==99 || key==118 || key==120)) return true;   //ctrl v x c para firefox
  if (key==8 || key==9 || key==0 || key==127 || key==46 || key==45) return true;
  if (key==13 && latitud.length>0  && longitud.length>0 ) enviar();
    if (key < 48 || key > 57) {
        if (bn=="Microsoft Internet Explorer"){
            window.event.keyCode=0;
        }
     return false;
 }
}


//FUNCION ENVIA LATITUD Y LONGITUD PARA LA GENERACION DE UN PUNTO// ****************************************************************************************************************
function enviar(valor){

        document.busqueda.latitud.value=document.busqueda.latitud.value.replace(/ /g, '');
        document.busqueda.latitud.value=document.busqueda.latitud.value.replace(/;/g, '');
        document.busqueda.latitud.value=document.busqueda.latitud.value.replace(/'/g, '');
        document.busqueda.latitud.value=document.busqueda.latitud.value.replace(/\u00a0/g, '');
        document.busqueda.latitud.value=document.busqueda.latitud.value.replace(/\t/g,'');

        document.busqueda.longitud.value=document.busqueda.longitud.value.replace(/ /g, '');
        document.busqueda.longitud.value=document.busqueda.longitud.value.replace(/;/g, '');
        document.busqueda.longitud.value=document.busqueda.longitud.value.replace(/'/g, '');
        document.busqueda.longitud.value=document.busqueda.longitud.value.replace(/\u00a0/g, '');
        document.busqueda.longitud.value=document.busqueda.longitud.value.replace(/\t/g,'');



var oper=2000;
if (valor!= undefined){
    oper=valor;
}
var latitud=document.busqueda.latitud.value.replace(/^\s+|\s+$/g, '');
var longitud=document.busqueda.longitud.value.replace(/^\s+|\s+$/g, '');
if (latitud.length==0 || longitud.length==0){
    alertmsg ("Proporcione coordenadas");
    return false;
}
var element = document.getElementById('output');
if ((Math.abs(latitud)>13 && Math.abs(latitud)<34) || (Math.abs(longitud)>84 && Math.abs(longitud)<120)){
    element.innerHTML = 'DEC';
    lat_dec=parseFloat(latitud);
    lon_dec=parseFloat(longitud);
    if (lon_dec>0){
        lon_dec=lon_dec*-1;
    }
}else if ((Math.abs(latitud)>140000 && Math.abs(latitud)<330000 && Math.abs(longitud)>860000 && Math.abs(longitud)<1190000)){
    element.innerHTML = 'GEO';
    longitud=longitud.replace("-","");
    var lat_dec=parseInt(latitud.substr(0,2),10)+parseInt(latitud.substr(2,2),10)/60+parseFloat(latitud.substr(4,latitud.length),10)/3600;
    var lon_dec=(parseInt(longitud.substr(0,3),10)+parseInt(longitud.substr(3,2),10)/60+parseFloat(longitud.substr(5,longitud.length),10)/3600)*(-1);
}else{
//}else if ((Math.abs(latitud)>318947 && Math.abs(latitud)<2348068 && Math.abs(longitud)>907961 && Math.abs(longitud)<4077189)){
        element.innerHTML = 'CCL';
        lat_dec=parseFloat(latitud);
        lon_dec=parseFloat(longitud);
        geometry1 = new OpenLayers.Geometry.Point(lon_dec, lat_dec);
        geometry1.transform(
            new OpenLayers.Projection('EPSG:32800'),
            new OpenLayers.Projection('EPSG:4326')
        );
        lon_dec=geometry1.x;
        lat_dec=geometry1.y;
}
if (parseInt(Math.abs(lat_dec),10)>parseInt(33,10) || parseInt(Math.abs(lat_dec),10)<parseInt(13,10)){
    alertmsg ("Latitud fuera de rango");
    return false;
}else{
    if (parseInt(Math.abs(lon_dec),10)>parseInt(120,10) || parseInt(Math.abs(lon_dec),10)<parseInt(84,10)){
        alertmsg ("Longitud fuera de rango");
        return false;
    }
}

geometry = new OpenLayers.Geometry.Point(lon_dec, lat_dec);
    //alert (geometry.getBounds());
    geometry.transform(                                               //solo si es 38200 la projeccion del mapa
        new OpenLayers.Projection('EPSG:4326'),
        new OpenLayers.Projection('EPSG:900913')
    );

      // alert (geometry.getBounds());
    var feature = new OpenLayers.Feature.Vector(geometry, {}, {
        strokeColor: '#000000',
        strokeOpacity: 1,
        strokeWidth: 1,
        fillColor: '#'+document.getElementById('colorin').value,
        fillOpacity: 0.5,
        pointRadius: 7,
        graphicName: 'star'
    });
    puntogen.addFeatures([feature]);
    s0=geometry.x-(oper);    //ccl o mercator
    s1=geometry.y-(oper);
    s2=geometry.x+(oper);
    s3=geometry.y+(oper);
    bounds = new OpenLayers.Bounds(s0,s1,s2,s3);
    map.zoomToExtent(bounds);
}




function datonumjuntos(e){
    //alert (e.keyCode+" :: "+e.which);
  var latitud=document.busqueda.latitud.value.replace(/^\s+|\s+$/g, '');
  var longitud=document.busqueda.longitud.value.replace(/^\s+|\s+$/g, '');
  var ctrlDown = e.ctrlKey;
  var bn=navigator.appName;
  key = (document.all) ? e.keyCode : e.which;
  if (ctrlDown && (key==67 || key==86 || key==88 || key==99 || key==118 || key==120)) return true;   //ctrl v x c para firefox
  if (key==8 || key==9 || key==0 || key==127 || key==46 || key==45) return true;
  if (key==13 && latitud.length>0  && longitud.length>0 ) enviar();
    if (key < 48 || key > 57) {
        if (key!=44){  //coma
                if (bn=="Microsoft Internet Explorer"){
                    window.event.keyCode=0;
                }
            return false;
        }
 }
}


//FUNCION ENVIA LATITUD Y LONGITUD PARA LA GENERACION DE UN PUNTO JUNTOS// ****************************************************************************************************************
function enviarjuntos(valor){

        document.busqueda.latitud.value=document.busqueda.latitud.value.replace(/ /g, '');
        document.busqueda.latitud.value=document.busqueda.latitud.value.replace(/;/g, '');
        document.busqueda.latitud.value=document.busqueda.latitud.value.replace(/'/g, '');
        document.busqueda.latitud.value=document.busqueda.latitud.value.replace(/\u00a0/g, '');
        document.busqueda.latitud.value=document.busqueda.latitud.value.replace(/\t/g,'');
        document.busqueda.latitud.value=document.busqueda.latitud.value.replace(/^\s+|\s+$/g, '');   //al final o al inicio espacio en blanco

        document.busqueda.longitud.value=document.busqueda.longitud.value.replace(/ /g, '');
        document.busqueda.longitud.value=document.busqueda.longitud.value.replace(/;/g, '');
        document.busqueda.longitud.value=document.busqueda.longitud.value.replace(/'/g, '');
        document.busqueda.longitud.value=document.busqueda.longitud.value.replace(/\u00a0/g, '');
        document.busqueda.longitud.value=document.busqueda.longitud.value.replace(/\t/g,'');
        document.busqueda.longitud.value=document.busqueda.longitud.value.replace(/^\s+|\s+$/g, '');   //al final o al inicio espacio en blanco



// aqui lo hago solo con una
    var inputValue = document.busqueda.longitud.value;

    let encontrado1 = inputValue.includes(',');  //se encuetra coma
    if (encontrado1){
        var values = inputValue.split(',');
    }else{
        alertmsg ('Debe de separar las coordenadas con coma');
        return false;
    }


    const lon1 = values[0];
    const lat1 = values[1];
    var lon = lon1.replace(/^\s+|\s+$/g, '');   //al final o al inicio
    var lat = lat1.replace(/^\s+|\s+$/g, '');

    document.busqueda.latitud.value=lat;
    document.busqueda.longitud.value=lon;



var oper=2000;
if (valor!= undefined){
    oper=valor;
}
var latitud=document.busqueda.latitud.value.replace(/^\s+|\s+$/g, '');
var longitud=document.busqueda.longitud.value.replace(/^\s+|\s+$/g, '');
if (latitud.length==0 || longitud.length==0){
    alertmsg ("Proporcione coordenadas");
    document.busqueda.longitud.value=inputValue;
    return false;
}
var element = document.getElementById('output');
if ((Math.abs(latitud)>13 && Math.abs(latitud)<34) || (Math.abs(longitud)>84 && Math.abs(longitud)<120)){
    element.innerHTML = 'DEC';
    lat_dec=parseFloat(latitud);
    lon_dec=parseFloat(longitud);
    if (lon_dec>0){
        lon_dec=lon_dec*-1;
    }
}else if ((Math.abs(latitud)>140000 && Math.abs(latitud)<330000 && Math.abs(longitud)>860000 && Math.abs(longitud)<1190000)){
    element.innerHTML = 'GEO';
    longitud=longitud.replace("-","");
    var lat_dec=parseInt(latitud.substr(0,2),10)+parseInt(latitud.substr(2,2),10)/60+parseFloat(latitud.substr(4,latitud.length),10)/3600;
    var lon_dec=(parseInt(longitud.substr(0,3),10)+parseInt(longitud.substr(3,2),10)/60+parseFloat(longitud.substr(5,longitud.length),10)/3600)*(-1);
}else{
//}else if ((Math.abs(latitud)>318947 && Math.abs(latitud)<2348068 && Math.abs(longitud)>907961 && Math.abs(longitud)<4077189)){
        element.innerHTML = 'CCL';
        lat_dec=parseFloat(latitud);
        lon_dec=parseFloat(longitud);
        geometry1 = new OpenLayers.Geometry.Point(lon_dec, lat_dec);
        geometry1.transform(
            new OpenLayers.Projection('EPSG:32800'),
            new OpenLayers.Projection('EPSG:4326')
        );
        lon_dec=geometry1.x;
        lat_dec=geometry1.y;
}
if (parseInt(Math.abs(lat_dec),10)>parseInt(33,10) || parseInt(Math.abs(lat_dec),10)<parseInt(13,10)){
    alertmsg ("Latitud fuera de rango");
    document.busqueda.longitud.value=inputValue;
    return false;
}else{
    if (parseInt(Math.abs(lon_dec),10)>parseInt(120,10) || parseInt(Math.abs(lon_dec),10)<parseInt(84,10)){
        alertmsg ("Longitud fuera de rango");
        document.busqueda.longitud.value=inputValue;

        return false;
    }
}

geometry = new OpenLayers.Geometry.Point(lon_dec, lat_dec);
    //alert (geometry.getBounds());
    geometry.transform(                                               //solo si es 38200 la projeccion del mapa
        new OpenLayers.Projection('EPSG:4326'),
        new OpenLayers.Projection('EPSG:900913')
    );

      // alert (geometry.getBounds());
    var feature = new OpenLayers.Feature.Vector(geometry, {}, {
        strokeColor: '#000000',
        strokeOpacity: 1,
        strokeWidth: 1,
        fillColor: '#'+document.getElementById('colorin').value,
        fillOpacity: 0.5,
        pointRadius: 7,
        graphicName: 'star'
    });
    puntogen.addFeatures([feature]);
    s0=geometry.x-(oper);    //ccl o mercator
    s1=geometry.y-(oper);
    s2=geometry.x+(oper);
    s3=geometry.y+(oper);
    bounds = new OpenLayers.Bounds(s0,s1,s2,s3);
    map.zoomToExtent(bounds);

        document.busqueda.longitud.value=inputValue;

}





//FUNCION PARA VER LOS MAPAS TEMATICOS// ****************************************************************************************************************
function vertema(num,filtertema){
            var tban=0;
        if (map.getLayersByName("TEMATICO")!=""){
            map.removeLayer(capatema);
        }
        for (i=0;i<map.controls.length;i++){
            if (inArray(map.controls[i].title,vectema)){
                map.controls[i].deactivate();
            }
            if (map.controls[i].title==('te1'+filtertema) && num==1){
                map.controls[i].activate();
                tban=1;
            }else if (map.controls[i].title==('te2') && num==2){
                map.controls[i].activate();
                tban=1;
            }else if (map.controls[i].title==('te3') && num==3){
                map.controls[i].activate();
                tban=1;
            }
        }
        switch (num){
        case 1:
            filban="ano='"+filtertema+"'";
            capatema= new OpenLayers.Layer.WMS( "TEMATICO",
                                "http://"+hostnew+"/geoserver/INEGI/wms", {layers: 'INEGI:a_tematico1',transparent: true,CQL_FILTER: filban},{visibility: true,singleTile: true});
            capatema.displayInLayerSwitcher= false
            map.addLayer(capatema);
            if (tban==0){
                string = "var te1"+filtertema+" = new OpenLayers.Control.WMSGetFeatureInfo({\n\r";
                string +="   title: 'te1"+filtertema+"', url: 'http://"+hostnew+"/geoserver/INEGI/wms',layers: [capatema],\n\r";
                string +="   vendorParams:{ CQL_FILTER: \""+filban+"\"},\n\r";
                string +="   queryVisible: true,eventListeners: { getfeatureinfo: function(event){map.addPopup(\n\r";
                string +="   new OpenLayers.Popup.FramedCloud('chicken',map.getLonLatFromPixel(event.xy),null,event.text,null,true));}}});";
                eval(string);
                eval("map.addControl(te1"+filtertema+");");
                eval("te1"+filtertema+".activate();");
                vectema[vectema.length] = "te1"+filtertema;
            }
            break;
        case 2:
            capatema= new OpenLayers.Layer.WMS( "TEMATICO",
                                "http://"+hostnew+"/geoserver/INEGI/wms", {layers: 'INEGI:a_tematico2',transparent: true},{visibility: true,singleTile: true});
            capatema.displayInLayerSwitcher= false
            map.addLayer(capatema);
             if (tban==0){
                string = "var te2 = new OpenLayers.Control.WMSGetFeatureInfo({\n\r";
                string +="   title: 'te2', url: 'http://"+hostnew+"/geoserver/INEGI/wms',layers: [capatema],\n\r";
                //string +="   vendorParams:{ CQL_FILTER: \""+filban+"\"},\n\r";
                string +="   queryVisible: true,eventListeners: { getfeatureinfo: function(event){map.addPopup(\n\r";
                string +="   new OpenLayers.Popup.FramedCloud('chicken',map.getLonLatFromPixel(event.xy),null,event.text,null,true));}}});";
                eval(string);
                eval("map.addControl(te2);");
                eval("te2.activate();");
                vectema[vectema.length] = "te2";
            }
            break;
        case 3:
            capatema= new OpenLayers.Layer.WMS( "TEMATICO",
                                "http://"+hostnew+"/geoserver/INEGI/wms", {layers: 'INEGI:cat_zm',transparent: true},{visibility: true,singleTile: true});
            capatema.displayInLayerSwitcher= false
            map.addLayer(capatema);
             if (tban==0){
                string = "var te3 = new OpenLayers.Control.WMSGetFeatureInfo({\n\r";
                string +="   title: 'te3', url: 'http://"+hostnew+"/geoserver/INEGI/wms',layers: [capatema],\n\r";
                //string +="   vendorParams:{ CQL_FILTER: \""+filban+"\"},\n\r";
                string +="   queryVisible: true,eventListeners: { getfeatureinfo: function(event){map.addPopup(\n\r";
                string +="   new OpenLayers.Popup.FramedCloud('chicken',map.getLonLatFromPixel(event.xy),null,event.text,null,true));}}});";
                eval(string);
                eval("map.addControl(te3);");
                eval("te3.activate();");
                vectema[vectema.length] = "te3";
            }
            break;
        }
}


// FUNCION QUE CAMBIA LA VISIBILIDAD DE LAS CAPAS BASE, ESTA LA LLAMA EL SCRIPT DE LA VENTANA DE CAPAS// ****************************************************************************************************************

function changeFeatureVisibility(num,capa,flag,tipo){
    //alert (capa);

    if (tipo==1){
        eval (capa+'.setVisibility('+flag+');');
        if (flag){
            capasel[num-1]=1;
        }else{
            capasel[num-1]=0;
        }
    }else if (tipo==2){
        eval (capa+'.setVisibility('+flag+');');
        if (flag){
            textsel[num-1]=1;
        }else{
            textsel[num-1]=0;
        }
    }else{
        eval ('map.setBaseLayer('+capa+');');
        if (capa=='fondo'){
            fondo.opacity=0.3;
        }else{
            if (capa=='gooimg'){
                gooimg.setOpacity(1);
            }else{
                eval (capa+'.opacity=1;');
                if (capa=='spot6'){
                    spot6a.opacity=1;
                }
            }
        }
        basesel=capa;
    }

}


var alertrec;
//FUNCION QUE PONE EL ALERTA Y LO QUITA EN 10 SEGUNDOS// ****************************************************************************************************************
function alertmsg(msg){
    clearTimeout(alertrec);
    document.getElementById('textomsg').innerHTML = "<font class='msg'>::&nbsp;&nbsp;"+msg+"&nbsp;&nbsp;::</font>";
    alertrec = setTimeout(function(){ document.getElementById('textomsg').innerHTML = "" }, 10000);
    return alertrec;
}



//FUNCION PARA LA GEBNERACION DEL AXAJ// ****************************************************************************************************************
function nuevoAjax()
{
    /* Crea el objeto AJAX. Esta funcion es generica para cualquier utilidad de este tipo, por
    lo que se puede copiar tal como esta aqui */
    var xmlhttp=false;
    try {
        // Creacion del objeto AJAX para navegadores no IE
        xmlhttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch(e){
        try {
            // Creacion del objet AJAX para IE
            xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
        }catch(E){
            if (!xmlhttp && typeof XMLHttpRequest!=undefined) xmlhttp=new XMLHttpRequest();
        }
    }return xmlhttp;
}



//FUNCIONES QUE ABREL VENTANAS// ****************************************************************************************************************
function tel(pass,ent,regid){
ventana = window.open('tel.jsp?loc=&pass='+pass,'TEL','toolbar=no,Resizable=1,scrollbars=1');
ventana.focus();
}
function tem(pass,ent,regid){
ventana = window.open('tem.jsp?loc=&pass='+pass,'TEM','toolbar=no,Resizable=1,scrollbars=1');
ventana.focus();
}

function temf(pass,ent,regid){
ventana = window.open('temf.jsp?loc=&pass='+pass,'TEMF','toolbar=no,Resizable=1,scrollbars=1');
ventana.focus();
}


function temj(pass,ent,regid){
ventana = window.open('temj.jsp?loc=&pass='+pass,'TEMJ','toolbar=no,Resizable=1,scrollbars=1');
ventana.focus();
}


function modulocc(pass,ent,regid){
ventana = window.open('modcar.jsp?loc=&pass='+pass,'MCC','toolbar=no,Resizable=1,scrollbars=1');
ventana.focus();
}

function moduloccCUR(pass,ent,regid){
ventana = window.open('modcar_acu.jsp?loc=&pass='+pass,'ACU','toolbar=no,Resizable=1,scrollbars=1');
ventana.focus();

}

/*  //deshabilito el boton de la herramienta y dejo solo el boton de index
function trbutmodcar(){
ventana = window.open('modcar_acu.jsp?loc=&tipo=&ban=&pass='+pass,'Modulo','scrollbars=yes,toolbar=no,resizable=yes');
ventana.focus();
}
*/


function moduloni(pass,ent,regid){
// esto es lo del ACTUALIZACIONES TERRESNOS
//ventana = window.open('modcar_acu.jsp?loc=&pass='+pass,'MCC','toolbar=no,Resizable=1,scrollbars=1');
// esto es lo del MCC
ventana = window.open('modcar_ni.jsp?loc=&pass='+pass,'TERRENOS','toolbar=no,Resizable=1,scrollbars=1');
ventana.focus();
}


function modpre(pass,ent,regid){
ventana = window.open('modpre.jsp?loc=&pass='+pass,'PRE','toolbar=no,Resizable=1,scrollbars=1');
ventana.focus();
}

function modaupr(pass,ent,regid){
ventana = window.open('modaupr.jsp?loc=&pass='+pass,'AU/PR/PE','toolbar=no,Resizable=1,scrollbars=1');
ventana.focus();
}


function acca22(pass,ent,regid){
ventana = window.open('ac-eic25.jsp?loc=&pass='+pass,'ac-eic25','toolbar=no,Resizable=1,scrollbars=1');
ventana.focus();
}

function modtefr(pass,ent,regid){
ventana = window.open('modtefr.jsp?loc=&pass='+pass,'TE/FR','toolbar=no,Resizable=1,scrollbars=1');
ventana.focus();
}

function tema(){
ventana = window.open('mapate.jsp','MAPATE','toolbar=no,Resizable=1,scrollbars=1');
ventana.focus();
}
function trbutcapas(){
//ventana = window.open('capas.html','capas','scrollbars=yes,toolbar=no,resizable=yes');
document.getElementById('ventana-flotante').className = 'mostrar';
tamanoVentana();
//ventana.focus();
}
function trbutmanual(){
//ventana = window.open('manual_mapa.pdf','manual','scrollbars=yes,toolbar=no,resizable=yes');
ventana = window.open('vermanuales.jsp','manual','scrollbars=yes,toolbar=no,resizable=yes');
ventana.focus();
}

function trbutshape(){
ventana = window.open('vershape.jsp','shape','scrollbars=yes,toolbar=no,resizable=yes');
ventana.focus();
}

function trbutqr(){
    var center = map.getCenter().transform("EPSG:900913", "EPSG:4326");
    document.getElementById('framecapas_qr').src = "mostrar_qr.jsp?&lat="+center.lat+"&lon="+center.lon+"&zoom="+(map.getZoom()+4);
    document.getElementById('ventana-flotante_qr').className = 'mostrar_qr';
    setTimeout(function(){
                        document.getElementById('ventana-flotante_qr').className = 'oculto_qr';
                    }, 25000);
}


function descargar(){
ventana = window.open('descarga.jsp','Descargar','toolbar=no,Resizable=1,scrollbars=1');
ventana.focus();
}

function anotaciones(){
ventana = window.open('anotaciones.jsp?&pass='+pass,'Anotaciones','toolbar=no,Resizable=1,scrollbars=1');
ventana.focus();
}


function verservers(){
ventana = window.open('verservers.jsp','Servers','toolbar=no,Resizable=1,scrollbars=1');
ventana.focus();
}


function verchgpass(){
ventana = window.open('zedit-passSigma.jsp?nom='+nomuser,'Servers','toolbar=no,Resizable=1,scrollbars=1');
ventana.focus();
}


//BUSCA INFORMACION DE 1 ARRAY// ****************************************************************************************************************
function inArray(a_var, a_vec) {
    var length = a_vec.length;
    for(var i = 0; i < length; i++){
        if(a_vec[i] == a_var) return true;
    }
    return false;
}

//FUNCION PARA TRANSFORMAR LO GRADOS// ****************************************************************************************************************
var transformToDegrees = function(base){
        var t, t2;
        var prefix = '';
        if(base <0){
            //prefix='-';
        }
        base = Math.abs(base);
        var degrees = Math.floor(base);
        var minutes = Math.floor(t = ( base - degrees ) * 60);
        var seconds = Math.floor(t2 = ( t - minutes ) * 60000);  //el 60000 es para el redondeo
        seconds = seconds / 1000;
        return ("" + prefix+  degrees + "\u00B0 " + minutes + "\u0027 " +seconds +"\u0022 " );
    };


//FUNCION PARA TRASFORMAR A GGMMSSS// ****************************************************************************************************************
function togms(base,tipo){
        var t, t2;
        var prefix = '';
        if(base <0){
            //prefix='-';
        }
        base = Math.abs(base);
        var degrees = Math.floor(base);
        var minutes = Math.floor(t = ( base - degrees ) * 60);
        var seconds = Math.floor(t2 = ( t - minutes ) * 60000);  //el 60000 es para el redondeo
        seconds = seconds / 1000;
        if (tipo=='x'){
            ag = (degrees.toString().length < 3) ? pad("0"+degrees, 3):degrees;
        }else{
            ag = (degrees.toString().length < 2) ? pad("0"+degrees, 2):degrees;
        }
            am = (minutes.toString().length < 2) ? pad("0"+minutes, 2):minutes;
            as = String(seconds).split(".");
            as0 = (as[0].toString().length < 2) ? pad("0"+as[0], 2):as[0];
            if (as[1].length=='0'){
                as1=as[1]+'000';
            }else if (as[1].length=='1'){
                as1=as[1]+'00';
            }else if (as[1].length=='2'){
                as1=as[1]+'0';
            }else{
                as1=as[1];
            }
            return (String(ag) + String(am) + String(as0) + '.' + String(as1));
};

//FUNCION PARA HACER UN PAD A LA IZQUERDA// ****************************************************************************************************************
function pad(value, length) {
    return (value.toString().length < length) ? pad("0"+value, length):value;
}

function datonumat(e){
  var bn=navigator.appName;
  key = (document.all) ? e.keyCode : e.which;
  if (key==8) return true;
      if (key < 48 || key > 57) {
        if (bn=="Microsoft Internet Explorer"){
            window.event.keyCode=0;
        }
     return false;
 }
}




// FUNCION QUE REVISA EL DATO NUMERICO // ****************************************************************************************************************
function datonumatageb(e){
  var element=e.target;
  var pos=element.value.length;
  var bn=navigator.appName;
  var p=0
if (pos==4){
    p=65;
}
  key = (document.all) ? e.keyCode : e.which;
  if (key==97)key=65;
if (key==8 || key==9 || key==0 || key==127 || key==p || key==13) return true;
    if (key < 48 || key > 57) {
        if (bn=="Microsoft Internet Explorer"){
            window.event.keyCode=0;
        }
     return false;
 }

}


// FUNCION QUE REVISA EL DATO NUMERICO // ****************************************************************************************************************
function datonumatageb2(e){
  var element=e.target;
  var pos=element.value.length;
    if (pos==3){
        element.value=element.value+"-";
   }
}

//FUNCIONES QUE CAMBIAN EL COLOR Y TRANSPARENCIA DE LA CAPA WFS
function cambiaOpac(){
    if (styles!=undefined){
        styles.styles.default.rules[1].symbolizer.Polygon.fillOpacity=document.getElementById('opac').value;
        styles.styles.default.rules[1].symbolizer.Polygon.strokeOpacity=parseFloat(document.getElementById('opac').value)+0.5;
        //styles.styles.default.rules[1].symbolizer.Polygon.fontOpacity=parseFloat(document.getElementById('opac').value)+0.5;
        styles.styles.default.rules[1].symbolizer.Line.strokeOpacity=parseFloat(document.getElementById('opac').value)+0.5;

        stylespre.styles.default.rules[1].symbolizer.Polygon.fillOpacity=document.getElementById('opac').value;
        stylespre.styles.default.rules[1].symbolizer.Polygon.strokeOpacity=parseFloat(document.getElementById('opac').value)+0.5;
        stylespre.styles.default.rules[1].symbolizer.Point.fillOpacity=document.getElementById('opac').value;
        stylespre.styles.default.rules[1].symbolizer.Point.strokeOpacity=parseFloat(document.getElementById('opac').value)+0.5;
        //stylespre.styles.default.rules[1].symbolizer.Polygon.fontOpacity=parseFloat(document.getElementById('opac').value)+0.5;
        stylespre.styles.default.rules[1].symbolizer.Line.strokeOpacity=parseFloat(document.getElementById('opac').value)+0.5;


        stylespr.styles.default.rules[1].symbolizer.Polygon.fillOpacity=document.getElementById('opac').value;
        stylespr.styles.default.rules[1].symbolizer.Polygon.strokeOpacity=parseFloat(document.getElementById('opac').value)+0.5;
        //stylespr.styles.default.rules[1].symbolizer.Polygon.fontOpacity=parseFloat(document.getElementById('opac').value)+0.5;

        stylesau.styles.default.rules[1].symbolizer.Polygon.fillOpacity=document.getElementById('opac').value;
        stylesau.styles.default.rules[1].symbolizer.Polygon.strokeOpacity=parseFloat(document.getElementById('opac').value)+0.5;
        //stylesau.styles.default.rules[1].symbolizer.Polygon.fontOpacity=parseFloat(document.getElementById('opac').value)+0.5;

        stylescd.styles.default.rules[1].symbolizer.Point.fillOpacity=document.getElementById('opac').value;
        stylescd.styles.default.rules[1].symbolizer.Point.strokeOpacity=parseFloat(document.getElementById('opac').value)+0.5;

        stylescdpol.styles.default.rules[1].symbolizer.Polygon.fillOpacity=document.getElementById('opac').value;
        stylescdpol.styles.default.rules[1].symbolizer.Polygon.strokeOpacity=parseFloat(document.getElementById('opac').value)+0.5;

        if (wfs!=undefined){
            wfs.redraw(true);
        }
         if (wfs_punto!=undefined){
            wfs_punto.redraw(true);
        }
         if (wfs_pe!=undefined){
            wfs_pe.redraw(true);
        }
    }
}



function cambiaColor(){  //este lo llama jscolor.js dentro de la carpeta jscolor LINEA 469
    if (styles!=undefined){
        styles.styles.default.rules[1].symbolizer.Polygon.fillColor='#'+document.getElementById('colorin').value;
        styles.styles.default.rules[1].symbolizer.Polygon.strokeColor='#'+document.getElementById('colorin').value;
        //styles.styles.default.rules[1].symbolizer.Polygon.fontColor='#'+document.getElementById('colorin').value;
        styles.styles.default.rules[1].symbolizer.Line.strokeColor='#'+document.getElementById('colorin').value;

        stylespre.styles.default.rules[1].symbolizer.Polygon.fillColor='#'+document.getElementById('colorin').value;
        stylespre.styles.default.rules[1].symbolizer.Polygon.strokeColor='#'+document.getElementById('colorin').value;
        stylespre.styles.default.rules[1].symbolizer.Point.fillColor='#'+document.getElementById('colorin').value;
        stylespre.styles.default.rules[1].symbolizer.Point.strokeColor='#'+document.getElementById('colorin').value;
        //stylespre.styles.default.rules[1].symbolizer.Polygon.fontColor='#'+document.getElementById('colorin').value;
        stylespre.styles.default.rules[1].symbolizer.Line.strokeColor='#'+document.getElementById('colorin').value;


        stylespr.styles.default.rules[1].symbolizer.Polygon.fillColor='#'+document.getElementById('colorin').value;
        stylespr.styles.default.rules[1].symbolizer.Polygon.strokeColor='#'+document.getElementById('colorin').value;
        //stylespr.styles.default.rules[1].symbolizer.Polygon.fontColor='#'+document.getElementById('colorin').value;

        stylesau.styles.default.rules[1].symbolizer.Polygon.fillColor='#'+document.getElementById('colorin').value;
        stylesau.styles.default.rules[1].symbolizer.Polygon.strokeColor='#'+document.getElementById('colorin').value;
        //stylesau.styles.default.rules[1].symbolizer.Polygon.fontColor='#'+document.getElementById('colorin').value;

        stylescd.styles.default.rules[1].symbolizer.Point.fillColor='#'+document.getElementById('colorin').value;

        stylescdpol.styles.default.rules[1].symbolizer.Polygon.fillColor='#'+document.getElementById('colorin').value;
        stylescdpol.styles.default.rules[1].symbolizer.Polygon.strokeColor='#'+document.getElementById('colorin').value;

        //stylescd.styles.default.rules[1].symbolizer.Point.strokeColor='#'+document.getElementById('colorin').value;
        //stylesau.styles.default.rules[1].symbolizer.Polygon.fontColor='#'+document.getElementById('colorin').value;


        if (wfs!=undefined){
            wfs.redraw(true);
        }
        if (wfs_cdpol!=undefined){
            wfs_cdpol.redraw(true);
        }
        if (wfs_punto!=undefined){
            wfs_punto.redraw(true);
        }
         if (wfs_pe!=undefined){
            wfs_pe.redraw(true);
        }
    }
}



function addBookmarks(xx,yy){
    //eval ('var desc = document.getElementById("descripcionbookmark").value;');
    var desc = document.getElementById('descripcionbookmark').value;
    desc=desc.replace("'", "");
    desc=desc.replace('"', '');
    desc=desc.replace('\\', '');
    desc=desc.replace('', '');
    desc=desc.substring(0,255);
    if (desc.trim().length==0 || desc==''){
        alertmsg("Anotacion vacia");
    }else{
        var ajax=nuevoAjax();
        ajax.open("GET",'regbookmark.jsp?x='+xx+'&y='+yy+'&ent='+filterid+'&us='+iduser+'&desc='+encodeURIComponent(desc), true);
        ajax.onreadystatechange=function()
        {
            if(ajax.readyState==4)  {
                var val=ajax.responseText;
                if (val=='1'){
                    alertmsg ("No se pudo registrar la anotacion");
                }else{
                    alertmsg("Anotacion agregada");
                }
            }
        }
        ajax.send(null);
    }
    for( var i = 0; i < map.popups.length; ++i ) {
        map.removePopup(map.popups[i]);
    };
    document.getElementById("descripcionbookmark").value="";
}



function crearUnPunto(x,y,proj){
    geometry = new OpenLayers.Geometry.Point(x, y);
    geometry.transform(                                               //solo si es 38200 la projeccion del mapa
        new OpenLayers.Projection('EPSG:'+proj),
        new OpenLayers.Projection('EPSG:3857')
    );

    var feature = new OpenLayers.Feature.Vector(geometry, {}, {
        strokeColor: '#000000',
        strokeOpacity: 1,
        strokeWidth: 1,
        fillColor: '#'+document.getElementById('colorin').value,
        fillOpacity: document.getElementById('opac').value,
        pointRadius: 7,
        graphicName: 'star'
    });
    puntogen.addFeatures([feature]);
    s0=geometry.x-2000;    //ccl o mercator
    s1=geometry.y-2000;
    s2=geometry.x+2000;
    s3=geometry.y+2000;
    bounds = new OpenLayers.Bounds(s0,s1,s2,s3);
    map.zoomToExtent(bounds);
}


function obtener_maximos_au_pr_mz(){
if (max_au==0 || max_pr==0 || max_mz==0 || max_pe==0){
    var ajax=nuevoAjax();
    ajax.open("GET",'obt_maximos.jsp', true);
    ajax.onreadystatechange=function()
    {
        if(ajax.readyState==4)  {
             var val=String(ajax.responseText).trim();
            if (val=='x'){
                alertmsg ("Error al obtener los maximos");
            }else{
                var array=val.split(',');
                max_au=array[0];
                max_pr=array[1];
                max_mz=array[2];
                max_pe=array[3];
            }
        }
    }
    ajax.send(null);
}
}


function desactivar_rueda_raton(){
    map.controls[0].deactivate();
    map.controls[0].zoomWheelEnabled=false;
    map.controls[0].activate();
    //c1.deactivate();
    //c1.zoomWheelEnabled=false;
    //c1.activate();
}
function activar_rueda_raton(){
    map.controls[0].deactivate();
    map.controls[0].zoomWheelEnabled=true;
    map.controls[0].activate();
    //c1.deactivate();
    //c1.zoomWheelEnabled=true;
    //c1.activate();
}

//deteccion de movimiento de ventana
window.onresize = tamanoVentana;

function tamanoVentana(){
//var w = window.innerWidth;
//var h = window.innerHeight;
if ((document.getElementById('map').clientHeight-40)<(capasalto+capasextra)){
    if (document.getElementById("ventana-flotante").style.height==document.getElementById('map').clientHeight-40+"px"){
        document.getElementById("ventana-flotante").style.height = document.getElementById('map').clientHeight-41 + "px";
        document.getElementById("framecapas").style.height = document.getElementById('map').clientHeight-61 + "px";
    }else{
        document.getElementById("ventana-flotante").style.height = document.getElementById('map').clientHeight-40 + "px";
        document.getElementById("framecapas").style.height = document.getElementById('map').clientHeight-60 + "px";
    }
}else{
    if (document.getElementById("ventana-flotante").style.height!=(capasalto+capasextra)){
        document.getElementById("ventana-flotante").style.height = (capasalto+capasextra)+'px';
        document.getElementById("framecapas").style.height = (capasalto+capasextra)+'px';
    }
}
}




function edita_off(val){
    document.getElementById('framecapas').contentWindow.edita_off(val);
}


function min_ventana(lon,lat){
    document.getElementById('framecapas_sv').src = "streetview_dentro.html?lon="+lon+"&lat="+lat;
    document.getElementById('ventana-flotante_sv').className = 'mostrar';
}


function max_ventana(lon,lat){
    document.getElementById('ventana-flotante_sv').className = 'oculto';
    ventana = window.open("streetview.html?lon="+lon+"&lat="+lat,"Street","scrollbars=no,toolbar=no,resizable=no");
    ventana.focus();
}

function max_ventana_inegi(lon,lat){
    document.getElementById('ventana-flotante_inegiv').className = 'oculto';
    ventana = window.open("inegiview.html?lon="+lon+"&lat="+lat,"Inegi","scrollbars=no,toolbar=no,resizable=no");
    ventana.focus();
}

function min_ventana_inegi(lon,lat){
    document.getElementById('framecapas_inegiv').src = "inegiview_dentro.html?lon="+lon+"&lat="+lat;
    document.getElementById('ventana-flotante_inegiv').className = 'mostrar';
}

function seguireg2(val){
    var geom=featureg.geometry.toString();
    tiporeg=val;
    switch (val){
        case 1:
                document.getElementById('rad1').disabled = true;
                document.getElementById('rad2').disabled = true;
                document.getElementById('rad3').disabled = true;
                document.getElementById('rad4').disabled = false;
                break;
        case 2:
                document.getElementById('rad1').disabled = false;
                document.getElementById('rad2').disabled = false;
                document.getElementById('rad3').disabled = false;
                document.getElementById('rad4').disabled = false;
                break;
        case 3:
                var ajax=nuevoAjax();
                //val = 3 , poligonos acu, 
                ajax.open("GET",'registra_np.jsp?tipo=1&us='+iduser+'&img='+baseimg+'&val='+val+'&geom='+geom, true);
                ajax.onreadystatechange=function()
                {
                    if(ajax.readyState==4)  {
                        var val=ajax.responseText;
                        if (val==1){
                            alertmsg ("No se pudo registrar");
                        }else{
                            alertmsg("Registrado");
                            if (mza_acu.getVisibility()){mza_acu.redraw(true);}
                            map.removePopup(featureg.popup);
                        }
                            for (var i = map.popups.length - 1; i >= 0; i--) {
                                map.removePopup(map.popups[i]);
                            }
                    }
                }
                ajax.send(null);
                break;
         case 4:
                var ajax=nuevoAjax();
                ///val = 4 , loc rur  acu, 
                ajax.open("GET",'registra_np.jsp?tipo=2&us='+iduser+'&img='+baseimg+'&val='+val+'&geom='+geom, true);
                ajax.onreadystatechange=function()
                {
                    if(ajax.readyState==4)  {
                        var val=ajax.responseText;
                        if (val==1){
                            alertmsg ("No se pudo registrar");
                        }else{
                            alertmsg("Registrado");
                            if (mza_acu.getVisibility()){mza_acu.redraw(true);}
                            map.removePopup(featureg.popup);
                        }
                            for (var i = map.popups.length - 1; i >= 0; i--) {
                                map.removePopup(map.popups[i]);
                            }
                    }
                }
                ajax.send(null);
                break;
         case 5:
                var ajax=nuevoAjax();
                ///val = 5 , mza_predig 
                ajax.open("GET",'registra_np.jsp?tipo=3&us='+iduser+'&img='+baseimg+'&val='+val+'&geom='+geom, true);
                ajax.onreadystatechange=function()
                {
                    if(ajax.readyState==4)  {
                        var val=ajax.responseText;
                        if (val==1){
                            alertmsg ("No se pudo registrar");
                        }else{
                            alertmsg("Registrado");
                            if (predig.getVisibility()){predig.redraw(true);}
                            map.removePopup(featureg.popup);
                        }
                            for (var i = map.popups.length - 1; i >= 0; i--) {
                                map.removePopup(map.popups[i]);
                            }
                    }
                }
                ajax.send(null);
                break;
    }
}

function seguireg(val){
    var geom=featureg.geometry.toString();
    if (tiporeg==0){
                alertmsg ("Debe seleccionar el tipo de manzana");
                document.getElementById('rad1').checked = false;
                document.getElementById('rad2').checked = false;
                document.getElementById('rad3').checked = false;
                document.getElementById('rad4').checked = false;
                return false;
            }
    if (tiporeg==1 && predig.getVisibility()==false){
        alertmsg ("No tiene activa la capa de Mz Pre-Dig");
         document.getElementById('rad1').checked = false;
         document.getElementById('rad2').checked = false;
         document.getElementById('rad3').checked = false;
         document.getElementById('rad4').checked = false;
        return false;
    }
    if (tiporeg==2 && mza_acu.getVisibility()==false){    //esta es para la CU
        alertmsg ("No tiene activa la capa de CUR-Informacion");
        document.getElementById('rad1').checked = false;
        document.getElementById('rad2').checked = false;
        document.getElementById('rad3').checked = false;
        document.getElementById('rad4').checked = false;
        return false;
    }
            var ajax=nuevoAjax();

            ajax.open("GET",'registra_mz.jsp?tipo='+tiporeg+'&us='+iduser+'&img='+baseimg+'&val='+val+'&geom='+geom, true);
            ajax.onreadystatechange=function()
            {
                if(ajax.readyState==4)  {
                    var val=ajax.responseText;
                    if (val==1){
                        alertmsg ("No se pudo registrar");
                        document.getElementById('rad1').checked = false;
                        document.getElementById('rad2').checked = false;
                        document.getElementById('rad3').checked = false;
                    }else{
                        alertmsg("Registrado");
                        if (tiporeg==1){
                            if (predig.getVisibility()){predig.redraw(true);}
                        }else{
                            if (mza_acu.getVisibility()){mza_acu.redraw(true);}
                        }
                        map.removePopup(featureg.popup);
                    }
                               for (var i = map.popups.length - 1; i >= 0; i--) {
                            map.removePopup(map.popups[i]);
                            }
                }
            }
            ajax.send(null);
        }


/*function seguireinv(){
            var val=document.getElementById('numerodeviviendas').value;
            var valfte='G';
            if (document.getElementById('numvivfte2').checked == true){
                valfte='C';
            }
            var geom=featureg.geometry.toString();
            var ajax=nuevoAjax();
            var mapext=map.getExtent();
            var vis=0;
            if (mza_inv.getVisibility() && predig.getVisibility()){
                vis=1;
            }else if (mza_inv.getVisibility()==false && predig.getVisibility()){
                vis=2
            }else if (mza_inv.getVisibility() && predig.getVisibility()==false){
                vis=3;
            }
            ajax.open("GET",'registra_invmz.jsp?tipo='+vis+'&valfte='+valfte+'&val='+val+'&us='+iduser+'&img='+baseimg+'&geom='+geom+'&mapext='+mapext, true);
            ajax.onreadystatechange=function()
            {
                if(ajax.readyState==4)  {
                    var val=ajax.responseText.trim();;
                    if (val==1){
                        alertmsg ("No se pudo registrar");
                    }else{
                        if (mza_inv.getVisibility()){mza_inv.redraw(true);}
                        if (predig.getVisibility()){predig.redraw(true);}
                            map.removePopup(featureg.popup);
                         alertmsg ("Registrado");
                    }
                }
            }
            ajax.send(null);
        }*/

function seguireinvpre(id,tipo){
    //1 manzan
    //2 PE
    //tipo 3 = mz 800
        if (tipo==1){
            var feature = wfs.getFeatureBy('id', id);
            if  (document.getElementById('radmcur0').checked == false && document.getElementById('radmcur1').checked == false){
                    alertmsg ("Debe seleccionar el criterio de la manzana");
                    return false;
            }else{
                if (document.getElementById('radmcur0').checked == true){  //mz MG
                    feature.attributes.cur=document.getElementById('radmcur0').value;
                }else{  //mz CUR
                   feature.attributes.cur=document.getElementById('radmcur1').value;
                }
            }
        }else if (tipo==3){
            var feature = wfs.getFeatureBy('id', id);
            feature.attributes.baja=800;
        }else{   //PE
            var feature = wfs_pe.getFeatureBy('id', id);
        }
            var val=document.getElementById('numerodeviviendaspre').value;
            feature.attributes.conviv=val;
            map.removePopup(feature.popup);
           for (var i = map.popups.length - 1; i >= 0; i--) {
              map.removePopup(map.popups[i]);
    }
}





//arreglar error en CHROME
const eventListenerOptionsSupported = () => {
  let supported = false;

  try {
    const opts = Object.defineProperty({}, 'passive', {
      get() {
        supported = true;
      }
    });

    window.addEventListener('test', null, opts);
    window.removeEventListener('test', null, opts);
  } catch (e) {}

  return supported;
}

const defaultOptions = {
  passive: false,
  capture: false
};
const supportedPassiveTypes = [
  'scroll', 'wheel',
  'touchstart', 'touchmove', 'touchenter', 'touchend', 'touchleave',
  'mouseout', 'mouseleave', 'mouseup', 'mousedown', 'mousemove', 'mouseenter', 'mousewheel', 'mouseover'
];
const getDefaultPassiveOption = (passive, eventName) => {
  if (passive !== undefined) return passive;

  return supportedPassiveTypes.indexOf(eventName) === -1 ? false : defaultOptions.passive;
};

const getWritableOptions = (options) => {
  const passiveDescriptor = Object.getOwnPropertyDescriptor(options, 'passive');

  return passiveDescriptor && passiveDescriptor.writable !== true && passiveDescriptor.set === undefined
    ? Object.assign({}, options)
    : options;
};

const overwriteAddEvent = (superMethod) => {
  EventTarget.prototype.addEventListener = function (type, listener, options) {
    const usesListenerOptions = typeof options === 'object' && options !== null;
    const useCapture          = usesListenerOptions ? options.capture : options;

    options         = usesListenerOptions ? getWritableOptions(options) : {};
    options.passive = getDefaultPassiveOption(options.passive, type);
    options.capture = useCapture === undefined ? defaultOptions.capture : useCapture;

    superMethod.call(this, type, listener, options);
  };

  EventTarget.prototype.addEventListener._original = superMethod;
};

const supportsPassive = eventListenerOptionsSupported();

if (supportsPassive) {
  const addEvent = EventTarget.prototype.addEventListener;
  overwriteAddEvent(addEvent);
}


///relaciona localidad a manzana, caserio u otra localidad
function regaddrelloc(gid,tipo){
    addsap.deactivate();
    addsaptipo=tipo;
    addsapgid=gid;
    addsapclas=3;
    switch (tipo){
        case 1:
        case 11:
            alertmsg("Seleccione la manzana");break;
        case 2:
        case 21:
            alertmsg("Seleccione el caserio");break;
        case 3:
        case 31:
            alertmsg("Seleccione la localidad vigente");break;
        case 8:
        case 81:
            alertmsg("Seleccione la localidad de baja");break;
    }
    panelDig.addControls([regaddsap]);
    regaddsap.activate();

}

function regaddrelmza(gid,figura,tipo){
    butagmz.deactivate();
    addsaptipo=tipo;
    addsapgid=gid;
    addsapclas=1;
    addsapfigura=figura;
    switch (tipo){
        case 1:
            alertmsg("Seleccione la manzana");break;
        case 2:
            alertmsg("Seleccione el caserio");break;
        case 3:
            alertmsg("Seleccione la localidad");break;
        case 4:
            alertmsg("Seleccione la manzana eliminada");break;
    }
    panelDig.addControls([regaddsap]);
    regaddsap.activate();
}

function regaddrelcd(gid,figura,tipo){
    butagmz.deactivate();
    addsaptipo=tipo;
    addsapgid=gid;
    addsapclas=2;
    addsapfigura=figura;
    switch (tipo){
        case 1:
            alertmsg("Seleccione la manzana");break;
        case 2:
            alertmsg("Seleccione el caserio");break;
        case 3:
            alertmsg("Seleccione la localidad");break;
    }
    panelDig.addControls([regaddsap]);
    regaddsap.activate();
}



function changeFeatureVisibilitypunto_ce(num,capa,flag,tipo){
        eval (capa+'.setVisibility('+flag+');');
        if (flag){
            puntosel_ce[num-1]=1;
        }else{
            puntosel_ce[num-1]=0;
        }
}

function cerrarSesion(){
     alertmsg("SESION TERMINADA POR INACTIVDAD, SE REINICIA EL SISTEMA");
     setTimeout(function(){ window.location.href = window.location.href.replace("index.jsp",""); }, 3000);

}



function maxzindex(){
    let all= Array.from(document.querySelectorAll('body *'));
    //console.log(all);
    let allIndexes=all.map((elem)=>{
  if (elem.style) {
    return +elem.style.zIndex || 0;
  }
  return -9999;
  });
  let max=Math.max.apply(null,allIndexes);
return max;
}



