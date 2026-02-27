<%@ page import="java.util.*" session="true" %>
<%@ page import="java.util.Date"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.time.Instant"%>
<%@ page import="java.time.format.DateTimeParseException"%>
<%@ page import="java.text.*"%>


<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>
SIGMA
</title>
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-Q856GDCQ02"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'G-Q856GDCQ02');
</script>

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
window.resizeTo(1100,600);


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


function modval(val,cons,id) {
    var ajax=nuevoAjax();
    ajax.open("GET",'modvalpre_acu.jsp?cons='+cons+'&id='+id+'&val='+val+'&tabla=acu',true);
    ajax.onreadystatechange=function()
    {
        if(ajax.readyState==4)  {
             var vale=ajax.responseText;
            if (vale=='x'){
                alert ("No se pudo modificar la validacion!!");
            }else{
                div="voc"+id;
                  if (val=='N'){
                      tabla = "<img title='"+id+" - Registro sin validar (Click para validar)' onclick='modval(\"S\","+cons+","+id+");' border='0' src=images/sinval.png border=0></img>";
                  }else if (val=='S'){
                      tabla = "<img title='"+id+" - Registro validado (Click para retener)' onclick='modval(\"R\","+cons+","+id+");' border='0' src=images/val.png border=0></img>";
                  }else{
                      tabla = "<img title='"+id+" - Registro retenido (Click para invalidar)' onclick='modval(\"N\","+cons+","+id+");' border='0' src=images/ret.png border=0></img></div>";
                  }
                document.getElementById(div).innerHTML = tabla;
            }
        }
    }
    ajax.send(null);
    }




function observaval(gid,nivel,cons){
ventana = window.open('verobsvalpre_acu.jsp?cons='+cons+'&gid='+gid+'&nivel='+nivel+'&val=1&tabla=acu','Observapre','scrollbars=no,toolbar=no');
ventana.focus();
}

function observaed(gid,nivel,cons){
ventana = window.open('verobsvalpre_acu.jsp?cons='+cons+'&gid='+gid+'&nivel='+nivel+'&val=3&tabla=acu','Observapre','scrollbars=no,toolbar=no');
ventana.focus();
}

function obt_geom(gid,ban){
    var ajax=nuevoAjax();
    ajax.open("GET",'obtgeo_modcar_acu.jsp?id='+gid+'&ban='+ban+'&tipo=1', true);
    ajax.onreadystatechange=function()
    {
        if(ajax.readyState==4)  {
             var vale=ajax.responseText;
            if (parseInt(vale)==1){
                alert ("No se pudo obtener las coordenadas!!");
            }else{
                window.opener.buscazoomtemz(2,vale);
            }
        }
    }
    ajax.send(null);
}


function exp(consulta){
ventana = window.open("exp_csv.jsp?c="+consulta,'Consultamz','scrollbars=no,toolbar=no');
}


