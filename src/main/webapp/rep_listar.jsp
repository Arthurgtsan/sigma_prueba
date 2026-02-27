<%@ page import="java.util.*" session="true" %>
<%@ page import="java.sql.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>
SIGMA
</title>
<style type="text/css">
table {
  border-collapse: collapse;
}
.t{font-size: 12pt; font-family: Arial; font-weight: bold; color: #000000;}
.c{font-family: Arial; font-size: 8pt; line-height: 1.3; font-weight: normal;}
.n{font-family: Arial; font-size: 8pt; line-height: 1.3; font-weight: bold;}
.boton{font-family: Arial; font-size: 10px; line-height: 1; font-weight: normal;}
a.liga1:link { font-size: 9pt; color: black;text-decoration: none;font-family: Arial;}
a.liga1:visited {font-size: 9pt;color: black;text-decoration: none;font-family: Arial;}
a.liga1:hover {font-size: 9pt;color: black;text-decoration: none;font-family: Arial;}
.liga {font-size: 9pt;color: red;text-decoration: none;font-family: Arial;}
a.liga2:link {  text-decoration: none;}
a.liga2:visited { text-decoration: none;}
a.liga2:hover { text-decoration: none;}

</style>
<script language='javascript' src="popcalendar.js"></script>
<script language="javascrpt" type="text/javascript">
window.resizeTo(700,600);

function datonum(e){
  var nfr=document.enviar.filtipofr.value.replace(/^\s+|\s+$/g, '');
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
            if (!xmlhttp && typeof XMLHttpRequest!='undefined') xmlhttp=new XMLHttpRequest();
        }
    }return xmlhttp;
}

function modval(val,id,carta) {
    var ajax=nuevoAjax();
    ajax.open("GET",'modval_rep_c5.jsp?tipo=sup&id='+id+'&val='+val, true);
    ajax.onreadystatechange=function()
    {
        if(ajax.readyState==4)  {
             var vale=ajax.responseText;
            if (vale=='x'){
                alert ("No se pudo modificar la validacion!!");
            }else{
              div="val"+id;
                  if (val==0){
                      tabla = "<img title='"+carta+" - Registro sin validar (Click para validar)' onclick='modval(1,"+id+",\""+carta+"\");' border='0' src=images/sinval.png border=0></img>";
                  }else if (val==1){
                      tabla = "<img title='"+carta+" - Registro validado (Click para retener)' onclick='modval(2,"+id+",\""+carta+"\");' border='0' src=images/val.png border=0></img>";
                  }else{
                      tabla = "<img title='"+carta+" - Registro retenido (Click para invalidar)' onclick='modval(0,"+id+",\""+carta+"\");' border='0' src=images/ret.png border=0></img></div>";
                  }
                document.getElementById(div).innerHTML = tabla;
            }
        }
    }
    ajax.send(null);
}

function observa(gid,tipo,nivel){
ventana = window.open('verobspre.jsp?gid='+gid+'&tipo='+tipo+'&nivel='+nivel,'Observapre','scrollbars=no,toolbar=no');
ventana.focus();
}

function modvalvoc(val,id,carta) {
    var ajax=nuevoAjax();
    ajax.open("GET",'modval_rep_c5.jsp?tipo=voc&id='+id+'&val='+val, true);
    ajax.onreadystatechange=function()
    {
        if(ajax.readyState==4)  {
             var vale=ajax.responseText;
            if (vale=='x'){
                alert ("No se pudo modificar la validacion!!");
            }else{
              div="voc"+id;
                  if (val==0){
                      tabla = "<img title='"+carta+" - Registro sin validar (Click para validar)' onclick='modvalvoc(1,"+id+",\""+carta+"\");' border='0' src=images/sinval.png border=0></img>";
                  }else if (val==1){
                      tabla = "<img title='"+carta+" - Registro validado (Click para retener)' onclick='modvalvoc(2,"+id+",\""+carta+"\");' border='0' src=images/val.png border=0></img>";
                  }else{
                      tabla = "<img title='"+carta+" - Registro retenido (Click para invalidar)' onclick='modvalvoc(0,"+id+",\""+carta+"\");' border='0' src=images/ret.png border=0></img></div>";
                  }
                document.getElementById(div).innerHTML = tabla;
            }
        }
    }
    ajax.send(null);
}

function obt_geom(gid,ban){
    var ajax=nuevoAjax();
    ajax.open("GET",'obtgeo_aupr.jsp?id='+gid+'&ban='+ban, true);
    ajax.onreadystatechange=function()
    {
        if(ajax.readyState==4)  {
             var vale=ajax.responseText;
            if (parseInt(vale)==1){
                alert ("No se pudo obtener las coordenadas!!");
            }else{
                window.opener.buscazoompredig(2,vale);
            }
        }
    }
    ajax.send(null);
}


