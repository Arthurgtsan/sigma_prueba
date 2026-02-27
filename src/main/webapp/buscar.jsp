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
<%


HttpSession sesion = request.getSession(true);
if ((sesion != null && !sesion.isNew())) {
        //out.println("LA SESION SIGUE ACTIVA");



int capa = Integer.parseInt(request.getParameter("capa")),
    tipo = Integer.parseInt(request.getParameter("tipo")),
    n = 0, ban=0;
String  buscar = request.getParameter("buscar").toUpperCase(),
         consulta = "",
         salida = "",
         limit = " limit 100",
         st = "";
%>
<style type="text/css">
table {
  border-collapse: collapse;
}
.t{font-size: 12pt; font-family: Arial; font-weight: bold; color: #000000;}
.c{font-family: Arial; font-size: 10pt; line-height: 1.3; font-weight: normal;}
.n{font-family: Arial; font-size: 10pt; line-height: 1.3; font-weight: bold;}
.r{font-family: Arial; font-size: 8pt; line-height: 1.3;}
.boton{font-family: Arial; font-size: 10px; line-height: 1; font-weight: normal;}

</style>
<script language="javascrpt" type="text/javascript">
window.resizeTo(800,400);
var buscar='<% out.print(buscar); %>';
var capa='<% out.print(capa); %>';

function envia(){
    document.enviar.submit();
}

var out = "";
var out2 = 0;
if (capa=='12'){
    out+='<style type="text/css">table { border-collapse: collapse;}';
    out+='.t{font-size: 12pt; font-family: Arial; font-weight: bold; color: #000000;}';
    out+='.c{font-family: Arial; font-size: 10pt; line-height: 1.3; font-weight: normal;}';
    out+='.n{font-family: Arial; font-size: 10pt; line-height: 1.3; font-weight: bold;}';
    out+='.r{font-family: Arial; font-size: 8pt; line-height: 1.3;}';
    out+='.boton{font-family: Arial; font-size: 10px; line-height: 1; font-weight: normal;}</style>';
    var requestURL = 'https://nominatim.openstreetmap.org/search?q='+buscar+'&format=json';
    var xmlhttp = new XMLHttpRequest();

  xmlhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
        var myArr = JSON.parse(this.responseText);
        //document.write(myArr);
        //setTimeout(function(){ }, 1000);
        myFunction(myArr);
    }else{
      if (out2==0){
        out="";
        out+= "<body><form action='buscar.jsp' method='post' name='enviar'><center class='t'>RESULTADOS<br><br>";
        out+= "<table border=1 width=75%><tr class=n bgcolor=#BBBBBB><th width=80%>&nbsp;&nbsp;Direccion&nbsp;&nbsp;<th>&nbsp;&nbsp;Referencia&nbsp;&nbsp;"
        out += '<tr><td colspan=2 align=center>Sin servicio OSM... Conectando...';
        document.write( out );
        out2=1;
      }
    }
  };

xmlhttp.open("GET", requestURL, true);
xmlhttp.send();
}

function myFunction(arr) {
  //console.log(arr);
    out = "";
    var i;
    out+='<style type="text/css">table { border-collapse: collapse;}';
    out+='.t{font-size: 12pt; font-family: Arial; font-weight: bold; color: #000000;}';
    out+='.c{font-family: Arial; font-size: 10pt; line-height: 1.3; font-weight: normal;}';
    out+='.n{font-family: Arial; font-size: 10pt; line-height: 1.3; font-weight: bold;}';
    out+='.r{font-family: Arial; font-size: 8pt; line-height: 1.3;}';
    out+='.boton{font-family: Arial; font-size: 10px; line-height: 1; font-weight: normal;}</style>';
    out+= "<body><form action='buscar.jsp' method='post' name='enviar'><center class='t'>RESULTADOS<br><br>";
    out+= "<table border=1 width=75%><tr class=n bgcolor=#BBBBBB><th width=80%>&nbsp;&nbsp;Direccion&nbsp;&nbsp;<th>&nbsp;&nbsp;Referencia&nbsp;&nbsp;"
    for(i = 0; i < arr.length; i++) {
        out += '<tr><td>'+arr[i].display_name + '<td align=center><input type=button onclick="buscazoomosm('+arr[i].lon+','+arr[i].lat+');" value=" Ver " class="boton">';
      }
    document.write( out );
}