function ver_resp(clave,gid,ban,figura){
ventana = window.open('verrespmcc_acu.jsp?gid='+gid+'&ban='+ban+'&figura='+figura+'&clave='+clave,'Respuesta','scrollbars=no,toolbar=no');
ventana.focus();
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

function campro(gid,cgo) {
    var ajax=nuevoAjax();
    ajax.open("GET",'campro.jsp?id='+gid+'&cgo='+cgo, true);
    ajax.onreadystatechange=function()
    {
        if(ajax.readyState==4)  {
             var vale=ajax.responseText;
            if (vale=='x'){
                alert ("No se pudo modificar la respuesta!!");
            }else{
                div1="pr1"+gid+cgo;
                tabla1="&nbsp;&nbsp;<b>SIN RESPUESTA</b>&nbsp;&nbsp;";
                document.getElementById(div1).innerHTML = tabla1;
            }
        }
    }
    ajax.send(null);
    }


</script>
  </head>
<body>
<%
int n=0;
int n1=0;
String  ent = "",regid = "",
        loc = request.getParameter("loc").replace("'",""),
        pass = request.getParameter("pass"),
        tipo = request.getParameter("tipo"),
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
         select1="",select2="",
         st = "",
         filent="",
         filtipo="",filtipo2="",filcgo="",
         filfe1="",
         filfe2="",
         where="",
         obs="",observa="",lobs="",obs1="";
      consultapas = "select nivel,edicion,id,regid,nombre,cons from usuarios where md5(password) = '"+pass+"';";


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


String remotehost  = session.getAttribute("remotehost").toString();
String regionalid  = session.getAttribute("regionalid").toString();

try {
      Statement str = null;
      ResultSet rs = null;
      Connection conexion = null;
      Class.forName("org.postgresql.Driver");
      String hostbd  = session.getAttribute("hostbd").toString();
      String remotehostbd  = session.getAttribute("remotehostbd").toString();
      conexion = DriverManager.getConnection("jdbc:postgresql://"+remotehostbd+":5434/"+hostbd,"actcar","actcar");      str = conexion.createStatement(rs.TYPE_SCROLL_SENSITIVE, rs.CONCUR_UPDATABLE);
    rs = str.executeQuery( consultapas );
    rs.next();
    String s1=rs.getObject(1).toString();
      Integer s2=(Integer) rs.getObject(2);

      ent=rs.getObject(3).toString();
    regid=rs.getObject(4).toString();
    String nombre=rs.getObject(5).toString();
      Integer cons=(Integer) rs.getObject(6);

//out.println( consultapas );
sesion.setAttribute("script", "modcar");
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
filcgo = request.getParameter("filcgo");
filtipo2 = request.getParameter("filtipo2");
filfe1 = request.getParameter("filfe1");
filfe2 = request.getParameter("filfe2");
if (filent==null)filent="00";
if (filtipo==null)filtipo="X";
if (filcgo==null)filcgo="X";
if (filtipo2==null)filtipo2="X";
if (filfe1==null){
  filfe1=fec1;
  filfe1="2026-01-01";
}
if (filfe2==null)filfe2=fec2;

//out.println("<br>ent:"+ent);
//out.println("<br>filent:"+filent);
//out.println("<br>filfe1:"+filfe1);
//out.println("<br>filfe2:"+filfe2);
if (filtipo.equals("X")){
  select1="";
}else if(filtipo.equals("0")){
  select1=" proc=0 and  ";
}else if (filtipo.equals("1")){
  select1=" proc=1 and ";
}else if (filtipo.equals("2")){
  select1=" proc>=2 and";
}else if (filtipo.equals("3")){    //proyectadas
select1=" ";
}

if (filcgo.equals("X")){
  select1+="";
}else {
  select1+=" substring(tip_act,1,1)='"+filcgo+"' and ";
}

if (filtipo2.equals("on")){
  select2=" ";
}else{
  //select2=" cgo!='FR' and ";
  select2=" ";
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
          consulta="select gid,cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,tipo as tip1,tip_act,f_registro,proc,fresp,case when geom is null then '0' else '1' end as geom,ban,cve_def,tipo,status,cgo_def,mal,observ,voc,obsoc,obsed,mza_mg,usr_mod from act_cu.bcu_bd_manzana where  "+select1+" "+select2+" f_registro between '"+filfe1+"' and '"+ filfe2 +"' "+filreg+
            " order by cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,gid";
          where = select1+" "+select2+" f_registro between '"+filfe1+"' and '"+ filfe2 +"' "+filreg+" order by cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,gid";
                }else{
          consulta="select gid,cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,tipo as tip1,tip_act,f_registro,proc,fresp,case when geom is null then '0' else '1' end as geom,ban,cve_def,tipo,status,cgo_def,mal,observ,voc,obsoc,obsed,mza_mg,usr_mod from act_cu.bcu_bd_manzana where  "+select1+" "+select2+" f_registro between '"+filfe1+"' and '"+ filfe2 +"' and cve_ent = '"+filent+"'"+
            " order by cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,gid";
          where = select1+" "+select2+" f_registro between '"+filfe1+"' and '"+ filfe2 +"' and cve_ent = '"+filent+"' order by cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,gid";
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
          consulta="select gid,cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,tipo as tip1,tip_act,f_registro,proc,fresp,case when geom is null then '0' else '1' end as geom,ban,cve_def,tipo,status,cgo_def,mal,observ,voc,obsoc,obsed,mza_mg,usr_mod from act_cu.bcu_bd_manzana where  "+select1+" "+select2+" f_registro between '"+filfe1+"' and '"+ filfe2 +"' "+filreg+
            " order by cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,gid";
          where = select1+" "+select2+" f_registro between '"+filfe1+"' and '"+ filfe2 +"' "+filreg+" order by cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,gid";
                }else{
          consulta="select gid,cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,tipo as tip1,tip_act,f_registro,proc,fresp,case when geom is null then '0' else '1' end as geom,ban,cve_def,tipo,status,cgo_def,mal,observ,voc,obsoc,obsed,mza_mg,usr_mod from act_cu.bcu_bd_manzana where  "+select1+" "+select2+" f_registro between '"+filfe1+"' and '"+ filfe2 +"' and cve_ent = '"+filent+"'"+
            " order by cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,gid";
          where = select1+" "+select2+" f_registro between '"+filfe1+"' and '"+ filfe2 +"' and cve_ent = '"+filent+"' order by cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,gid";
                }
                 select="<select name=filent class='boton'>";
                select+="<option value='00' ";if (filent.equals("00")){select+="selected";}select+=">TODAS</option>";
                select+=selreg+"</select>";
    }else{
    consulta="select gid,cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,tipo as tip1,tip_act,f_registro,proc,fresp,case when geom is null then '0' else '1' end as geom,ban,cve_def,tipo,status,cgo_def,mal,observ,voc,obsoc,obsed,mza_mg,usr_mod from act_cu.bcu_bd_manzana where  "+select1+" "+select2+" f_registro between '"+filfe1+"' and '"+ filfe2 +"' and cve_ent = '"+ent+"'"+
      " order by cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,gid";
    where = select1+" "+select2+" f_registro between '"+filfe1+"' and '"+ filfe2 +"' and cve_ent = '"+ent+"' order by cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,gid";
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
        }else {
            filult=filreg;
        }
    consulta="select gid,cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,tipo as tip1,tip_act,f_registro,proc,fresp,case when geom is null then '0' else '1' end as geom,ban,cve_def,tipo,status,cgo_def,mal,observ,voc,obsoc,obsed,mza_mg,usr_mod from act_cu.bcu_bd_manzana where cve_ent||cve_mun||cve_loc||replace(cve_ageb,'-','')||cve_mza like '" + loc.replace("-", "") + "%' "+filult+" order by cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,gid";
         where = "cve_ent||cve_mun||cve_loc||replace(cve_ageb,'-','')||cve_mza like'" +  loc.replace("-", "") + "%' "+filult+" order by cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,gid";
}

       select1="<select name=filtipo class='boton'>";
       select1+="<option value='X' ";if (filtipo.equals("X")){select1+="selected";}select1+=">TODOS</option>";
       select1+="<option value='0' ";if (filtipo.equals("0")){select1+="selected";}select1+=">SIN RESPUESTA</option>";
       select1+="<option value='1' ";if (filtipo.equals("1")){select1+="selected";}select1+=">SI PROCEDE</option>";
       select1+="<option value='2' ";if (filtipo.equals("2")){select1+="selected";}select1+=">NO PROCEDE</option></select>";

       select2="<select name=filcgo class='boton' style='background: #aaffff'>";
       select2+="<option value='X' ";if (filcgo.equals("X")){select2+="selected";}select2+=">TODOS</option>";
       select2+="<option value='1' ";if (filcgo.equals("1")){select2+="selected";}select2+=">FUSION DE MZ</option>";
       select2+="<option value='2' ";if (filcgo.equals("2")){select2+="selected";}select2+=">SUBDIVISION DE MZ</option>";
       select2+="<option value='3' ";if (filcgo.equals("3")){select2+="selected";}select2+=">BAJA DE MZ</option>";
       select2+="<option value='4' ";if (filcgo.equals("4")){select2+="selected";}select2+=">ALTA DE MZ</option>";
       select2+="<option value='F' ";if (filcgo.equals("F")){select2+="selected";}select2+=">CAMBIO DE FORMA</option></select>";

      out.println( "<center class='t'><b class='t' style='background-color: #E7A4F9;'>&nbsp;&nbsp;Informacion procedente de la AC Integral&nbsp;&nbsp;(MANZANAS)</b><br>"
                + "<br><input class='boton' disabled type='button' value=' Manzanas '>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
                + "<input class='boton' type='button' value=' Pol. Externos ' onclick='window.open(\"modcar_acu_pe.jsp?loc=&pass="+pass+"\",\"_self\");''>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
                + "<input class='boton' type='button' value=' Localidades ' onclick='window.open(\"modcarloc_acu.jsp?loc=&pass="+pass+"\",\"_self\");''></center>"
                + "<form action=\"modcar_acu.jsp\" method=\"post\" name=\"enviar\">"
                + "<center><br>"
                + "<font class=n>De:</font>&nbsp;<input class='boton' name='filfe1' type='text' id='p1id' onClick=\"popUpCalendar(this, enviar.p1id, 'yyyy-mm-dd');\" size='10'  value='"+filfe1+"'>"
                + "&nbsp;&nbsp;<font class=n>a:</font>&nbsp;<input class='boton' name='filfe2' type='text' id='p2id' onClick=\"popUpCalendar(this, enviar.p2id, 'yyyy-mm-dd');\" size='10' value='"+filfe2+"'>"
                + "&nbsp;&nbsp;<font class=n>Entidad:</font>&nbsp;"+select
                + "&nbsp;&nbsp;<font class=n>Codigo:</font>&nbsp;"+select2);