function envia(n){
  document.enviar.loc.value=document.enviar.loc.value.replace(/ /g, '');
  document.enviar.loc.value=document.enviar.loc.value.replace(/;/g, '');
  document.enviar.loc.value=document.enviar.loc.value.replace(/'/g, '');
  document.enviar.loc.value=document.enviar.loc.value.replace(/\u00a0/g, '');
  document.enviar.loc.value=document.enviar.loc.value.replace(/\t/g,''); 

  if (n==1){
    document.enviar.loc.value='';
    document.enviar.submit();
  }else{
    document.enviar.submit();
  }
}

function enviaedo(n){
  if (document.enviar.filent.value=='00'){
    alert("Seleccione un estado!!");
    return false;
  }
  //document.enviaredo.filedo.value=document.enviar.filent.value;
  //document.enviaredo.submit();
  //document.enviaredo.botonedo.disabled=true;
  ventana = window.open('avance_preedo.jsp?filedo='+document.enviar.filent.value,'Reporte','scrollbars=no,toolbar=no');
  ventana.focus();
}


</script>
  </head>
<body>
  <div align="center" id="pleasewaitScreen" style="position:absolute;visibility:hidden;top:40%;left:40%;">
 <table  bgcolor="#000000" border=1 bordercolor="#000000" cellpadding=0 cellspacing=0 height=100 width=200>
    <tr>
        <td width="100%" height="100%" bgcolor="#e6e6e6" align="center" valign="middle">
            <font FACE="Arial" SIZE=3><b>Procesando, espere...</b></font>
        </td>
      </tr>
    </table>
</div>
<%
int n=0;
int n1=0;
String  ent = "",regid = "",
        loc = request.getParameter("loc"),
        pass = request.getParameter("pass"),
        ban = request.getParameter("ban"),
         consulta = "",
     consultapas = "",
         salida1 = "",
         salida2 = "",
         salida3 = "",
         salida4 = "",
         salida5 = "",
     salida6 = "",
         select="",
         select1="",selectoc="",selectfr="",
         st = "",
         filent="",
         filtipo="",filtipooc="",
         filfe1="",
         filfe2="",
         where="",
         obs="",observa="",lobs="",obs1="";
      consultapas = "select nivel,edicionpre,id,regid,nombre from usuarios where md5(password) = '"+pass+"';";

//declare variables
  int numPages = 0;
  //finish decleration
  String startIndexString = request.getParameter("startIndex");  // get the index pages
  if(startIndexString == null) {
  startIndexString = "0";
  }

  //parse string into integer
  int startIndex = Integer.parseInt(startIndexString);

  //set number of product per page
  int numRecordsPerPage = 100;

  if (loc==null){
    loc="";
  }

HttpSession sesion = request.getSession(true);
if ((sesion != null && !sesion.isNew())) {
        //out.println("LA SESION SIGUE ACTIVA");


String regionalid  = session.getAttribute("regionalid").toString();

try {
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
    rs = str.executeQuery( consultapas );
    rs.next();
    String s1=rs.getObject(1).toString();
      Integer s2=(Integer) rs.getObject(2);

      ent=rs.getObject(3).toString();
    regid=rs.getObject(4).toString();
    String nombre=rs.getObject(5).toString();

//out.println( consultapas );
sesion.setAttribute("script", "aupr");
String cad=regid+"-"+ent+"-"+nombre+ " ("+request.getRemoteAddr()+")";
sesion.setAttribute("userName", cad);


Calendar fecha = Calendar.getInstance();
String m1="",d1="",fec1="",fec2="",filreg="",selreg="";
//out.println("<br>"+fecha.get(Calendar.MONTH));
//out.println("<br>"+fecha.get(Calendar.DATE));
if (fecha.get(Calendar.MONTH)<9)m1="0";   // supongo que el mes empieza por 0
if (fecha.get(Calendar.DATE)<10)d1="0";
fec1=fecha.get(Calendar.YEAR) + "-" + m1 + (fecha.get(Calendar.MONTH)+1) + "-" + d1 + fecha.get(Calendar.DATE);
fec2=fecha.get(Calendar.YEAR) + "-" + m1 + (fecha.get(Calendar.MONTH)+1) + "-" + d1 + fecha.get(Calendar.DATE);
filent = request.getParameter("filent");
filtipo = request.getParameter("filtipo");
filtipooc = request.getParameter("filtipooc");
String filtipofrst  = request.getParameter("filtipofr");
int filtipofr=0;
if (filtipofrst!=null){
 filtipofr  = Integer.parseInt(filtipofrst.trim());
}

filfe1 = request.getParameter("filfe1");
filfe2 = request.getParameter("filfe2");
if (filent==null)filent="00";
if (filtipo==null)filtipo="0";
if (filtipooc==null)filtipooc="0";

if (filfe1==null)filfe1=fec1; //filfe1="2017-01-01";
if (filfe2==null)filfe2=fec2;
if (filtipo.equals("0")){
  select1="";
}else if (filtipo.equals("1")){
  select1=" sup=1 and ";     //validado
}else if (filtipo.equals("2")){
  select1=" sup=2 and ";   //con reporte
}else if (filtipo.equals("3")){
  select1=" sup=0 and ";   //pendiente
}
if (filtipooc.equals("0")){
  selectoc="";
}else if (filtipooc.equals("1")){
  selectoc=" voc=1 and ";     //validado
}else if (filtipooc.equals("2")){
  selectoc=" voc=2 and ";   //con reporte
}else if (filtipooc.equals("3")){
  selectoc=" voc=0 and ";   //pendiente
}
if (filtipofr>0){
  selectfr=" (select count(*) from z_digf_respaldo where st_intersects(the_geom,st_transform(t1.geom,32800)))>="+filtipofr+" and ";   //mayor a cero
}else {
  selectfr="";
}

if ((ent.equals("00"))){
         switch(regionalid){
          case "01":
                filreg = " and cve_ent in ('02','03','25','26')";
                selreg+="<option value='02' ";if (filent.equals("02")){selreg+="selected";}selreg+=">02</option>";
                selreg+="<option value='03' ";if (filent.equals("03")){selreg+="selected";}selreg+=">03</option>";
                selreg+="<option value='25' ";if (filent.equals("25")){selreg+="selected";}selreg+=">25</option>";
                selreg+="<option value='26' ";if (filent.equals("26")){selreg+="selected";}selreg+=">26</option>";
            break;
          case "02":
                filreg = " and cve_ent in ('08','10','32')";
                selreg+="<option value='08' ";if (filent.equals("08")){selreg+="selected";}selreg+=">08</option>";
                selreg+="<option value='10' ";if (filent.equals("10")){selreg+="selected";}selreg+=">10</option>";
                selreg+="<option value='32' ";if (filent.equals("32")){selreg+="selected";}selreg+=">32</option>";
            break;
          case "03":
                filreg = " and cve_ent in ('05','19','28')";
                selreg+="<option value='05' ";if (filent.equals("05")){selreg+="selected";}selreg+=">05</option>";
                selreg+="<option value='19' ";if (filent.equals("19")){selreg+="selected";}selreg+=">19</option>";
                selreg+="<option value='28' ";if (filent.equals("28")){selreg+="selected";}selreg+=">28</option>";
            break;
          case "04":
                filreg = " and cve_ent in ('06','14','16','18')";
                selreg+="<option value='06' ";if (filent.equals("06")){selreg+="selected";}selreg+=">06</option>";
                selreg+="<option value='14' ";if (filent.equals("14")){selreg+="selected";}selreg+=">14</option>";
                selreg+="<option value='16' ";if (filent.equals("16")){selreg+="selected";}selreg+=">16</option>";
                selreg+="<option value='18' ";if (filent.equals("18")){selreg+="selected";}selreg+=">18</option>";
            break;
          case "05":
                filreg = " and cve_ent in ('01','11','22','24')";
                selreg+="<option value='01' ";if (filent.equals("01")){selreg+="selected";}selreg+=">01</option>";
                selreg+="<option value='11' ";if (filent.equals("11")){selreg+="selected";}selreg+=">11</option>";
                selreg+="<option value='22' ";if (filent.equals("22")){selreg+="selected";}selreg+=">22</option>";
                selreg+="<option value='24' ";if (filent.equals("24")){selreg+="selected";}selreg+=">24</option>";
            break;
          case "06":
                filreg = " and cve_ent in ('12','15','17')";
                selreg+="<option value='12' ";if (filent.equals("12")){selreg+="selected";}selreg+=">12</option>";
                selreg+="<option value='15' ";if (filent.equals("15")){selreg+="selected";}selreg+=">15</option>";
                selreg+="<option value='17' ";if (filent.equals("17")){selreg+="selected";}selreg+=">17</option>";
            break;
          case "07":
                filreg = " and cve_ent in ('13','21','29','30')";
                selreg+="<option value='13' ";if (filent.equals("13")){selreg+="selected";}selreg+=">13</option>";
                selreg+="<option value='21' ";if (filent.equals("21")){selreg+="selected";}selreg+=">21</option>";
                selreg+="<option value='29' ";if (filent.equals("29")){selreg+="selected";}selreg+=">29</option>";
                selreg+="<option value='30' ";if (filent.equals("30")){selreg+="selected";}selreg+=">30</option>";
            break;
          case "08":
                filreg = " and cve_ent in ('07','20','27')";
                selreg+="<option value='07' ";if (filent.equals("07")){selreg+="selected";}selreg+=">07</option>";
                selreg+="<option value='20' ";if (filent.equals("20")){selreg+="selected";}selreg+=">20</option>";
                selreg+="<option value='27' ";if (filent.equals("27")){selreg+="selected";}selreg+=">27</option>";
            break;
          case "09":
                filreg = " and cve_ent in ('04','23','31')";
                selreg+="<option value='04' ";if (filent.equals("04")){selreg+="selected";}selreg+=">04</option>";
                selreg+="<option value='23' ";if (filent.equals("23")){selreg+="selected";}selreg+=">23</option>";
                selreg+="<option value='31' ";if (filent.equals("31")){selreg+="selected";}selreg+=">31</option>";
            break;
          case "10":
                filreg = " and cve_ent in ('09')";
                selreg+="<option value='09' ";if (filent.equals("09")){selreg+="selected";}selreg+=">09</option>";
            break;
        }
            if (filent.equals("00")){
          consulta="select gid,cve_ent,carta,sup,fact,(select count(*) from z_digf_respaldo where st_intersects(the_geom,st_transform(t1.geom,32800))) as nf,(select count(*) from z_dige_respaldo where st_intersects(the_geom,st_transform(t1.geom,32800))) as ne,voc,( SELECT correo FROM usuarios WHERE cons = us) AS correo,reobs,ocobs,rev  from a_rep_cardig t1 where "+select1+" "+selectoc+" "+selectfr+" fact between '"+filfe1+"' and '"+ filfe2 +"' "+filreg+" order by cve_ent,carta";
                }else{
          consulta="select gid,cve_ent,carta,sup,fact,(select count(*) from z_digf_respaldo where st_intersects(the_geom,st_transform(t1.geom,32800))) as nf,(select count(*) from z_dige_respaldo where st_intersects(the_geom,st_transform(t1.geom,32800))) as ne,voc,( SELECT correo FROM usuarios WHERE cons = us) AS correo,reobs,ocobs,rev  from a_rep_cardig t1 where "+select1+" "+selectoc+" "+selectfr+" fact between '"+filfe1+"' and '"+ filfe2 +"' and cve_ent = '"+filent+"'"+" order by cve_ent,carta";
                }
                select="<select name=filent class='boton'>";
                select+="<option value='00' ";if (filent.equals("00")){select+="selected";}select+=">TODAS</option>";
                select+=selreg+"</select>";
    }else if (s1.equals("2")){
         switch(ent){
          case "01":
                filreg = " and cve_ent in ('02','03','25','26')";
                selreg+="<option value='02' ";if (filent.equals("02")){selreg+="selected";}selreg+=">02</option>";
                selreg+="<option value='03' ";if (filent.equals("03")){selreg+="selected";}selreg+=">03</option>";
                selreg+="<option value='25' ";if (filent.equals("25")){selreg+="selected";}selreg+=">25</option>";
                selreg+="<option value='26' ";if (filent.equals("26")){selreg+="selected";}selreg+=">26</option>";
            break;
          case "02":
                filreg = " and cve_ent in ('08','10','32')";
                selreg+="<option value='08' ";if (filent.equals("08")){selreg+="selected";}selreg+=">08</option>";
                selreg+="<option value='10' ";if (filent.equals("10")){selreg+="selected";}selreg+=">10</option>";
                selreg+="<option value='32' ";if (filent.equals("32")){selreg+="selected";}selreg+=">32</option>";
            break;
          case "03":
                filreg = " and cve_ent in ('05','19','28')";
                selreg+="<option value='05' ";if (filent.equals("05")){selreg+="selected";}selreg+=">05</option>";
                selreg+="<option value='19' ";if (filent.equals("19")){selreg+="selected";}selreg+=">19</option>";
                selreg+="<option value='28' ";if (filent.equals("28")){selreg+="selected";}selreg+=">28</option>";
            break;
          case "04":
                filreg = " and cve_ent in ('06','14','16','18')";
                selreg+="<option value='06' ";if (filent.equals("06")){selreg+="selected";}selreg+=">06</option>";
                selreg+="<option value='14' ";if (filent.equals("14")){selreg+="selected";}selreg+=">14</option>";
                selreg+="<option value='16' ";if (filent.equals("16")){selreg+="selected";}selreg+=">16</option>";
                selreg+="<option value='18' ";if (filent.equals("18")){selreg+="selected";}selreg+=">18</option>";
            break;
          case "05":
                filreg = " and cve_ent in ('01','11','22','24')";
                selreg+="<option value='01' ";if (filent.equals("01")){selreg+="selected";}selreg+=">01</option>";
                selreg+="<option value='11' ";if (filent.equals("11")){selreg+="selected";}selreg+=">11</option>";
                selreg+="<option value='22' ";if (filent.equals("22")){selreg+="selected";}selreg+=">22</option>";
                selreg+="<option value='24' ";if (filent.equals("24")){selreg+="selected";}selreg+=">24</option>";
            break;
          case "06":
                filreg = " and cve_ent in ('12','15','17')";
                selreg+="<option value='12' ";if (filent.equals("12")){selreg+="selected";}selreg+=">12</option>";
                selreg+="<option value='15' ";if (filent.equals("15")){selreg+="selected";}selreg+=">15</option>";
                selreg+="<option value='17' ";if (filent.equals("17")){selreg+="selected";}selreg+=">17</option>";
            break;
          case "07":
                filreg = " and cve_ent in ('13','21','29','30')";
                selreg+="<option value='13' ";if (filent.equals("13")){selreg+="selected";}selreg+=">13</option>";
                selreg+="<option value='21' ";if (filent.equals("21")){selreg+="selected";}selreg+=">21</option>";
                selreg+="<option value='29' ";if (filent.equals("29")){selreg+="selected";}selreg+=">29</option>";
                selreg+="<option value='30' ";if (filent.equals("30")){selreg+="selected";}selreg+=">30</option>";
            break;
          case "08":
                filreg = " and cve_ent in ('07','20','27')";
                selreg+="<option value='07' ";if (filent.equals("07")){selreg+="selected";}selreg+=">07</option>";
                selreg+="<option value='20' ";if (filent.equals("20")){selreg+="selected";}selreg+=">20</option>";
                selreg+="<option value='27' ";if (filent.equals("27")){selreg+="selected";}selreg+=">27</option>";
            break;
          case "09":
                filreg = " and cve_ent in ('04','23','31')";
                selreg+="<option value='04' ";if (filent.equals("04")){selreg+="selected";}selreg+=">04</option>";
                selreg+="<option value='23' ";if (filent.equals("23")){selreg+="selected";}selreg+=">23</option>";
                selreg+="<option value='31' ";if (filent.equals("31")){selreg+="selected";}selreg+=">31</option>";
            break;
          case "10":
                filreg = " and cve_ent in ('09')";
                selreg+="<option value='09' ";if (filent.equals("09")){selreg+="selected";}selreg+=">09</option>";
            break;
        }
            if (filent.equals("00")){
          consulta="select gid,cve_ent,carta,sup,fact,(select count(*) from z_digf_respaldo where st_intersects(the_geom,st_transform(t1.geom,32800))) as nf,(select count(*) from z_dige_respaldo where st_intersects(the_geom,st_transform(t1.geom,32800))) as ne,voc,( SELECT correo FROM usuarios WHERE cons = us) AS correo,reobs,ocobs,rev  from a_rep_cardig t1 where "+select1+" "+selectoc+" "+selectfr+" fact between '"+filfe1+"' and '"+ filfe2 +"' "+filreg+" order by cve_ent,carta";
                }else{
          consulta="select gid,cve_ent,carta,sup,fact,(select count(*) from z_digf_respaldo where st_intersects(the_geom,st_transform(t1.geom,32800))) as nf,(select count(*) from z_dige_respaldo where st_intersects(the_geom,st_transform(t1.geom,32800))) as ne,voc,( SELECT correo FROM usuarios WHERE cons = us) AS correo,reobs,ocobs,rev  from a_rep_cardig t1 where "+select1+" "+selectoc+" "+selectfr+" fact between '"+filfe1+"' and '"+ filfe2 +"' and cve_ent = '"+filent+"'"+" order by cve_ent,carta";
                }
                select="<select name=filent class='boton'>";
                select+="<option value='00' ";if (filent.equals("00")){select+="selected";}select+=">TODAS</option>";
                select+=selreg+"</select>";
    }else{
    consulta="select gid,cve_ent,carta,sup,fact,(select count(*) from z_digf_respaldo where st_intersects(the_geom,st_transform(t1.geom,32800))) as nf,(select count(*) from z_dige_respaldo where st_intersects(the_geom,st_transform(t1.geom,32800))) as ne,voc,( SELECT correo FROM usuarios WHERE cons = us) AS correo,reobs,ocobs,rev  from a_rep_cardig t1 where "+select1+" "+selectoc+" "+selectfr+" fact between '"+filfe1+"' and '"+ filfe2 +"' and cve_ent = '"+ent+"'"+" order by cve_ent,carta";
    select="<select name=filent class='boton'>";
      select+="<option value='"+ent+"' selected>"+ent+"</option>";
      select+="</select>";
    }
    String filult="";
  if(loc != null && !loc.isEmpty()){
        if (s1.equals("1")){
            filult = " and cve_ent ='"+ent+"'";
       }else if (s1.equals("2")){
            filult=filreg;
        }
    consulta="select gid,cve_ent,carta,sup,fact,(select count(*) from z_digf_respaldo where st_intersects(the_geom,st_transform(t1.geom,32800))) as nf,(select count(*) from z_dige_respaldo where st_intersects(the_geom,st_transform(t1.geom,32800))) as ne,voc,( SELECT correo FROM usuarios WHERE cons = us) AS correo,reobs,ocobs,rev  from a_rep_cardig t1 where carta ilike '" + loc + "%' "+filult+" order by cve_ent,carta";
}


       select1="<select name=filtipo class='boton'>";
       select1+="<option value='0' ";if (filtipo.equals("0")){select1+="selected";}select1+=">TODOS</option>";
       select1+="<option value='1' ";if (filtipo.equals("1")){select1+="selected";}select1+=">VALIDADO</option>";
       select1+="<option value='2' ";if (filtipo.equals("2")){select1+="selected";}select1+=">CON ERROR</option>";
       select1+="<option value='3' ";if (filtipo.equals("3")){select1+="selected";}select1+=">PENDIENTE</option></select>";
       selectoc="<select name=filtipooc class='boton'>";
       selectoc+="<option value='0' ";if (filtipooc.equals("0")){selectoc+="selected";}selectoc+=">TODOS</option>";
       selectoc+="<option value='1' ";if (filtipooc.equals("1")){selectoc+="selected";}selectoc+=">VALIDADO</option>";
       selectoc+="<option value='2' ";if (filtipooc.equals("2")){selectoc+="selected";}selectoc+=">CON ERROR</option>";
       selectoc+="<option value='3' ";if (filtipooc.equals("3")){selectoc+="selected";}selectoc+=">PENDIENTE</option></select>";
       selectfr="<input type=text class='boton' size=4 value="+filtipofr+" name='filtipofr' onKeypress='return datonum(event)'>";
      out.println( "<center class='t'>Reporte y Validacion de predigitalizacion por carta 5,000</center>"
                + "<form action=\"rep_listar.jsp\" method=\"post\" name=\"enviar\">"
                + "<center><br>"
                + "&nbsp;&nbsp;&nbsp;&nbsp;<font class=n>De:</font>&nbsp;<input class='boton' name='filfe1' type='text' id='p1id' onClick=\"popUpCalendar(this, enviar.p1id, 'yyyy-mm-dd');\" size='10' readOnly value='"+filfe1.substring(0,10)+"'>"
                + "&nbsp;&nbsp;&nbsp;&nbsp;<font class=n>a:</font>&nbsp;<input class='boton' name='filfe2' type='text' id='p2id' onClick=\"popUpCalendar(this, enviar.p2id, 'yyyy-mm-dd');\" size='10' readOnly value='"+filfe2.substring(0,10)+"'>"
                + "&nbsp;&nbsp;&nbsp;&nbsp;<font class=n>Entidad:</font>&nbsp;"+select+"<br>"
                + "&nbsp;&nbsp;&nbsp;&nbsp;<font class=n>V-REG:</font>&nbsp;"+select1
                + "&nbsp;&nbsp;&nbsp;&nbsp;<font class=n>V-OC:</font>&nbsp;"+selectoc
                + "&nbsp;&nbsp;&nbsp;&nbsp;<font class=n>#Frts >= a:</font>&nbsp;"+selectfr
                + "<input type='hidden' name='ent' value='"+ent+"'><input type='hidden' name='ban' value='1'><input type='hidden' name='regid' value='"+regid+"'>&nbsp;&nbsp;&nbsp;&nbsp;<input class='boton' type='button' value=' Buscar ' onclick='envia(1)''><br><br><font class=n>Por clave de carta:&nbsp;&nbsp;</font>"
                + "<input type='text' maxlength=22 size=20 name='loc' value='"+loc+"' class='boton'><input type='hidden' name='pass' value='"+pass+"'>&nbsp;&nbsp;&nbsp;&nbsp;<input class='boton' type='button' value=' Buscar ' onclick='envia(2)'></form><br><br>"
                + "<form action=\"avance_preedo.jsp\" method=\"post\" name=\"enviaredo\">&nbsp;&nbsp;&nbsp;&nbsp;<input class='boton' name='botonedo' type='button' value=' Ver totales por estado ' onclick='enviaedo()'><input type='hidden' name='filedo' value=''></form>");
  out.println( "<table border=1><tr class=n bgcolor=#BBBBBB>");
  out.println("<th>&nbsp;&nbsp;Ver&nbsp;&nbsp;<th>&nbsp;&nbsp;Estado&nbsp;&nbsp;<th>&nbsp;&nbsp;Carta&nbsp;&nbsp;<th>&nbsp;&nbsp;Fecha&nbsp;&nbsp;");
  //out.println("<th>&nbsp;&nbsp;# Mzas&nbsp;&nbsp;");
  out.println("<th>&nbsp;&nbsp;# Frts&nbsp;&nbsp;<th>&nbsp;&nbsp;# Ejes&nbsp;&nbsp;");
  out.println("<th>Val<br>&nbsp;Reg&nbsp;<th>Obs<br>&nbsp;Reg&nbsp;");
  out.println("<th>Val<br>&nbsp;OC&nbsp;<th>Obs<br>&nbsp;OC&nbsp;");
  out.println("<th>&nbsp;<img src='images/contacto.png' width='16' height='18' title='Usuario'>&nbsp;");
  out.println("<th title='Numero de revisiones'>&nbsp;Rev&nbsp;");
  //out.println(consulta);
  if (ban!=null){
      rs = str.executeQuery( consulta );
      //paginacion
      //get total rows
      rs.last();
      int totalRows = rs.getRow();
      rs.beforeFirst();
      /*get total number of pages starts here */
      numPages = totalRows /numRecordsPerPage; // get initiate pages without the remind page
      int remain = totalRows % numRecordsPerPage; // check remain records
      if(remain != 0){
        numPages = numPages+ 1;  // if there is remind   1 page.
      }

    consulta  += " limit " + numRecordsPerPage+ " offset "+ startIndex ;
    //out.println( " limit " + numRecordsPerPage+ " offset "+ startIndex );
    rs = str.executeQuery( consulta );
    //out.println(consulta);
    String nom="",correo="";
    while(rs.next()){
    //gid,cve_ent,carta,sup,fact,nm,nf,ne
      String gid=rs.getObject(1).toString();
      String cve_ent=rs.getObject(2).toString();
      String carta=rs.getObject(3).toString();
      int sup=Integer.parseInt(rs.getString(4));
      String fact=rs.getObject(5).toString();
      //int nm=Integer.parseInt(rs.getString(6));
      int nf=Integer.parseInt(rs.getString(6));
      int ne=Integer.parseInt(rs.getString(7));
      int voc=Integer.parseInt(rs.getString(8));
      correo=rs.getString(9);
      String cgotxt="";
      String reobs="";if (rs.getString(10) != null){reobs=rs.getString(10).trim();}
      String ocobs="";if (rs.getString(11) != null){ocobs=rs.getString(11).trim();}
      String rev=rs.getString(12);
      //switch(sup){
      //       case 0:cgotxt="REGISTRADA";break;
      //       case 1:cgotxt="<font color='#01DF01'>VALIDADA</font>";break;
      //       case 2:cgotxt="<font color='#FF0000'>CON ERROR</font>";break;
     // }
      out.println("<tr class=c bgcolor=''>");
        out.println("<td align=center nowrap>&nbsp;<input type=button onclick='obt_geom("+gid+",4);' value=' Ver ' class='boton'>&nbsp;");
            out.println("<td align=center nowrap>&nbsp;"+cve_ent+"&nbsp;");
            out.println("<td align=center nowrap>&nbsp;"+carta+"&nbsp;");
            out.println("<td align=center nowrap>&nbsp;&nbsp;"+fact+"&nbsp;&nbsp;");
            //out.println("<td align=center nowrap>&nbsp;&nbsp;"+cgotxt+"&nbsp;&nbsp;");
            //out.println("<td align=center nowrap>&nbsp;&nbsp;"+nm+"&nbsp;&nbsp;");
            out.println("<td align=center nowrap>&nbsp;&nbsp;"+nf+"&nbsp;&nbsp;");
            out.println("<td align=center nowrap>&nbsp;&nbsp;"+ne+"&nbsp;&nbsp;");


////////validacion regional

     if (s1.equals("2")){
        if (sup==0){
            out.println("<td align=center><div id=val"+gid+"><img title='"+carta+" - Registro sin validar (Click para validar)' onclick='modval(1,"+gid+",\""+carta+"\");' border='0' src=images/sinval.png border=0></img></div>");
        }else if (sup==1){
            out.println("<td align=center><div id=val"+gid+"><img title='"+carta+" - Registro validado (Click para retener)' onclick='modval(2,"+gid+",\""+carta+"\");' border='0' src=images/val.png border=0></img></div>");
        }else{
            out.println("<td align=center><div id=val"+gid+"><img title='"+carta+" - Registro retenido (Click para invalidar)' onclick='modval(0,"+gid+",\""+carta+"\");' border='0' src=images/ret.png border=0></img></div>");
        }
     }else{
        if (sup==0){
            out.println ("<td align=center><div id=val"+gid+"><img title='"+carta+" - Registro sin validar' border='0' src=images/sinval.png border=0></img></div>");
        }else if (sup==1){
            out.println ( "<td align=center><div id=val"+gid+"><img title='"+carta+" - Registro validado' border='0' src=images/val.png border=0></img></div>");
        }else{
            out.println ( "<td align=center><div id=val"+gid+"><img title='"+carta+" - Registro retenido' border='0' src=images/ret.png border=0></img></div>");
        }
    }
    String col="";
    if (reobs.length()>1){col="bgcolor=red";}
    out.println ("<td "+col+" align=center nowrap title='"+reobs+"'>&nbsp;&nbsp;<input type=button onclick='observa("+gid+",\"R\","+s1+");' value=' Ver ' class='boton'>&nbsp;&nbsp;");
////////validacion oficinas centrales

     if (s1.equals("3")){
        if (voc==0){
            out.println("<td align=center><div id=voc"+gid+"><img title='"+carta+" - Registro sin validar (Click para validar)' onclick='modvalvoc(1,"+gid+",\""+carta+"\");' border='0' src=images/sinval.png border=0></img></div>");
        }else if (voc==1){
            out.println("<td align=center><div id=voc"+gid+"><img title='"+carta+" - Registro validado (Click para retener)' onclick='modvalvoc(2,"+gid+",\""+carta+"\");' border='0' src=images/val.png border=0></img></div>");
        }else{
            out.println("<td align=center><div id=voc"+gid+"><img title='"+carta+" - Registro retenido (Click para invalidar)' onclick='modvalvoc(0,"+gid+",\""+carta+"\");' border='0' src=images/ret.png border=0></img></div>");
        }
     }else{
        if (voc==0){
            out.println ("<td align=center><div id=voc"+gid+"><img title='"+carta+" - Registro sin validar' border='0' src=images/sinval.png border=0></img></div>");
        }else if (voc==1){
            out.println ( "<td align=center><div id=voc"+gid+"><img title='"+carta+" - Registro validado' border='0' src=images/val.png border=0></img></div>");
        }else{
            out.println ( "<td align=center><div id=voc"+gid+"><img title='"+carta+" - Registro retenido' border='0' src=images/ret.png border=0></img></div>");
        }    }

        col="";
      if (ocobs.length()>1){col="bgcolor=red";}
    out.println ("<td "+col+" align=center nowrap title='"+ocobs+"'>&nbsp;&nbsp;<input type=button onclick='observa("+gid+",\"O\","+s1+");' value=' Ver ' class='boton'>&nbsp;&nbsp;");
    out.println("<td>&nbsp;<a href='mailto:"+correo+"@inegi.org.mx'><img src='images/contacto.png' width='14' height='14' title='"+correo+"'></img></a>");
    out.println("<td align=center>&nbsp;"+rev+"&nbsp;");
            n++;
       }
    rs.close();
    out.println( "</table><br><center><table align=center><tr align=center><td><font class=n>Total de Registros: " + totalRows +"</font><br><br>");
  
 //String export = consulta.replace("%", "-");
  //out.println ("<table><tr><td nowrap><input class='boton' type='Button' onClick='exp(\""+export.replace("'","*")+"\");' value=' Exportar a DBF '/>");

String barra="";
if(startIndex != 0) {
barra="<a class=liga1 href='rep_listar.jsp?filent="+filent+"&filtipo="+filtipo+"&filtipooc="+filtipooc+"&filtipofr="+filtipofr+"&filfe1="+filfe1+"&filfe2="+filfe2+"&loc="+loc+"&pass="+pass+"&ban="+ban+"&startIndex="+(startIndex-numRecordsPerPage)+"'> &nbsp;<<&nbsp; </a>";
}

for (n =0 ; n<numPages; n++){
  if (n*numRecordsPerPage == startIndex) {
    // Si el numero de pagina es la actual ($_pagi_actual). Se escribe el numero, pero sin enlace y en negrita.
    barra+="<b> &nbsp;<font class=liga>"+(n+1)+"</font>&nbsp; </b>";
  }else{
    // Si es cualquier otro. Se escibe el enlace a dicho numero de pagina.
    barra+="<a class=liga1 href='rep_listar.jsp?filent="+filent+"&filtipo="+filtipo+"&filtipooc="+filtipooc+"&filtipofr="+filtipofr+"&filfe1="+filfe1+"&filfe2="+filfe2+"&loc="+loc+"&pass="+pass+"&ban="+ban+"&startIndex="+(numRecordsPerPage*n)+"'> &nbsp;"+(n+1)+"&nbsp; </a>";
  }
 }




if(startIndex+numRecordsPerPage <= totalRows){
  barra+="<a class=liga1 href='rep_listar.jsp?filent="+filent+"&filtipo="+filtipo+"&filtipooc="+filtipooc+"&filtipofr="+filtipofr+"&filfe1="+filfe1+"&filfe2="+filfe2+"&loc="+loc+"&pass="+pass+"&ban="+ban+"&startIndex="+(startIndex+numRecordsPerPage)+"'> &nbsp;>>&nbsp; </a>";
}
out.println(barra+"<br><br>");
}else{   //ban
   out.println ("</table><table class='n'><tr><td><br><br><tr><td>Genera la consulta y presiona \"Buscar\"");

}
    str.close();
    conexion.close();
 }//try

    catch (SQLException ex){
      out.println("<script>");
      out.println("  alert(\"Se genero la expresion de SQL: "+ex.getMessage()+" !\");");
      out.println("</script>");
    }

    catch(Exception ex){
      out.println("<script>");
      out.println("  alert(\"Se genero la expresion: "+ex.getMessage()+" !\");");
      out.println("</script>");
    }
    }else{
          out.println("<script>opener.cerrarSesion();window.close();</script>");
    }

%>
</body>
</html>
