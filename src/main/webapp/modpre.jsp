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
window.resizeTo(900,600);


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

function modval(val,cons,id,tipo) {
    var ajax=nuevoAjax();
    ajax.open("GET",'modvalpre_acu.jsp?cons='+cons+'&id='+id+'&val='+val+'&tipo='+tipo+'&tabla=pre', true);
    ajax.onreadystatechange=function()
    {
        if(ajax.readyState==4)  {
             var vale=ajax.responseText;
            if (vale=='x'){
                alert ("No se pudo modificar la validacion!!");
            }else{
                div="voc"+id+"_"+tipo;
                  if (val=='N'){
                      tabla = "<img title='"+id+" - Registro sin validar (Click para validar)' onclick='modval(\"S\","+cons+","+id+","+tipo+");' border='0' src=images/sinval.png border=0></img>";
                  }else if (val=='S'){
                      tabla = "<img title='"+id+" - Registro validado (Click para retener)' onclick='modval(\"R\","+cons+","+id+","+tipo+");' border='0' src=images/val.png border=0></img>";
                  }else{
                      tabla = "<img title='"+id+" - Registro retenido (Click para invalidar)' onclick='modval(\"N\","+cons+","+id+","+tipo+");' border='0' src=images/ret.png border=0></img></div>";
                  }
                document.getElementById(div).innerHTML = tabla;
            }
        }
    }
    ajax.send(null);
    }



function observaval(gid,nivel,tipo,val,cons){
ventana = window.open('verobsvalpre_acu.jsp?cons='+cons+'&gid='+gid+'&nivel='+nivel+'&val='+val+'&tipo='+tipo+'&tabla=pre','Observapre','scrollbars=no,toolbar=no');
ventana.focus();
}

function observaed(gid,nivel,tipo,val,cons){
ventana = window.open('verobsvalpre_acu.jsp?cons='+cons+'&gid='+gid+'&nivel='+nivel+'&val='+val+'&tipo='+tipo+'&tabla=pre','Observapre','scrollbars=no,toolbar=no');
ventana.focus();
}

function obt_geom(gid,ban){
    var ajax=nuevoAjax();
    ajax.open("GET",'obtgeo_modpre.jsp?id='+gid+'&ban='+ban, true);
    ajax.onreadystatechange=function()
    {
        if(ajax.readyState==4)  {
             var vale=ajax.responseText;
            if (parseInt(vale)==1){
                alert ("No se pudo obtener las coordenadas!!");
            }else{
                window.opener.buscazoompre(ban,vale);
            }
        }
    }
    ajax.send(null);
}


function enviabcuu(){
if (document.enviar.bcuu.checked==false || 1==1){   //1==1 lo obligo a entrar
  cadena="INCLUDE;INCLUDE;cve_baja<>'BCUU'";
}else{
  cadena="INCLUDE;INCLUDE;INCLUDE";

}
   opener.predig.params["CQL_FILTER"] = cadena;
   opener.predig.redraw(true);
  document.enviar.submit();
}


setTimeout(function(){
  cadena=opener.predig.params["CQL_FILTER"];
  //console.log(cadena);
  if (cadena.search("BCUU")==-1){ //no se encontro
    //document.enviar.bcuu.checked=true;    //aqui quitamos lo de la bcuu
  }
}, 1000);

