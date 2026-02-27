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
window.resizeTo(850,600);



function observaval(gid,tipo,nivel,tipote){
if (tipote=='PR'){
      tipot="2";
    }else if (tipote=='AU'){
      tipot="1";
    }else{
      tipot="3";   //poligono externo
    }
ventana = window.open('verobsmzvalpe.jsp?gid='+gid+'&tipo='+tipo+'&tipote='+tipot+'&nivel='+nivel,'Observapre','scrollbars=no,toolbar=no');
ventana.focus();
}

function modval(val,cons,id,tipoval,tipote) {
    var ajax=nuevoAjax();
    ajax.open("GET",'modvalpe.jsp?cons='+cons+'&id='+id+'&tipoval='+tipoval+'&val='+val+'&tipote='+tipote, true);
    ajax.onreadystatechange=function()
    {
        if(ajax.readyState==4)  {
             var vale=ajax.responseText;
            if (vale=='x'){
                alert ("No se pudo modificar la validacion!!");
            }else{
                div="valof"+id;
                  if (val=='N'){
                      tabla = "<img title='Registro sin validar (Click para validar)' onclick='modval(\"S\","+cons+","+id+",\""+tipoval+"\",\""+tipote+"\");' border='0' src=images/sinval.png border=0></img>";
                  }else if (val=='S'){
                      tabla = "<img title='Registro validado (Click para retener)' onclick='modval(\"R\","+cons+","+id+",\""+tipoval+"\",\""+tipote+"\");' border='0' src=images/val.png border=0></img>";
                  }else{
                      tabla = "<img title='Registro retenido (Click para invalidar)' onclick='modval(\"N\","+cons+","+id+",\""+tipoval+"\",\""+tipote+"\");' border='0' src=images/ret.png border=0></img></div>";
                  }
            }
                document.getElementById(div).innerHTML = tabla;
        }
    }
    ajax.send(null);
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




function obt_geom(gid){
    var ajax=nuevoAjax();
    ajax.open("GET",'obtgeo_tefr.jsp?gid='+gid, true);
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

function regresa(gid) {
  document.all.pleasewaitScreen.style.visibility="visible";
    var ajax=nuevoAjax();
    ajax.open("GET",'regresa_tefr.jsp?gid='+gid, true);
    ajax.onreadystatechange=function()
    {
        if(ajax.readyState==4)  {
             document.all.pleasewaitScreen.style.visibility="hidden";
             var vale=ajax.responseText;
            if (parseInt(vale)==1){
                alert ("No se pudo regresar el registro!!");
            }else{
              location.reload();
            }
            }
    }
    ajax.send(null);
    }



function envia(n){
  document.enviar.loc.value=document.enviar.loc.value.replace(/ /g, '');
  document.enviar.loc.value=document.enviar.loc.value.replace('-', '');
  document.enviar.loc.value=document.enviar.loc.value.replace(/;/g, '');
  document.enviar.loc.value=document.enviar.loc.value.replace(/'/g, '');
  document.enviar.loc.value=document.enviar.loc.value.replace(/\u00a0/g, '');
document.enviar.loc.value=document.enviar.loc.value.replace(/\t/g,'');

  document.enviar.oper.value=document.enviar.oper.value.replace(/ /g, '');
  document.enviar.oper.value=document.enviar.oper.value.replace('-', '');
  document.enviar.oper.value=document.enviar.oper.value.replace(/;/g, '');
  document.enviar.oper.value=document.enviar.oper.value.replace(/'/g, '');
  document.enviar.oper.value=document.enviar.oper.value.replace(/\u00a0/g, '');
document.enviar.oper.value=document.enviar.oper.value.replace(/\t/g,'');


  if (n==1){
    document.enviar.loc.value='';
    document.enviar.oper.value='';
    document.enviar.submit();
  }else{
    document.enviar.submit();
  }
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
        oper = request.getParameter("oper"),
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
         obs="",observa="",lobs="",obs1="",filerr1="",filerrq="";
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
  if (oper==null){
    oper="";
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
filerr1 = request.getParameter("filerr1");


if (filerr1!=null && (filerr1.equals("R") ||  filerr1.equals("S") ||  filerr1.equals("N"))){
        filerrq+=" voc='"+filerr1+"' and ";
      }


if (filent==null)filent="00";
if (filtipo==null)filtipo="0";
if (filfe1==null){
  filfe1=fec1;
  filfe1="2019-01-01";
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
  select1=" tipo=1 and ";     //ageburb
}else if (filtipo.equals("2")){
  select1=" tipo=2 and ";   //polrur
}else if (filtipo.equals("3")){
  select1=" tipo=3 and ";   //externo
}
select1=select1+filerrq;
if ((ent.equals("00"))){
        switch(regionalid){
          case "01":
                filreg = " cve_ent in ('02','03','25','26')";
                selreg+="<option value='02' ";if (filent.equals("02")){selreg+="selected";}selreg+=">02</option>";
                selreg+="<option value='03' ";if (filent.equals("03")){selreg+="selected";}selreg+=">03</option>";
                selreg+="<option value='25' ";if (filent.equals("25")){selreg+="selected";}selreg+=">25</option>";
                selreg+="<option value='26' ";if (filent.equals("26")){selreg+="selected";}selreg+=">26</option>";
            break;
          case "02":
                filreg = "  cve_ent in ('08','10','32')";
                selreg+="<option value='08' ";if (filent.equals("08")){selreg+="selected";}selreg+=">08</option>";
                selreg+="<option value='10' ";if (filent.equals("10")){selreg+="selected";}selreg+=">10</option>";
                selreg+="<option value='32' ";if (filent.equals("32")){selreg+="selected";}selreg+=">32</option>";
            break;
          case "03":
                filreg = "  cve_ent in ('05','19','28')";
                selreg+="<option value='05' ";if (filent.equals("05")){selreg+="selected";}selreg+=">05</option>";
                selreg+="<option value='19' ";if (filent.equals("19")){selreg+="selected";}selreg+=">19</option>";
                selreg+="<option value='28' ";if (filent.equals("28")){selreg+="selected";}selreg+=">28</option>";
            break;
          case "04":
                filreg = "  cve_ent in ('06','14','16','18')";
                selreg+="<option value='06' ";if (filent.equals("06")){selreg+="selected";}selreg+=">06</option>";
                selreg+="<option value='14' ";if (filent.equals("14")){selreg+="selected";}selreg+=">14</option>";
                selreg+="<option value='16' ";if (filent.equals("16")){selreg+="selected";}selreg+=">16</option>";
                selreg+="<option value='18' ";if (filent.equals("18")){selreg+="selected";}selreg+=">18</option>";
            break;
          case "05":
                filreg = "  cve_ent in ('01','11','22','24')";
                selreg+="<option value='01' ";if (filent.equals("01")){selreg+="selected";}selreg+=">01</option>";
                selreg+="<option value='11' ";if (filent.equals("11")){selreg+="selected";}selreg+=">11</option>";
                selreg+="<option value='22' ";if (filent.equals("22")){selreg+="selected";}selreg+=">22</option>";
                selreg+="<option value='24' ";if (filent.equals("24")){selreg+="selected";}selreg+=">24</option>";
            break;
          case "06":
                filreg = "  cve_ent in ('12','15','17')";
                selreg+="<option value='12' ";if (filent.equals("12")){selreg+="selected";}selreg+=">12</option>";
                selreg+="<option value='15' ";if (filent.equals("15")){selreg+="selected";}selreg+=">15</option>";
                selreg+="<option value='17' ";if (filent.equals("17")){selreg+="selected";}selreg+=">17</option>";
            break;
          case "07":
                filreg = "  cve_ent in ('13','21','29','30')";
                selreg+="<option value='13' ";if (filent.equals("13")){selreg+="selected";}selreg+=">13</option>";
                selreg+="<option value='21' ";if (filent.equals("21")){selreg+="selected";}selreg+=">21</option>";
                selreg+="<option value='29' ";if (filent.equals("29")){selreg+="selected";}selreg+=">29</option>";
                selreg+="<option value='30' ";if (filent.equals("30")){selreg+="selected";}selreg+=">30</option>";
            break;
          case "08":
                filreg = "  cve_ent in ('07','20','27')";
                selreg+="<option value='07' ";if (filent.equals("07")){selreg+="selected";}selreg+=">07</option>";
                selreg+="<option value='20' ";if (filent.equals("20")){selreg+="selected";}selreg+=">20</option>";
                selreg+="<option value='27' ";if (filent.equals("27")){selreg+="selected";}selreg+=">27</option>";
            break;
          case "09":
                filreg = "  cve_ent in ('04','23','31')";
                selreg+="<option value='04' ";if (filent.equals("04")){selreg+="selected";}selreg+=">04</option>";
                selreg+="<option value='23' ";if (filent.equals("23")){selreg+="selected";}selreg+=">23</option>";
                selreg+="<option value='31' ";if (filent.equals("31")){selreg+="selected";}selreg+=">31</option>";
            break;
          case "10":
                filreg = "  cve_ent in ('09')";
                selreg+="<option value='09' ";if (filent.equals("09")){selreg+="selected";}selreg+=">09</option>";
            break;
        }
            if (filent.equals("00")){

          consulta=" select gid, cve_ent,cveoper, substring(clave,1,2)||' '||substring(clave,3,3)||' '||substring(clave,6,4)||' '||substring(clave,10,4)||' '||substring(clave,14,3) as clave,cve_ft,the_geom, substring(clave_def,1,2)||' '||substring(clave_def,3,3)||' '||substring(clave_def,6,4)||' '||substring(clave_def,10,4)||' '||substring(clave_def,14,3) as clave_def ,substring(clave_def,17,3) as cve_ft_def,num,obs,usuario , fact from  ( SELECT gid, cve_ent, cveoper, clave, cve_ft, the_geom,clave_def,1 as num, obs, usuario , fact FROM te_fr   where clave_def='0' union  SELECT gid, cve_ent, cveoper, clave, cve_ft, the_geom, unnest(string_to_array(substring(clave_def,1,(length(clave_def)-1)),',')),array_length(string_to_array(substring(clave_def,1,(length(clave_def)-1)),','),1), obs, usuario , fact FROM te_fr  where clave_def!='0') t1 where "+filreg+ " order by cveoper,clave,cve_ft";
                }else{
          consulta="select gid, cve_ent,cveoper, substring(clave,1,2)||' '||substring(clave,3,3)||' '||substring(clave,6,4)||' '||substring(clave,10,4)||' '||substring(clave,14,3) as clave,cve_ft,the_geom, substring(clave_def,1,2)||' '||substring(clave_def,3,3)||' '||substring(clave_def,6,4)||' '||substring(clave_def,10,4)||' '||substring(clave_def,14,3) as clave_def ,substring(clave_def,17,3) as cve_ft_def,num,obs,usuario , fact from  ( SELECT gid, cve_ent, cveoper, clave, cve_ft, the_geom,clave_def,1 as num, obs, usuario , fact FROM te_fr   where clave_def='0' union  SELECT gid, cve_ent, cveoper, clave, cve_ft, the_geom, unnest(string_to_array(substring(clave_def,1,(length(clave_def)-1)),',')),array_length(string_to_array(substring(clave_def,1,(length(clave_def)-1)),','),1), obs, usuario , fact FROM te_fr  where clave_def!='0') t1 where  cve_ent = '"+filent+"'"+
            " order by cveoper,clave,cve_ft";
                }
                 select="<select name=filent class='boton'>";
                select+="<option value='00' ";if (filent.equals("00")){select+="selected";}select+=">TODAS</option>";
                select+=selreg+"</select>";
    }else if (s1.equals("2")){
         switch(ent){
          case "01":
                filreg = "  cve_ent in ('02','03','25','26')";
                selreg+="<option value='02' ";if (filent.equals("02")){selreg+="selected";}selreg+=">02</option>";
                selreg+="<option value='03' ";if (filent.equals("03")){selreg+="selected";}selreg+=">03</option>";
                selreg+="<option value='25' ";if (filent.equals("25")){selreg+="selected";}selreg+=">25</option>";
                selreg+="<option value='26' ";if (filent.equals("26")){selreg+="selected";}selreg+=">26</option>";
            break;
          case "02":
                filreg = "  cve_ent in ('08','10','32')";
                selreg+="<option value='08' ";if (filent.equals("08")){selreg+="selected";}selreg+=">08</option>";
                selreg+="<option value='10' ";if (filent.equals("10")){selreg+="selected";}selreg+=">10</option>";
                selreg+="<option value='32' ";if (filent.equals("32")){selreg+="selected";}selreg+=">32</option>";
            break;
          case "03":
                filreg = "  cve_ent in ('05','19','28')";
                selreg+="<option value='05' ";if (filent.equals("05")){selreg+="selected";}selreg+=">05</option>";
                selreg+="<option value='19' ";if (filent.equals("19")){selreg+="selected";}selreg+=">19</option>";
                selreg+="<option value='28' ";if (filent.equals("28")){selreg+="selected";}selreg+=">28</option>";
            break;
          case "04":
                filreg = "  cve_ent in ('06','14','16','18')";
                selreg+="<option value='06' ";if (filent.equals("06")){selreg+="selected";}selreg+=">06</option>";
                selreg+="<option value='14' ";if (filent.equals("14")){selreg+="selected";}selreg+=">14</option>";
                selreg+="<option value='16' ";if (filent.equals("16")){selreg+="selected";}selreg+=">16</option>";
                selreg+="<option value='18' ";if (filent.equals("18")){selreg+="selected";}selreg+=">18</option>";
            break;
          case "05":
                filreg = "  cve_ent in ('01','11','22','24')";
                selreg+="<option value='01' ";if (filent.equals("01")){selreg+="selected";}selreg+=">01</option>";
                selreg+="<option value='11' ";if (filent.equals("11")){selreg+="selected";}selreg+=">11</option>";
                selreg+="<option value='22' ";if (filent.equals("22")){selreg+="selected";}selreg+=">22</option>";
                selreg+="<option value='24' ";if (filent.equals("24")){selreg+="selected";}selreg+=">24</option>";
            break;
          case "06":
                filreg = "  cve_ent in ('12','15','17')";
                selreg+="<option value='12' ";if (filent.equals("12")){selreg+="selected";}selreg+=">12</option>";
                selreg+="<option value='15' ";if (filent.equals("15")){selreg+="selected";}selreg+=">15</option>";
                selreg+="<option value='17' ";if (filent.equals("17")){selreg+="selected";}selreg+=">17</option>";
            break;
          case "07":
                filreg = "  cve_ent in ('13','21','29','30')";
                selreg+="<option value='13' ";if (filent.equals("13")){selreg+="selected";}selreg+=">13</option>";
                selreg+="<option value='21' ";if (filent.equals("21")){selreg+="selected";}selreg+=">21</option>";
                selreg+="<option value='29' ";if (filent.equals("29")){selreg+="selected";}selreg+=">29</option>";
                selreg+="<option value='30' ";if (filent.equals("30")){selreg+="selected";}selreg+=">30</option>";
            break;
          case "08":
                filreg = "  cve_ent in ('07','20','27')";
                selreg+="<option value='07' ";if (filent.equals("07")){selreg+="selected";}selreg+=">07</option>";
                selreg+="<option value='20' ";if (filent.equals("20")){selreg+="selected";}selreg+=">20</option>";
                selreg+="<option value='27' ";if (filent.equals("27")){selreg+="selected";}selreg+=">27</option>";
            break;
          case "09":
                filreg = "  cve_ent in ('04','23','31')";
                selreg+="<option value='04' ";if (filent.equals("04")){selreg+="selected";}selreg+=">04</option>";
                selreg+="<option value='23' ";if (filent.equals("23")){selreg+="selected";}selreg+=">23</option>";
                selreg+="<option value='31' ";if (filent.equals("31")){selreg+="selected";}selreg+=">31</option>";
            break;
          case "10":
                filreg = "  cve_ent in ('09')";
                selreg+="<option value='09' ";if (filent.equals("09")){selreg+="selected";}selreg+=">09</option>";
            break;
        }
            if (filent.equals("00")){
          consulta="select gid, cve_ent,cveoper, substring(clave,1,2)||' '||substring(clave,3,3)||' '||substring(clave,6,4)||' '||substring(clave,10,4)||' '||substring(clave,14,3) as clave,cve_ft,the_geom, substring(clave_def,1,2)||' '||substring(clave_def,3,3)||' '||substring(clave_def,6,4)||' '||substring(clave_def,10,4)||' '||substring(clave_def,14,3) as clave_def ,substring(clave_def,17,3) as cve_ft_def,num,obs,usuario , fact from  ( SELECT gid, cve_ent, cveoper, clave, cve_ft, the_geom,clave_def,1 as num, obs, usuario , fact FROM te_fr   where clave_def='0' union  SELECT gid, cve_ent, cveoper, clave, cve_ft, the_geom, unnest(string_to_array(substring(clave_def,1,(length(clave_def)-1)),',')),array_length(string_to_array(substring(clave_def,1,(length(clave_def)-1)),','),1), obs, usuario , fact FROM te_fr  where clave_def!='0') t1 where "+filreg+ 
            " order by cveoper,clave,cve_ft";
                }else{
          consulta="select gid, cve_ent,cveoper, substring(clave,1,2)||' '||substring(clave,3,3)||' '||substring(clave,6,4)||' '||substring(clave,10,4)||' '||substring(clave,14,3) as clave,cve_ft,the_geom, substring(clave_def,1,2)||' '||substring(clave_def,3,3)||' '||substring(clave_def,6,4)||' '||substring(clave_def,10,4)||' '||substring(clave_def,14,3) as clave_def ,substring(clave_def,17,3) as cve_ft_def,num,obs,usuario , fact from  ( SELECT gid, cve_ent, cveoper, clave, cve_ft, the_geom,clave_def,1 as num, obs, usuario , fact FROM te_fr   where clave_def='0' union  SELECT gid, cve_ent, cveoper, clave, cve_ft, the_geom, unnest(string_to_array(substring(clave_def,1,(length(clave_def)-1)),',')),array_length(string_to_array(substring(clave_def,1,(length(clave_def)-1)),','),1), obs, usuario , fact FROM te_fr  where clave_def!='0') t1 where cve_ent = '"+filent+"'"+
            " order by cveoper,clave,cve_ft";
                }
                 select="<select name=filent class='boton'>";
                select+="<option value='00' ";if (filent.equals("00")){select+="selected";}select+=">TODAS</option>";
                select+=selreg+"</select>";
    }else{
    consulta="select gid, cve_ent,cveoper, substring(clave,1,2)||' '||substring(clave,3,3)||' '||substring(clave,6,4)||' '||substring(clave,10,4)||' '||substring(clave,14,3) as clave,cve_ft,the_geom, substring(clave_def,1,2)||' '||substring(clave_def,3,3)||' '||substring(clave_def,6,4)||' '||substring(clave_def,10,4)||' '||substring(clave_def,14,3) as clave_def ,substring(clave_def,17,3) as cve_ft_def,num,obs,usuario , fact from  ( SELECT gid, cve_ent, cveoper, clave, cve_ft, the_geom,clave_def,1 as num, obs, usuario , fact FROM te_fr   where clave_def='0' union  SELECT gid, cve_ent, cveoper, clave, cve_ft, the_geom, unnest(string_to_array(substring(clave_def,1,(length(clave_def)-1)),',')),array_length(string_to_array(substring(clave_def,1,(length(clave_def)-1)),','),1), obs, usuario , fact FROM te_fr  where clave_def!='0') t1 where cve_ent = '"+ent+"'"+
      " order by cveoper,clave,cve_ft";
    select="<select name=filent class='boton'>";
      select+="<option value='"+ent+"' selected>"+ent+"</option>";
      select+="</select>";
    }
    String filult="";
  if((loc != null && !loc.isEmpty()) || (oper != null && !oper.isEmpty()) ){
        if (s1.equals("1")){
            filult = " and cve_ent ='"+ent+"'";
       }else if (s1.equals("2")){
            filult=filreg;
        }else {
            filult=filreg;
        }
    consulta="select gid, cve_ent,cveoper, substring(clave,1,2)||' '||substring(clave,3,3)||' '||substring(clave,6,4)||' '||substring(clave,10,4)||' '||substring(clave,14,3) as clave,cve_ft,the_geom, substring(clave_def,1,2)||' '||substring(clave_def,3,3)||' '||substring(clave_def,6,4)||' '||substring(clave_def,10,4)||' '||substring(clave_def,14,3) as clave_def ,substring(clave_def,17,3) as cve_ft_def,num,obs,usuario , fact from  ( SELECT gid, cve_ent, cveoper, clave, cve_ft, the_geom,clave_def,1 as num, obs, usuario , fact FROM te_fr   where clave_def='0' union  SELECT gid, cve_ent, cveoper, clave, cve_ft, the_geom, unnest(string_to_array(substring(clave_def,1,(length(clave_def)-1)),',')),array_length(string_to_array(substring(clave_def,1,(length(clave_def)-1)),','),1), obs, usuario , fact FROM te_fr  where clave_def!='0') t1 where cveoper like '" + oper.replace("-", "")  + "%' and "+filult+" and clave like '" + loc.replace("-", "")  + "%' and "+filult+" order by cveoper,clave,cve_ft";
}
//out.println(consulta);

       select1="<select name=filtipo class='boton'>";
       select1+="<option value='0' ";if (filtipo.equals("0")){select1+="selected";}select1+=">TODOS</option>";
       select1+="<option value='1' ";if (filtipo.equals("1")){select1+="selected";}select1+=">AGEB URBANA</option>";
       select1+="<option value='2' ";if (filtipo.equals("2")){select1+="selected";}select1+=">POLIGONO RURAL</option>";
       select1+="<option value='3' ";if (filtipo.equals("3")){select1+="selected";}select1+=">POLIGONO EXTERNO</option>";
      out.println( "<center class='t'>Informacion de la tabla de Frentes de Manzana asociados</center>"
                + "<form action=\"modtefr.jsp\" method=\"post\" name=\"enviar\">"
                + "<center><br>"
                //+ "&nbsp;&nbsp;&nbsp;&nbsp;<font class=n>De:</font>&nbsp;<input class='boton' name='filfe1' type='text' id='p1id' onClick=\"popUpCalendar(this, enviar.p1id, 'yyyy-mm-dd');\" size='10' readOnly value='"+filfe1.substring(0,10)+"'>"
                //+ "&nbsp;&nbsp;&nbsp;&nbsp;<font class=n>a:</font>&nbsp;<input class='boton' name='filfe2' type='text' id='p2id' onClick=\"popUpCalendar(this, enviar.p2id, 'yyyy-mm-dd');\" size='10' readOnly value='"+filfe2.substring(0,10)+"'>"
                + "&nbsp;&nbsp;&nbsp;&nbsp;<font class=n>Entidad:</font>&nbsp;"+select
               // + "&nbsp;&nbsp;&nbsp;&nbsp;<font class=n>Tipo:</font>&nbsp;"+select1
                + "<input type='hidden' name='ent' value='"+ent+"'><input type='hidden' name='ban' value='1'><input type='hidden' name='regid' value='"+regid+"'>&nbsp;&nbsp;&nbsp;&nbsp;<input class='boton' type='button' value=' Buscar ' onclick='envia(1)''><br><br><font class=n>Por clave oper:&nbsp;&nbsp;</font>"
                + "<input type='text' maxlength=22 size=10 name='oper' value='"+oper+"' class='boton'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font class=n>Por clave anterior:&nbsp;&nbsp;</font>"
                + "<input type='text' maxlength=22 size=15 name='loc' value='"+loc+"' class='boton'><input type='hidden' name='pass' value='"+pass+"'>&nbsp;&nbsp;&nbsp;&nbsp;<input class='boton' type='button' value=' Buscar ' onclick='envia(2)'></form><br><br>");

/*
      String checkerr="<table border=0><tr class=n><td align=center>Val OC (POL-EXT) >>> ";
       checkerr+="<input class='boton' type='radio' value='T' name='filerr1' ";
        if (filerr1==null || filerr1.equals("T") ){
          checkerr+="checked='checked'";
        }
       checkerr+=">Todos&nbsp;&nbsp;";
    checkerr+="<input class='boton' type='radio' value='N'  name='filerr1' ";
        if (filerr1!=null && filerr1.equals("N") ){
          checkerr+="checked='checked'";
        }
       checkerr+=">Sin revisar&nbsp;&nbsp;";
checkerr+="<input class='boton' type='radio' value='S'  name='filerr1' ";
        if (filerr1!=null && filerr1.equals("S") ){
          checkerr+="checked='checked'";
        }
       checkerr+=">Validados&nbsp;&nbsp;";
checkerr+="<input class='boton' type='radio' value='R'  name='filerr1' ";
        if (filerr1!=null && filerr1.equals("R") ){
          checkerr+="checked='checked'";
        }
       checkerr+=">&nbsp;Retenidos</table><br>";

              out.println(checkerr);
*/
  out.println( "<table border=1><tr class=n bgcolor=#BBBBBB>");
  /*out.println("<th rowspan=1>Val<br>&nbsp;OC&nbsp;");
  out.println("<th rowspan=1>Obs<br>&nbsp;OC&nbsp;");
  out.println("<th rowspan=1>Obs<br>&nbsp;Edo&nbsp;");*/
  out.println("<th>&nbsp;&nbsp;Ver&nbsp;&nbsp;<th>&nbsp;&nbsp;Clave&nbsp;Oper&nbsp;&nbsp;<th>&nbsp;&nbsp;Clave Mza&nbsp;&nbsp;<th>&nbsp;&nbsp;Ft&nbsp;&nbsp;<th>&nbsp;&nbsp;Clave&nbsp;Mza&nbsp;Def&nbsp;&nbsp;<th>&nbsp;&nbsp;Ft&nbsp;Def&nbsp;&nbsp;<th>Fecha<br>&nbsp;registro&nbsp;<th title='Observaciones'>&nbsp;<img src=images/res.png>&nbsp;");
  //if (s2==1){
      out.println("<th title='Limpiar el frente'><img src=images/borra.gif>");
   // }
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
    String col1="";
    String col2="";
    int siobs=0;
    int siobsedo=0;
            String valof="";
        String valobs="";
        String valobsedo="";
      String gid="";
       String gid2="";
      String cve_ent="";
      String cveoper="";
      String clave="";
      String cve_ft="";
      String unnest="";
      String unnestft="";
        String colorn="";
      String fact="";
      String geom="";
      int color=0;
            int numrow=0;
              int row=1;
    while(rs.next()){
    //gid,cve_ent,cve_mun,cve_loc,cve_ageb,tipo,fact,img,fdg,ban,obs,err,geom,cveold,ext
       gid=rs.getObject(1).toString();
       cve_ent=rs.getObject(2).toString();
       cveoper=rs.getObject(3).toString();
       clave=rs.getObject(4).toString();
       cve_ft=rs.getObject(5).toString();
       unnest="";unnestft="";
       obs="";
       fact="";
      if (rs.getObject(7) != null){
          unnest=rs.getObject(7).toString();
          }
      if (rs.getObject(8) != null){
          unnestft=rs.getObject(8).toString();
          }
      if (rs.getObject(10) != null){
          obs=rs.getString(10);
          }
      if (rs.getObject(12) != null){
       fact=rs.getObject(12).toString().substring(0,10);
          }
        numrow=Integer.parseInt(rs.getObject(9).toString());

       geom=rs.getObject(6).toString();
/*
        valof="";
        valobs="";
        valobsedo="";
        siobs=0;
        siobsedo=0;
      if (tipo.equals("3")){
        valof=rs.getString(16);
        valobs="";
        if (rs.getString(17) != null){
          valobs=rs.getString(17);
          if (valobs.length()>0){
            siobs=1;
          }
        }
        valobsedo="";
        if (rs.getString(18) != null){
          valobsedo=rs.getString(18);
          if (valobsedo.length()>0){
            siobsedo=1;
          }
        }
      }
      */


        //out.println(gid+"=="+gid2);





           // out.println("<tr class=c bgcolor='"+colorn+"'>");

if (!(gid.equals(gid2))){
 
      if (color==0){
            colorn="";
            color=1;
        }else{
            colorn="#EAEAEA";
            color=0;

          }
          out.println("<tr class=c bgcolor='"+colorn+"'>");

        out.println("<td align=center nowrap rowspan="+numrow+">&nbsp;<input type=button onclick='obt_geom("+gid+");' value=' Ver ' class='boton'>&nbsp;");

            out.println("<td align=center nowrap rowspan="+numrow+">&nbsp;"+cveoper+"&nbsp;");
             out.println("<td align=center nowrap rowspan="+numrow+">&nbsp;"+clave+"&nbsp;");
             out.println("<td align=center nowrap rowspan="+numrow+">&nbsp;"+cve_ft+"&nbsp;");
}else{
            out.println("<tr class=c bgcolor='"+colorn+"'>");

}


         if (rs.getObject(7).equals("0")){
             out.println("<td align=center nowrap>&nbsp;&nbsp;");
             out.println("<td align=center nowrap>&nbsp;&nbsp;");
          }else{
             out.println("<td align=center nowrap>&nbsp;"+unnest+"&nbsp;");
             out.println("<td align=center nowrap>&nbsp;"+unnestft+"&nbsp;");
             }



if (!(gid.equals(gid2))){
      out.println("<td align=center nowrap rowspan="+numrow+">&nbsp;&nbsp;"+fact+"&nbsp;&nbsp;");
      out.println("<td align=center nowrap rowspan="+numrow+">&nbsp;"+obs+"&nbsp;");
        //if (s2==1){
        if (!(unnestft.equals(""))){
            out.println("<td align=center nowrap rowspan="+numrow+">&nbsp;&nbsp;<img title='Regresar el movimiento' src=images/borra.gif onclick='regresa("+gid+")';>  &nbsp;&nbsp;");
        }else{
           out.println("<td align=center nowrap rowspan="+numrow+">&nbsp;&nbsp;-&nbsp;&nbsp;");
      }
}

 gid2=gid;

            n++;
       }
    rs.close();
  out.println( "</table><br><center><table align=center><tr align=center><td><font class=n>Total de Registros: " + totalRows +"</font><br><br>");

 //String export = consulta.replace("%", "-");
  //out.println ("<table><tr><td nowrap><input class='boton' type='Button' onClick='exp(\""+export.replace("'","*")+"\");' value=' Exportar a DBF '/>");

String barra="";
if(startIndex != 0) {
barra="<a class=liga1 href='modtefr.jsp?filerr1="+filerr1+"&filent="+filent+"&filtipo="+filtipo+"&filfe1="+filfe1.substring(0,10)+"&filfe2="+filfe2.substring(0,10)+"&loc="+loc+"&pass="+pass+"&ban="+ban+"&startIndex="+(startIndex-numRecordsPerPage)+"'> &nbsp;<<&nbsp; </a>";
}

for (n =0 ; n<numPages; n++){
  if (n*numRecordsPerPage == startIndex) {
    // Si el numero de pagina es la actual ($_pagi_actual). Se escribe el numero, pero sin enlace y en negrita.
    barra+="<b> &nbsp;<font class=liga>"+(n+1)+"</font>&nbsp; </b>";
  }else{
    // Si es cualquier otro. Se escibe el enlace a dicho numero de pagina.
    barra+="<a class=liga1 href='modtefr.jsp?filerr1="+filerr1+"&filent="+filent+"&filtipo="+filtipo+"&filfe1="+filfe1.substring(0,10)+"&filfe2="+filfe2.substring(0,10)+"&loc="+loc+"&pass="+pass+"&ban="+ban+"&startIndex="+(numRecordsPerPage*n)+"'> &nbsp;"+(n+1)+"&nbsp; </a>";
  }
 }




if(startIndex+numRecordsPerPage <= totalRows){
  barra+="<a class=liga1 href='modtefr.jsp?filerr1="+filerr1+"&filent="+filent+"&filtipo="+filtipo+"&filfe1="+filfe1.substring(0,10)+"&filfe2="+filfe2.substring(0,10)+"&loc="+loc+"&pass="+pass+"&ban="+ban+"&startIndex="+(startIndex+numRecordsPerPage)+"'> &nbsp;>>&nbsp; </a>";
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
