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

function modval(val,id,clave) {
    var ajax=nuevoAjax();
    ajax.open("GET",'modval.jsp?id='+id+'&val='+val, true);
    ajax.onreadystatechange=function()
    {
        if(ajax.readyState==4)  {
             var vale=ajax.responseText;
            if (vale=='x'){
                alert ("No se pudo modificar la validacion!!");
            }else{
                div="val"+id;
                if (val=='N'){
                    tabla = "<img title='"+clave+" - Registro sin validar (Click para validar)' onclick='modval(\"S\","+id+","+clave+");' border='0' src=images/sinval.png border=0></img>";
                }else if (val=='S'){
                    tabla = "<img title='"+clave+" - Registro validado (Click para retener)' onclick='modval(\"R\","+id+","+clave+");' border='0' src=images/val.png border=0></img>";
                }else{
                    tabla = "<img title='"+clave+" - Registro retenido (Click para invalidar)' onclick='modval(\"N\","+id+","+clave+");' border='0' src=images/ret.png border=0></img></div>";
                }
                document.getElementById(div).innerHTML = tabla;
            }
        }
    }
    ajax.send(null);
    }

function camfe(gid,fecha1,fecha2) {
    var ajax=nuevoAjax();
    ajax.open("GET",'camfe.jsp?id='+gid+'&val='+fecha2, true);
    ajax.onreadystatechange=function()
    {
        if(ajax.readyState==4)  {
             var vale=ajax.responseText;
            if (vale=='x'){
                alert ("No se pudo modificar la fecha!!");
            }else{
                div="fe"+gid;
                tabla = "<a href='javascript:;' onclick='camfe("+gid+",\""+fecha2+"\",\""+fecha1+"\");'>"+fecha2+"</a>";
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


function regresa(gid,pass,clave) {
    var ajax=nuevoAjax();
    ajax.open("GET",'regresa.jsp?tipo=1&pass='+pass+'&clave='+clave, true);
    ajax.onreadystatechange=function()
    {
        if(ajax.readyState==4)  {
             var vale=ajax.responseText;
            if (parseInt(vale)==1){
                alert ("No se pudo regresar el registro!!");
            }else{
              for (i=1;i<15;i++){
                if (!(i==6 || i==7 || i==11 || i==12)){ /// este lo puse para ocultar los campos de CCL y no marque error
                  div ="c"+i+gid;
                  tabla = "-";
                  document.getElementById(div).innerHTML = tabla;
                }
              }
              div="val"+gid;
              tabla = "-";
              document.getElementById(div).innerHTML = tabla;
              div="fe"+gid;
              tabla = "-";
              document.getElementById(div).innerHTML = tabla;
              if (window.opener.editar.active){
                  window.opener.wfs.refresh({force: true});
                  window.opener.wfs.redraw(true);
              }
            }
        }
    }
    ajax.send(null);
    }

function regresa_varios(pass,where){
if (confirm("Desea borrar los registro y regresar la coordenada original??")){
ventana = window.open('regresa_varios.jsp?tipo=2&pass='+pass+'&clave='+where,'Regresa','scrollbars=no,toolbar=no');
ventana.focus();
}
}

function aplica(pass,clave){
if (confirm("Desea aplicar el cambio permanentemente??")){
ventana = window.open('real.jsp?tipo=1&pass='+pass+'&clave='+clave,'Aplicar','scrollbars=no,toolbar=no');
ventana.focus();
}
}

function real(pass,where){
if (confirm("Desea realizar los cambios permanentemente??")){
ventana = window.open('real.jsp?tipo=2&pass='+pass+'&clave="'+where+'"','Aplicar','scrollbars=no,toolbar=no');
ventana.focus();
}
}

function exp(consulta){
ventana = window.open("exp_csv.jsp?t=1&c="+consulta,'Consulta','scrollbars=no,toolbar=no');
}

function observa(cve,cod,gid,obs,img){
ventana = window.open('verobs.jsp?cve='+cve+'&cod='+cod+'&gid='+gid+'&obs='+obs+'&img='+img,'Observa','scrollbars=no,toolbar=no');
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
    document.enviar.filtipo2.value=document.enviar.filtipo.value;
    document.enviar.submit();
  }else{
    if (document.enviar.loc.value==''){
      alert ('Debe de proporcionar una clave!!');
      return false;
    }
    document.enviar.filtipo.value=document.enviar.filtipo2.value;
    document.enviar.submit();

  }
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
    ban = request.getParameter("ban"),
         consulta = "",
		 consultapas = "",
         salida1 = "",
         salida2 = "",
         salida3 = "",
         salida4 = "",
         salida5 = "",
		 salida6 = "",
         select="",select2="",
         select1="",
         st = "",
         filent="",
         filtipo="",
         filfe1="",
         filfe2="",filerr="", filerr2="",
         where="",
         observa="",lobs="",obs1="";
      consultapas = "select nivel,edicion,id,regid,nombre from usuarios where md5(password) = '"+pass+"';";

HttpSession sesion = request.getSession(true);
if ((sesion != null && !sesion.isNew())) {
        //out.println("LA SESION SIGUE ACTIVA");

    }else{
          out.println("<script>opener.cerrarSesion();window.close();</script>");
    }

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
filfe1 = request.getParameter("filfe1");
filfe2 = request.getParameter("filfe2");
filerr = request.getParameter("filerr");
if (filent==null)filent="00";
if (filtipo==null)filtipo="0";
if (filfe1==null){
  filfe1=fec1;
  filfe1="2024-12-01";
}
if (filfe2==null)filfe2=fec2;
if (filerr!=null && filerr.equals("on") ){
        filerr2=" substring (obs,1,1) !='<' and ";
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
select1="(select ok from shp_locr_coord t3 where t3.clave=t2.clave)=false and ";
select2="(select ok from shp_locr_coord t3 where t3.clave=t2.clave)=false and ";
}
if (filtipo.equals("2")){
select1="(select ok from shp_locr_coord t3 where t3.clave=t2.clave)=true and gid=(select max(gid) from te_loc_coord t1 where t1.clave=t2.clave) and ";
select2="(select ok from shp_locr_coord t3 where t3.clave=t2.clave)=true and gid=(select max(gid) from te_loc_coord t1 where t1.clave=t2.clave) and ";
}
if ((ent.equals("00"))){
                if (filent.equals("00")){
                    consulta="SELECT clave,fact,"+
                    "b_decgra(ST_X(st_transform(the_geom_ant,4326)),ST_Y(st_transform(the_geom_ant,4326))),"+
                    "b_decgra(ST_X(st_transform(the_geom_act,4326)),ST_Y(st_transform(the_geom_act,4326))),"+
                    //"ST_AsText(the_geom_ant),ST_AsText(the_geom_act),"+
                    "'','',"+
                    "ST_AsText(st_transform(the_geom_ant,3857)),ST_AsText(st_transform(the_geom_act,3857)),"+
                             "gid,(select max(gid) from te_loc_coord t1 where t1.clave=t2.clave),(select ok from shp_locr_coord t3 where t3.clave=t2.clave),obs,img,vreg from te_loc_coord t2 where "+filerr2+" "+select1+" fact between '"+filfe1+"' and '"+ filfe2 +"' order by fact,clave,gid";
               where = filerr2+"fact between '"+filfe1+"' and '"+ filfe2 +"' order by fact,clave,gid";
                }else{
                    consulta="SELECT clave,fact,"+
                    "b_decgra(ST_X(st_transform(the_geom_ant,4326)),ST_Y(st_transform(the_geom_ant,4326))),"+
                    "b_decgra(ST_X(st_transform(the_geom_act,4326)),ST_Y(st_transform(the_geom_act,4326))),"+
                    //"ST_AsText(the_geom_ant),ST_AsText(the_geom_act),"+
                    "'','',"+
                    "ST_AsText(st_transform(the_geom_ant,3857)),ST_AsText(st_transform(the_geom_act,3857)),"+
                             "gid,(select max(gid) from te_loc_coord t1 where t1.clave=t2.clave),(select ok from shp_locr_coord t3 where t3.clave=t2.clave),obs,img,vreg from te_loc_coord t2 where "+filerr2+" "+select1+" fact between '"+filfe1+"' and '"+ filfe2 +"' and substring(clave, 0 , 3) = '"+filent+"' order by fact,clave,gid";
               where = filerr2+"fact between '"+filfe1+"' and '"+ filfe2 +"' and substring(clave, 0 , 3) = '"+filent+"' order by fact,clave,gid";
                }
                select="<select name=filent class='boton'>";
                select+="<option value='00' ";if (filent.equals("00")){select+="selected";}select+=">TODAS</option>";
                select+="<option value='01' ";if (filent.equals("01")){select+="selected";}select+=">01</option>";
                select+="<option value='02' ";if (filent.equals("02")){select+="selected";}select+=">02</option>";
                select+="<option value='03' ";if (filent.equals("03")){select+="selected";}select+=">03</option>";
                select+="<option value='04' ";if (filent.equals("04")){select+="selected";}select+=">04</option>";
                select+="<option value='05' ";if (filent.equals("05")){select+="selected";}select+=">05</option>";
                select+="<option value='06' ";if (filent.equals("06")){select+="selected";}select+=">06</option>";
                select+="<option value='07' ";if (filent.equals("07")){select+="selected";}select+=">07</option>";
                select+="<option value='08' ";if (filent.equals("08")){select+="selected";}select+=">08</option>";
                select+="<option value='09' ";if (filent.equals("09")){select+="selected";}select+=">09</option>";
                select+="<option value='10' ";if (filent.equals("10")){select+="selected";}select+=">10</option>";
                select+="<option value='11' ";if (filent.equals("11")){select+="selected";}select+=">11</option>";
                select+="<option value='12' ";if (filent.equals("12")){select+="selected";}select+=">12</option>";
                select+="<option value='13' ";if (filent.equals("13")){select+="selected";}select+=">13</option>";
                select+="<option value='14' ";if (filent.equals("14")){select+="selected";}select+=">14</option>";
                select+="<option value='15' ";if (filent.equals("15")){select+="selected";}select+=">15</option>";
                select+="<option value='16' ";if (filent.equals("16")){select+="selected";}select+=">16</option>";
                select+="<option value='17' ";if (filent.equals("17")){select+="selected";}select+=">17</option>";
                select+="<option value='18' ";if (filent.equals("18")){select+="selected";}select+=">18</option>";
                select+="<option value='19' ";if (filent.equals("19")){select+="selected";}select+=">19</option>";
                select+="<option value='20' ";if (filent.equals("20")){select+="selected";}select+=">20</option>";
                select+="<option value='21' ";if (filent.equals("21")){select+="selected";}select+=">21</option>";
                select+="<option value='22' ";if (filent.equals("22")){select+="selected";}select+=">22</option>";
                select+="<option value='23' ";if (filent.equals("23")){select+="selected";}select+=">23</option>";
                select+="<option value='24' ";if (filent.equals("24")){select+="selected";}select+=">24</option>";
                select+="<option value='25' ";if (filent.equals("25")){select+="selected";}select+=">25</option>";
                select+="<option value='26' ";if (filent.equals("26")){select+="selected";}select+=">26</option>";
                select+="<option value='27' ";if (filent.equals("27")){select+="selected";}select+=">27</option>";
                select+="<option value='28' ";if (filent.equals("28")){select+="selected";}select+=">28</option>";
                select+="<option value='29' ";if (filent.equals("29")){select+="selected";}select+=">29</option>";
                select+="<option value='30' ";if (filent.equals("30")){select+="selected";}select+=">30</option>";
                select+="<option value='31' ";if (filent.equals("31")){select+="selected";}select+=">31</option>";
                select+="<option value='32' ";if (filent.equals("32")){select+="selected";}select+=">32</option></select>";
    }else if (s1.equals("2")){
         switch(ent){
          case "01":
                filreg = " and substring(clave, 0 , 3) in ('02','03','25','26')";
                selreg+="<option value='02' ";if (filent.equals("02")){selreg+="selected";}selreg+=">02</option>";
                selreg+="<option value='03' ";if (filent.equals("03")){selreg+="selected";}selreg+=">03</option>";
                selreg+="<option value='25' ";if (filent.equals("25")){selreg+="selected";}selreg+=">25</option>";
                selreg+="<option value='26' ";if (filent.equals("26")){selreg+="selected";}selreg+=">26</option>";
            break;
          case "02":
                filreg = " and substring(clave, 0 , 3) in ('08','10','32')";
                selreg+="<option value='08' ";if (filent.equals("08")){selreg+="selected";}selreg+=">08</option>";
                selreg+="<option value='10' ";if (filent.equals("10")){selreg+="selected";}selreg+=">10</option>";
                selreg+="<option value='32' ";if (filent.equals("32")){selreg+="selected";}selreg+=">32</option>";
            break;
          case "03":
                filreg = " and substring(clave, 0 , 3) in ('05','19','28')";
                selreg+="<option value='05' ";if (filent.equals("05")){selreg+="selected";}selreg+=">05</option>";
                selreg+="<option value='19' ";if (filent.equals("19")){selreg+="selected";}selreg+=">19</option>";
                selreg+="<option value='28' ";if (filent.equals("28")){selreg+="selected";}selreg+=">28</option>";
            break;
          case "04":
                filreg = " and substring(clave, 0 , 3) in ('06','14','16','18')";
                selreg+="<option value='06' ";if (filent.equals("06")){selreg+="selected";}selreg+=">06</option>";
                selreg+="<option value='14' ";if (filent.equals("14")){selreg+="selected";}selreg+=">14</option>";
                selreg+="<option value='16' ";if (filent.equals("16")){selreg+="selected";}selreg+=">16</option>";
                selreg+="<option value='18' ";if (filent.equals("18")){selreg+="selected";}selreg+=">18</option>";
            break;
          case "05":
                filreg = " and substring(clave, 0 , 3) in ('01','11','22','24')";
                selreg+="<option value='01' ";if (filent.equals("01")){selreg+="selected";}selreg+=">01</option>";
                selreg+="<option value='11' ";if (filent.equals("11")){selreg+="selected";}selreg+=">11</option>";
                selreg+="<option value='22' ";if (filent.equals("22")){selreg+="selected";}selreg+=">22</option>";
                selreg+="<option value='24' ";if (filent.equals("24")){selreg+="selected";}selreg+=">24</option>";
            break;
          case "06":
                filreg = " and substring(clave, 0 , 3) in ('12','15','17')";
                selreg+="<option value='12' ";if (filent.equals("12")){selreg+="selected";}selreg+=">12</option>";
                selreg+="<option value='15' ";if (filent.equals("15")){selreg+="selected";}selreg+=">15</option>";
                selreg+="<option value='17' ";if (filent.equals("17")){selreg+="selected";}selreg+=">17</option>";
            break;
          case "07":
                filreg = " and substring(clave, 0 , 3) in ('13','21','29','30')";
                selreg+="<option value='13' ";if (filent.equals("13")){selreg+="selected";}selreg+=">13</option>";
                selreg+="<option value='21' ";if (filent.equals("21")){selreg+="selected";}selreg+=">21</option>";
                selreg+="<option value='29' ";if (filent.equals("29")){selreg+="selected";}selreg+=">29</option>";
                selreg+="<option value='30' ";if (filent.equals("30")){selreg+="selected";}selreg+=">30</option>";
            break;
          case "08":
                filreg = " and substring(clave, 0 , 3) in ('07','20','27')";
                selreg+="<option value='07' ";if (filent.equals("07")){selreg+="selected";}selreg+=">07</option>";
                selreg+="<option value='20' ";if (filent.equals("20")){selreg+="selected";}selreg+=">20</option>";
                selreg+="<option value='27' ";if (filent.equals("27")){selreg+="selected";}selreg+=">27</option>";
            break;
          case "09":
                filreg = " and substring(clave, 0 , 3) in ('04','23','31')";
                selreg+="<option value='04' ";if (filent.equals("04")){selreg+="selected";}selreg+=">04</option>";
                selreg+="<option value='23' ";if (filent.equals("23")){selreg+="selected";}selreg+=">23</option>";
                selreg+="<option value='31' ";if (filent.equals("31")){selreg+="selected";}selreg+=">31</option>";
            break;
          case "10":
                filreg = " and substring(clave, 0 , 3) in ('09')";
                selreg+="<option value='09' ";if (filent.equals("09")){selreg+="selected";}selreg+=">09</option>";
            break;
        }
            if (filent.equals("00")){
                    consulta="SELECT clave,fact,"+
                    "b_decgra(ST_X(st_transform(the_geom_ant,4326)),ST_Y(st_transform(the_geom_ant,4326))),"+
                    "b_decgra(ST_X(st_transform(the_geom_act,4326)),ST_Y(st_transform(the_geom_act,4326))),"+
                    //"ST_AsText(the_geom_ant),ST_AsText(the_geom_act),"+
                    "'','',"+
                    "ST_AsText(st_transform(the_geom_ant,3857)),ST_AsText(st_transform(the_geom_act,3857)),"+
                             "gid,(select max(gid) from te_loc_coord t1 where t1.clave=t2.clave),(select ok from shp_locr_coord t3 where t3.clave=t2.clave),obs,img,vreg from te_loc_coord t2 where "+filerr2+" "+select1+" fact between '"+filfe1+"' and '"+ filfe2 +"' "+filreg+"order by fact,clave,gid";
               where = filerr2+"fact between '"+filfe1+"' and '"+ filfe2 +"' "+filreg+" order by fact,clave,gid";
                }else{
                    consulta="SELECT clave,fact,"+
                    "b_decgra(ST_X(st_transform(the_geom_ant,4326)),ST_Y(st_transform(the_geom_ant,4326))),"+
                    "b_decgra(ST_X(st_transform(the_geom_act,4326)),ST_Y(st_transform(the_geom_act,4326))),"+
                    //"ST_AsText(the_geom_ant),ST_AsText(the_geom_act),"+
                    "'','',"+
                    "ST_AsText(st_transform(the_geom_ant,3857)),ST_AsText(st_transform(the_geom_act,3857)),"+
                             "gid,(select max(gid) from te_loc_coord t1 where t1.clave=t2.clave),(select ok from shp_locr_coord t3 where t3.clave=t2.clave),obs,img,vreg from te_loc_coord t2 where "+filerr2+" "+select1+" fact between '"+filfe1+"' and '"+ filfe2 +"' and substring(clave, 0 , 3) = '"+filent+"' order by fact,clave,gid";
               where = filerr2+"fact between '"+filfe1+"' and '"+ filfe2 +"' and substring(clave, 0 , 3) = '"+filent+"' order by fact,clave,gid";
                }
                 select="<select name=filent class='boton'>";
                select+="<option value='00' ";if (filent.equals("00")){select+="selected";}select+=">TODAS</option>";
                select+=selreg+"</select>";
    }else{
        consulta="SELECT clave,fact,"+
                    "b_decgra(ST_X(st_transform(the_geom_ant,4326)),ST_Y(st_transform(the_geom_ant,4326))),"+
                    "b_decgra(ST_X(st_transform(the_geom_act,4326)),ST_Y(st_transform(the_geom_act,4326))),"+
                    //"ST_AsText(the_geom_ant),ST_AsText(the_geom_act),"+
                    "'','',"+
                    "ST_AsText(st_transform(the_geom_ant,3857)),ST_AsText(st_transform(the_geom_act,3857)),"+
                 "gid,(select max(gid) from te_loc_coord t1 where t1.clave=t2.clave),(select ok from shp_locr_coord t3 where t3.clave=t2.clave),obs,img,vreg " +
                 "from te_loc_coord t2 where "+filerr2+" "+select1+" fact between '"+filfe1+"' and '"+ filfe2 +"' and substring(clave, 0 , 3) = '"+ent+"' order by fact,clave,gid";
                select="<select name=filent class='boton'>"+"<option value='"+ent+"'>"+ent+"</option></select>";
            where = filerr2+"fact between '"+filfe1+"' and '"+ filfe2 +"' and substring(clave, 0 , 3) = '"+ent+"' order by fact,clave,gid";
    }
    String filult="";
  if(loc != null && !loc.isEmpty()){
        if (s1.equals("1")){
            filult = " and substring(clave, 0 , 3) ='"+ent+"'";
       }else if (s1.equals("2")){
            filult=filreg;
        }

          consulta="SELECT clave,fact,"+
                    "b_decgra(ST_X(st_transform(the_geom_ant,4326)),ST_Y(st_transform(the_geom_ant,4326))),"+
                    "b_decgra(ST_X(st_transform(the_geom_act,4326)),ST_Y(st_transform(the_geom_act,4326))),"+
                    //"ST_AsText(the_geom_ant),ST_AsText(the_geom_act),"+
                    "'','',"+
                    "ST_AsText(st_transform(the_geom_ant,3857)),ST_AsText(st_transform(the_geom_act,3857)),"+
         "gid,(select max(gid) from te_loc_coord t1 where t1.clave=t2.clave),(select ok from shp_locr_coord t3 where t3.clave=t2.clave),obs,img,vreg " +
         "from te_loc_coord t2 where "+select1+" clave like '" + loc + "%' "+filult+" order by fact,clave,gid";
         where = select1+" clave like '" + loc + "%' "+filult+" order by fact,clave,gid";
}


  //out.println( consulta );
       select2="<select name=filtipo2 class='boton'>";
       select2+="<option value='0' ";if (filtipo.equals("0")){select2+="selected";}select2+=">TODOS</option>";
       select2+="<option value='1' ";if (filtipo.equals("1")){select2+="selected";}select2+=">APLICADOS</option>";
       select2+="<option value='2' ";if (filtipo.equals("2")){select2+="selected";}select2+=">PENDIENTES</option></select>";


       select1="<select name=filtipo class='boton'>";
       select1+="<option value='0' ";if (filtipo.equals("0")){select1+="selected";}select1+=">TODOS</option>";
       select1+="<option value='1' ";if (filtipo.equals("1")){select1+="selected";}select1+=">APLICADOS</option>";
       select1+="<option value='2' ";if (filtipo.equals("2")){select1+="selected";}select1+=">PENDIENTES</option></select>";
       String checkerr="&nbsp;&nbsp;&nbsp;<input class='boton' type='checkbox' name='filerr' ";
       if (filerr!=null && filerr.equals("on") ){
        checkerr+="checked";
      }
       checkerr+=">Solo con Obs";
      out.println( "<center class='t'>Tabla de Equivalencia de Coordenadas</center>"
              	+ "<form action=\"tel.jsp\" method=\"post\" name=\"enviar\">"
                + "<center><br><table border=0><tr onmouseover='this.style.background=\"#F0F0F0\"' onmouseout='this.style.background=\"#FFFFFF\"' class=n><td align=center>"
                + "&nbsp;&nbsp;&nbsp;&nbsp;De:&nbsp;<input class='boton' name='filfe1' type='text' id='p1id' onClick=\"popUpCalendar(this, enviar.p1id, 'yyyy-mm-dd');\" size='10'  value='"+filfe1+"'>"
                + "&nbsp;&nbsp;&nbsp;&nbsp;a:&nbsp;<input class='boton' name='filfe2' type='text' id='p2id' onClick=\"popUpCalendar(this, enviar.p2id, 'yyyy-mm-dd');\" size='10'  value='"+filfe2+"'>"
                + "&nbsp;&nbsp;&nbsp;&nbsp;Entidad:&nbsp;"+select
                + "&nbsp;&nbsp;&nbsp;&nbsp;Tipo:&nbsp;"+select1+checkerr
                + "<input type='hidden' name='ent' value='"+ent+"'><input type='hidden' name='ban' value='1'><input type='hidden' name='regid' value='"+regid+"'>&nbsp;&nbsp;&nbsp;&nbsp;<input class='boton' type='button' value=' Buscar ' onclick='envia(1)''><tr><td>&nbsp;<tr onmouseover='this.style.background=\"#F0F0F0\"' onmouseout='this.style.background=\"#FFFFFF\"' class=n><td align=center>Tipo:&nbsp;"+select2+"&nbsp;&nbsp;&nbsp;&nbsp;Por localidad:&nbsp;&nbsp;"
                + "<input type='text' maxlength=13 size=15 name='loc' value='"+loc+"' class='boton'><input type='hidden' name='pass' value='"+pass+"'>&nbsp;&nbsp;&nbsp;&nbsp;<input class='boton' type='button' value=' Buscar ' onclick='envia(2)'></table></form><br>");
	out.println( "<table border=1><tr class=n bgcolor=#BBBBBB>");
         out.println("<th rowspan=2>Val<br>&nbsp;OC&nbsp;");
       out.println("<th rowspan=2>Val<br>&nbsp;Reg&nbsp;");
  out.println("<th rowspan=2>&nbsp;&nbsp;Clave&nbsp;&nbsp;<th rowspan=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Fecha&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<th rowspan=2>&nbsp;Obs&nbsp;<th colspan=3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Anterior&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<th colspan=3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Actual&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
		if (s2==1){
			out.println("<th rowspan=2><img src=images/borra.gif>");
		}
        out.println( "<tr class=n bgcolor=#BBBBBB><th>&nbsp;&nbsp;LONGITUD&nbsp;&nbsp;<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;LATITUD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
        //out.println( "<th>&nbsp;&nbsp;CCL(X)&nbsp;&nbsp;<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;CCL(Y)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
        out.println( "<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ver&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
	      out.println( "<th>&nbsp;&nbsp;LONGITUD&nbsp;&nbsp;<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;LATITUD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
        //out.println( "<th>&nbsp;&nbsp;CCL(X)&nbsp;&nbsp;<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;CCL(Y)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
        out.println( "<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ver&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");


  if (ban!=null){

   String consultacount=consulta.replace("clave,fact,b_decgra(ST_X(st_transform(the_geom_ant,4326)),ST_Y(st_transform(the_geom_ant,4326))),b_decgra(ST_X(st_transform(the_geom_act,4326)),ST_Y(st_transform(the_geom_act,4326))),'','',ST_AsText(st_transform(the_geom_ant,3857)),ST_AsText(st_transform(the_geom_act,3857)),gid,(select max(gid) from te_loc_coord t1 where t1.clave=t2.clave),(select ok from shp_locr_coord t3 where t3.clave=t2.clave),obs,img,vreg","count(*)");
    consultacount=consultacount.replace("order by fact,clave,gid","");
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
		while(rs.next()){
            String clave=rs.getObject(1).toString();
            String fact=rs.getObject(2).toString();
            //String ccl1=rs.getObject(3).toString();
            //String ccl2=rs.getObject(4).toString();
            String gra1=rs.getObject(3).toString();
            String gra2=rs.getObject(4).toString();
            //String geo1=rs.getObject(5).toString();
            //String geo2=rs.getObject(6).toString();
            String gog1=rs.getObject(7).toString();
            String gog2=rs.getObject(8).toString();
            String gid=rs.getObject(9).toString();
            String gid2=rs.getObject(10).toString();
            String ok1=rs.getObject(11).toString();
            String obs=rs.getString(12);
            String img=rs.getString(13);
            String val=rs.getString(14);
            lobs=obs.substring(0, 1);
            if (lobs.equals("X") || lobs.equals("G") || lobs.equals("D") || lobs.equals("E")){
            obs=obs.substring(1,obs.length());
            obs1=obs.replace("<br>","");
             observa="<td align=center nowrap title='FUENTE: "+img+" "+obs1+"' bgcolor=red><div id=c1"+gid+">&nbsp;&nbsp;" +
                     "<input type=button onclick='observa(\""+clave+"\",\""+lobs+"\","+gid+",\""+obs+"\",\""+img+"\");' value=' Ver ' class='boton'>" +
                     "&nbsp;&nbsp;</div>";
            }else{
            obs1=obs.replace("<br>","");
             observa="<td align=center nowrap title='FUENTE: "+img+" "+obs1+"'><div id=c1"+gid+">&nbsp;&nbsp;" +
                     "<input type=button onclick='observa(\""+clave+"\",\"\","+gid+",\""+obs+"\",\""+img+"\");' value=' Ver ' class='boton'>" +
                     "&nbsp;&nbsp;</div>";
            }
            //salida1 = ccl1.replace("POINT(","");
            //salida1 = salida1.replace(" ",",");
            //salida1 = salida1.replace(")","");
            //salida2 = ccl2.replace("POINT(","");
            //salida2 = salida2.replace(" ",",");
            //salida2 = salida2.replace(")","");
            salida1 = gra1.replace("{","");
            salida1 = salida1.replace(" ",",");
            salida1 = salida1.replace("}","");
            salida2 = gra2.replace("{","");
            salida2 = salida2.replace(" ",",");
            salida2 = salida2.replace("}","");
            //salida3 = geo1.replace("POINT(","");
            //salida3 = salida3.replace(" ",",");
            //salida3 = salida3.replace(")","");
            //salida4 = geo2.replace("POINT(","");
            //salida4 = salida4.replace(" ",",");
            //salida4 = salida4.replace(")","");
            salida5 = gog1.replace("POINT(","");
            salida5 = salida5.replace(" ",",");
            salida5 = salida5.replace(")","");
            salida6 = gog2.replace("POINT(","");
            salida6 = salida6.replace(" ",",");
            salida6 = salida6.replace(")","");
            String[] salvec1 = salida1.split(",");
            String[] salvec2 = salida2.split(",");
            //String[] salvec3 = salida3.split(",");
            //String[] salvec4 = salida4.split(",");
			String[] salvec5 = salida5.split(",");
			String[] salvec6 = salida6.split(",");
            //if (salvec1[0].length()>10){salvec1[0]=salvec1[0].substring(0,10);};
            //if (salvec1[1].length()>8){salvec1[1]=salvec1[1].substring(0,8);};
            if (salvec1[0].length()>10){salvec1[0]=salvec1[0].substring(0,11);};
            if (salvec1[1].length()>8){salvec1[1]=salvec1[1].substring(0,10);};
            //if (salvec3[0].length()>13){salvec3[0]=salvec3[0].substring(0,13);};
            //if (salvec3[1].length()>13){salvec3[1]=salvec3[1].substring(0,13);};
            //if (salvec2[0].length()>10){salvec2[0]=salvec2[0].substring(0,10);};
            //if (salvec2[1].length()>8){salvec2[1]=salvec2[1].substring(0,8);};
            if (salvec2[0].length()>10){salvec2[0]=salvec2[0].substring(0,11);};
            if (salvec2[1].length()>8){salvec2[1]=salvec2[1].substring(0,10);};
            //if (salvec4[0].length()>13){salvec4[0]=salvec4[0].substring(0,13);};
            //if (salvec4[1].length()>13){salvec4[1]=salvec4[1].substring(0,13);};
            if (salvec5[0].length()>13){salvec5[0]=salvec5[0].substring(0,13);};
            if (salvec5[1].length()>13){salvec5[1]=salvec5[1].substring(0,13);};
            if (salvec6[0].length()>13){salvec6[0]=salvec6[0].substring(0,13);};
            if (salvec6[1].length()>13){salvec6[1]=salvec6[1].substring(0,13);};
            salvec1[0]=salvec1[0].substring(0,3)+"\u00B0"+salvec1[0].substring(3,5)+"\u0027"+salvec1[0].substring(5,11)+'\u0022';
            salvec1[1]=salvec1[1].substring(0,2)+"\u00B0"+salvec1[1].substring(2,4)+"\u0027"+salvec1[1].substring(4,10)+'\u0022';
            salvec2[0]=salvec2[0].substring(0,3)+"\u00B0"+salvec2[0].substring(3,5)+"\u0027"+salvec2[0].substring(5,11)+'\u0022';
            salvec2[1]=salvec2[1].substring(0,2)+"\u00B0"+salvec2[1].substring(2,4)+"\u0027"+salvec2[1].substring(4,10)+'\u0022';
            out.println( "<tr class=c>");

     if (gid.equals(gid2) && ok1.equals("true") && s1.equals("3") && s2==1){
        out.println("<td align=center nowrap><div id=c2"+gid+">&nbsp;&nbsp;<img title='Aplicar el cambio a la localida "+clave+"' src=images/aplica.png onclick='aplica(\""+pass+"\",\""+clave+"\")';>&nbsp;&nbsp;</div>");
        n1++;
      }else{
        if (gid.equals(gid2) && ok1.equals("true")){
          out.println("<td align=center nowrap><div id=c2"+gid+">&nbsp;&nbsp;No&nbsp;&nbsp;</div>");
        }else{
          out.println("<td align=center nowrap><div id=c2"+gid+">&nbsp;&nbsp;Si&nbsp;&nbsp;</div>");
        }
     }

     if (gid.equals(gid2) && s1.equals("2")){
        if (val.equals("N")){
            out.println("<td align=center><div id=val"+gid+"><img title='"+clave+" - Registro sin validar (Click para validar)' onclick='modval(\"S\","+gid+","+clave+");' border='0' src=images/sinval.png border=0></img></div>");
        }else if (val.equals("S")){
            out.println("<td align=center><div id=val"+gid+"><img title='"+clave+" - Registro validado (Click para retener)' onclick='modval(\"R\","+gid+","+clave+");' border='0' src=images/val.png border=0></img></div>");
        }else{
            out.println("<td align=center><div id=val"+gid+"><img title='"+clave+" - Registro retenido (Click para invalidar)' onclick='modval(\"N\","+gid+","+clave+");' border='0' src=images/ret.png border=0></img></div>");
        }
     }else{
        if (val.equals("N")){
            out.println ("<td align=center><div id=val"+gid+"><img title='"+clave+" - Registro sin validar' border='0' src=images/sinval.png border=0></img></div>");
        }else if (val.equals("S")){
            out.println ( "<td align=center><div id=val"+gid+"><img title='"+clave+" - Registro validado' border='0' src=images/val.png border=0></img></div>");
        }else{
            out.println ( "<td align=center><div id=val"+gid+"><img title='"+clave+" - Registro retenido' border='0' src=images/ret.png border=0></img></div>");
        }
    }
            out.println("<td align=center nowrap><div id=c3"+gid+">&nbsp;&nbsp;"+clave+"&nbsp;&nbsp;</div>");
            if (gid.equals(gid2) && ok1.equals("true") && s1.equals("3") && s2==1){
              out.println("<td align=center nowrap title='Cambiar fecha'><div id=fe"+gid+"><a href='javascript:;' onclick='camfe("+gid+",\""+fact+"\",\""+fec1+"\");'>"+fact+"</a></div>");
            }else{
              out.println("<td align=center nowrap><div id=fe"+gid+">"+fact+"</div>");
            }
            out.println(observa+"<td align=center nowrap><div id=c4"+gid+">&nbsp;&nbsp;"+salvec1[0]+"&nbsp;&nbsp;</div>"
            + "<td align=center nowrap><div id=c5"+gid+">&nbsp;&nbsp;"+salvec1[1]+"&nbsp;&nbsp;</div>"
            //+ "<td align=center nowrap><div id=c6"+gid+">&nbsp;&nbsp;"+salvec3[0]+"&nbsp;&nbsp;</div>"
            //+ "<td align=center nowrap><div id=c7"+gid+">&nbsp;&nbsp;"+salvec3[1]+"&nbsp;&nbsp;</div>"
            + "<td align=center nowrap><div id=c8"+gid+"><input type=button onclick='window.opener.buscazoomte(\"0\","+(salvec5[0])+","+(salvec5[1])+");' value=' Ver ' class='boton'></div>"
            + "<td align=center nowrap><div id=c9"+gid+">&nbsp;&nbsp;"+salvec2[0]+"&nbsp;&nbsp;</div>"
            + "<td align=center nowrap><div id=c10"+gid+">&nbsp;&nbsp;"+salvec2[1]+"&nbsp;&nbsp;</div>"
            //+ "<td align=center nowrap><div id=c11"+gid+">&nbsp;&nbsp;"+salvec4[0]+"&nbsp;&nbsp;</div>"
            //+ "<td align=center nowrap><div id=c12"+gid+">&nbsp;&nbsp;"+salvec4[1]+"&nbsp;&nbsp;</div>"
            + "<td align=center nowrap><div id=c13"+gid+"><input type=button onclick='window.opener.buscazoomte(\"1\","+(salvec6[0])+","+(salvec6[1])+");' value=' Ver ' class='boton'></div>");
            n++;
			if (s2==1){
				if (gid.equals(gid2) && ok1.equals("true")){
					out.println("<td align=center nowrap><div id=c14"+gid+">&nbsp;&nbsp;<img title='Regresar a su coordenada original la localidad "+clave+"' src=images/borra.gif onclick='regresa("+gid+",\""+pass+"\",\""+clave+"\","+gid+")';>&nbsp;&nbsp;</div>");
				}else{
					out.println("<td align=center nowrap><div id=c14"+gid+">&nbsp;&nbsp;&nbsp;&nbsp;</div>");
				}
			}
		}
    rs.close();
 	out.println( "</table><br><center><table align=center><tr align=center><td><font class=n>Total de Registros: " + totalRows +"</font><br><br>");

 //String export = consulta.replace("%", "-");
  //out.println ("<table><tr><td nowrap><input class='boton' type='Button' onClick='exp(\""+export.replace("'","*")+"\");' value=' Exportar a DBF '/>");

String barra="";
if(startIndex != 0) {
barra="<a class=liga1 href='tel.jsp?filent="+filent+"&filtipo="+filtipo+"&filfe1="+filfe1.substring(0,10)+"&filfe2="+filfe2.substring(0,10)+"&loc="+loc+"&pass="+pass+"&ban="+ban+"&startIndex="+(startIndex-numRecordsPerPage)+"'> &nbsp;<<&nbsp; </a>";
}

for (n =0 ; n<numPages; n++){
  if (n*numRecordsPerPage == startIndex) {
    // Si el numero de pagina es la actual ($_pagi_actual). Se escribe el numero, pero sin enlace y en negrita.
    barra+="<b> &nbsp;<font class=liga>"+(n+1)+"</font>&nbsp; </b>";
  }else{
    // Si es cualquier otro. Se escibe el enlace a dicho numero de pagina.
    barra+="<a class=liga1 href='tel.jsp?filent="+filent+"&filtipo="+filtipo+"&filfe1="+filfe1.substring(0,10)+"&filfe2="+filfe2.substring(0,10)+"&loc="+loc+"&pass="+pass+"&ban="+ban+"&startIndex="+(numRecordsPerPage*n)+"'> &nbsp;"+(n+1)+"&nbsp; </a>";
  }
 }




if(startIndex+numRecordsPerPage <= totalRows){
  barra+="<a class=liga1 href='tel.jsp?filent="+filent+"&filtipo="+filtipo+"&filfe1="+filfe1.substring(0,10)+"&filfe2="+filfe2.substring(0,10)+"&loc="+loc+"&pass="+pass+"&ban="+ban+"&startIndex="+(startIndex+numRecordsPerPage)+"'> &nbsp;>>&nbsp; </a>";
}
out.println(barra+"<br><br>");





  if (s1.equals("3") && s2==1){
    where = where.replace("%", "$");
        where = where.replace("'","%2A");
        where = where.replace("|","%7C");
    out.println ("<table><td nowrap>&nbsp;&nbsp;<input class='boton' type='Button' onClick='real(\""+pass+"\",\""+where+"\");' Title='Realizar cambios en la tabla original' value=' CAMBIAR TODOS LOS REGISTROS ("+n1+")'/>");
    out.println ("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<td nowrap>&nbsp;&nbsp;<input class='boton' type='Button' onClick='regresa_varios(\""+pass+"\",\""+where+"\");' Title='Regresar a su posicion original' value=' REGRESAR TODOS LOS REGISTROS ("+n1+")'/></table>");
	 out.println( "<br>");

 }
 String export="select clave,fact,ant[1] as lon_ant,ant[2] as lat_ant ,act[1] as lon_act,act[2] as lat_act, obs,img,vreg  from (SELECT clave,fact,b_decgra(ST_X(st_transform(the_geom_ant,4326)),ST_Y(st_transform(the_geom_ant,4326))) as ant,b_decgra(ST_X(st_transform(the_geom_act,4326)),ST_Y(st_transform(the_geom_act,4326))) as act,replace(obs,*<br>*,**) as obs,img,vreg from te_loc_coord t2 where "+where+") t1";
 export = export.replace("%", "$");
        export = export.replace("'","%2A");
        export = export.replace("|","%7C");
export = export.replace("[", "corchete1");
export = export.replace("]", "corchete2");

  out.println ("<table><tr><td nowrap><input class='boton' type='Button' onClick='exp(\""+export+"\");' value=' Exportar a DBF '/>");

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