</script>
  </head>
<body>
<%
if (capa!=12){

 String select="",filent="",where1="",where2="";

filent = request.getParameter("filent");
if (filent==null){
  filent="00";
}
if (filent.equals("00")){
   where1 = "";
   where2 = "";
}else{
   where1 = " cve_ent='"+filent+"' and ";
   where2 = " where cve_ent='"+filent+"'";
}

buscar = buscar.replace("-","");
buscar = buscar.replace(";","");
switch(capa){
     case 1:    //cartas
	if (tipo == 0){
		consulta="SELECT cve_carta,nombre,case when the_geom is not null THEN box2d(ST_Transform(the_geom,3857))::text else 'x' end as salida FROM cat_cartas t1 where a_sinacentos(cve_carta) like '" + buscar + "%' order by cve_carta"+limit;
	}else{
		consulta="select cve_carta,nombre,case when the_geom is not null THEN box2d(ST_Transform(the_geom,3857))::text else 'x' end as salida FROM cat_cartas t1 where upper(a_sinacentos(cve_carta)) like '%" + buscar + "%'  order by cve_carta"+limit;
	}
	break;
case 2:		//estados
	if (tipo==0){
		consulta="SELECT clave,nom_ent,case when the_geom is not null THEN box2d(ST_Transform(the_geom,3857))::text else 'x' end as salida FROM cat_ent t1 where "+where1+" clave like '" + buscar + "%' and status=1 order by clave"+limit;
	}else{
		consulta="select clave,nom_ent,case when the_geom is not null THEN box2d(ST_Transform(the_geom,3857))::text else 'x' end as salida FROM cat_ent t1 where "+where1+" upper(a_sinacentos(nom_ent)) like '%" + buscar + "%'  and status=1 order by clave"+limit;
	}
	break;
case 3:		//municipios
	if (tipo==0){
		consulta="SELECT clave,nom_mun,case when the_geom is not null THEN box2d(ST_Transform(the_geom,3857))::text else 'x' end as salida FROM cat_mun t1 where "+where1+" clave like '" + buscar + "%' and status=1 order by clave"+limit;
	}else{
		consulta="select clave,nom_mun,case when the_geom is not null THEN box2d(ST_Transform(the_geom,3857))::text else 'x' end as salida FROM cat_mun t1 where "+where1+" upper(a_sinacentos(nom_mun)) like '%" + buscar + "%'  and status=1 order by clave"+limit;
	}
	break;
case 4:		//agebs
	if (tipo==0){
		consulta="SELECT clave,cve_ageb,case when the_geom is not null THEN box2d(ST_Transform(the_geom,3857))::text else 'x' end as salida,ambito FROM (select clave,cve_ageb,ambito,the_geom from cat_ageb where "+where1+" status=1 union select clave,cve_ageb,ambito,the_geom from cat_agebu "+where2+") t1 where replace(clave,'-','') like '" + buscar + "%' order by ambito,clave"+limit;
	}else{
		consulta="select clave,cve_ageb,case when the_geom is not null THEN box2d(ST_Transform(the_geom,3857))::text else 'x' end as salida,ambito FROM (select clave,cve_ageb,ambito,the_geom from cat_ageb where "+where1+" status=1 union select clave,cve_ageb,ambito,the_geom from cat_agebu "+where2+") t1 where upper(a_sinacentos(replace(cve_ageb,'-',''))) like '%" + buscar + "%'  order by ambito,clave"+limit;
	}
	break;
case 5:		//urbanas   --deshabilitado
	if (tipo==0){
		consulta="SELECT clave,nom_loc,case when the_geom is not null THEN box2d(ST_Transform(the_geom,3857))::text else 'x' end as salida FROM cat_loc t1 where "+where1+" clave like '" + buscar + "%' and status=1 order by clave"+limit;
	}else{
		consulta="select clave,nom_loc,case when the_geom is not null THEN box2d(ST_Transform(the_geom,3857))::text else 'x' end as salida FROM cat_loc t1 where "+where1+" upper(a_sinacentos(nom_loc)) like '%" + buscar + "%' and status=1 order by clave"+limit;
	}
	break;
case 6:		//pol rurales  --deshabilitado
	if (tipo==0){
		consulta="SELECT clave,nom_loc,case when the_geom is not null THEN box2d(ST_Transform(the_geom,3857))::text else 'x' end as salida FROM cat_loc t1 where "+where1+" the_geom_pr NOT NULL and clave like '" + buscar + "%' and status=1 order by clave"+limit;
	}else{
		consulta="select clave,nom_loc,case when the_geom is not null THEN box2d(ST_Transform(the_geom,3857))::text else 'x' end as salida FROM cat_loc t1 where "+where1+" the_geom_pr NOT NULL and upper(a_sinacentos(nom_loc)) like '%" + buscar + "%' and status=1 order by clave"+limit;
	}
	break;
case 7:		//rurales   --lo modifique para que buscque tanto urbanas como rurales y poligonos rurales
	if (tipo==0){
            consulta = "SELECT clave,nom_loc,"
            + "case "
            + "	when the_geom is not null THEN box2d(ST_Transform(the_geom,3857))::text "
            + " else 'x' "
            + "end "
            + "as salida,status,ambito,cve_ageb "
            + "FROM cat_loc t1 where "+where1+" replace(clave,'-','') like '" + buscar + "%' order by clave"+limit;
	}else{
            consulta = "SELECT clave,nom_loc,"
            + "case "
            + "	when the_geom is not null THEN box2d(ST_Transform(the_geom,3857))::text "
            + " else 'x' "
            + "end "
            + "as salida,status,ambito,cve_ageb "
            + "FROM cat_loc t1 where "+where1+" upper(a_sinacentos(nom_loc)) like '%" + buscar + "%' order by clave"+limit;
	}
	break;
case 8:     //asentamiento
	if (tipo==0){
		consulta="SELECT clave,nom_asen,case when the_geom is not null THEN box2d(ST_Transform(the_geom,3857))::text else 'x' end as salida FROM cat_asen t1 where "+where1+" the_geom is NOT NULL and clave like '" + buscar + "%' order by clave"+limit;

	}else{
		consulta="select clave,nom_asen,case when the_geom is not null THEN box2d(ST_Transform(the_geom,3857))::text else 'x' end as salida FROM cat_asen t1 where "+where1+" the_geom is NOT NULL and upper(a_sinacentos(nom_asen)) like '%" + buscar + "%' order by clave"+limit;
	}
	break;
case 9:   //vialidades
	if (tipo==0){
		consulta="SELECT clave,nom_via,case when the_geom is not null THEN box2d(ST_Transform(the_geom,3857))::text else 'x' end as salida FROM cat_vial t1 where "+where1+" the_geom is NOT NULL and clave like '" + buscar + "%' order by clave"+limit;

	}else{
		consulta="select clave,nom_via,case when the_geom is not null THEN box2d(ST_Transform(the_geom,3857))::text else 'x' end as salida FROM cat_vial t1 where "+where1+" the_geom is NOT NULL and upper(a_sinacentos(nom_via)) like '%" + buscar + "%' order by clave"+limit;
	}
	break;
case 10:   //bd_loc
    consulta="select id||' - '||cgo1||' - '||entidad as clave,nom_loc,box2d(ST_Transform(the_geom,3857))::text FROM a_bd_loc where entidad='"+buscar+"'";
      break;
case 11:   //manzanas
    consulta="select * from ( SELECT cve_ent||' '||cve_mun||' '||cve_loc||' '||cve_ageb as cvegeo,cve_mza,box2d(ST_Transform(st_union(the_geom),3857))::text as salida,tipo as ambito from cat_cd where "+where1+"  cve_ent||cve_mun||cve_loc||replace(cve_ageb,'-','')||cve_mza like '" + buscar + "%' group by cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,tipo union  SELECT cve_ent||' '||cve_mun||' '||cve_loc||' '||cve_ageb as cvegeo,cve_mza,case when the_geom is not null THEN box2d(ST_Transform(the_geom,3857))::text else 'x' end as salida,ambito from cat_manz where ban!='X' and "+where1+"  cve_ent||cve_mun||cve_loc||replace(cve_ageb,'-','')||cve_mza like '" + buscar + "%' ) tt   order by cvegeo,cve_mza "+limit;
  break;
  }
//out.println( consulta );

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
      rs = str.executeQuery( consulta );
      out.println( "<form action=\"buscar.jsp\" method=\"post\" name=\"enviar\"><center class='t'>RESULTADOS<br><br>");
     if (capa!=1 && capa!=10){
                select="<select name=filent class='boton' onChange='envia();''>";
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
                out.println ("&nbsp;&nbsp;&nbsp;&nbsp;<font class=n>Filtrar por estado:</font>&nbsp;"+select+"<br><br>");
                out.println ("<input type='hidden' name='buscar' value='"+buscar+"'><input type='hidden' name='capa' value='"+capa+"'><input type='hidden' name='tipo' value='"+tipo+"'>");
        }

if (capa==11){
out.println( "<table border=1><tr class=n bgcolor=#BBBBBB><th>&nbsp;&nbsp;Clave&nbsp;&nbsp;<th>&nbsp;&nbsp;Mz&nbsp;&nbsp;");
}else{
	out.println( "<table border=1><tr class=n bgcolor=#BBBBBB><th>&nbsp;&nbsp;Clave&nbsp;&nbsp;<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Nombre&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
}
  if (capa==7){
    out.println( "<th>&nbsp;&nbsp;Ambito&nbsp;&nbsp;<th>&nbsp;&nbsp;Ageb&nbsp;&nbsp;<th>&nbsp;&nbsp;Status&nbsp;&nbsp;");
  }
  if (capa==4 || capa==11){
    out.println( "<th>&nbsp;&nbsp;Ambito&nbsp;&nbsp;");
  }
	out.println( "<th>&nbsp;Referencia&nbsp;");
	while(rs.next()){
            String s1=rs.getObject(1).toString();
            String s2=rs.getObject(2).toString();
            String s3=rs.getObject(3).toString();
            if (s3.equals("x")){
                ban=1;
            }else{
              salida = s3.replace("BOX(","");
              salida = salida.replace(" ",",");
              salida = salida.replace(")","");
            }
            String[] salvec = salida.split(",");
            double[] salsal = {0,0,0,0};
            out.println( "<tr class=c><td align=center>&nbsp;&nbsp;"+s1+"&nbsp;&nbsp;<td>&nbsp;&nbsp;"+s2+"&nbsp;&nbsp;");
            String s6="";
            if (capa==7){
                st="ALTA";
                String s4=rs.getObject(4).toString();
		            String s5=rs.getObject(5).toString();
                s6=rs.getObject(6).toString();
                if (Integer.parseInt(s4)==0)st="BAJA";
                out.println( "<td align=center>&nbsp;&nbsp;"+s5+"&nbsp;&nbsp;<td align=center rowspan>"+s6+"<td align=center>&nbsp;&nbsp;"+st+"&nbsp;&nbsp;");
                if (s5.equals("U")){
                        capa=5;
                }
            }
            if (capa==4 || capa==11){
                String s4=rs.getObject(4).toString();
                out.println( "<td align=center>&nbsp;&nbsp;"+s4+"&nbsp;&nbsp;");
				        if (s4.equals("U") && capa==4){
                        capa=41;
                }
            }
            if (ban!=1){
              salsal[0]=Float.parseFloat(salvec[0]);
              salsal[1]=Float.parseFloat(salvec[1]);
              salsal[2]=Float.parseFloat(salvec[2]);
              salsal[3]=Float.parseFloat(salvec[3]);
            }
            if (salsal[0]==salsal[2]){
                salsal[0]=salsal[0]-2000;   //CCL , mercator
				salsal[1]=salsal[1]-2000;
				salsal[2]=salsal[2]+2000;
				salsal[3]=salsal[3]+2000;
                //salsal[0]=salsal[0]-.02000;
				//salsal[1]=salsal[1]-.02000;
				//salsal[2]=salsal[2]+.02000;
				//salsal[3]=salsal[3]+.02000;
            }else{
                if (capa==9){
                    salsal[0]=salsal[0]-100;   //CCL , mercator
                    salsal[1]=salsal[1]-100;
                    salsal[2]=salsal[2]+100;
                    salsal[3]=salsal[3]+100;
                }
            }
            if (ban!=1){
               if (capa==7 || capa==5){
                out.println("<td align=center><input type=button onclick='buscazoomlocal(\""+st+"\","+capa+","+salsal[0]+","+salsal[1]+","+salsal[2]+","+salsal[3]+",\""+s1+"\",\""+s6+"\");' value=' Ver ' class='boton'>");
               }else if (capa==4 || capa==41){
                out.println("<td align=center><input type=button onclick='buscazoomlocal(\""+st+"\","+capa+","+salsal[0]+","+salsal[1]+","+salsal[2]+","+salsal[3]+",\""+s1+"\",\"0\");' value=' Ver ' class='boton'>");
               }else{
                out.println("<td align=center><input type=button onclick='window.opener.buscazoom(\""+st+"\","+capa+","+salsal[0]+","+salsal[1]+","+salsal[2]+","+salsal[3]+");' value=' Ver ' class='boton'>");
               }
            }else{
              out.println("<td align=center title='Sin coordenadas'>S/C");
            }
            n++;
            ban=0;
            capa = Integer.parseInt(request.getParameter("capa"));
        }
        rs.close();
        str.close();
        conexion.close();
	      out.println( "</table><br><font class=n>Total de Registros: " + n +"</font>");
        if (n>=100 && capa!=10){
        out.println( "<br><font class=r>* La consulta tiene un limite de 100 registros. </font>");
      }
        out.println( "<br><br>");
    }

    catch (SQLException ex){
      out.println("<script>");
      out.println("  alert(\'Se genero la expresion de SQL: "+ex.getMessage()+" !\');");
      out.println("</script>");
    }

    catch(Exception ex){
      out.println("<script>");
      out.println("  alert(\'Se genero la expresion: "+ex.getMessage()+" !\');");
      out.println("</script>");
    }
}  //try

    }else{
          out.println("<script>opener.cerrarSesion();window.close();</script>");
    }

