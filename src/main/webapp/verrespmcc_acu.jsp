<%@ page import="java.util.*" session="true" %>
<%@ page import="java.sql.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>
SIGMA
</title>
      <script language="javascrpt" type="text/javascript">
window.resizeTo(600,300);
</script>
<style type="text/css">
table {
  border-collapse: collapse;
}
.t{font-size: 12pt; font-family: Arial; font-weight: bold; color: #000000;} 
.c{font-family: Arial; font-size: 8pt; line-height: 1.3; font-weight: normal;}
.n{font-family: Arial; font-size: 8pt; line-height: 1.3; font-weight: bold;}
.boton{font-family: Arial; font-size: 10px; line-height: 1; font-weight: normal;}

</style>
 </head>
<body>
<%
String  gid = request.getParameter("gid");
String  clave = request.getParameter("clave");
String  cgo = request.getParameter("ban");
String  figura = request.getParameter("figura");
String consulta="";
String fig="";
HttpSession sesion = request.getSession(false);
String remotehost  = session.getAttribute("remotehost").toString();
try {
//if (cgo.equals("3")){
//    consulta= "select cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,cve_temp,ban,proy,tipomza from cat_manz where ban='3' and vienede='M"+gid+"' ";
//    consulta+= " and (cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza in (select clave1 from v_te_mza) ";
//    consulta+= " or cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza in (select clave2 from v_te_mza)) ";
//}else{
fig="T";
if (figura.equals("CENSOR")){
  fig="C";
}
    consulta= "select cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,cve_temp,ban,proy,tipomza from cat_manz where vienede='"+gid+"' ";
    //consulta+= " and (cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza in (select clave1 from v_te_mza) ";
    //consulta+= " or cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza in (select clave2 from v_te_mza)) ";
    consulta+= "union select cve_ent,cve_mun,cve_loc,cve_ageb,cve_mza,cve_temp,ban,proy,'9' as tipomza from cat_cd where vienede='"+gid+"' ";
    //consulta+= " and (cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza in (select clave1 from v_te_mza) ";
    //consulta+= " or cve_ent||cve_mun||cve_loc||cve_ageb||cve_mza in (select clave2 from v_te_mza)) ";

//}
//out.println(consulta);

      Statement str = null;
      ResultSet rs = null;
      Connection conexion = null;
      Class.forName("org.postgresql.Driver");
      String hostbd  = session.getAttribute("hostbd").toString();
      String remotehostbd  = session.getAttribute("remotehostbd").toString();
      conexion = DriverManager.getConnection("jdbc:postgresql://"+remotehostbd+":5434/"+hostbd,"actcar","actcar");
      str = conexion.createStatement(rs.TYPE_SCROLL_SENSITIVE, rs.CONCUR_UPDATABLE);
      rs = str.executeQuery( consulta );
      String cve_ent="";
      String cve_mun="";
      String cve_loc="";
      String cve_ageb="";
      String cve_mza="";
      String cve_temp="";
      String ban="";
      String proy="";
      String tipomza="";
      String cgotxt="";
      String tipotxt="";
      String tipoproy="";
      Integer bans=0;
      while(rs.next()){
        if (bans==0){
        bans=1;
        cve_ent=rs.getObject(1).toString();
        cve_mun=rs.getObject(2).toString();
        cve_loc=rs.getObject(3).toString();
        cve_ageb=rs.getObject(4).toString();
        cve_mza=rs.getObject(5).toString();
        if (rs.getObject(6) != null){
          cve_temp=rs.getObject(6).toString();
          cve_temp=cve_temp.substring(0,2)+" "+cve_temp.substring(2,5)+" "+cve_temp.substring(5,9)+" "+cve_temp.substring(9,14)+" "+cve_temp.substring(14,17);
        }else{
          cve_temp="";
        }
        ban=rs.getObject(7).toString();
        if (rs.getObject(8) != null){
                proy=rs.getObject(8).toString();
        }else{
                proy="";
         }
        tipomza=rs.getObject(9).toString();

      switch(ban){
             case "1":cgotxt="Fusion de mza";break;
             case "2":cgotxt="Subdivision de mza";break;
             case "3":cgotxt="Baja de mza";break;
             case "4":cgotxt="Creacion de mza";break;
             case "5":cgotxt="Cambio mza de ageb";break;
             case "6":cgotxt="Cambio mza de loc";break;
             //case "5":cgotxt="Cambio de forma de mza";break;
             //case "6":cgotxt="Cambio de forma de mza";break;
             case "E":cgotxt="Conurba loc";break;
             case "D":cgotxt="Fusiona loc";break;
             case "N":cgotxt="Desconurba loc";break;
             case "O":cgotxt="Desfusiona loc";break;
             case "H":cgotxt="Cambio de mun";break;
             case "G":cgotxt="Cambio de ageb";break;
             case "I":cgotxt="Cambio de ent";break;
             case "M":cgotxt="Creacion de mun";break;
             case "Y":cgotxt="Consolidacion de ageb";break;

      }
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
      switch(proy){
            case "0": tipoproy="Sin Proyecto";break;
            case "1": tipoproy="Censos Economicos 2014";break;
            case "2": tipoproy="Recorrido de Act del MGN 2014";break;
            case "3": tipoproy="Encuesta Intercensal 2015";break;
            case "4": tipoproy="Cartografia Participativa";break;
            case "5": tipoproy="Carta Topografica";break;
            case "6": tipoproy="Censos de Escuelas Maestros y Alumnos de Educacion Basica y Especial";break;
            case "7": tipoproy="Actualizacion Permanente del MG 2016";break;
            case "8": tipoproy="Registro Unico de Viviendas 2016";break;
            case "9": tipoproy="Registro Unico de Viviendas 2014";break;
            case "10": tipoproy="Actualizacion Permanente del MG 2015";break;
            case "11": tipoproy="Registro Unico de Viviendas 2015";break;
            case "12": tipoproy="Instituto Nacional Electoral 2016";break;
            case "13": tipoproy="Marco Nacional de Viviendas";break;
            case "14": tipoproy="Actualizacion Permanente del MG 2017";break;
    }

      out.println("<br><center>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font class='n'>Registro de respuesta para: "+clave+"</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</center><br><table border=1 align=center><tr>");
      out.println("<tr><th class='n'>&nbsp;&nbsp;Clave Definitiva&nbsp;&nbsp;<th class='n'>Codigo<br>&nbsp;&nbsp;Definitivo&nbsp;&nbsp;<th class='n'>&nbsp;&nbsp;Clave Original&nbsp;&nbsp;<th class='n'>Tipo<br>&nbsp;&nbsp;Manzana&nbsp;&nbsp;<th class='n'>&nbsp;&nbsp;Proyecto&nbsp;&nbsp;");
      out.println("<tr><td class='c' align='center'>&nbsp;&nbsp;"+cve_ent+"&nbsp;"+cve_mun+"&nbsp;"+cve_loc+"&nbsp;"+cve_ageb+"&nbsp;"+cve_mza+"&nbsp;&nbsp;");
      out.println("<td class='c' align='center' title='"+cgotxt+"'>&nbsp;&nbsp;"+ban+"&nbsp;&nbsp;");
      out.println("<td class='c' align='center'>&nbsp;&nbsp;"+cve_temp+"&nbsp;&nbsp;");
      out.println("<td class='c' align='center' title='"+tipotxt+"'>&nbsp;&nbsp;"+tipomza+"&nbsp;&nbsp;");
      out.println("<td class='c' align='center' title='"+tipoproy+"'>&nbsp;&nbsp;"+proy+"&nbsp;&nbsp;");
    }}
    out.println("</table><center><br><br><input type=button class=boton value=' Cerrar ' onclick='window.close();'></center>");


      str.close();
      conexion.close();
    }
   catch (SQLException ex){
     out.println(ex);
    }

    catch(Exception ex){
     out.println(ex);
    }

%>
</body>
</html>