function envia(n){
    document.enviar.submit();
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

try {

int n=0;
int n1=0;
String  ent = "",regid = "",
        loc = request.getParameter("loc"),
        bcuu = request.getParameter("bcuu"),
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
         select1="",
         st = "",
         filent="",
         filtipo="",
         filfe1="",
         filfe2="",
         where="",
         obs="",observa="",lobs="",obs1="";
      consultapas = "select nivel,edicionagpr,id,regid,nombre,cons from usuarios where md5(password) = '"+pass+"';";


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
        //out.println("<script>window.opener.location.reload(false);window.close();</script>");
         // out.println("<script>window.opener.location.reload(false);window.close();</script>");
        //out.println("LA SESION SIGUE ACTIVA");

    }else{
          out.println("<script>opener.cerrarSesion();window.close();</script>");

    }


String remotehost  = session.getAttribute("remotehost").toString();
String regionalid  = session.getAttribute("regionalid").toString();
if (bcuu==null){
 bcuu="off";
}

      
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
      Integer cons=(Integer) rs.getObject(6);

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
filfe1 = request.getParameter("filfe1");
filfe2 = request.getParameter("filfe2");
if (filent==null)filent="00";
if (filtipo==null)filtipo="0";
if (filfe1==null){
  filfe1=fec1;
  filfe1="2024-10-01";
}
if (filfe2==null)filfe2=fec2;
filfe1 += " 00:00:00";
filfe2 += " 23:59:59";
//out.println("<br>ent:"+ent);
//out.println("<br>filent:"+filent);
//out.println("<br>filfe1:"+filfe1);
//out.println("<br>filfe2:"+filfe2);
if (filtipo.equals("0")){
  select1="";
}else if (filtipo.equals("1")){
  select1=" tipo=1 and ";     //mz
}else if (filtipo.equals("2")){
  select1=" tipo=2 and ";   //pol
}else if (filtipo.equals("3")){
  select1=" tipo=3 and ";   //point
}
if (bcuu.equals("off")){
  select1+=" (cve_baja is null or cve_baja!='BCUU') and ";
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
          consulta="select * from (select 1 as tipo,gid,cve_ent,fact,img,fdg,baja,cve_baja,conviv,cvegeo,forma,aplicado ,voc,obsoc,obsed,cur,cod from   z_digmz union select 2 as tipo,gid,cve_ent,fact,img,fdg,0,cve_ent||cve_mun||cve_ageb||cve_loc,conviv,cvegeo,'0' as forma,aplicado  ,voc,obsoc,obsed,0,0 from   z_digpe union select 3 as tipo,gid,cve_ent,fact,img,fdg,baja,cve_baja,0,cvegeo,'0',aplicado as forma ,voc,obsoc,obsed,0,0 from   z_digmp) t2 where "+select1+" fact between '"+filfe1+"' and '"+ filfe2 +"' "+filreg+
            " order by tipo,cve_ent,gid";
                }else{
          consulta="select * from (select 1 as tipo,gid,cve_ent,fact,img,fdg,baja,cve_baja,conviv,cvegeo,forma,aplicado ,voc,obsoc,obsed,cur,cod from   z_digmz union select 2 as tipo,gid,cve_ent,fact,img,fdg,0,cve_ent||cve_mun||cve_ageb||cve_loc,conviv,cvegeo,'0' as forma,aplicado  ,voc,obsoc,obsed,0,0 from   z_digpe union select 3 as tipo,gid,cve_ent,fact,img,fdg,baja,cve_baja,0,cvegeo,'0',aplicado as forma ,voc,obsoc,obsed,0,0 from   z_digmp) t2 where "+select1+" fact between '"+filfe1+"' and '"+ filfe2 +"' and cve_ent = '"+filent+"'"+
            " order by tipo,cve_ent,gid";
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
          consulta="select * from (select 1 as tipo,gid,cve_ent,fact,img,fdg,baja,cve_baja,conviv,cvegeo,forma,aplicado ,voc,obsoc,obsed,cur,cod from   z_digmz union select 2 as tipo,gid,cve_ent,fact,img,fdg,0,cve_ent||cve_mun||cve_ageb||cve_loc,conviv,cvegeo,'0' as forma,aplicado  ,voc,obsoc,obsed,0,0 from   z_digpe union select 3 as tipo,gid,cve_ent,fact,img,fdg,baja,cve_baja,0,cvegeo,'0',aplicado as forma ,voc,obsoc,obsed,0,0 from   z_digmp) t2 where "+select1+" fact between '"+filfe1+"' and '"+ filfe2 +"' "+filreg+
            " order by tipo,cve_ent,gid";
                }else{
          consulta="select * from (select 1 as tipo,gid,cve_ent,fact,img,fdg,baja,cve_baja,conviv,cvegeo,forma,aplicado ,voc,obsoc,obsed,cur,cod from   z_digmz union select 2 as tipo,gid,cve_ent,fact,img,fdg,0,cve_ent||cve_mun||cve_ageb||cve_loc,conviv,cvegeo,'0' as forma,aplicado  ,voc,obsoc,obsed,0,0 from   z_digpe union select 3 as tipo,gid,cve_ent,fact,img,fdg,baja,cve_baja,0,cvegeo,'0',aplicado as forma ,voc,obsoc,obsed,0,0 from   z_digmp) t2 where "+select1+" fact between '"+filfe1+"' and '"+ filfe2 +"' and cve_ent = '"+filent+"'"+
            " order by tipo,cve_ent,gid";
                }
                 select="<select name=filent class='boton'>";
                select+="<option value='00' ";if (filent.equals("00")){select+="selected";}select+=">TODAS</option>";
                select+=selreg+"</select>";
    }else{
    consulta="select * from (select 1 as tipo,gid,cve_ent,fact,img,fdg,baja,cve_baja,conviv,cvegeo,forma,aplicado ,voc,obsoc,obsed,cur,cod from   z_digmz union select 2 as tipo,gid,cve_ent,fact,img,fdg,0,cve_ent||cve_mun||cve_ageb||cve_loc,conviv,cvegeo,'0' as forma,aplicado  ,voc,obsoc,obsed,0,0 from   z_digpe union select 3 as tipo,gid,cve_ent,fact,img,fdg,baja,cve_baja,0,cvegeo,'0',aplicado as forma ,voc,obsoc,obsed,0,0 from   z_digmp) t2 where "+select1+" fact between '"+filfe1+"' and '"+ filfe2 +"' and cve_ent = '"+ent+"'"+
      " order by tipo,cve_ent,gid";
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
    consulta="select * from (select 1 as tipo,gid,cve_ent,fact,img,fdg,baja,cve_baja,conviv,cvegeo,forma,aplicado ,voc,obsoc,obsed,cur,cod from   z_digmz union select 2 as tipo,gid,cve_ent,fact,img,fdg,0,cve_ent||cve_mun||cve_ageb||cve_loc,conviv,cvegeo,'0' as forma,aplicado  ,voc,obsoc,obsed,0,0 from   z_digpe union select 3 as tipo,gid,cve_ent,fact,img,fdg,baja,cve_baja,0,cvegeo,'0',aplicado as forma ,voc,obsoc,obsed,0,0 from   z_digmp) t2 where  replace(cvegeo,'-','') like '" + loc.replace("-", "") + "%' "+filult+"  order by cvegeo,gid";
         where = "replace(cvegeo,'-','') like '" +  loc.replace("-", "") + "%' "+filult+" order cvegeo,gid";
}



       select1="<select name=filtipo class='boton'>";
       select1+="<option value='0' ";if (filtipo.equals("0")){select1+="selected";}select1+=">TODOS</option>";
       select1+="<option value='1' ";if (filtipo.equals("1")){select1+="selected";}select1+=">MANZANAS</option>";
       select1+="<option value='2' ";if (filtipo.equals("2")){select1+="selected";}select1+=">POLIGONO</option>";
       select1+="<option value='3' ";if (filtipo.equals("3")){select1+="selected";}select1+=">PUNTO</option>";
      out.println( "<center class='t'>Informacion Predigitalizada</center>"
                + "<form action=\"modpre.jsp\" method=\"post\" name=\"enviar\">"
                + "<center><br>"
                + "&nbsp;&nbsp;&nbsp;&nbsp;<font class=n>De:</font>&nbsp;<input class='boton' name='filfe1' type='text' id='p1id' onClick=\"popUpCalendar(this, enviar.p1id, 'yyyy-mm-dd');\" size='10'  value='"+filfe1.substring(0,10)+"'>"
                + "&nbsp;&nbsp;&nbsp;&nbsp;<font class=n>a:</font>&nbsp;<input class='boton' name='filfe2' type='text' id='p2id' onClick=\"popUpCalendar(this, enviar.p2id, 'yyyy-mm-dd');\" size='10'  value='"+filfe2.substring(0,10)+"'>"
                + "&nbsp;&nbsp;&nbsp;&nbsp;<font class=n>Entidad:</font>&nbsp;"+select
                + "&nbsp;&nbsp;&nbsp;&nbsp;<font class=n>Tipo:</font>&nbsp;"+select1
                + "<input type='hidden' name='ent' value='"+ent+"'><input type='hidden' name='ban' value='1'><input type='hidden' name='regid' value='"+regid+"'>&nbsp;&nbsp;&nbsp;&nbsp;<input class='boton' type='button' value=' Buscar ' onclick='envia(1)''><br><br><font class=n>Por ageb:&nbsp;&nbsp;</font>"
                + "<input type='text' maxlength=22 size=20 name='loc' value='"+loc+"' class='boton'><input type='hidden' name='pass' value='"+pass+"'>&nbsp;&nbsp;&nbsp;&nbsp;<input class='boton' type='button' value=' Buscar ' onclick='envia(2)'></form><font class=n><br><br>");