/*if (filtipo2.equals("on")){
  out.println(  "<font class=n>&nbsp;&nbsp;</font><input type='checkbox' name='filtipo2' class=boton checked><font class=n>Incluir codigo FR&nbsp;</font>");
}else{
  out.println(  "<font class=n>&nbsp;&nbsp;</font><input type='checkbox' name='filtipo2' class=boton><font class=n>Incluir codigo FR&nbsp;</font>");
}*/
      out.println( "&nbsp;&nbsp;<font class=n>Respuesta:</font>&nbsp;"+select1
                + "<input type='hidden' name='ent' value='"+ent+"'><input type='hidden' name='ban' value='1'><input type='hidden' name='regid' value='"+regid+"'>&nbsp;&nbsp;&nbsp;&nbsp;<input class='boton' type='button' value=' Buscar ' onclick='envia(1)''>"
                + "<br><br><font class=n>Por manzana:&nbsp;&nbsp;</font>"
                + "<input type='text' maxlength=40 size=20 name='loc' value='"+loc+"' class='boton'><input type='hidden' name='pass' value='"+pass+"'>&nbsp;&nbsp;&nbsp;&nbsp;<input class='boton' type='button' value=' Buscar ' onclick='envia(2)'></form><br><br>");
  out.println( "<table border=1><tr class=n bgcolor=#BBBBBB>");
     //if (s1!=2){
      out.println("<th rowspan=1>Val<br>&nbsp;OC&nbsp;");out.println("<th rowspan=1>Obs<br>&nbsp;OC&nbsp;<th rowspan=1>Obs<br>&nbsp;Edo&nbsp;");
    //}
  out.println("<th>&nbsp;&nbsp;Ver&nbsp;&nbsp;<th>&nbsp;&nbsp;Clave Geo&nbsp;&nbsp;<th>Tipo&nbsp;de<br>&nbsp;manzana&nbsp;<th>&nbsp;Codigo&nbsp;<th>Fecha<br>&nbsp;registro&nbsp;<th>Fecha<br>&nbsp;respuesta&nbsp;<th>&nbsp;Procede&nbsp;<th>&nbsp;Respuesta&nbsp;<th title='Registro con informe'>&nbsp;<img src=images/res.png>&nbsp;<th>&nbsp;Observ&nbsp;<th title='Manzana propuesta al MG'>&nbsp;MZ-MG&nbsp;");
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
    String tipo_figura="";
    String cveoper="";
    String observ2="";
    String obsoc="",lobsoc="",voc="",col="",obsed="",lobsed="";
    String mza_mg="",usr_mod="";

      SimpleDateFormat sdformat = new SimpleDateFormat("yyyy-MM-dd");

    Date f_d1 = null;
    Date f_d2 = sdformat.parse("2023-01-01");

    while(rs.next()){
    //gid,cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,tipomza,cgo,f_registro,proc,fresp,geom
    //gid,cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,tipo,tip_act,f_registro,proc,fresp, geom,ban,cve_def,tipo,status,cgo_def,mal,observ,voc,obsoc,obsed,mza_mg,usr_mod

      String gid=rs.getObject(1).toString();
      String cve_ent=rs.getObject(2).toString();
      String cve_mun=rs.getObject(3).toString();
      String cve_loc=rs.getObject(4).toString();
      String cve_ageb=rs.getObject(5).toString();
      String cve_mza=rs.getObject(6).toString();
      String tipomza="";
      if (rs.getObject(7) != null){
        tipomza=rs.getObject(7).toString();
      }
      String cgo=rs.getObject(8).toString();
      String f_registro=rs.getObject(9).toString();
      String proc=rs.getObject(10).toString();
      String fresp="";
      if (rs.getObject(11) != null){
        fresp=rs.getObject(11).toString();
      }
      String geom=rs.getObject(12).toString();
      int elim = Integer.parseInt(rs.getString(13));
      String cve_def="";
      if (rs.getObject(14) != null){
        cve_def=rs.getObject(14).toString();
      }
      String tipovi=rs.getObject(15).toString();
       String status="0";
      if (rs.getObject(16) != null){
        status=rs.getObject(16).toString();
       }
       String cgo_def="";
      if (rs.getObject(17) != null){
        cgo_def=rs.getObject(17).toString();
      }
      int mal = Integer.parseInt(rs.getString(18));
      String observ="";
      if (rs.getObject(19) != null){
        observ=rs.getObject(19).toString();
      }
     voc=rs.getString(20);
     obsoc="";
      if (rs.getString(21) != null){
        obsoc=rs.getString(21);
      }
      obsed="";
      if (rs.getString(22) != null){
        obsed=rs.getString(22);
      }
      mza_mg="-";
      if (rs.getString(23) != null){
        mza_mg=rs.getString(23);
      }
      usr_mod="-";
      if (rs.getString(24) != null){
        usr_mod=rs.getString(24);
      }

    f_d1 = sdformat.parse(f_registro);



      String sttxt="";
      switch(status){
             case "0": sttxt="Analizar";break;
             case "1":
                      sttxt="Aceptada";break;
             case "2":sttxt="C/cambios";break;
             case "3":
             case "4":
             case "5":
             case "6":
             case "8":
             case "9":
                      sttxt="Rechazada";break;
             case "7":sttxt="Caserio";break;
      }
      String cgotxt="";
      switch(cgo){
             case "1":cgotxt="Fusion de mza";break;
             case "2":cgotxt="Subdivision de mza";break;
             case "3":cgotxt="Baja de mza";break;
             case "4":cgotxt="Creacion de mza";break;
             //case "5":cgotxt="Cambio mza de ageb";break;
             //case "6":cgotxt="Cambio mza de loc";break;
             case "5":cgotxt="Cambio de forma de mza";break;
             case "6":cgotxt="Cambio de forma de mza";break;
             case "FR":cgotxt="Cambio de frentes";break;
             case "44":cgotxt="Creacion de caserio";break;
             case "45":cgotxt="Baja de Caserio";break;
             case "46":cgotxt="Cambio de caserio";break;

      }
      String tipotxt="";
      switch(tipomza){
              case "0":tipotxt="Sin tipo";break;
              case "1":tipotxt="Contenedora";break;
              case "2":tipotxt="Contenida";break;
              case "3":tipotxt="Edificio-Manzana";break;
              case "4":tipotxt="Tipica";break;
              case "5":tipotxt="Parque o Jardin";break;
              case "6":tipotxt="Glorieta";break;
              case "7":tipotxt="Camellon";break;
              case "8":tipotxt="Bajo Puente";break;
              case "9":tipotxt="Caserio Disperso";break;
              case "10":tipotxt="Proyectada";break;
              case "11":tipotxt="Atipica";break;
              case "12":tipotxt="Economica";break;
    }
      String protxt="";
      String resp="";
      switch(proc){
        case "0":
          protxt="<td align=center nowrap><div id=pr1"+gid+cgo+">&nbsp;&nbsp;<b>SIN RESPUESTA</b>&nbsp;&nbsp;</div>";
          resp="<td align=center nowrap><div id=pr2"+gid+cgo+">&nbsp;&nbsp;--&nbsp;&nbsp;</div>";
          break;
        case "1":
              protxt="<td align=center nowrap><div id=pr1"+gid+cgo+">&nbsp;&nbsp;<font color='green'><b>SI PROCEDE</b></font>&nbsp;&nbsp;</div>";
            //if (f_d1.compareTo(f_d2) < 0){
                resp="<td align=center nowrap><div id=pr2"+gid+cgo+">&nbsp;INTEGRADO&nbsp;</div>";
            //}else{
               // resp="<td align=center nowrap><div id=pr2"+gid+cgo+">&nbsp;<input type=button onclick='ver_resp(\""+cve_ent+" "+cve_mun+" "+cve_loc+" "+cve_ageb+" "+cve_mza+"\","+gid+",\""+cgo+"\");' value=' Respuesta ' class='boton'>&nbsp;</div>";
            //}


          break;
        /*case "2":
          protxt="<td align=center nowrap><div id=pr1"+gid+cgo+">&nbsp;&nbsp;<font color='green'><b>SI PROCEDE</b></font>&nbsp;&nbsp;</div>";
           if (cgo_def.equals("1")){
             resp="<td align=center nowrap><div id=pr2"+gid+cgo+">&nbsp;"+cve_def+"-M&nbsp;</div>";
          }else if (cgo_def.equals("2")){
             resp="<td align=center nowrap><div id=pr2"+gid+cgo+">&nbsp;"+cve_def+"-C&nbsp;</div>";
          }else if (cgo_def.equals("3")){
             resp="<td align=center nowrap><div id=pr2"+gid+cgo+">&nbsp;"+cve_def+"-L&nbsp;</div>";
          }
          break;*/
        case "2":
          protxt="<td align=center nowrap><div id=pr1"+gid+cgo+">&nbsp;&nbsp;<b>NO PROCEDE</b>&nbsp;&nbsp;</div>";
          resp="<td align=center nowrap><div id=pr2"+gid+cgo+">&nbsp;&nbsp;Por criterios MG&nbsp;&nbsp;</div>";
          break;
        case "3":
          resp="<td align=center nowrap><div id=pr2"+gid+cgo+">&nbsp;&nbsp;Por ser caerio&nbsp;&nbsp;</div>";
          protxt="<td align=center nowrap><div id=pr1"+gid+cgo+">&nbsp;&nbsp;<b>NO PROCEDE</b>&nbsp;&nbsp;</div>";
          break;
        case "4":
          resp="<td align=center nowrap><div id=pr2"+gid+cgo+">&nbsp;&nbsp;# de Mzs < 3&nbsp;&nbsp;</div>";
          protxt="<td align=center nowrap><div id=pr1"+gid+cgo+">&nbsp;&nbsp;<b>NO PROCEDE</b>&nbsp;&nbsp;</div>";
          break;
         case "5":
          resp="<td align=center nowrap><div id=pr2"+gid+cgo+">&nbsp;&nbsp;Ya existe en MG&nbsp;&nbsp;</div>";
          protxt="<td align=center nowrap><div id=pr1"+gid+cgo+">&nbsp;&nbsp;<b>NO PROCEDE</b>&nbsp;&nbsp;</div>";
        //protxt="<td align=center nowrap><div id=pr1"+gid+cgo+">&nbsp;&nbsp;<a class='liga2' title='Regresar el registro a SIN RESPUESTA'  href='javascript:;' onclick='campro("+gid+",\""+cgo+"\");'><font color='red'><b>NO PROCEDE</b></font></a>&nbsp;&nbsp;</div>";
          break;
        //case "3": protxt="<td align=center nowrap><div id=pr1"+gid+cgo+">&nbsp;&nbsp;<a class='liga2' title='Regresar el registro a SIN RESPUESTA'  href='javascript:;' onclick='campro("+gid+",\""+cgo+"\");'><font color='#FFBF00'><b>PROYECTADA</b></font></a>&nbsp;&nbsp;</div>";
        //  resp="<td align=center nowrap><div id=pr2"+gid+cgo+">&nbsp;&nbsp;"+cve_def+"&nbsp;&nbsp;</div>";
        //  break;
      }
      /*if (((status.equals("3") || status.equals("4") || status.equals("5") || status.equals("6") || status.equals("8") || status.equals("9")) && (!cve_mza.equals("800")))){
            protxt="<td align=center nowrap><div id=pr1"+gid+cgo+">&nbsp;&nbsp;<font color='red'><b>NO PROCEDE</b></font>&nbsp;&nbsp;</div>";
            resp="<td align=center nowrap><div id=pr2"+gid+cgo+">&nbsp;&nbsp;--&nbsp;&nbsp;</div>";
      }else if (cve_mza.equals("800") && cgo.equals("46")){
            protxt="<td align=center nowrap><div id=pr1"+gid+cgo+">&nbsp;&nbsp;<b>-- Analizar --</font>&nbsp;&nbsp;</div>";
            resp="<td align=center nowrap><div id=pr2"+gid+cgo+">&nbsp;&nbsp;--&nbsp;&nbsp;</div>";
        }*/
      if (elim==1 || mal==9){   //le pongo ban=1 cuando tiene baja posterior
        out.println( "<tr class=c bgcolor='#F4FA58'>");
      }else{
        out.println( "<tr class=c>");
      }
      //out.println( "<td align=center nowrap>&nbsp;&nbsp;"+gid+"&nbsp;&nbsp;");
////estoy agregando la validacion OC

 if (s1.equals("3")){
        if (voc.equals("N")){
            out.println("<td align=center><div id=voc"+gid+"><img title='"+gid+" - Registro sin validar (Click para validar)' onclick='modval(\"S\","+cons+","+gid+");' border='0' src=images/sinval.png border=0></img></div>");
        }else if (voc.equals("S")){
            out.println("<td align=center><div id=voc"+gid+"><img title='"+gid+" - Registro validado (Click para retener)' onclick='modval(\"R\","+cons+","+gid+");' border='0' src=images/val.png border=0></img></div>");
        }else{
            out.println("<td align=center><div id=voc"+gid+"><img title='"+gid+" - Registro retenido (Click para invalidar)' onclick='modval(\"N\","+cons+","+gid+");' border='0' src=images/ret.png border=0></img></div>");
        }
     }else{
            if (voc.equals("N")){
                out.println ("<td align=center><div id=voc"+gid+"><img title='"+gid+" - Registro sin validar' border='0' src=images/sinval.png border=0></img></div>");
            }else if (voc.equals("S")){
                out.println ( "<td align=center><div id=voc"+gid+"><img title='"+gid+" - Registro validado' border='0' src=images/val.png border=0></img></div>");
            }else{
                out.println ( "<td align=center><div id=voc"+gid+"><img title='"+gid+" - Registro retenido' border='0' src=images/ret.png border=0></img></div>");
            }
    }

col="";
 if (obsoc.length()>1){col="bgcolor=#2EFE2E";}
    out.println ("<td "+col+" align=center nowrap title='"+obsoc+"'>&nbsp;&nbsp;<input type=button onclick='observaval("+gid+","+s1+","+cons+");' value=' Obs ' class='boton'>&nbsp;&nbsp;");


col="";
 if (obsed.length()>1){col="bgcolor=#2EFE2E";}
    out.println ("<td "+col+" align=center nowrap title='"+obsed+"'>&nbsp;&nbsp;<input type=button onclick='observaed("+gid+","+s1+","+cons+");' value=' Obs ' class='boton'>&nbsp;&nbsp;");

///// vaidacion OC





      if (geom.equals("1")){
        out.println("<td align=center nowrap>&nbsp;<input type=button onclick='obt_geom(\""+gid+"\",\""+cgo+"\");' value=' Geom ' class='boton'>&nbsp;");
      }else{
        out.println("<td align=center nowrap title='Sin geometria'>&nbsp;-&nbsp;");
      }
            out.println("<td align=center nowrap>&nbsp;"+cve_ent+"&nbsp;"+cve_mun+"&nbsp;"+cve_loc+"&nbsp;"+cve_ageb+"&nbsp;"+cve_mza+"&nbsp;");
            //out.println("<td align=center nowrap title='"+tipotxt+"'>&nbsp;&nbsp;"+tipomza+"&nbsp;&nbsp;/&nbsp;&nbsp;"+tipovi+"&nbsp;&nbsp;");
            out.println("<td align=center nowrap title='"+tipotxt+"'>&nbsp;&nbsp;"+tipomza+"&nbsp;&nbsp;");
            out.println("<td align=center nowrap title='"+cgotxt+"'>&nbsp;&nbsp;"+cgo+"&nbsp;&nbsp;");
            //out.println("<td align=center nowrap title='"+nota+"'>&nbsp;&nbsp;"+status+"&nbsp;&nbsp;");
            out.println("<td align=center nowrap>&nbsp;&nbsp;"+f_registro+"&nbsp;&nbsp;");
            out.println("<td align=center nowrap>&nbsp;&nbsp;"+fresp+"&nbsp;&nbsp;");
            out.println(protxt);
            /*if (proc.equals("2") || proc.equals("3") || proc.equals("4") || proc.equals("5")){
                out.println("<td align=center nowrap>&nbsp;"+proc+"&nbsp;");
            }else{
                out.println("<td align=center nowrap>&nbsp;&nbsp;");
            }*/
            out.println(resp);
            if (elim==1){
              out.println("<td align=center nowrap title='Este registro tiene error en el codigo de baja'>&nbsp;<img src=images/res.png>&nbsp;<b>BAJA POSTERIOR</b>");
            }else{
              if (mal==9){
                  out.println("<td align=center nowrap title='Este registro no tiene completos sus frentes de manzana'>&nbsp;<img src=images/res.png>&nbsp;<b>FALTAN FRENTES</b>");
              }else{
                  out.println("<td align=center nowrap>&nbsp;");
              }
            }
            if (observ.length()>10){
              observ2=observ.substring(0,10)+"...";
            }else{
              observ2=observ;
            }

            out.println("<td align=left nowrap title='"+usr_mod+" - "+observ+"'>&nbsp;&nbsp;"+observ2+"&nbsp;&nbsp;");
            //  out.println("<td align=left nowrap>&nbsp;&nbsp;&nbsp;&nbsp;");

            out.println("<td align=center nowrap>&nbsp;&nbsp;"+mza_mg+"&nbsp;&nbsp;");

            n++;
       }
    rs.close();

    out.println( "</table><br><center><table align=center><tr align=center><td><font class=n>Total de Registros: " + totalRows +"</font><br><br>");


 //String export = consulta.replace("%", "-");
  //out.println ("<table><tr><td nowrap><input class='boton' type='Button' onClick='exp(\""+export.replace("'","*")+"\");' value=' Exportar a DBF '/>");