%>
</form>
</body>
<script language="javascript" type="text/javascript">
function buscazoomlocal(st,capa,sal1,sal2,sal3,sal4,clave,ageb){
  if (capa==5 || capa==7){
    window.opener.cve_ent=clave.substring(0,2);
    window.opener.cve_mun=clave.substring(2,5);
    window.opener.cve_loc=clave.substring(5,9);
    window.opener.cve_ageb=ageb
  }else if (capa==4){
    window.opener.cve_ent=clave.substring(0,2);
    window.opener.cve_mun=clave.substring(2,5);
    window.opener.cve_loc='0000';
    window.opener.cve_ageb=clave.substring(5,10);
  }else if (capa==41){
    window.opener.cve_ent=clave.substring(0,2);
    window.opener.cve_mun=clave.substring(2,5);
    window.opener.cve_loc=clave.substring(5,9);
    window.opener.cve_ageb=clave.substring(9,14);
  }
  //alert (window.opener.cve_ent+":"+window.opener.cve_mun+":"+window.opener.cve_loc+":"+window.opener.cve_ageb);
  window.opener.buscazoom(st,capa,sal1,sal2,sal3,sal4);

}

function buscazoomosm(lon,lat){
  var ban=0;
if (opener.busqueda.latitud.value==''){
  ban=1;
}
opener.busqueda.latitud.value=lat;
opener.busqueda.longitud.value=lon;
opener.enviar(500);
if (ban==1){
opener.busqueda.latitud.value='';
opener.busqueda.longitud.value='';
}


}
</script>
</html>