//  out.println( "<input type=checkbox name=bcuu onclick='enviabcuu();' class=boton");
  out.println( "<input type=hidden name=bcuu value='off'><br>");
//out.println(consulta);
  if (bcuu.equals("on")){
    out.println(" checked");
}
  //out.println( ">Incluir manzanas BCUU<br><br></font>");
  out.println( "<table border=1><tr class=n bgcolor=#BBBBBB>");
       //if (s1!=2){
      out.println("<th rowspan=1>Val<br>&nbsp;OC&nbsp;");out.println("<th rowspan=1>Obs<br>&nbsp;OC&nbsp;<th rowspan=1>Obs<br>&nbsp;Edo&nbsp;");    //}
  out.println("<th>&nbsp;&nbsp;Ver&nbsp;&nbsp;<th>&nbsp;&nbsp;Tipo&nbsp;&nbsp;<th>&nbsp;Clave&nbsp;<th>&nbsp;# Inm&nbsp;<th>Fecha<br>&nbsp;registro&nbsp;<th>&nbsp;Imagen&nbsp;<th>&nbsp;Clave/Baja&nbsp;<th>&nbsp;Ageb&nbsp;<th>&nbsp;Aplicado&nbsp;<th>&nbsp;Codigo&nbsp;<th title='Criterio'>&nbsp;Criterio&nbsp;");
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
      String cvegeo="";
      int forma;
      int aplicado;
    String obsoc="",lobsoc="",voc="",col="",obsed="",lobsed="";
    int cur=0,cod=0;

    while(rs.next()){
      int tipo=Integer.parseInt(rs.getString(1));
      String gid=rs.getObject(2).toString();
      String cve_ent=rs.getObject(3).toString();
      String fact=rs.getObject(4).toString().substring(0,10);
      String img="";
      if (rs.getObject(5) != null){
        img=rs.getObject(5).toString();
      }
      String fdg="";
      if (rs.getObject(6) != null){
        fdg=rs.getObject(6).toString();
      }

      String tipotxt="";
      switch(tipo){
             case 1:tipotxt="MANZANA";break;
             case 2:tipotxt="POLIGONO";break;
             case 3:tipotxt="PUNTO";break;
      }
      int baja=Integer.parseInt(rs.getString(7));
      String cvebaja="-";
      if (rs.getObject(8) != null){
        cvebaja=rs.getObject(8).toString();
      }
      int conviv=Integer.parseInt(rs.getString(9));

      if (tipo==1 && baja==800){   //manzana 800
        cvebaja="800";
      }

      if (rs.getObject(10) != null){
        cvegeo=rs.getObject(10).toString();
      }
       forma=Integer.parseInt(rs.getString(11));
       aplicado=0;
       if (rs.getObject(12) != null){
        aplicado=Integer.parseInt(rs.getString(12));
      }


     voc=rs.getString(13);
          obsoc="";

      if (rs.getString(14) != null){
        obsoc=rs.getString(14);
      }
      obsed="";
      if (rs.getString(15) != null){
        obsed=rs.getString(15);
      }
        cur=Integer.parseInt(rs.getString(16));
        cod=Integer.parseInt(rs.getString(17));
      out.println( "<tr class=c>");

//// validacion oc
 
 if (s1.equals("3")){
        if (voc.equals("N")){
            out.println("<td align=center><div id=voc"+gid+"_"+tipo+"><img title='"+gid+" - Registro sin validar (Click para validar)' onclick='modval(\"S\","+cons+","+gid+","+tipo+");' border='0' src=images/sinval.png border=0></img></div>");
        }else if (voc.equals("S")){
            out.println("<td align=center><div id=voc"+gid+"_"+tipo+"><img title='"+gid+" - Registro validado (Click para retener)' onclick='modval(\"R\","+cons+","+gid+","+tipo+");' border='0' src=images/val.png border=0></img></div>");
        }else{
            out.println("<td align=center><div id=voc"+gid+"_"+tipo+"><img title='"+gid+" - Registro retenido (Click para invalidar)' onclick='modval(\"N\","+cons+","+gid+","+tipo+");' border='0' src=images/ret.png border=0></img></div>");
        }
     }else{
            if (voc.equals("N")){
                out.println ("<td align=center><div id=voc"+gid+"_"+tipo+"><img title='"+gid+" - Registro sin validar' border='0' src=images/sinval.png border=0></img></div>");
            }else if (voc.equals("S")){
                out.println ( "<td align=center><div id=voc"+gid+"_"+tipo+"><img title='"+gid+" - Registro validado' border='0' src=images/val.png border=0></img></div>");
            }else{
                out.println ( "<td align=center><div id=voc"+gid+"_"+tipo+"><img title='"+gid+" - Registro retenido' border='0' src=images/ret.png border=0></img></div>");
            }
    }

col="";

 if (obsoc.length()>1){col="bgcolor=#2EFE2E";}
    out.println ("<td "+col+" align=center nowrap title='"+obsoc+"'>&nbsp;&nbsp;<input type=button onclick='observaval("+gid+","+s1+","+tipo+",1,"+cons+");' value=' Obs ' class='boton'>&nbsp;&nbsp;");

col="";
 if (obsed.length()>1){col="bgcolor=#2EFE2E";}
    out.println ("<td "+col+" align=center nowrap title='"+obsed+"'>&nbsp;&nbsp;<input type=button onclick='observaed("+gid+","+s1+","+tipo+",3,"+cons+");' value=' Obs ' class='boton'>&nbsp;&nbsp;");

///// vaidacion OC





        out.println("<td align=center nowrap>&nbsp;<input type=button onclick='obt_geom("+gid+","+tipo+");' value=' Geom ' class='boton'>&nbsp;");
        out.println("<td align=center nowrap>&nbsp;&nbsp;"+tipotxt+"&nbsp;&nbsp;");
        //if (tipo==2){
        //    out.println("<td align=center nowrap>&nbsp;"+cvebaja+"&nbsp;");
        //}else{
            out.println("<td align=center nowrap>&nbsp;"+cve_ent+"&nbsp;");
          //}

            out.println("<td align=center nowrap>&nbsp;&nbsp;"+conviv+"&nbsp;&nbsp;");
            out.println("<td align=center nowrap>&nbsp;&nbsp;"+fact+"&nbsp;&nbsp;");
       if ((fdg.equals(""))){
          out.println("<td align=center nowrap>&nbsp;"+img+"&nbsp;");
      }else{
          out.println("<td align=center nowrap>&nbsp;"+img+"-"+fdg+"&nbsp;");
    }
        //if (tipo==2 || tipo=1){
            out.println("<td align=center nowrap>&nbsp;"+cvebaja+"&nbsp;");
        //}else{
         //   out.println("<td align=center nowrap>&nbsp;-&nbsp;");
        //}
            out.println("<td align=center nowrap>&nbsp;"+cvegeo+"&nbsp;");


      
 if ((aplicado==1)){
          out.println("<td align=center nowrap>&nbsp;SI&nbsp;");
      }else if ((aplicado==2)){
        out.println("<td align=center nowrap>&nbsp;NO PROCEDE&nbsp;");
      }else{
         out.println("<td align=center nowrap>&nbsp;-&nbsp;");
  }


if (tipo==1){
  if ((forma==1)){
      if ((cod==0)){
        out.println("<td align=center nowrap>&nbsp;FORMA&nbsp;");
      }else{
        out.println("<td align=center nowrap>&nbsp;FORMA-"+cod+"&nbsp;");
      }
  }else{
      out.println("<td align=center nowrap>&nbsp;"+cod+"&nbsp;");
  }
  if ((cur==1)){
      out.println("<td align=center nowrap>&nbsp;CUR&nbsp;");
  }else{
      out.println("<td align=center nowrap>&nbsp;MG&nbsp;");
  }
}else{
     out.println("<td align=center nowrap>&nbsp;-&nbsp;");
     out.println("<td align=center nowrap>&nbsp;-&nbsp;");
}



            n++;
       }
    rs.close();
  out.println( "</table><br><center><table align=center><tr align=center><td><font class=n>Total de Registros: " + totalRows +"</font><br><br>");

 //String export = consulta.replace("%", "-");
  //out.println ("<table><tr><td nowrap><input class='boton' type='Button' onClick='exp(\""+export.replace("'","*")+"\");' value=' Exportar a DBF '/>");

