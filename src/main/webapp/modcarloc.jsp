<%@ page import="java.util.*" session="true" %>
<%@ page import="java.sql.*"%>
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
window.resizeTo(1000,600);


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



function obt_geom(gid,ban){
    var ajax=nuevoAjax();
    ajax.open("GET",'obtgeo_modcar.jsp?id='+gid+'&ban='+ban+'&tipo=2', true);
    ajax.onreadystatechange=function()
    {
        if(ajax.readyState==4)  {
             var vale=ajax.responseText;
            if (parseInt(vale)==1){
                alert ("No se pudo obtener las coordenadas!!");
            }else{
                var arr = vale.split(",");
                var ban=0;
                if (opener.busqueda.latitud.value==''){
                  ban=1;
                }
                opener.busqueda.latitud.value=arr[1];
                opener.busqueda.longitud.value=arr[0];
                opener.enviar(500);
                if (ban==1){
                opener.busqueda.latitud.value='';
                opener.busqueda.longitud.value='';
                }
            }
        }
    }
    ajax.send(null);
}


function exp(consulta){
ventana = window.open("exp_csv.jsp?c="+consulta,'Consultamz','scrollbars=no,toolbar=no');
}


function ver_resp(clave,gid){
ventana = window.open('verrespmccloc.jsp?gid='+gid+'&clave='+clave,'Respuesta','scrollbars=no,toolbar=no');
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
        loc = request.getParameter("loc"),
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
         filtipo="",filtipo2="",
         filfe1="",
         filfe2="",
         where="",
         obs="",observa="",lobs="",obs1="";
      consultapas = "select nivel,edicion,id,regid,nombre from usuarios where md5(password) = '"+pass+"';";


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

//try {
      Statement str = null;
      ResultSet rs = null;
      Connection conexion = null;
      Class.forName("org.postgresql.Driver");
      String hostbd  = session.getAttribute("hostbd").toString();
      String remotehostbd  = session.getAttribute("remotehostbd").toString();
      conexion = DriverManager.getConnection("jdbc:postgresql://"+remotehostbd+":5434/"+hostbd,"actcar","actcar");   
       str = conexion.createStatement(rs.TYPE_SCROLL_SENSITIVE, rs.CONCUR_UPDATABLE);
    rs = str.executeQuery( consultapas );
    rs.next();
    String s1=rs.getObject(1).toString();
      Integer s2=(Integer) rs.getObject(2);

      ent=rs.getObject(3).toString();
    regid=rs.getObject(4).toString();
    String nombre=rs.getObject(5).toString();

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
filtipo2 = request.getParameter("filtipo2");
filfe1 = request.getParameter("filfe1");
filfe2 = request.getParameter("filfe2");
if (filent==null)filent="00";
if (filtipo==null)filtipo="X";
if (filtipo2==null)filtipo2="X";
if (filfe1==null){
  filfe1=fec1;
  filfe1="2025-01-01";
}
if (filfe2==null)filfe2=fec2;

//out.println("<br>ent:"+ent);
//out.println("<br>filent:"+filent);
//out.println("<br>filfe1:"+filfe1);
//out.println("<br>filfe2:"+filfe2);
if (filtipo.equals("X")){
  select1="";
}else if (filtipo.equals("1")){
  select1=" proc>=1 and ";
}else if (filtipo.equals("2")){
  select1=" (proc=0 and status>=2) and";
}else if(filtipo.equals("0")){
  select1=" (proc=0) and ";
}//else if (filtipo.equals("3")){    //proyectadas
//select1=" proc=3 and ";
//}
/*
if (filtipo2.equals("X")){
  select2="";
}else if (filtipo2.equals("1")){
  select2=" gid>1000000 and ";
}else if (filtipo2.equals("2")){
  select2=" gid<1000000 and ";
}*/

if (filtipo2.equals("X")){
  select2+="";
}else {
  select2+=" codigoact in ("+filtipo2+") and ";
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
          consulta="select gid,cve_ent,cve_mun,cve_loc,cve_ageb,codigoact,f_registro,proc,fresp,case when geom is null then '0' else '1' end as geom,ban,cve_def,status,nota,figura,cgo_def,cveoper from mcc_poblacion.loc_rur"+
            " where   ((figura='CENSOR' and status!=2) or (figura='TCAR')) and "+select1+" "+select2+" f_registro between '"+filfe1+"' and '"+ filfe2 +"' "+filreg+
            " order by cve_ent,cve_mun,cve_loc,cve_ageb,gid";
          where = select1+" "+select2+" f_registro between '"+filfe1+"' and '"+ filfe2 +"' "+filreg+" order by cve_ent,cve_mun,cve_loc,cve_ageb,gid";
                }else{
          consulta="select gid,cve_ent,cve_mun,cve_loc,cve_ageb,codigoact,f_registro,proc,fresp,case when geom is null then '0' else '1' end as geom,ban,cve_def,status,nota,figura,cgo_def,cveoper from mcc_poblacion.loc_rur"+
              " where    ((figura='CENSOR' and status!=2) or (figura='TCAR')) and "+select1+" "+select2+" f_registro between '"+filfe1+"' and '"+ filfe2 +"' and cve_ent = '"+filent+"'"+
            " order by cve_ent,cve_mun,cve_loc,cve_ageb,gid";
          where = select1+" "+select2+" f_registro between '"+filfe1+"' and '"+ filfe2 +"' and cve_ent = '"+filent+"' order by cve_ent,cve_mun,cve_loc,cve_ageb,gid";
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
          consulta="select gid,cve_ent,cve_mun,cve_loc,cve_ageb,codigoact,f_registro,proc,fresp,case when geom is null then '0' else '1' end as geom,ban,cve_def,status,nota,figura,cgo_def,cveoper from mcc_poblacion.loc_rur"+
            " where    ((figura='CENSOR' and status!=2) or (figura='TCAR')) and "+select1+" "+select2+" f_registro between '"+filfe1+"' and '"+ filfe2 +"' "+filreg+
            " order by cve_ent,cve_mun,cve_loc,cve_ageb,gid";
          where = select1+" "+select2+" f_registro between '"+filfe1+"' and '"+ filfe2 +"' "+filreg+" order by cve_ent,cve_mun,cve_loc,cve_ageb,gid";
                }else{
          consulta="select gid,cve_ent,cve_mun,cve_loc,cve_ageb,codigoact,f_registro,proc,fresp,case when geom is null then '0' else '1' end as geom,ban,cve_def,status,nota,figura,cgo_def,cveoper from mcc_poblacion.loc_rur"+
              " where    ((figura='CENSOR' and status!=2) or (figura='TCAR')) and "+select1+" "+select2+" f_registro between '"+filfe1+"' and '"+ filfe2 +"' and cve_ent = '"+filent+"'"+
            " order by cve_ent,cve_mun,cve_loc,cve_ageb,gid";
          where = select1+" "+select2+" f_registro between '"+filfe1+"' and '"+ filfe2 +"' and cve_ent = '"+filent+"' order by cve_ent,cve_mun,cve_loc,cve_ageb,gid";
                }
                 select="<select name=filent class='boton'>";
                select+="<option value='00' ";if (filent.equals("00")){select+="selected";}select+=">TODAS</option>";
                select+=selreg+"</select>";
    }else{
    consulta="select gid,cve_ent,cve_mun,cve_loc,cve_ageb,codigoact,f_registro,proc,fresp,case when geom is null then '0' else '1' end as geom,ban,cve_def,status,nota,figura,cgo_def,cveoper from mcc_poblacion.loc_rur"+
      " where    ((figura='CENSOR' and status!=2) or (figura='TCAR')) and "+select1+" "+select2+" f_registro between '"+filfe1+"' and '"+ filfe2 +"' and cve_ent = '"+ent+"'"+
      " order by cve_ent,cve_mun,cve_loc,cve_ageb,gid";
    where = select1+" "+select2+" f_registro between '"+filfe1+"' and '"+ filfe2 +"' and cve_ent = '"+ent+"' order by cve_ent,cve_mun,cve_loc,cve_ageb,gid";
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
    consulta="select gid,cve_ent,cve_mun,cve_loc,cve_ageb,codigoact,f_registro,proc,fresp,case when geom is null then '0' else '1' end as geom,ban,cve_def,status,nota,figura,cgo_def,cveoper from mcc_poblacion.loc_rur"+ " where     ((figura='CENSOR' and status!=2) or (figura='TCAR')) and cve_ent||cve_mun||cve_loc||replace(cve_ageb,'-','') like '" + loc.replace("-", "") + "%' "+filult+" order by cve_ent,cve_mun,cve_loc,cve_ageb,gid";
         where = "cve_ent||cve_mun||cve_loc||replace(cve_ageb,'-','') like'" +  loc.replace("-", "") + "%' "+filult+" order by cve_ent,cve_mun,cve_loc,cve_ageb,gid";
}
  

       select1="<select name=filtipo class='boton'>";
       select1+="<option value='X' ";if (filtipo.equals("X")){select1+="selected";}select1+=">TODOS</option>";
       select1+="<option value='0' ";if (filtipo.equals("0")){select1+="selected";}select1+=">SIN RESPUESTA</option>";
       select1+="<option value='1' ";if (filtipo.equals("1")){select1+="selected";}select1+=">SI PROCEDE</option>";
       select1+="<option value='2' ";if (filtipo.equals("2")){select1+="selected";}select1+=">NO PROCEDE</option></select>";
       //select1+="<option value='3' ";if (filtipo.equals("3")){select1+="selected";}select1+=">PROYECTADAS</option></select>";

 select2="<select name=filtipo2 class='boton' style='background: #aaffff'>";
       select2+="<option value='X' ";if (filtipo2.equals("X")){select2+="selected";}select2+=">TODOS</option>";
       select2+="<option value='7' ";if (filtipo2.equals("7")){select2+="selected";}select2+=">ALTA</option>";
       select2+="<option value='9' ";if (filtipo2.equals("9")){select2+="selected";}select2+=">CAMBIO DE NOMBRE</option>";
     select2+="<option value='8,81' ";if (filtipo2.equals("8")){select2+="selected";}select2+=">BAJA</option></select>";
      out.println( "<center class='t'><b  style='background-color: #F5A560;' >&nbsp;&nbsp;Informacion procedente del Modulo Cartografico EIC2025 (LOCALIDADES)&nbsp;&nbsp;</b><br><br>"
                + "<input class='boton'  type='button' value=' Manzanas ' onclick='window.open(\"modcar.jsp?loc=&pass="+pass+"\",\"_self\");''>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
                + "<input class='boton' disabled type='button' value=' Localidades ' ></center>"
                + "<form action=\"modcarloc.jsp\" method=\"post\" name=\"enviar\">"
                + "<center><br>"
                + "<font class=n>De:</font>&nbsp;<input class='boton' name='filfe1' type='text' id='p1id' onClick=\"popUpCalendar(this, enviar.p1id, 'yyyy-mm-dd');\" size='10'  value='"+filfe1+"'>"
                + "&nbsp;&nbsp;<font class=n>a:</font>&nbsp;<input class='boton' name='filfe2' type='text' id='p2id' onClick=\"popUpCalendar(this, enviar.p2id, 'yyyy-mm-dd');\" size='10' value='"+filfe2+"'>"
                + "&nbsp;&nbsp;<font class=n>Entidad:</font>&nbsp;"+select
                + "&nbsp;&nbsp;<font class=n>Codigo:</font>&nbsp;"+select2
                + "&nbsp;&nbsp;<font class=n>Respuesta:</font>&nbsp;"+select1
                + "<input type='hidden' name='ent' value='"+ent+"'><input type='hidden' name='ban' value='1'><input type='hidden' name='regid' value='"+regid+"'>&nbsp;&nbsp;&nbsp;&nbsp;<input class='boton' type='button' value=' Buscar ' onclick='envia(1)''><br><br><font class=n>Por localidad:&nbsp;&nbsp;</font>"
                + "<input type='text' maxlength=22 size=20 name='loc' value='"+loc+"' class='boton'><input type='hidden' name='pass' value='"+pass+"'>&nbsp;&nbsp;&nbsp;&nbsp;<input class='boton' type='button' value=' Buscar ' onclick='envia(2)'></form><br><br>");
  out.println( "<table border=1><tr class=n bgcolor=#BBBBBB>");
  out.println("<th>&nbsp;&nbsp;Id-MCC&nbsp;&nbsp;<th>&nbsp;&nbsp;Ver&nbsp;&nbsp;<th>&nbsp;&nbsp;Clave Oper&nbsp;&nbsp;<th>&nbsp;&nbsp;Clave&nbsp;&nbsp;<th>&nbsp;Codigo&nbsp;<th colspan=2>&nbsp;Status/MCC&nbsp;<th>Fecha<br>&nbsp;registro&nbsp;<th>Fecha<br>&nbsp;respuesta&nbsp;<th>&nbsp;Procede&nbsp;<th>&nbsp;Respuesta&nbsp;<th title='Registro con informe'>&nbsp;<img src=images/res.png>&nbsp;");
  if (ban!=null){
  //out.println(consulta);
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


    while(rs.next()){
    //gid,cve_ent,cve_mun,cve_loc,cve_ageb,codigoact,f_registro,proc,fresp,geom,ban,cve_def,status,nota,figura,cgo_def,cveoper 
      String gid=rs.getObject(1).toString();
      String cve_ent=rs.getObject(2).toString();
      String cve_mun=rs.getObject(3).toString();
      String cve_loc=rs.getObject(4).toString();
      String cve_ageb=rs.getObject(5).toString();
      String cgo=rs.getObject(6).toString();
      String f_registro=rs.getObject(7).toString();
      String proc=rs.getObject(8).toString();
      String fresp="";
      if (rs.getObject(9) != null){
        fresp=rs.getObject(9).toString();
      }
      String geom=rs.getObject(10).toString();
      int elim = Integer.parseInt(rs.getString(11));
      String cve_def="";
      if (rs.getObject(12) != null){
        cve_def=rs.getObject(12).toString();
      }
      String status=rs.getObject(13).toString();
         String nota="";
      if (rs.getObject(14) != null){
        nota=rs.getObject(14).toString();
       }
      String figura=rs.getObject(15).toString();
       String cgo_def="";
      if (rs.getObject(16) != null){
        cgo_def=rs.getObject(16).toString();
      }
          String cveoper=rs.getObject(17).toString();

      String sttxt="";
      switch(status){
             case "1":sttxt="Aceptada";break;
             case "2":sttxt="C/cambios";break;
             case "3":
             case "4":
             case "5":
             case "6":
             case "7":
             case "8":
             case "9":
             case "10":
             case "11":
             case "12":
             case "13":
                    sttxt="Rechazada";break;
      }
      String cgotxt="";
      switch(cgo){
             case "7":cgotxt="Nueva";break;
             case "8":cgotxt="Baja";break;
             case "81":cgotxt="Baja (Inexistente)";break;
             case "82":cgotxt="Baja (Conurbacion)";break;
             case "83":cgotxt="Baja (Fusion)";break;
             case "9":cgotxt="Cambio de Nombre";break;
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
            resp="<td align=center nowrap><div id=pr2"+gid+cgo+">&nbsp;<input type=button onclick='ver_resp(\""+cve_ent+" "+cve_mun+" "+cve_loc+" "+cve_ageb+"\","+gid+");' value=' Respuesta ' class='boton'>&nbsp;</div>";
          break;
        case "2":
          protxt="<td align=center nowrap><div id=pr1"+gid+cgo+">&nbsp;&nbsp;<font color='green'><b>SI PROCEDE</b></font>&nbsp;&nbsp;</div>";
           if (cgo_def.equals("1")){
             resp="<td align=center nowrap><div id=pr2"+gid+cgo+">&nbsp;"+cve_def+"-M&nbsp;</div>";
          }else if (cgo_def.equals("2")){
             resp="<td align=center nowrap><div id=pr2"+gid+cgo+">&nbsp;"+cve_def+"-C&nbsp;</div>";
          }else if (cgo_def.equals("3")){
             resp="<td align=center nowrap><div id=pr2"+gid+cgo+">&nbsp;"+cve_def+"-L&nbsp;</div>";
          }
          break;
        case "3":
        case "4":
        //protxt="<td align=center nowrap><div id=pr1"+gid+cgo+">&nbsp;&nbsp;<a class='liga2' title='Regresar el registro a SIN RESPUESTA'  href='javascript:;' onclick='campro("+gid+",\""+cgo+"\");'><font color='red'><b>NO PROCEDE</b></font></a>&nbsp;&nbsp;</div>";
          protxt="<td align=center nowrap><div id=pr1"+gid+cgo+">&nbsp;&nbsp;<b>NO PROCEDE</b>&nbsp;&nbsp;</div>";
          resp="<td align=center nowrap><div id=pr2"+gid+cgo+">&nbsp;&nbsp;--&nbsp;&nbsp;</div>";
          break;
        //case "3": protxt="<td align=center nowrap><div id=pr1"+gid+cgo+">&nbsp;&nbsp;<a class='liga2' title='Regresar el registro a SIN RESPUESTA'  href='javascript:;' onclick='campro("+gid+",\""+cgo+"\");'><font color='#FFBF00'><b>PROYECTADA</b></font></a>&nbsp;&nbsp;</div>";
        //  resp="<td align=center nowrap><div id=pr2"+gid+cgo+">&nbsp;&nbsp;"+cve_def+"&nbsp;&nbsp;</div>";
        //  break;
      }
      if (status.equals("3")){
            protxt="<td align=center nowrap><div id=pr1"+gid+cgo+">&nbsp;&nbsp;<font color='red'><b>NO PROCEDE</b></font>&nbsp;&nbsp;</div>";
            //resp="<td align=center nowrap><div id=pr2"+gid+cgo+">&nbsp;&nbsp;--&nbsp;&nbsp;</div>";
      }
      if (elim==0){   //le pongo ban=1 cuando tiene baja posterior
        out.println( "<tr class=c>");
      }else{
        out.println( "<tr class=c bgcolor='#F4FA58'>");
      }
      //out.println( "<td align=center nowrap>&nbsp;&nbsp;"+gid+"&nbsp;&nbsp;");
      if (geom.equals("1")){
        out.println("<td>"+gid+"<td align=center nowrap>&nbsp;<input type=button onclick='obt_geom(\""+gid+figura+"\","+cgo+");' value=' Ver ' class='boton'>&nbsp;");
      }else{
        out.println("<td>"+gid+"<td align=center nowrap title='Sin geometria'>&nbsp;-&nbsp;");
      }
            out.println("<td align=center nowrap>&nbsp;"+cveoper+"<td align=center nowrap>&nbsp;"+cve_ent+"&nbsp;"+cve_mun+"&nbsp;"+cve_loc+"&nbsp;"+cve_ageb+"&nbsp;");
            //out.println("<td align=center nowrap title='"+tipotxt+"'>&nbsp;&nbsp;"+tipomza+"&nbsp;&nbsp;/&nbsp;&nbsp;"+tipovi+"&nbsp;&nbsp;");
            out.println("<td align=center nowrap title='"+cgotxt+"'>&nbsp;&nbsp;"+cgo+"&nbsp;&nbsp;");
            //out.println("<td align=center nowrap title='"+nota+"'>&nbsp;&nbsp;"+status+"&nbsp;&nbsp;");
            out.println("<td align=center nowrap title='"+nota+"'>&nbsp;&nbsp;"+sttxt+"&nbsp;&nbsp;");
            out.println("<td align=center nowrap title='"+nota+"'>&nbsp;&nbsp;"+figura+"&nbsp;&nbsp;");
            out.println("<td align=center nowrap>&nbsp;&nbsp;"+f_registro+"&nbsp;&nbsp;");
            out.println("<td align=center nowrap>&nbsp;&nbsp;"+fresp+"&nbsp;&nbsp;");
            out.println(protxt);
            /*if (proc.equals("2") || proc.equals("3") || proc.equals("4")){
                out.println("<td align=center nowrap>&nbsp;"+proc+"&nbsp;");
            }else{
                out.println("<td align=center nowrap>&nbsp;&nbsp;");
            }*/
            out.println(resp);
            if (elim==1){
              out.println("<td align=center nowrap title='Este registro tiene error en el codigo de baja (3)'>&nbsp;<img src=images/res.png>&nbsp;");
            }else{
              out.println("<td align=center nowrap>&nbsp;");
            }

            n++;
       }
    rs.close();

    out.println( "</table><br><center><table align=center><tr align=center><td><font class=n>Total de Registros: " + totalRows +"</font><br><br>");


 //String export = consulta.replace("%", "-");
  //out.println ("<table><tr><td nowrap><input class='boton' type='Button' onClick='exp(\""+export.replace("'","*")+"\");' value=' Exportar a DBF '/>");

String barra="";
if(startIndex != 0) {
barra="<a class=liga1 href='modcarloc.jsp?loc="+loc+"&pass="+pass+"&tipo="+tipo+"&ban="+ban+"&startIndex="+(startIndex-numRecordsPerPage)+"'> &nbsp;<<&nbsp; </a>";
}

for (n =0 ; n<numPages; n++){
  if (n*numRecordsPerPage == startIndex) {
    // Si el numero de pagina es la actual ($_pagi_actual). Se escribe el numero, pero sin enlace y en negrita.
    barra+="<b> &nbsp;<font class=liga>"+(n+1)+"</font>&nbsp; </b>";
  }else{
    // Si es cualquier otro. Se escibe el enlace a dicho numero de pagina.
    barra+="<a class=liga1 href='modcarloc.jsp?filent="+filent+"&filtipo="+filtipo+"&filtipo2="+filtipo2+"&filfe1="+filfe1+"&filfe2="+filfe2+"&loc="+loc+"&pass="+pass+"&tipo="+tipo+"&ban="+ban+"&startIndex="+(numRecordsPerPage*n)+"'> &nbsp;"+(n+1)+"&nbsp; </a>";
  }
 }




if(startIndex+numRecordsPerPage <= totalRows){
  barra+="<a class=liga1 href='modcarloc.jsp?filent="+filent+"&filtipo="+filtipo+"&filtipo2="+filtipo2+"&filfe1="+filfe1+"&filfe2="+filfe2+"&loc="+loc+"&pass="+pass+"&tipo="+tipo+"&ban="+ban+"&startIndex="+(startIndex+numRecordsPerPage)+"'> &nbsp;>>&nbsp; </a>";
}
out.println(barra+"<br><br>");
 String export = consulta.replace("%", "$");
        export = export.replace("'","%2A");
        export = export.replace("|","%7C");
        export = export.substring(0, (export.indexOf("order by cve_ent,cve_mun,cve_loc,cve_ageb,gid")+45));


  out.println ("<tr><td nowrap align=center><input class='boton' type='Button' onClick='exp(\""+export+"\");' value=' Exportar a DBF '/>");

}else{   //ban
   out.println ("</table><table class='n'><tr><td><br><br><tr><td>Genera la consulta y presiona \"Buscar\"");

}
    str.close();
    conexion.close();
/* }//try

    catch (SQLException ex){
      out.println("<script>");
      out.println("  alert(\"Se genero la expresion de SQL: "+ex.getMessage()+" !\");");
      out.println("</script>");
    }

    catch(Exception ex){
      out.println("<script>");
      out.println("  alert(\"Se genero la expresion: "+ex.getMessage()+" !\");");
      out.println("</script>");
    }*/
    }else{
          out.println("<script>opener.cerrarSesion();window.close();</script>");
    }
%>
</body>
</html>