String barra="";
if(startIndex != 0) {
barra="<a class=liga1 href='modcar_acu.jsp?loc="+loc+"&pass="+pass+"&tipo="+tipo+"&ban="+ban+"&startIndex="+(startIndex-numRecordsPerPage)+"'> &nbsp;<<&nbsp; </a>";
}

for (n =0 ; n<numPages; n++){
  if (n*numRecordsPerPage == startIndex) {
    // Si el numero de pagina es la actual ($_pagi_actual). Se escribe el numero, pero sin enlace y en negrita.
    barra+="<b> &nbsp;<font class=liga>"+(n+1)+"</font>&nbsp; </b>";
  }else{
    // Si es cualquier otro. Se escibe el enlace a dicho numero de pagina.
    barra+="<a class=liga1 href='modcar_acu.jsp?filent="+filent+"&filtipo="+filtipo+"&filcgo="+filcgo+"&filtipo2="+filtipo2+"&filfe1="+filfe1+"&filfe2="+filfe2+"&loc="+loc+"&pass="+pass+"&tipo="+tipo+"&ban="+ban+"&startIndex="+(numRecordsPerPage*n)+"'> &nbsp;"+(n+1)+"&nbsp; </a>";
  }
 }




if(startIndex+numRecordsPerPage <= totalRows){
  barra+="<a class=liga1 href='modcar_acu.jsp?filent="+filent+"&filtipo="+filtipo+"&filcgo="+filcgo+"&filtipo2="+filtipo2+"&filfe1="+filfe1+"&filfe2="+filfe2+"&loc="+loc+"&pass="+pass+"&tipo="+tipo+"&ban="+ban+"&startIndex="+(startIndex+numRecordsPerPage)+"'> &nbsp;>>&nbsp; </a>";
}
out.println(barra+"<br><br>");
 String export = consulta.replace("%", "$");
        export = export.replace("'","%2A");
        export = export.replace("|","%7C");
        export = export.substring(0, (export.indexOf("order by cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,gid")+53));


  out.println ("<tr><td nowrap align=center><input class='boton' type='Button' onClick='exp(\""+export+"\");' value=' Exportar a DBF '/>");

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