String barra="";
if(startIndex != 0) {
barra="<a class=liga1 href='modpre.jsp?filent="+filent+"&filtipo="+filtipo+"&filfe1="+filfe1.substring(0,10)+"&filfe2="+filfe2.substring(0,10)+"&loc="+loc+"&pass="+pass+"&ban="+ban+"&bcuu="+bcuu+"&startIndex="+(startIndex-numRecordsPerPage)+"'> &nbsp;<<&nbsp; </a>";
}

for (n =0 ; n<numPages; n++){
  if (n*numRecordsPerPage == startIndex) {
    // Si el numero de pagina es la actual ($_pagi_actual). Se escribe el numero, pero sin enlace y en negrita.
    barra+="<b> &nbsp;<font class=liga>"+(n+1)+"</font>&nbsp; </b>";
  }else{
    // Si es cualquier otro. Se escibe el enlace a dicho numero de pagina.
    barra+="<a class=liga1 href='modpre.jsp?filent="+filent+"&filtipo="+filtipo+"&filfe1="+filfe1.substring(0,10)+"&filfe2="+filfe2.substring(0,10)+"&loc="+loc+"&pass="+pass+"&ban="+ban+"&bcuu="+bcuu+"&startIndex="+(numRecordsPerPage*n)+"'> &nbsp;"+(n+1)+"&nbsp; </a>";
  }
 }


if(startIndex+numRecordsPerPage <= totalRows){
  barra+="<a class=liga1 href='modpre.jsp?filent="+filent+"&filtipo="+filtipo+"&filfe1="+filfe1.substring(0,10)+"&filfe2="+filfe2.substring(0,10)+"&loc="+loc+"&pass="+pass+"&ban="+ban+"&bcuu="+bcuu+"&startIndex="+(startIndex+numRecordsPerPage)+"'> &nbsp;>>&nbsp; </a>";
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

%>
</body>
</html>
