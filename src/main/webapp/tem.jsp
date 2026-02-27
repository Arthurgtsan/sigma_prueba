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

</style><script language='javascript' src="popcalendar.js"></script>
<script language="javascrpt" type="text/javascript">
window.resizeTo(1100,800);

function modval(val,cons,id,cgo,tipoval,tipote) {
    var ajax=nuevoAjax();
    ajax.open("GET",'modvalmz.jsp?cons='+cons+'&id='+id+'&tipoval='+tipoval+'&val='+val+'&tipote='+tipote+'&cgo='+cgo, true);
    ajax.onreadystatechange=function()
    {
        if(ajax.readyState==4)  {
             var vale=ajax.responseText;
            if (vale=='x'){
                alert ("No se pudo modificar la validacion!!");
            }else{
              if (tipoval=='R'){
                  div="val"+id;
                  if (val=='N'){
                      tabla = "<img title='"+cgo+" - Registro sin validar (Click para validar)' onclick='modval(\"S\","+cons+","+id+",\""+cgo+"\",\""+tipoval+"\",\""+tipote+"\");' border='0' src=images/sinval.png border=0></img>";
                  }else if (val=='S'){
                      tabla = "<img title='"+cgo+" - Registro validado (Click para retener)' onclick='modval(\"R\","+cons+","+id+",\""+cgo+"\",\""+tipoval+"\",\""+tipote+"\");' border='0' src=images/val.png border=0></img>";
                  }else{
                      tabla = "<img title='"+cgo+" - Registro retenido (Click para invalidar)' onclick='modval(\"N\","+cons+","+id+",\""+cgo+"\",\""+tipoval+"\",\""+tipote+"\");' border='0' src=images/ret.png border=0></img></div>";
                  }
              }else{  //tipoval=O (oficinas centrales)
                div="valof"+id;
                  if (val=='N'){
                      tabla = "<img title='"+cgo+" - Registro sin validar (Click para validar)' onclick='modval(\"S\","+cons+","+id+",\""+cgo+"\",\""+tipoval+"\",\""+tipote+"\");' border='0' src=images/sinval.png border=0></img>";
                  }else if (val=='S'){
                      tabla = "<img title='"+cgo+" - Registro validado (Click para retener)' onclick='modval(\"R\","+cons+","+id+",\""+cgo+"\",\""+tipoval+"\",\""+tipote+"\");' border='0' src=images/val.png border=0></img>";
                  }else{
                      tabla = "<img title='"+cgo+" - Registro retenido (Click para invalidar)' onclick='modval(\"N\","+cons+","+id+",\""+cgo+"\",\""+tipoval+"\",\""+tipote+"\");' border='0' src=images/ret.png border=0></img></div>";
                  }
              }
                document.getElementById(div).innerHTML = tabla;
            }
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

function edita(gid,tipote){
ventana = window.open('tem_cambia.jsp?ban=0&tipote='+tipote+'&i='+gid,'CambiaTEM','scrollbars=no,toolbar=no');
ventana.focus();

}

function regresa(tipo,gid,tipote) {
  document.all.pleasewaitScreen.style.visibility="visible";
    var ajax=nuevoAjax();
    if (tipote=='TEF'){
      tipo="2";
    }else if (tipote=='TEM'){
      tipo="1";
    }else{
      tipo="3";   //caserio
    }
    ajax.open("GET",'regresamz.jsp?tipo='+tipo+'&gid='+gid, true);
    ajax.onreadystatechange=function()
    {
        if(ajax.readyState==4)  {
             document.all.pleasewaitScreen.style.visibility="hidden";
             var vale=ajax.responseText;
            if (parseInt(vale)==1){
                alert ("No se pudo eliminar el registro!!");
            }else if (parseInt(vale)==2){
                alert ("No es el ultimo registro de la clave de manzana!!");
            }else if (parseInt(vale)==3){
                alert ("El registro esta validado!!");
            }else if (parseInt(vale)==4){
                alert ("El municipio esta bloqueado!!");
            }else{
              for (i=1;i<14;i++){
                if (!(i==13)){  //me brinco el motivo por que lo elimine
                  div ="c"+i+gid;
                  tabla = "-";
                  document.getElementById(div).innerHTML = tabla;
                }
              }
              div="val"+gid;
              tabla = "-";
              if (tipote=='TEC'){
                document.getElementById(div).innerHTML = tabla;
                if (window.opener.editarcd.active){
                    window.opener.wfs.refresh({force: true});
                    window.opener.wfs.redraw(true);
                }
                if (window.opener.caserio_gen.getVisibility()){
                    window.opener.caserio_gen.redraw(true);
                }
              }else{
                document.getElementById(div).innerHTML = tabla;
                if (window.opener.editarmz.active){
                    window.opener.wfs.refresh({force: true});
                    window.opener.wfs.redraw(true);
                }
                if (window.opener.mza_gen.getVisibility()){
                    window.opener.mza_gen.redraw(true);
                }
              }
              //location.reload();
            }
        }
    }
    ajax.send(null);
    }


function obt_geom(val,gid,cgo,clave,tipote){
    var ajax=nuevoAjax();
    ajax.open("GET",'obtgeo.jsp?id='+gid+'&val='+val+'&cgo='+cgo+'&tipote='+tipote+'&clave='+clave, true);
    ajax.onreadystatechange=function()
    {
        if(ajax.readyState==4)  {
             var vale=ajax.responseText;
            if (parseInt(vale)==1){
                alert ("No se pudo obtener las coordenadas!!");
            }else{
                if (tipote=='TEC'){
                    window.opener.buscazoomtecd(val,vale);
                }else{
                    window.opener.buscazoomtemz(val,vale);
                }
            }
        }
    }
    ajax.send(null);
}

function chg_motivo(ele,gid,cgo){
    var ajax=nuevoAjax();
    ajax.open("GET",'chg_motivo.jsp?gid='+gid+'&cgo='+cgo+'&val='+ele.value, true);
    ajax.onreadystatechange=function()
    {
        if(ajax.readyState==4)  {
             var vale=ajax.responseText;
            if (parseInt(vale)==1){
                alert ("No se pudo cambiar el motivo!!");
            }
        }
    }
    ajax.send(null);
}

function exp(consulta){
consulta1 =  "select cgo_act,";
consulta1 += "tipo_ant,substring(clave1,1,2) as ent_ant,substring(clave1,3,3) as mun_ant,substring(clave1,6,4) as loc_ant,substring(clave1,10,5) as ageb_ant,substring(clave1,15,3) as mza_ant,mov_ant,";
consulta1 += "tipo_act,substring(clave2,1,2) as ent_act,substring(clave2,3,3) as mun_act,substring(clave2,6,4) as loc_act,substring(clave2,10,5) as ageb_act,substring(clave2,15,3) as mza_act,mov_act,";
consulta1 += "fact as fecha,voc,obsoc,vreg,obsre,obsed,img,fdg,usuario from ("+consulta+") t1";
ventana = window.open("exp_csv.jsp?c="+consulta1,'Consultamz','scrollbars=no,toolbar=no');
}

function observaval(cons,gid,tipo,nivel,tipote){
if (tipote=='TEF'){
      tipot="2";
    }else if (tipote=='TEM'){
      tipot="1";
    }else{
      tipot="3";   //caserio
    }
ventana = window.open('verobsmzval.jsp?cons='+cons+'&gid='+gid+'&tipo='+tipo+'&tipote='+tipot+'&nivel='+nivel,'Observapre','scrollbars=no,toolbar=no');
ventana.focus();
}



function observa(user,fdg,cod,gid,obs,img,correo){
ventana = window.open('verobsmz.jsp?user='+user+'&correo='+correo+'&fdg='+fdg+'&cod='+cod+'&gid='+gid+'&obs='+obs+'&img='+img,'Observamz','scrollbars=no,toolbar=no');
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
    //document.enviar.filtipo2.value=document.enviar.filtipo.value;
    document.enviar.submit();
  }else{
    if (document.enviar.loc.value==''){
      alert ('Debe de proporcionar una clave!!');
      return false;
    }
    //document.enviar.filtipo.value=document.enviar.filtipo2.value;
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
        loc = request.getParameter("loc").replace("'",""),
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
         select1="",select2="",
         st = "",
         filent="",
         filtipo="",
         filcgo="",
         filfe1="",
         filfe2="",filerr="",filerr1="",filerr2="", filerrq="", filerrv="",
         where="",
         obs="",observa="",lobs="",obs1="";
      consultapas = "select nivel,edicionmz,id,regid,nombre,cons from usuarios where md5(password) = '"+pass+"';";
HttpSession sesion = request.getSession(true);
if ((sesion != null && !sesion.isNew())) {
        //out.println("LA SESION SIGUE ACTIVA");

String remotehost  = session.getAttribute("remotehost").toString();
String regionalid  = session.getAttribute("regionalid").toString();



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
  int numRecordsPerPage = 1000;

  if (loc==null){
    loc="";
  }

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
	  //String s1=rs.getObject(1).toString();
      Integer s1=(Integer) rs.getObject(1);
      Integer s2=(Integer) rs.getObject(2);

      ent=rs.getObject(3).toString();
    regid=rs.getObject(4).toString();
    String nombre=rs.getObject(5).toString();
      Integer cons=(Integer) rs.getObject(6);
//out.println( consultapas );

sesion.setAttribute("script", "te");
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
filfe1 = request.getParameter("filfe1");
filfe2 = request.getParameter("filfe2");
filerr = request.getParameter("filerr");
filerrv = request.getParameter("filerrv");
filerr1 = request.getParameter("filerr1");
filerr2 = request.getParameter("filerr2");

if (filent==null)filent="00";
if (filtipo==null)filtipo="0";
if (filfe1==null){
  filfe1=fec1;
  filfe1="2024-12-01";
}
if (filfe2==null)filfe2=fec2;
filfe1 += " 00:00:00";
filfe2 += " 23:59:59";
if (filerr!=null && filerr.equals("on") ){
        filerrq=" substring (obs,1,1) ='X' and ";
      }
if (filerrv!=null && filerrv.equals("on") ){
        filerrq+=" motivo=1  and ";
      }
if (filerr1!=null && (filerr1.equals("R") ||  filerr1.equals("S") ||  filerr1.equals("N"))){
        filerrq+=" voc='"+filerr1+"' and ";
      }
if (filerr2!=null && (filerr2.equals("R") ||  filerr2.equals("S") ||  filerr2.equals("N"))){
        filerrq+=" vreg='"+filerr2+"' and ";
      }
//out.println("<br>ent:"+ent);
//out.println("<br>filent:"+filent);
//out.println("<br>filfe1:"+filfe1);
//out.println("<br>filfe2:"+filfe2);
if (filtipo.equals("0")){
select1="";
select2="";
}
if (filtipo.equals("1")){
  //select1=" substring(cgo_act,1,1)!='F' and ";
  //select2=" substring(cgo_act,1,1)!='F' and ";
  select1=" length(cgo_act)=1 and ";
  select2=" length(cgo_act)=1 and ";
}
if (filtipo.equals("2")){
//select1=" substring(cgo_act,1,1)='F' and ";
//select2=" substring(cgo_act,1,1)='F' and ";
  select1=" length(cgo_act)=2 and ";
  select2=" length(cgo_act)=2 and ";
}
if (filcgo==null){filcgo="0";}
if (!(filcgo.equals("0"))){
   filerrq+=" cgo_act='"+filcgo+"' and ";
}
consulta="select oid,cgo_act,fact,tipo_ant,clave1,mov_ant,tipo_act,clave2,mov_act,obs,vreg,voc,motivo,"+
        " max(case when clave1!='000000000000-0000' and clave2!='000000000000-0000' then oid END) OVER (PARTITION BY clave1 order by oid desc) as max1,"+
        " max(case when clave1!='000000000000-0000' and clave2!='000000000000-0000' then oid END) OVER (PARTITION BY clave2 order by oid desc) as max2,"+
        " img,usuario,fdg,correo,tipte,obsoc,obsre,obsed,jpg from v_te_mza t2 ";

if ((ent.equals("00"))){   //NACIONAL
     switch(regionalid){
          case "01":
                filreg = " and (substring(clave1, 0 , 3) in ('02','03','25','26') or substring(clave2, 0 , 3) in ('02','03','25','26'))";
                selreg+="<option value='02' ";if (filent.equals("02")){selreg+="selected";}selreg+=">02</option>";
                selreg+="<option value='03' ";if (filent.equals("03")){selreg+="selected";}selreg+=">03</option>";
                selreg+="<option value='25' ";if (filent.equals("25")){selreg+="selected";}selreg+=">25</option>";
                selreg+="<option value='26' ";if (filent.equals("26")){selreg+="selected";}selreg+=">26</option>";
            break;
          case "02":
                filreg = " and (substring(clave1, 0 , 3) in ('08','10','32') or substring(clave2, 0 , 3) in ('08','10','32'))";
                selreg+="<option value='08' ";if (filent.equals("08")){selreg+="selected";}selreg+=">08</option>";
                selreg+="<option value='10' ";if (filent.equals("10")){selreg+="selected";}selreg+=">10</option>";
                selreg+="<option value='32' ";if (filent.equals("32")){selreg+="selected";}selreg+=">32</option>";
            break;
          case "03":
                filreg = " and (substring(clave1, 0 , 3) in ('05','19','28') or substring(clave2, 0 , 3) in ('05','19','28'))";
                selreg+="<option value='05' ";if (filent.equals("05")){selreg+="selected";}selreg+=">05</option>";
                selreg+="<option value='19' ";if (filent.equals("19")){selreg+="selected";}selreg+=">19</option>";
                selreg+="<option value='28' ";if (filent.equals("28")){selreg+="selected";}selreg+=">28</option>";
            break;
          case "04":
                filreg = " and (substring(clave1, 0 , 3) in ('06','14','16','18') or substring(clave2, 0 , 3) in ('06','14','16','18'))";
                selreg+="<option value='06' ";if (filent.equals("06")){selreg+="selected";}selreg+=">06</option>";
                selreg+="<option value='14' ";if (filent.equals("14")){selreg+="selected";}selreg+=">14</option>";
                selreg+="<option value='16' ";if (filent.equals("16")){selreg+="selected";}selreg+=">16</option>";
                selreg+="<option value='18' ";if (filent.equals("18")){selreg+="selected";}selreg+=">18</option>";
            break;
          case "05":
                filreg = " and (substring(clave1, 0 , 3) in ('01','11','22','24') or substring(clave2, 0 , 3) in ('01','11','22','24'))";
                selreg+="<option value='01' ";if (filent.equals("01")){selreg+="selected";}selreg+=">01</option>";
                selreg+="<option value='11' ";if (filent.equals("11")){selreg+="selected";}selreg+=">11</option>";
                selreg+="<option value='22' ";if (filent.equals("22")){selreg+="selected";}selreg+=">22</option>";
                selreg+="<option value='24' ";if (filent.equals("24")){selreg+="selected";}selreg+=">24</option>";
            break;
          case "06":
                filreg = " and (substring(clave1, 0 , 3) in ('12','15','17') or substring(clave2, 0 , 3) in ('12','15','17'))";
                selreg+="<option value='12' ";if (filent.equals("12")){selreg+="selected";}selreg+=">12</option>";
                selreg+="<option value='15' ";if (filent.equals("15")){selreg+="selected";}selreg+=">15</option>";
                selreg+="<option value='17' ";if (filent.equals("17")){selreg+="selected";}selreg+=">17</option>";
            break;
          case "07":
                filreg = " and (substring(clave1, 0 , 3) in ('13','21','29','30') or substring(clave2, 0 , 3) in ('13','21','29','30'))";
                selreg+="<option value='13' ";if (filent.equals("13")){selreg+="selected";}selreg+=">13</option>";
                selreg+="<option value='21' ";if (filent.equals("21")){selreg+="selected";}selreg+=">21</option>";
                selreg+="<option value='29' ";if (filent.equals("29")){selreg+="selected";}selreg+=">29</option>";
                selreg+="<option value='30' ";if (filent.equals("30")){selreg+="selected";}selreg+=">30</option>";
            break;
          case "08":
                filreg = " and (substring(clave1, 0 , 3) in ('07','20','27') or substring(clave2, 0 , 3) in ('07','20','27'))";
                selreg+="<option value='07' ";if (filent.equals("07")){selreg+="selected";}selreg+=">07</option>";
                selreg+="<option value='20' ";if (filent.equals("20")){selreg+="selected";}selreg+=">20</option>";
                selreg+="<option value='27' ";if (filent.equals("27")){selreg+="selected";}selreg+=">27</option>";
            break;
          case "09":
                filreg = " and (substring(clave1, 0 , 3) in ('04','23','31') or substring(clave2, 0 , 3) in ('04','23','31'))";
                selreg+="<option value='04' ";if (filent.equals("04")){selreg+="selected";}selreg+=">04</option>";
                selreg+="<option value='23' ";if (filent.equals("23")){selreg+="selected";}selreg+=">23</option>";
                selreg+="<option value='31' ";if (filent.equals("31")){selreg+="selected";}selreg+=">31</option>";
            break;
          case "10":
                filreg = " and (substring(clave1, 0 , 3) in ('09') or substring(clave2, 0 , 3) in ('09'))";
                selreg+="<option value='09' ";if (filent.equals("09")){selreg+="selected";}selreg+=">09</option>";
            break;
        }
            if (filent.equals("00")){
          consulta="select oid,cgo_act,fact,tipo_ant,clave1,mov_ant,tipo_act,clave2,mov_act,obs,vreg,voc,motivo,"+
          " max(case when clave1!='000000000000-0000' and clave2!='000000000000-0000' then oid END) OVER (PARTITION BY clave1 order by oid desc) as max1,"+
        " max(case when clave1!='000000000000-0000' and clave2!='000000000000-0000' then oid END) OVER (PARTITION BY clave2 order by oid desc) as max2,img,usuario,fdg,correo,tipte,obsoc,obsre,obsed,jpg "+
          "from v_te_mza t2"+
            " where "+filerrq+" "+select1+" fact between '"+filfe1+"' and '"+ filfe2 +"' "+filreg+
            " order by oid";
          where = filerrq+" "+select1+" fact between '"+filfe1+"' and '"+ filfe2 +"' "+filreg+" order by oid";
                }else{
          consulta="select oid,cgo_act,fact,tipo_ant,clave1,mov_ant,tipo_act,clave2,mov_act,obs,vreg,voc,motivo,"+
          " max(case when clave1!='000000000000-0000' and clave2!='000000000000-0000' then oid END) OVER (PARTITION BY clave1 order by oid desc) as max1,"+
        " max(case when clave1!='000000000000-0000' and clave2!='000000000000-0000' then oid END) OVER (PARTITION BY clave2 order by oid desc) as max2,img,usuario,fdg,correo,tipte,obsoc,obsre,obsed,jpg "+
          "from v_te_mza t2"+
              " where "+filerrq+" "+select1+" fact between '"+filfe1+"' and '"+ filfe2 +"' and (substring(clave1, 0 , 3) = '"+filent+"' or substring(clave2, 0 , 3) = '"+filent+"')"+
            " order by oid";
          where = filerrq+" "+select1+" fact between '"+filfe1+"' and '"+ filfe2 +"' and (substring(clave1, 0 , 3) = '"+filent+"' or substring(clave2, 0 , 3) = '"+filent+"') order by oid";
                }
                 select="<select name=filent class='boton'>";
                select+="<option value='00' ";if (filent.equals("00")){select+="selected";}select+=">TODAS</option>";
                select+=selreg+"</select>";
    }else if (s1==2){   //REGIONAL
         switch(ent){
          case "01":
                filreg = " and (substring(clave1, 0 , 3) in ('02','03','25','26') or substring(clave2, 0 , 3) in ('02','03','25','26'))";
                selreg+="<option value='02' ";if (filent.equals("02")){selreg+="selected";}selreg+=">02</option>";
                selreg+="<option value='03' ";if (filent.equals("03")){selreg+="selected";}selreg+=">03</option>";
                selreg+="<option value='25' ";if (filent.equals("25")){selreg+="selected";}selreg+=">25</option>";
                selreg+="<option value='26' ";if (filent.equals("26")){selreg+="selected";}selreg+=">26</option>";
            break;
          case "02":
                filreg = " and (substring(clave1, 0 , 3) in ('08','10','32') or substring(clave2, 0 , 3) in ('08','10','32'))";
                selreg+="<option value='08' ";if (filent.equals("08")){selreg+="selected";}selreg+=">08</option>";
                selreg+="<option value='10' ";if (filent.equals("10")){selreg+="selected";}selreg+=">10</option>";
                selreg+="<option value='32' ";if (filent.equals("32")){selreg+="selected";}selreg+=">32</option>";
            break;
          case "03":
                filreg = " and (substring(clave1, 0 , 3) in ('05','19','28') or substring(clave2, 0 , 3) in ('05','19','28'))";
                selreg+="<option value='05' ";if (filent.equals("05")){selreg+="selected";}selreg+=">05</option>";
                selreg+="<option value='19' ";if (filent.equals("19")){selreg+="selected";}selreg+=">19</option>";
                selreg+="<option value='28' ";if (filent.equals("28")){selreg+="selected";}selreg+=">28</option>";
            break;
          case "04":
                filreg = " and (substring(clave1, 0 , 3) in ('06','14','16','18') or substring(clave2, 0 , 3) in ('06','14','16','18'))";
                selreg+="<option value='06' ";if (filent.equals("06")){selreg+="selected";}selreg+=">06</option>";
                selreg+="<option value='14' ";if (filent.equals("14")){selreg+="selected";}selreg+=">14</option>";
                selreg+="<option value='16' ";if (filent.equals("16")){selreg+="selected";}selreg+=">16</option>";
                selreg+="<option value='18' ";if (filent.equals("18")){selreg+="selected";}selreg+=">18</option>";
            break;
          case "05":
                filreg = " and (substring(clave1, 0 , 3) in ('01','11','22','24') or substring(clave2, 0 , 3) in ('01','11','22','24'))";
                selreg+="<option value='01' ";if (filent.equals("01")){selreg+="selected";}selreg+=">01</option>";
                selreg+="<option value='11' ";if (filent.equals("11")){selreg+="selected";}selreg+=">11</option>";
                selreg+="<option value='22' ";if (filent.equals("22")){selreg+="selected";}selreg+=">22</option>";
                selreg+="<option value='24' ";if (filent.equals("24")){selreg+="selected";}selreg+=">24</option>";
            break;
          case "06":
                filreg = " and (substring(clave1, 0 , 3) in ('12','15','17') or substring(clave2, 0 , 3) in ('12','15','17'))";
                selreg+="<option value='12' ";if (filent.equals("12")){selreg+="selected";}selreg+=">12</option>";
                selreg+="<option value='15' ";if (filent.equals("15")){selreg+="selected";}selreg+=">15</option>";
                selreg+="<option value='17' ";if (filent.equals("17")){selreg+="selected";}selreg+=">17</option>";
            break;
          case "07":
                filreg = " and (substring(clave1, 0 , 3) in ('13','21','29','30') or substring(clave2, 0 , 3) in ('13','21','29','30'))";
                selreg+="<option value='13' ";if (filent.equals("13")){selreg+="selected";}selreg+=">13</option>";
                selreg+="<option value='21' ";if (filent.equals("21")){selreg+="selected";}selreg+=">21</option>";
                selreg+="<option value='29' ";if (filent.equals("29")){selreg+="selected";}selreg+=">29</option>";
                selreg+="<option value='30' ";if (filent.equals("30")){selreg+="selected";}selreg+=">30</option>";
            break;
          case "08":
                filreg = " and (substring(clave1, 0 , 3) in ('07','20','27') or substring(clave2, 0 , 3) in ('07','20','27'))";
                selreg+="<option value='07' ";if (filent.equals("07")){selreg+="selected";}selreg+=">07</option>";
                selreg+="<option value='20' ";if (filent.equals("20")){selreg+="selected";}selreg+=">20</option>";
                selreg+="<option value='27' ";if (filent.equals("27")){selreg+="selected";}selreg+=">27</option>";
            break;
          case "09":
                filreg = " and (substring(clave1, 0 , 3) in ('04','23','31') or substring(clave2, 0 , 3) in ('04','23','31'))";
                selreg+="<option value='04' ";if (filent.equals("04")){selreg+="selected";}selreg+=">04</option>";
                selreg+="<option value='23' ";if (filent.equals("23")){selreg+="selected";}selreg+=">23</option>";
                selreg+="<option value='31' ";if (filent.equals("31")){selreg+="selected";}selreg+=">31</option>";
            break;
          case "10":
                filreg = " and (substring(clave1, 0 , 3) in ('09') or substring(clave2, 0 , 3) in ('09'))";
                selreg+="<option value='09' ";if (filent.equals("09")){selreg+="selected";}selreg+=">09</option>";
            break;
        }
            if (filent.equals("00")){
					consulta="select oid,cgo_act,fact,tipo_ant,clave1,mov_ant,tipo_act,clave2,mov_act,obs,vreg,voc,motivo,"+
          " max(case when clave1!='000000000000-0000' and clave2!='000000000000-0000' then oid END) OVER (PARTITION BY clave1 order by oid desc) as max1,"+
        " max(case when clave1!='000000000000-0000' and clave2!='000000000000-0000' then oid END) OVER (PARTITION BY clave2 order by oid desc) as max2,img,usuario,fdg,correo,tipte,obsoc,obsre,obsed,jpg "+
          "from v_te_mza t2"+
          	" where "+filerrq+" "+select1+" fact between '"+filfe1+"' and '"+ filfe2 +"' "+filreg+
						" order by oid";
					where = filerrq+" "+select1+" fact between '"+filfe1+"' and '"+ filfe2 +"' "+filreg+" order by oid";
                }else{
					consulta="select oid,cgo_act,fact,tipo_ant,clave1,mov_ant,tipo_act,clave2,mov_act,obs,vreg,voc,motivo,"+
          " max(case when clave1!='000000000000-0000' and clave2!='000000000000-0000' then oid END) OVER (PARTITION BY clave1 order by oid desc) as max1,"+
        " max(case when clave1!='000000000000-0000' and clave2!='000000000000-0000' then oid END) OVER (PARTITION BY clave2 order by oid desc) as max2,img,usuario,fdg,correo,tipte,obsoc,obsre,obsed,jpg "+
          "from v_te_mza t2"+
              " where "+filerrq+" "+select1+" fact between '"+filfe1+"' and '"+ filfe2 +"' and (substring(clave1, 0 , 3) = '"+filent+"' or substring(clave2, 0 , 3) = '"+filent+"')"+
						" order by oid";
					where = filerrq+" "+select1+" fact between '"+filfe1+"' and '"+ filfe2 +"' and (substring(clave1, 0 , 3) = '"+filent+"' or substring(clave2, 0 , 3) = '"+filent+"') order by oid";
                }
                 select="<select name=filent class='boton'>";
                select+="<option value='00' ";if (filent.equals("00")){select+="selected";}select+=">TODAS</option>";
                select+=selreg+"</select>";
    }else{   //ESTADO
		consulta="select oid,cgo_act,fact,tipo_ant,clave1,mov_ant,tipo_act,clave2,mov_act,obs,vreg,voc,motivo,"+
          " max(case when clave1!='000000000000-0000' and clave2!='000000000000-0000' then oid END) OVER (PARTITION BY clave1 order by oid desc) as max1,"+
        " max(case when clave1!='000000000000-0000' and clave2!='000000000000-0000' then oid END) OVER (PARTITION BY clave2 order by oid desc) as max2,img,usuario,fdg,correo,tipte,obsoc,obsre,obsed,jpg "+
          "from v_te_mza t2"+
			" where "+filerrq+" "+select1+" fact between '"+filfe1+"' and '"+ filfe2 +"' and (substring(clave1, 0 , 3) = '"+ent+"' or substring(clave2, 0 , 3) = '"+ent+"')"+
			" order by oid";
		where = filerrq+" "+select1+" fact between '"+filfe1+"' and '"+ filfe2 +"' and (substring(clave1, 0 , 3) = '"+ent+"' or substring(clave2, 0 , 3) = '"+ent+"') order by oid";
      select="<select name=filent class='boton'>";
      select+="<option value='"+ent+"' selected>"+ent+"</option>";
      select+="</select>";
    }
    String filult="";
  if(loc != null && !loc.isEmpty()){
        if (s1==1){
            filult = " and (substring(clave1, 0 , 3) ='"+ent+"' or substring(clave2, 0 , 3) ='"+ent+"')";
       }else if (s1==2){
            filult= filreg;
        }else{  // 3
            filult= filreg;
        }
		consulta="select oid,cgo_act,fact,tipo_ant,clave1,mov_ant,tipo_act,clave2,mov_act,obs,vreg,voc,motivo,"+
          " max(case when clave1!='000000000000-0000' and clave2!='000000000000-0000' then oid END) OVER (PARTITION BY clave1 order by oid desc) as max1,"+
        " max(case when clave1!='000000000000-0000' and clave2!='000000000000-0000' then oid END) OVER (PARTITION BY clave2 order by oid desc) as max2,img,usuario,fdg,correo,tipte,obsoc,obsre,obsed,jpg "+
          "from v_te_mza t2"+
			" where "+filerrq+" "+select1+ "(replace(clave1,'-','') like '" + loc.replace("-","") + "%' or replace(clave2,'-','') like '" + loc.replace("-","") + "%') "+filult+
			" order by oid";
         where = "(replace(clave1,'-','') like '" + loc.replace("-","") + "%' or replace(clave2,'-','') like '" + loc.replace("-","") + "%') "+filult+" order by oid";
}

       /*select2="<select name=filtipo2 class='boton'>";
       //select2+="<option value='0' ";if (filtipo.equals("0")){select2+="selected";}select2+=">TODOS</option>";
       select2+="<option value='1' ";if (filtipo.equals("1")){select2+="selected";}select2+=">CATALOGO</option>";
       //select2+="<option value='2' ";if (filtipo.equals("2")){select2+="selected";}select2+=">GEOMETRIA</option>";
       select2+="</select>";

       select1="<select name=filtipo class='boton'>";
       //select1+="<option value='0' ";if (filtipo.equals("0")){select1+="selected";}select1+=">TODOS</option>";
       select1+="<option value='1' ";if (filtipo.equals("1")){select1+="selected";}select1+=">CATALOGO</option>";
       //select1+="<option value='2' ";if (filtipo.equals("2")){select1+="selected";}select1+=">GEOMETRIA</option>";
       select1+="</select>";
        */
       select2="";
       select1="";
       select1+="&nbsp;&nbsp;&nbsp;&nbsp;Cgo:&nbsp;<select name=filcgo class='boton'>";
       select1+="<option value='0'>TODOS</option>";
       select1+="<option value='1' ";if (filcgo.equals("1")){select1+="selected";}select1+=">1</option>";
       select1+="<option value='2' ";if (filcgo.equals("2")){select1+="selected";}select1+=">2</option>";
       select1+="<option value='3' ";if (filcgo.equals("3")){select1+="selected";}select1+=">3</option>";
       select1+="<option value='4' ";if (filcgo.equals("4")){select1+="selected";}select1+=">4</option>";
       select1+="<option value='5' ";if (filcgo.equals("5")){select1+="selected";}select1+=">5</option>";
       select1+="<option value='6' ";if (filcgo.equals("6")){select1+="selected";}select1+=">6</option>";
       select1+="<option value='A' ";if (filcgo.equals("A")){select1+="selected";}select1+=">A</option>";
       select1+="<option value='B' ";if (filcgo.equals("B")){select1+="selected";}select1+=">B</option>";
       select1+="<option value='C' ";if (filcgo.equals("C")){select1+="selected";}select1+=">C</option>";
       select1+="<option value='D' ";if (filcgo.equals("D")){select1+="selected";}select1+=">D</option>";
       select1+="<option value='E' ";if (filcgo.equals("E")){select1+="selected";}select1+=">E</option>";
       select1+="<option value='F' ";if (filcgo.equals("F")){select1+="selected";}select1+=">F</option>";
       select1+="<option value='G' ";if (filcgo.equals("G")){select1+="selected";}select1+=">G</option>";
       select1+="<option value='H' ";if (filcgo.equals("H")){select1+="selected";}select1+=">H</option>";
       select1+="<option value='I' ";if (filcgo.equals("I")){select1+="selected";}select1+=">I</option>";
       select1+="<option value='J' ";if (filcgo.equals("J")){select1+="selected";}select1+=">J</option>";
       select1+="<option value='K' ";if (filcgo.equals("K")){select1+="selected";}select1+=">K</option>";
       select1+="<option value='L' ";if (filcgo.equals("L")){select1+="selected";}select1+=">L</option>";
       select1+="<option value='M' ";if (filcgo.equals("M")){select1+="selected";}select1+=">M</option>";
       select1+="<option value='N' ";if (filcgo.equals("N")){select1+="selected";}select1+=">N</option>";
       select1+="<option value='O' ";if (filcgo.equals("O")){select1+="selected";}select1+=">O</option>";
       select1+="<option value='R' ";if (filcgo.equals("R")){select1+="selected";}select1+=">R</option>";
       select1+="<option value='S' ";if (filcgo.equals("S")){select1+="selected";}select1+=">S</option>";
       select1+="<option value='T' ";if (filcgo.equals("T")){select1+="selected";}select1+=">T</option>";
       select1+="<option value='Y' ";if (filcgo.equals("Y")){select1+="selected";}select1+=">Y</option></select>";
      out.println( "<center class='t'>Tabla de Equivalencia de Manzanas</center>"
              	+ "<form action=\"tem.jsp\" method=\"post\" name=\"enviar\">"
                + "<center><br><table border=0><tr onmouseover='this.style.background=\"#F0F0F0\"' onmouseout='this.style.background=\"#FFFFFF\"' class=n><td align=center>"
                + "&nbsp;&nbsp;&nbsp;&nbsp;De:&nbsp;<input class='boton' name='filfe1' type='text' id='p1id' onClick=\"popUpCalendar(this, enviar.p1id, 'yyyy-mm-dd');\" size='10' value='"+filfe1.substring(0,10)+"'>"
                + "&nbsp;&nbsp;&nbsp;&nbsp;a:&nbsp;<input class='boton' name='filfe2' type='text' id='p2id' onClick=\"popUpCalendar(this, enviar.p2id, 'yyyy-mm-dd');\" size='10' value='"+filfe2.substring(0,10)+"'>"
                + "&nbsp;&nbsp;&nbsp;&nbsp;Entidad:&nbsp;"+select
                + "&nbsp;&nbsp;&nbsp;&nbsp;Tipo:&nbsp;"+select1
                + "<input type='hidden' name='ent' value='"+ent+"'><input type='hidden' name='ban' value='1'><input type='hidden' name='regid' value='"+regid+"'>&nbsp;&nbsp;&nbsp;&nbsp;<input class='boton' type='button' value=' Buscar por fecha ' onclick='envia(1)''><tr><td>&nbsp;<tr onmouseover='this.style.background=\"#F0F0F0\"' onmouseout='this.style.background=\"#FFFFFF\"' class=n><td align=center>"+select2+"&nbsp;&nbsp;&nbsp;&nbsp;Por manzana:&nbsp;&nbsp;"
                + "<input type='text' maxlength=22 size=20 name='loc' value='"+loc+"' class='boton'><input type='hidden' name='pass' value='"+pass+"'>&nbsp;&nbsp;&nbsp;&nbsp;<input class='boton' type='button' value=' Buscar por clave ' onclick='envia(2)'></table></form><br>");


      String checkerr="<table border=0><tr class=n><td align=left rowspan=2><input class='boton' style='accent-color: red;' type='checkbox' name='filerr' ";
       if (filerr!=null && filerr.equals("on") ){
        checkerr+="checked";
      }
       checkerr+=">Solo con Obs&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";


        checkerr+="<br><input class='boton' style='accent-color: #2196F3;' type='checkbox'  name='filerrv' ";
       if (filerrv!=null && filerrv.equals("on") ){
        checkerr+="checked";
      }
       checkerr+=">Movimiento";


       checkerr+="<td align=center>Val OC >>> ";
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
       checkerr+=">&nbsp;Retenidos";


checkerr+="<tr class=n><td align=center>Val REG >>> ";
       checkerr+="<input class='boton' type='radio' value='T' name='filerr2' ";
        if (filerr2==null || filerr2.equals("T") ){
          checkerr+="checked='checked'";
        }
       checkerr+=">Todos&nbsp;&nbsp;";
    checkerr+="<input class='boton' type='radio' value='N'  name='filerr2' ";
        if (filerr2!=null && filerr2.equals("N") ){
          checkerr+="checked='checked'";
        }
       checkerr+=">Sin revisar&nbsp;&nbsp;";
checkerr+="<input class='boton' type='radio' value='S'  name='filerr2' ";
        if (filerr2!=null && filerr2.equals("S") ){
          checkerr+="checked='checked'";
        }
       checkerr+=">Validados&nbsp;&nbsp;";
checkerr+="<input class='boton' type='radio' value='R'  name='filerr2' ";
        if (filerr2!=null && filerr2.equals("R") ){
          checkerr+="checked='checked'";
        }
       checkerr+=">&nbsp;Retenidos";


       out.println(checkerr);

	out.println( "</table><br><table border=1><tr class=n bgcolor=#BBBBBB>");
   //if (s1!=2){
      out.println("<th rowspan=2>Val<br>&nbsp;OC&nbsp;");out.println("<th rowspan=2>Obs<br>&nbsp;OC&nbsp;");
    //}
       out.println("<th rowspan=2>Val<br>&nbsp;Reg&nbsp;");out.println("<th rowspan=2>Obs<br>&nbsp;Reg&nbsp;");
       out.println("<th rowspan=2>Obs<br>&nbsp;Edo&nbsp;");
  out.println("<th rowspan=2>&nbsp;&nbsp;CGO&nbsp;&nbsp;<th rowspan=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Fecha/Hora&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<th rowspan=2>&nbsp;Obs&nbsp;<!--<th rowspan=2>&nbsp;Motivo&nbsp;--><th colspan=4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Anterior&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<th colspan=4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Actual&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
		if (s2==1){
			out.println("<th rowspan=2><img src=images/borra.gif>");
		}
        out.println( "<tr class=n bgcolor=#BBBBBB><th>&nbsp;&nbsp;TIPO&nbsp;&nbsp;<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;CLAVE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
        out.println( "<th>&nbsp;&nbsp;MOV&nbsp;&nbsp;<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ver&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
	      out.println( "<th>&nbsp;&nbsp;TIPO&nbsp;&nbsp;<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;CLAVE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
        out.println( "<th>&nbsp;&nbsp;MOV&nbsp;&nbsp;<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ver&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
//out.println(consulta);
  if (ban!=null){
    String consultacount=consulta.replace("oid,cgo_act,fact,tipo_ant,clave1,mov_ant,tipo_act,clave2,mov_act,obs,vreg,voc,motivo, max(case when clave1!='000000000000-0000' and clave2!='000000000000-0000' then oid END) OVER (PARTITION BY clave1 order by oid desc) as max1, max(case when clave1!='000000000000-0000' and clave2!='000000000000-0000' then oid END) OVER (PARTITION BY clave2 order by oid desc) as max2,img,usuario,fdg,correo,tipte,obsoc,obsre,obsed,jpg","count(*)");
    consultacount=consultacount.replace("order by oid","");
    String consultaexp=consulta.replace("oid,cgo_act,fact,tipo_ant,clave1,mov_ant,tipo_act,clave2,mov_act,obs,vreg,voc,motivo, max(case when clave1!='000000000000-0000' and clave2!='000000000000-0000' then oid END) OVER (PARTITION BY clave1 order by oid desc) as max1, max(case when clave1!='000000000000-0000' and clave2!='000000000000-0000' then oid END) OVER (PARTITION BY clave2 order by oid desc) as max2,img,usuario,fdg,correo,tipte,obsoc,obsre,obsed,jpg","cgo_act,fact,tipo_ant,clave1,mov_ant,tipo_act,clave2,mov_act,obs,vreg,voc,motivo,img,usuario,fdg,correo,tipte,obsoc,obsre,obsed,jpg");
    rs = str.executeQuery( consultacount );
      //paginacion
      //get total rows
      rs.next();
      int totalRows = Integer.parseInt(rs.getObject(1).toString());
      /*get total number of pages starts here */
      numPages = totalRows /numRecordsPerPage; // get initiate pages without the remind page
      int remain = totalRows % numRecordsPerPage; // check remain records
      if(remain != 0){
        numPages = numPages+ 1;  // if there is remind   1 page.
      }

    consulta  += " limit " + numRecordsPerPage+ " offset "+ startIndex ;
    rs = str.executeQuery( consulta );
	//out.println(consultacount);
  //out.println(consulta);
    String col="";
    String reobs="";
    String ocobs="";
    String edobs="";
    String jpg="";
    String colmnv="";

  	while(rs.next()){
			String gid=rs.getObject(1).toString();
      String cgo="";
      if (rs.getString(2) != null){
        cgo=rs.getString(2);
      }
			String cgotxt="";
			switch(cgo){
          case "":cgotxt="SIN VALIDAR";break;
					case "F1":cgotxt="Cambio de forma";break;
          case "F2":cgotxt="Cambio de posicion";break;
          case "F3":cgotxt="Cambio de dimension";break;
					case "1":cgotxt="Fusion de mza";break;
					case "2":cgotxt="Subdivision de mza";break;
					case "3":cgotxt="Baja de mza";break;
					case "4":cgotxt="Creacion de mza";break;
          case "A":cgotxt="Creacion de ageb";break;
          case "B":cgotxt="Creacion de loc";break;
          case "F":cgotxt="Reactivacion de loc";break;
					case "5":cgotxt="Cambio mza de ageb";break;
					case "6":cgotxt="Cambio mza de loc";break;
					case "E":cgotxt="Conurba loc";break;
          case "D":cgotxt="Fusiona loc";break;
          case "N":cgotxt="Desconurba loc";break;
          case "O":cgotxt="Desfusiona loc";break;
          case "H":cgotxt="Cambio de mun";break;
					case "I":cgotxt="Cambio de ent";break;
					case "M":cgotxt="Creacion de mun";break;
          case "Y":cgotxt="Consolidacion de ageb";break;
          case "K":cgotxt="Baja de Ageb";break;
          case "R":cgotxt="Baja de loc INEXISTENTE";break;
          case "T":cgotxt="Baja de loc TAPIAS/RIONAS";break;
          case "C":cgotxt="Baja de loc POR SERVICIO";break;
			}
			String fact=rs.getObject(3).toString().substring(0,19);
			String tipo1="";
     if (rs.getString(4) != null){
        tipo1=rs.getString(4);
      }

			String clave1=rs.getObject(5).toString();
			String mov1=rs.getObject(6).toString();
      String tipo2="";
     if (rs.getString(7) != null){
        tipo2=rs.getString(7);
      }

			String clave2=rs.getObject(8).toString();
			String mov2=rs.getObject(9).toString();
      String img="";
      if (rs.getString(16) != null){
        img=rs.getString(16);
      }else{
        img="";
      }
      if (img.equals("DG")){
            img="OA";
        }
      String user="";
      if (rs.getString(17) != null){
        user=rs.getString(17);
      }else{
        user="";
      }
      String fdg="";
      if (rs.getString(18) != null){
        fdg=rs.getString(18);
      }else{
        fdg="";
      }
      String correo="";
      if (rs.getString(19) != null){
        correo=rs.getString(19);
      }else{
        correo="";
      }
      String tipte=rs.getString(20);
			obs="";
			lobs="";
			if (rs.getString(10) != null){
				obs=rs.getString(10);
				if (obs.length()>0){
					lobs=obs.substring(0, 1);
				}
			}
      String val=rs.getString(11);
      String valof=rs.getString(12);
      int motivo = Integer.parseInt(rs.getObject(13).toString());
      int max1=0;
      if (rs.getString(14) != null){
        max1 = Integer.parseInt(rs.getObject(14).toString());
      }
      int max2=0;
      if (rs.getString(15) != null){
        max2 = Integer.parseInt(rs.getObject(15).toString());
      }

      if (lobs.equals("X")){
        String coloc="red";
        if (obs.equals("X<br>Cambio MANUAL por OC")){
             coloc="pink";
        }

        obs=obs.substring(1,obs.length());
        obs1=obs.replace("<br>","");
        observa="<td align=center nowrap title='FUENTE: "+img+" "+obs1+"' bgcolor="+coloc+"><div id=c3"+gid+">&nbsp;&nbsp;" +
                     "<input type=button onclick='observa(\""+user+"\",\""+fdg+"\",\""+lobs+"\","+gid+",\""+obs+"\",\""+img+"\",\""+correo+"\");' value=' Ver ' class='boton'>" +
                     "&nbsp;&nbsp;</div>";
       }else if (cgo.equals("F2") || cgo.equals("F3")){
        //obs=obs.substring(1,obs.length());
        obs1=obs.replace("<br>","");
        observa="<td align=center nowrap title='FUENTE: "+img+" "+obs1+"' bgcolor=yellow><div id=c3"+gid+">&nbsp;&nbsp;" +
                     "<input type=button onclick='observa(\""+user+"\",\""+fdg+"\",\""+lobs+"\","+gid+",\""+obs+"\",\""+img+"\",\""+correo+"\");' value=' Ver ' class='boton'>" +
                     "&nbsp;&nbsp;</div>";
       }else{
				obs1=obs.replace("<br>","");
				observa="<td align=center nowrap title='FUENTE: "+img+" "+obs1+"'><div id=c3"+gid+">&nbsp;&nbsp;" +
                     "<input type=button onclick='observa(\""+user+"\",\""+fdg+"\",\"\","+gid+",\""+obs+"\",\""+img+"\",\""+correo+"\");' value=' Ver ' class='boton'>" +
                     "&nbsp;&nbsp;</div>";
        }


   String color="";
   if (tipte.equals("TEC")){
      color="#E0F8F7";
   }
   if (motivo==1){
     // color="#ffe6ff";
   }
    out.println( "<tr class=c bgcolor="+color+">");


////////validacion oficinas centrales s1=nivel s2=edicion

     //if (s1==3 && s2==1){
     if (s1==3){
        if (valof.equals("N")){
            out.println("<td align=center><div id=valof"+gid+"><img title='"+cgo+" - Registro sin validar (Click para validar)' onclick='modval(\"S\","+cons+","+gid+",\""+cgo+"\",\"O\",\""+tipte+"\");' border='0' src=images/sinval.png border=0></img></div>");
        }else if (valof.equals("S")){
               if (motivo==1){
                    out.println("<td align=center bgcolor=#ade6ff><div id=valof"+gid+"><img title='"+cgo+" - Registro validado (Click para retener)' onclick='modval(\"R\","+cons+","+gid+",\""+cgo+"\",\"O\",\""+tipte+"\");' border='0' src=images/val.png border=0></img></div>");
                }else{
                    out.println("<td align=center><div id=valof"+gid+"><img title='"+cgo+" - Registro validado (Click para retener)' onclick='modval(\"R\","+cons+","+gid+",\""+cgo+"\",\"O\",\""+tipte+"\");' border='0' src=images/val.png border=0></img></div>");
                }
        }else{
            out.println("<td align=center><div id=valof"+gid+"><img title='"+cgo+" - Registro retenido (Click para invalidar)' onclick='modval(\"N\","+cons+","+gid+",\""+cgo+"\",\"O\",\""+tipte+"\");' border='0' src=images/ret.png border=0></img></div>");
        }
     }else{
        //que no vea la validacion de Oficinas centrasles la regional
        if (s1==2){
           out.println ( "<td align=center><div id=valof"+gid+">-</div>");
        }else{
            if (valof.equals("N")){
                out.println ("<td align=center><div id=valof"+gid+"><img title='"+cgo+" - Registro sin validar' border='0' src=images/sinval.png border=0></img></div>");
            }else if (valof.equals("S")){
                out.println ( "<td align=center><div id=valof"+gid+"><img title='"+cgo+" - Registro validado' border='0' src=images/val.png border=0></img></div>");
            }else{
                out.println ( "<td align=center><div id=valof"+gid+"><img title='"+cgo+" - Registro retenido' border='0' src=images/ret.png border=0></img></div>");
            }
        }
    }
     col="";
     reobs="";
     ocobs="";
     edobs="";
     jpg="";

 if (rs.getString(21) != null){
        ocobs=rs.getString(21);
      }
if (rs.getString(22) != null){
        reobs=rs.getString(22);
      }
      if (rs.getString(23) != null){
        edobs=rs.getString(23);
      }


  if (rs.getString(24) != null){
        jpg=rs.getString(24);
      }

      //observaciones solo si no es regional
  if (s1==2){
               out.println ( "<td align=center><div id=valof"+gid+">-</div>");

  }else{
    if (ocobs.length()>1){col="bgcolor=#2EFE2E";}
    out.println ("<td "+col+" align=center nowrap title='"+ocobs+"'>&nbsp;&nbsp;<input type=button onclick='observaval("+cons+","+gid+",\"O\","+s1+",\""+tipte+"\");' value=' Ver ' class='boton'>&nbsp;&nbsp;");

  }
////////validacion regional

     if (s1==2){
        if (val.equals("N")){
            out.println("<td align=center><div id=val"+gid+"><img title='"+cgo+" - Registro sin validar (Click para validar)' onclick='modval(\"S\","+cons+","+gid+",\""+cgo+"\",\"R\",\""+tipte+"\");' border='0' src=images/sinval.png border=0></img></div>");
        }else if (val.equals("S")){
            out.println("<td align=center><div id=val"+gid+"><img title='"+cgo+" - Registro validado (Click para retener)' onclick='modval(\"R\","+cons+","+gid+",\""+cgo+"\",\"R\",\""+tipte+"\");' border='0' src=images/val.png border=0></img></div>");
        }else{
            out.println("<td align=center><div id=val"+gid+"><img title='"+cgo+" - Registro retenido (Click para invalidar)' onclick='modval(\"N\","+cons+","+gid+",\""+cgo+"\",\"R\",\""+tipte+"\");' border='0' src=images/ret.png border=0></img></div>");
        }
     }else{
        if (val.equals("N")){
            out.println ("<td align=center><div id=val"+gid+"><img title='"+cgo+" - Registro sin validar' border='0' src=images/sinval.png border=0></img></div>");
        }else if (val.equals("S")){
            out.println ( "<td align=center><div id=val"+gid+"><img title='"+cgo+" - Registro validado' border='0' src=images/val.png border=0></img></div>");
        }else{
            out.println ( "<td align=center><div id=val"+gid+"><img title='"+cgo+" - Registro retenido' border='0' src=images/ret.png border=0></img></div>");
        }
    }
    col="";
    if (reobs.length()>1){col="bgcolor=#2EFE2E";}
    out.println ("<td "+col+" align=center nowrap title='"+reobs+"'>&nbsp;&nbsp;<input type=button onclick='observaval("+cons+","+gid+",\"R\","+s1+",\""+tipte+"\");' value=' Ver ' class='boton'>&nbsp;&nbsp;");
    col="";
    if (edobs.length()>1){
      col="bgcolor=#2EFE2E";
    }
    if (jpg.length()>0){
      col="bgcolor=#FF8D33";
    }
    out.println ("<td "+col+" align=center nowrap title='"+edobs+"'>&nbsp;&nbsp;<input type=button onclick='observaval("+cons+","+gid+",\"E\","+s1+",\""+tipte+"\");' value=' Ver ' class='boton'>&nbsp;&nbsp;");

    colmnv="";
   if ((obs.indexOf("SILAVAC")-1)>0){
      colmnv="bgcolor=#98D7CA";
   }

          if ((cons==44 || cons==60 || cons==234 || cons==496 || cons==1705) && (cgo.length()!=2)) { //cambia datos de la tabla de eq
            out.println("<td "+colmnv+" align=center nowrap title='"+cgotxt+"'><div id=c1"+gid+">&nbsp;&nbsp;<b><font color=red onclick='edita("+gid+",\""+tipte+"\")'>"+cgo+"</font></b>&nbsp;&nbsp;</div>");
          }else{
            out.println("<td  "+colmnv+" align=center nowrap title='"+cgotxt+"'><div id=c1"+gid+">"+cgo+"</div>");
          }
          out.println("<td align=center nowrap><div id=c2"+gid+">"+fact+"</div>");
            /*motivo
            int motivo = Integer.parseInt(rs.getString(13));
            String mo0="",mo1="",mo2="",mo3="",mo4="",mo5="";
            switch (motivo){
              case 0:mo0=" selected ";break;
              case 1:mo1=" selected ";break;
              case 2:mo2=" selected ";break;
              case 3:mo3=" selected ";break;
              case 4:mo4=" selected ";break;
              case 5:mo5=" selected ";break;
          }
          String mot="<td align=center nowrap><div id=c13"+gid+">&nbsp;&nbsp;";
      if (lobs.equals("X")){
            mot += "<select class='boton' name='mot"+gid+"' onchange='chg_motivo(this,"+gid+",\""+cgo+"\")'>";
            mot += "<option value='0' "+mo0+">0-Sin motivo";
            mot += "<option value='1' "+mo1+">1-Crecimiento";
            mot += "<option value='2' "+mo2+">2-Espacio nuevo";
            mot += "<option value='3' "+mo3+">3-No habia imagen";
            mot += "<option value='4' "+mo4+">4-Correccion";
            mot += "<option value='5' "+mo5+">5-Cambio de clave";
            mot += "</select>&nbsp;&nbsp;</div>";
      }else{
        mot+="-&nbsp;&nbsp;</div>";
      }*/
            out.println(observa);
            //out.println(mot);
            //
          if ((cons==44 || cons==60 || cons==234 || cons==496 || cons==1705) && (cgo.length()!=2)) { //cambia datos de la tabla de eq
            out.println("<td align=center nowrap><div id=c4"+gid+">&nbsp;&nbsp;<b><font color=red onclick='edita("+gid+",\""+tipte+"\")'>"+tipo1+"</font></b>&nbsp;&nbsp;</div>"
              + "<td align=center nowrap><div id=c5"+gid+">&nbsp;&nbsp;<b><font color=red onclick='edita("+gid+",\""+tipte+"\")'>"+clave1+"</font></b>&nbsp;&nbsp;</div>"
              + "<td align=center nowrap><div id=c6"+gid+">&nbsp;&nbsp;<b><font color=red onclick='edita("+gid+",\""+tipte+"\")'>"+mov1+"</font></b>&nbsp;&nbsp;</div>");
			}else{
          out.println("<td align=center nowrap><div id=c4"+gid+">&nbsp;&nbsp;"+tipo1+"&nbsp;&nbsp;</div>"
              + "<td align=center nowrap><div id=c5"+gid+">&nbsp;&nbsp;"+clave1+"&nbsp;&nbsp;</div>"
              + "<td align=center nowrap><div id=c6"+gid+">&nbsp;&nbsp;"+mov1+"&nbsp;&nbsp;</div>");
        }

      //if (mov1.equals("0") || cgo.equals("6") || cgo.equals("5") || cgo.equals("E") || cgo.equals("D") || cgo.equals("H")|| cgo.equals("G") || cgo.equals("I") || cgo.equals("M") || cgo.equals("N") || cgo.equals("O")){
      if (mov1.equals("0")){
				out.println("<td align=center nowrap><div id=c7"+gid+">-</div>");
			}else{
				out.println("<td align=center nowrap><div id=c7"+gid+"><input type=button onclick='obt_geom(\"0\","+gid+",\""+cgo+"\",\""+clave1+"\",\""+tipte+"\");' value=' Ver ' class='boton'></div>");
			}

          if ((cons==44 || cons==60 || cons==234 || cons==496 || cons==1705) && (cgo.length()!=2)) { //cambia datos de la tabla de eq
            out.println("<td align=center nowrap><div id=c8"+gid+">&nbsp;&nbsp;<b><font color=red onclick='edita("+gid+",\""+tipte+"\")'>"+tipo2+"</font></b>&nbsp;&nbsp;</div>"
            + "<td align=center nowrap><div id=c9"+gid+">&nbsp;&nbsp;<b><font color=red onclick='edita("+gid+",\""+tipte+"\")'>"+clave2+"</font></b>&nbsp;&nbsp;</div>"
            + "<td align=center nowrap><div id=c10"+gid+">&nbsp;&nbsp;<b><font color=red onclick='edita("+gid+",\""+tipte+"\")'>"+mov2+"</font></b>&nbsp;&nbsp;</div>");
    }else{
            out.println("<td align=center nowrap><div id=c8"+gid+">&nbsp;&nbsp;"+tipo2+"&nbsp;&nbsp;</div>"
            + "<td align=center nowrap><div id=c9"+gid+">&nbsp;&nbsp;"+clave2+"&nbsp;&nbsp;</div>"
            + "<td align=center nowrap><div id=c10"+gid+">&nbsp;&nbsp;"+mov2+"&nbsp;&nbsp;</div>");
    }



      if (mov2.equals("0")){
				out.println("<td align=center nowrap><div id=c11"+gid+">-</div>");
			}else{
				out.println("<td align=center nowrap><div id=c11"+gid+"><input type=button onclick='obt_geom(\"1\","+gid+",\""+cgo+"\",\""+clave2+"\",\""+tipte+"\");' value=' Ver ' class='boton'></div>");
			}

            n++;
			if (s2==1){
      int gidint = Integer.parseInt(gid);
        //if (val.equals("S") || valof.equals("S")){
               //if (gidint>=max1 && gidint>=max2 && gidint>=max3 && gidint>=max4){
          //LE METO UNA BANDERA PARA QU ENO SE PUEDA BORRAR NADA
        if (valof.equals("S") ){
          out.println("<td align=center nowrap><div id=c12"+gid+">&nbsp;&nbsp;<img title='Registro validado' src='images/val.png'>&nbsp;&nbsp;</div>");
        //}else if (valof.equals("R")){
          //out.println("<td align=center nowrap><div id=c12"+gid+">&nbsp;&nbsp;<img title='Registro retenido' src='images/ret.png'>&nbsp;&nbsp;</div>");   //peticion de carlonia rojas
        }else{
          //if (gidint>=max1 && gidint>=max2 && gidint>=max3 && gidint>=max4){
          if (gidint>=max1 && gidint>=max2){
					 out.println("<td align=center nowrap><div id=c12"+gid+">&nbsp;&nbsp;<img title='Eliminar registro de TE' src=images/borra.gif onclick='regresa(\""+cgo+"\","+gid+",\""+tipte+"\")';>  &nbsp;&nbsp;</div>");
				  }else{
					 out.println("<td align=center nowrap><div id=c12"+gid+">&nbsp;&nbsp;<img title='Existe un registro de TE mas reciente con la misma clave' src='images/otroab.png'>&nbsp;&nbsp;</div>");
				  }
        }
			}
		}
    rs.close();
out.println( "</table><br><center><table align=center><tr align=center><td><font class=n>Total de Registros: " + totalRows +"</font><br><br>");

 //String export = consulta.replace("%", "-");
  //out.println ("<table><tr><td nowrap><input class='boton' type='Button' onClick='exp(\""+export.replace("'","*")+"\");' value=' Exportar a DBF '/>");

String barra="";
if(startIndex != 0) {
barra="<a class=liga1 href='tem.jsp?filerr1="+filerr1+"&filerr2="+filerr2+"&filerr="+filerr+"&filerrv="+filerrv+"&filent="+filent+"&filtipo="+filtipo+"&filcgo="+filcgo+"&filfe1="+filfe1.substring(0,10)+"&filfe2="+filfe2.substring(0,10)+"&loc="+loc+"&pass="+pass+"&ban="+ban+"&startIndex="+(startIndex-numRecordsPerPage)+"'> &nbsp;<<&nbsp; </a>";
}

for (n =0 ; n<numPages; n++){
  if (n*numRecordsPerPage == startIndex) {
    // Si el numero de pagina es la actual ($_pagi_actual). Se escribe el numero, pero sin enlace y en negrita.
    barra+="<b> &nbsp;<font class=liga>"+(n+1)+"</font>&nbsp; </b>";
  }else{
    // Si es cualquier otro. Se escibe el enlace a dicho numero de pagina.
    barra+="<a class=liga1 href='tem.jsp?filerr1="+filerr1+"&filerr2="+filerr2+"&filerr="+filerr+"&filerrv="+filerrv+"&filent="+filent+"&filtipo="+filtipo+"&filcgo="+filcgo+"&filfe1="+filfe1.substring(0,10)+"&filfe2="+filfe2.substring(0,10)+"&loc="+loc+"&pass="+pass+"&ban="+ban+"&startIndex="+(numRecordsPerPage*n)+"'> &nbsp;"+(n+1)+"&nbsp; </a>";
  }
 }






if(startIndex+numRecordsPerPage <= totalRows){
  barra+="<a class=liga1 href='tem.jsp?filerr1="+filerr1+"&filerr2="+filerr2+"&filerr="+filerr+"&filerrv="+filerrv+"&filent="+filent+"&filtipo="+filtipo+"&filcgo="+filcgo+"&filfe1="+filfe1.substring(0,10)+"&filfe2="+filfe2.substring(0,10)+"&loc="+loc+"&pass="+pass+"&ban="+ban+"&startIndex="+(startIndex+numRecordsPerPage)+"'> &nbsp;>>&nbsp; </a>";
}
out.println(barra+"<br><br>");



 String export = consultaexp.replace("%", "$");
         export = export.replace("'","%2A");
        export = export.replace("|","%7C");
        export = export.replace("v_te_mza","v_te_mza_exportar");
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
</table>
</body>
</html>
