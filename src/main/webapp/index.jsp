<%@ page import="java.util.*" session="true" %>
<%@ page import="java.sql.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<title>
SIGMA
</title>

<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta http-equiv="X-UA-Compatible" content="IE=9">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE9">

  <meta http-equiv="Expires" content="0">
  <meta http-equiv="Last-Modified" content="0">
  <meta http-equiv="Cache-Control" content="no-cache, mustrevalidate">
  <meta http-equiv="Pragma" content="no-cache">

<style type="text/css">
.titulomgnew { font-family: Arial; font-size: 50px; font-style: normal; font-weight: bold; color: #333333; }
</style>
<script src="MD5.js"></script>
<script type="text/javascript">
  <%


/// si no contiene inegi.gob.. lo redirige
//
//if (!(request.getRequestURL().toString().contains("inegi.gob.mx"))){
//   out.println ("window.location='"+(request.getRequestURL()+"?"+request.getQueryString()).replace("dc046068asdggma:8070","dc046068asdggma.inegi.gob.mx:8070")+"';");
               // para que siempre entre con inegi.gob.mx
               
               	//para probar en eclipse
				//out.println ("window.location='"+(request.getRequestURL()+"?"+request.getQueryString())+"';");
    
               
               
               
//}
/// si no contiene 10.106.12.. no lo deja entrar al 2
//


//if ((!(request.getRemoteAddr().contains("10.106.12")) && request.getRequestURL().toString().contains("openlayers2"))){   /// si no es de la office lo saca a la productiva
//  String salta=(request.getRequestURL()+"?"+request.getQueryString()).replace("dc046068asdggma:8070","dc046068asdggma.inegi.gob.mx:8070");
//      salta=salta.replace("openlayers2","openlayers");
//      out.println ("window.location='"+salta+"';");

//}


%>


// Comentario nuevo para probar el push
// Segundo push
// tercer push






function enviarkey(e){
  /*key = (document.all) ? e.keyCode : e.which;
  if (key==13){
    //enviarpass();
    return false;
  }
*/
  if (e.keyCode === 13) {
    enviarpass();
    //return null;
  }



}

function enviarpass(){
 document.inicia.password.value=MD5(document.inicia.password.value.toUpperCase());
 document.inicia.submit()
}

</script>
<head>
  <!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-Q856GDCQ02"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'G-Q856GDCQ02');
</script>


<%


int verjs=(int) (Math.random() * 10000);


out.println ("<link rel='stylesheet' href='OpenLayers/theme/default/style.css?v="+verjs+"' type='text/css' />");
out.println ("<link rel='stylesheet' href='style.css?v="+verjs+"' type='text/css' />");




 try {
      //mantenimiento

      if (1==0){

      out.println ("</head><body style=\"background:url('images/fondo1.jpg'); background-repeat: no-repeat; background-size: cover;\"><br><center><font class='titulomgnew'>SIGMA 2026&nbsp;</font><br><img src='images/sigma_v2ei.png' height='350'></img><br><br><font class='titulo'>Sistema de Informaci&oacute;n Geogr&aacute;fica del Marco Geoestad&iacute;stico</font><br><br><br><img src='images/falla.jpg' height='250' width='250'></img><br><font class='titulomg'>SISTEMA EN MANTENIMIENTO</font>");


}else{


int n=0;
String ban="",cat="",c1="",c2="",c3="",c4="",st="",capa="",clave="",mandaageb="",cons="",anuncio="",
        id="",regid="",
        nivel="",
        nombre="",pass="",regionalid="",
        txt1="",txt2="",edicion="",edicionmz="",edicionpre="",edicionagpr="",restric="",userdg="",encdg="",passdg="",correodg="";
        String host="";
        String hostnew="";
    String hostbd="";
    String remotehostbd="";
    String localhost="";

         String vpn="";
     String idreggeo="";
        String servimg="";
        int permisoimgex1=0;
        int capasextra=0;
        int capasalto=730;
ban = request.getParameter("ban");
cat = request.getParameter("cat");
HttpSession sesion = request.getSession(true);






if (ban==null){
        out.println ("</head><body style=\"background:url('images/fondo1.jpg'); background-repeat: no-repeat; background-size: cover;\"><br><center><font class='titulomgnew'>SIGMA 2026&nbsp;</font><br><img src='images/sigma_v2ei.png' height='350'></img><br><br><font class='titulo'>Sistema de Informaci&oacute;n Geogr&aacute;fica del Marco Geoestad&iacute;stico</font><br><br>"
      + "<Form method=\"post\" name=\"inicia\">"
            + "<center class='t'>Usuario:<br>"
            + "<input type=\"password\" class=\"input\" name=\"password\" size=20 maxlength=20 value=\"\"  onkeypress=\"return enviarkey(event)\">"
            + "<br><br>Para usuario nacional:<br>"
            + "<select name=regionalid class=boton><option value='01'>Regional 01 - NOROESTE</option><option value='02'>Regional 02 - NORTE</option><option value='03'>Regional 03 - NORESTE</option><option value='04'>Regional 04 - OCCIDENTE</option><option value='05'>Regional 05 - CENTRO NORTE</option><option value='06'>Regional 06 - CENTRO SUR</option><option value='07'>Regional 07 - ORIENTE</option><option value='08'>Regional 08 - SUR</option><option value='09'>Regional 09 - SURESTE</option><option value='10'>Regional 10 - CENTRO</option></select><br><br><input type=\"button\"  onClick=\"enviarpass()\" class=\"boton\" name=\"boton\" value=\"             Ingresar             \" size=18 >");

      out.println("<input type=hidden name=ban value=1></form>");
      out.println("<br><br><br><center>");
    //out.println("<font class=search>Analisis, dise&ntilde;o y desarrollo:</font><br>");
      //out.println("<a class=liga1 href=\"mailto:neatil.ceballos@inegi.org.mx?subject=MAPA\" title=\"Analisis, dise&ntilde;o y desarrollo\">Neatil Ceballos</a>");
      out.println("</center>");
} else {

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
          String consulta="";
          pass = request.getParameter("password");
          regionalid = request.getParameter("regionalid");
          //672,673 son usuarios de capacitacion
          consulta = "select id,regid,nivel,nombre,edicion,cons,edicionmz,edicionpre,edicionagpr,restric,userdg,passdg,correo as correodg, encdg,anuncio from usuarios where cons not in (672,673) and md5(password) = '"+pass+"'";
          rs = str.executeQuery( consulta );
            while(rs.next()){
                n=1;
                id=rs.getObject(1).toString();
                regid=rs.getObject(2).toString();
                nivel=rs.getObject(3).toString();
                nombre=rs.getObject(4).toString();
                edicion=rs.getObject(5).toString();
                cons=rs.getObject(6).toString();
                edicionmz=rs.getObject(7).toString();
                edicionpre=rs.getObject(8).toString();
                edicionagpr=rs.getObject(9).toString();
                if (rs.getObject(10)==null){
                  //nacional
                  restric="-13459673.0276619,1232095.46159631,-9281930.46183394,4109451.87806631";
                }else{
                  restric=rs.getObject(10).toString();
                }
                if (rs.getObject(11)==null){
                  userdg="0";
                }else{
                  userdg=rs.getObject(11).toString();
                  passdg=rs.getObject(12).toString();
              }
                if (rs.getObject(13)==null){
                  correodg="0.0";
                }else{
                  correodg=rs.getObject(13).toString();
                 }
                 if (rs.getObject(14)==null){
                  encdg="0";
                }else{
                  encdg=rs.getObject(14).toString();
              }
                  anuncio=rs.getObject(15).toString();

                  //restricts por regional
                  /*
                  1 -13178648.822851261, 2565517.853772179, -11730030.321780054, 3860382.68086215
                  2 -12144429.442049993, 2394707.6503686095, -11212376.683252111, 3737404.4422955797
                  3 -11575039.742099693, 2534217.702652189, -10811823.605249867, 3490451.682992249
                  4 -12777072.120149486, 2025296.411782332, -11136834.080848195, 2644432.511011887
                  5 -11454057.394830033, 2260551.5277337027, -10943425.594943449, 2815636.152509703
                  6 -11377211.392503383, 1839256.3925362972, -10908037.42793386, 2309074.0218247976
                  7 -11118444.023088947, 1934674.505055045, -10418297.438110441, 2570444.0331525356
                  8 -10972915.33361405, 1633270.549955078, -10057890.82073665, 2118208.569328288
                  9 -10295691.50640591, 2013543.7834863127, -9650414.08600182, 2584204.2558371923
                  10  -11063374.046619846, 2158489.7686889353, -11011868.491067229, 2226990.9459850527
                  */
                  
                String cad=regid+"-"+id+"-"+nombre+ " ("+request.getRemoteAddr()+")";
                //request.getSession().setAttribute("userName", regid+"-"+id+"-"+nombre);
                sesion.setAttribute("userName", cad);
                sesion.setAttribute("script", "index");
                // control de usuarios
                if (nivel.equals("1")){regionalid=regid;}
                if (nivel.equals("2")){regionalid=id;}
                if (nivel.equals("3") && regionalid==null){regionalid="01";}
                if (nivel.equals("5") && regionalid==null){regionalid="01";}
                if (nivel.equals("5")){capasalto=capasalto-120;}
                if ((nivel.equals("1") && (id.equals("08") || id.equals("10") || id.equals("32"))) || ((nivel.equals("3") || nivel.equals("5")) && (regionalid.equals("02"))) || (nivel.equals("2") && (id.equals("02")))){   //regional norte 2,
                    host="geogat046166d"; //ANTES ="geoigb042489d"
                    servimg="ISRAEL.NAVARRO";
                    hostbd="actcargeo2";idreggeo="02";
                }else if ((nivel.equals("1") && (id.equals("02") || id.equals("03") || id.equals("25") || id.equals("26"))) || ((nivel.equals("3") || nivel.equals("5")) && (regionalid.equals("01"))) || (nivel.equals("2") && (id.equals("01")))){   //regional noroeste 1
                    host="geogat045732d"; //antes= geoigb042180d
                    servimg="MARIA.LOZANO";
                    hostbd="actcargeo1";idreggeo="01";
                }else if ((nivel.equals("1") && (id.equals("06") || id.equals("14") || id.equals("16") || id.equals("18"))) || ((nivel.equals("3") || nivel.equals("5")) && (regionalid.equals("04"))) || (nivel.equals("2") && (id.equals("04")))){       // regional occidente 4
                    host="geogat046050d";
                    servimg="JOSE.CALZADA";
                    hostbd="actcargeo4";idreggeo="04";
                }else if ((nivel.equals("1") && (id.equals("05") || id.equals("19") || id.equals("28"))) || ((nivel.equals("3") || nivel.equals("5")) && (regionalid.equals("03"))) || (nivel.equals("2") && (id.equals("03")))){       // regional noreste 3
                    host="geogat046025d";   //anteior geoigb042167d
                     servimg="LILIANA.RAMOS";
                    hostbd="actcargeo3";idreggeo="03";
                }else if ((nivel.equals("1") && (id.equals("01") || id.equals("11") || id.equals("22") || id.equals("24"))) || ((nivel.equals("3") || nivel.equals("5")) && (regionalid.equals("05"))) || (nivel.equals("2") && (id.equals("05")))){      //regional centro norte 5
                    host="geogat045957d";  //ANTERIOR geogat045736d    //nueva 
                    servimg="ROBERTO.MARIN";
                     hostbd="actcargeo5";idreggeo="05";
                }else if ((nivel.equals("1") && (id.equals("12") || id.equals("17") || id.equals("15"))) || ((nivel.equals("3") || nivel.equals("5")) && (regionalid.equals("06"))) || (nivel.equals("2") && (id.equals("06")))){      //regional centro sur 6
                    host="geogat045677d";
                    servimg="LUDIM.CASTILLO";
                     hostbd="actcargeo6";idreggeo="06";
                }else if ((nivel.equals("1") && (id.equals("13") || id.equals("21") || id.equals("29") || id.equals("30") || id.equals("09"))) || ((nivel.equals("3") || nivel.equals("5")) && (regionalid.equals("07") || regionalid.equals("10"))) || (nivel.equals("2") && (id.equals("07") || id.equals("10")))){      //regional oriente 7, centro 10
                        host="geogat045713d";
                    servimg="SEBASTIAN.CASTRO";
                    hostbd="actcargeo7";idreggeo="07";
                }else if ((nivel.equals("1") && (id.equals("07") || id.equals("20") || id.equals("27"))) || ((nivel.equals("3") || nivel.equals("5")) && (regionalid.equals("08"))) || (nivel.equals("2") && (id.equals("08")))){      //regional sur 8
                    host="geogat046028d";    //geoigb042483d
                    servimg="ARACELI.NIEVES";
                   hostbd="actcargeo8";idreggeo="08";
                }else if ((nivel.equals("1") && (id.equals("04") || id.equals("23") || id.equals("31"))) || ((nivel.equals("3") || nivel.equals("5")) && (regionalid.equals("09"))) || (nivel.equals("2") && (id.equals("09")))){      //regional  sureste 9
                    host="geogat045744d";  //ANTES=geoigb042526d
                    servimg="MARTHA.ROJAS";
                   hostbd="actcargeo9";idreggeo="09";
        }
        //host="geoigb042501d";
        //hostbd="actcargeo1"; //<--------------------
                //control para permiso de la capa del estado de mexico solo para mexico y para la regional
                if ((nivel.equals("1") && id.equals("15")) || (nivel.equals("2") && id.equals("06"))){
                  //permisoimgex1=1;capasextra++;
                }
                //if (nivel.equals("3")){
                //  capasextra++;
                //}

                localhost=request.getServerName();   //nombre del server con o sin .inegi
                remotehostbd="l-appwebmd1";

                //hostnew="w-webintratslic.inegi.gob.mx:8080";  //este es el server w-
                //hostnew=host+":8070";      //este es el local

                 if (idreggeo.equals("01") || idreggeo.equals("02") || idreggeo.equals("04") || idreggeo.equals("05")){
                    hostnew="w-webintratslic.inegi.gob.mx:8082";
                  }else{
                    hostnew="w-webintratslic.inegi.gob.mx:8080";
                  }

                //}else{
                  //hostnew=host+":8070";
                //}

                sesion.setAttribute("remotehost", hostnew);
                sesion.setAttribute("remotehostbd", remotehostbd);
                sesion.setAttribute("hostbd", hostbd);
                sesion.setAttribute("regionalid", regionalid);

            }
    /*    }
    catch (SQLException ex){
      out.println("<script>");
      out.println("  alert(\"Se genero la expresion de SQL: "+ex.getMessage().substring(0, ex.getMessage().length()-1)+" !\");");
      out.println("</script>");
    }
    catch(Exception ex){
      out.println("<script>");
      out.println("  alert(\"Se genero la expresion: "+ex.getMessage().substring(0, ex.getMessage().length()-1)+" !\");");
      out.println("</script>");
    }*/
    if (n==0){  //SI ESTA MAL EL PASSWORD

           //registro el cheeck correcto
              str.executeUpdate( "insert into usuarios_registro (usuario,ip,host,fecha,correcto,regional) values(0,'"+request.getRemoteAddr()+"','"+request.getRequestURL().toString() +"',CURRENT_TIMESTAMP(0),FALSE,'"+regionalid+"')");


    out.println ("</head><body style=\"background:url('images/fondo1.jpg'); background-repeat: no-repeat; background-size: cover;\"><br><center><font class='titulomgnew'>SIGMA 2026&nbsp;</font><br><img src='images/sigma_v2ei.png' height='350'></img><br><br><font class='titulo'>Sistema de Informaci&oacute;n Geogr&aacute;fica del Marco Geoestad&iacute;stico</font><br><br>"
      + "<Form  method=\"post\" name=\"inicia\">"
            + "<center class='t'>Usuario:<br>"
            + "<input type=\"password\" class=\"input\" name=\"password\" size=20 maxlength=20 value=\"\"  onkeypress=\"return enviarkey(event)\">"
            + "<br><br>Para usuario nacional:<br>"
            + "<select name=regionalid class=boton><option value='01'>Regional 01 - NOROESTE</option><option value='02'>Regional 02 - NORTE</option><option value='03'>Regional 03 - NORESTE</option><option value='04'>Regional 04 - OCCIDENTE</option><option value='05'>Regional 05 - CENTRO NORTE</option><option value='06'>Regional 06 - CENTRO SUR</option><option value='07'>Regional 07 - ORIENTE</option><option value='08'>Regional 08 - SUR</option><option value='09'>Regional 09 - SURESTE</option><option value='10'>Regional 10 - CENTRO</option></select><br><br><input type=\"button\"  onClick=\"enviarpass()\" class=\"boton\" name=\"boton\" value=\"             Ingresar             \" size=18 >");



          out.println("<input type=hidden name=ban value=1></form><br><br><br><font class='error'>-- USUARIO INCORRECTO --</font>");
    }else{  //ENTRA AL MAPA
           //registro el cheeck correcto
                  str.executeUpdate( "insert into usuarios_registro (usuario,ip,host,fecha,correcto,regional) values("+cons+",'"+request.getRemoteAddr()+"','"+request.getRequestURL().toString()+"',CURRENT_TIMESTAMP(0),TRUE,'"+regionalid+"')");

          if (nivel.equals("1")){
              txt1+=" (EDICION DE LA ENTIDAD "+id+") ";
              //txt1=" (ENTIDAD "+id+") ";
          }else if (nivel.equals("2")){
              txt1+=" (CONSULTA REGIONAL "+id+") ";
              //txt1=" (ENTIDAD "+id+") ";
          }else if (nivel.equals("3") || nivel.equals("5")  ){
              txt1+=" - ADMIN - REG ";
txt1+="<select name=regionalid class=boton onChange='regchange();'>";
txt1+="<option value='01' title='NOROESTE'";     if (regionalid.equals("01")){txt1+=" selected ";}txt1+=">01</option>";
txt1+="<option value='02' title='NORTE'";        if (regionalid.equals("02")){txt1+=" selected ";}txt1+=">02</option>";
txt1+="<option value='03' title='NORESTE'";      if (regionalid.equals("03")){txt1+=" selected ";}txt1+=">03</option>";
txt1+="<option value='04' title='OCCIDENTE'";    if (regionalid.equals("04")){txt1+=" selected ";}txt1+=">04</option>";
txt1+="<option value='05' title='CENTRO NORTE'"; if (regionalid.equals("05")){txt1+=" selected ";}txt1+=">05</option>";
txt1+="<option value='06' title='CENTRO SUR'";   if (regionalid.equals("06")){txt1+=" selected ";}txt1+=">06</option>";
txt1+="<option value='07' title='ORIENTE'";      if (regionalid.equals("07")){txt1+=" selected ";}txt1+=">07</option>";
txt1+="<option value='08' title='SUR'";          if (regionalid.equals("08")){txt1+=" selected ";}txt1+=">08</option>";
txt1+="<option value='09' title='SURESTE'";      if (regionalid.equals("09")){txt1+=" selected ";}txt1+=">09</option>";
txt1+="<option value='10' title='CENTRO'";       if (regionalid.equals("10")){txt1+=" selected ";}txt1+=">10</option></select>";

          }else{
          txt1=" (CONSULTA)";
          }
          txt1+="<input type='hidden' name='password' value='"+pass+"'><input type=hidden name=ban value=1><input type=hidden name=c1 value=''><input type=hidden name=c2 value=''><input type=hidden name=c3 value=''><input type=hidden name=c4 value=''><input type=hidden name=cat value='Y'><input type=hidden name=selcapa value=''><input type=hidden name=selpuntos_ce value=''><input type=hidden name=seltext value=''><input type=hidden name=pass value='"+pass+"'>";

          if ((cat!=null)){
               out.println ("<script>"
                    + "var cat='"+cat+"';"
                    + "var verjs="+verjs+";"
                    + "var st1='"+request.getParameter("st")+"';"
                    + "var capa1='"+request.getParameter("capa")+"';"
                    + "var bc1='"+request.getParameter("c1")+"';"
                    + "var bc2='"+request.getParameter("c2")+"';"
                    + "var bc3='"+request.getParameter("c3")+"';"
                    + "var bc4='"+request.getParameter("c4")+"';"
                    + "var clave='"+request.getParameter("clave")+"';"
                    + "var mandaageb='"+request.getParameter("ageb")+"';"
                    + "var selcapa='"+request.getParameter("selcapa")+"';"
                    + "var selpuntos_ce='"+request.getParameter("selpuntos_ce")+"';"
                    + "var seltext='"+request.getParameter("seltext")+"';"
                    + "</script>");
          }else{
                  out.println ("<script>var cat='';</script>");
          }
          capasextra=capasextra*20;
          out.println ("<script>var pass='"+pass+"'</script>");
          out.println ("<script>var localhost='"+localhost+"'</script>");
          out.println ("<script>var vpn='"+vpn+"'</script>");
          out.println ("<script>var host='"+host+"'</script>");
          out.println ("<script>var hostnew='"+hostnew+"'</script>");
          out.println ("<script>var servimg='"+servimg+"'</script>");
          out.println ("<script>var regid='"+regid+"'</script>");
          out.println ("<script>var iduser='"+cons+"'</script>");
          out.println ("<script>var nomuser='"+nombre+"'</script>");
          out.println ("<script>var capasextra="+capasextra+";var capasalto="+capasalto+";</script>");
          out.println ("<script>var permisoimgex1="+permisoimgex1+"</script>");
          out.println ("<script>var userdg='"+userdg+"'</script>");
          out.println ("<script>var encdg='"+encdg+"'</script>");
          out.println ("<script>var passdg='"+passdg+"'</script>");
          out.println ("<script>var correodg='"+correodg+"'</script>");
          out.println ("<script>var idreggeo='"+idreggeo+"'</script>");

          out.println ("<script>var restric='"+restric+"'</script>");
            if (nivel.equals("1") || nivel.equals("2") || nivel.equals("3")){
                if (anuncio.equals("0") || 1==0){
                  out.println ("<script>ventana = window.open('veranuncio.jsp','Anuncio','toolbar=0,Resizable=0,scrollbars=0');ventana.focus();</script>");
                }
           }
           /*   Process p = Runtime.getRuntime().exec("ping -n 1 googleapis.com");
              int status = p.waitFor();
               if (status==0){
              //if (status==10){
                  //out.println ("<script src=\"http://maps.google.com/maps/api/js?sensor=false\"></script>");
                  //out.println ("<script src=\"http://maps.googleapis.com/maps/api/js?v=3.12&key=AIzaSyAToi_hL19uDD_b_TnirgR0-J56RplDIJs&sensor=false\"></script>"); // mapa digital
                  out.println ("<script src=\"http://maps.googleapis.com/maps/api/js?v=3.12&key=AIzaSyAL8-CvaNgh7c1C7Zh7X4AFxrLxsXZNDO4&sensor=false\"></script>"); // mi cuenta
                  out.println ("<script>nored=0;</script>");
              }else{
                  out.println ("<script>nored=1;</script>");
                  out.println ("<script>alert ('No hay conexion con google mapas!!');</script>");
              }*/

          //bing
          //out.println ("<script>var apiKey='AmX1FVgGILJ-v3nO2tttFP5-CrYrAIip7w0Uzd9T_UfQqZz6ZoDrmgyv2rnhxO9z'");
          //out.println ("<script>var apiKey='AqMZwvNLl6dH-EX5DSt28PNzN3JSjgCJc1IPg-YdfevzTFFI8B1GMWzbcy3XDgeX'");
          //out.println ("</script>");

          out.println ("<script type='text/javascript'>");
          out.println ("      var scriptLoaded = false;");
          out.println ("      function checkScriptLoaded() {");
          //out.println ("        if (scriptLoaded) {");
          out.println ("          nored=0;");
          //out.println ("        } else {");
          //out.println ("          nored=1;");
          //out.println ("          alert ('No hay conexion con google mapas!!');");
          //out.println ("        }");
          if (nivel.equals("1")){
              //out.println ("      ventana = window.open('reporte.jsp?ent="+id+"&n=1','Reporte','toolbar=no,Resizable=1,scrollbars=1');");
          }else if(nivel.equals("2")){
              //out.println ("      ventana = window.open('reporte.jsp?ent="+id+"&n=2','Reporte','toolbar=no,Resizable=1,scrollbars=1');");
          }else if(nivel.equals("3")){
              //out.println ("      ventana = window.open('reporte.jsp?ent="+id+"&n=2','Reporte','toolbar=no,Resizable=1,scrollbars=1');");
          }
          out.println ("      init("+nivel+",'"+id+"',"+edicion+","+edicionmz+","+edicionpre+","+edicionagpr+");");
          out.println ("      }");
          out.println ("</script>");
          //out.println ("<script src='http://maps.googleapis.com/maps/api/js?v=3&key=AIzaSyAL8-CvaNgh7c1C7Zh7X4AFxrLxsXZNDO4' onload='scriptLoaded=true;'></script>"); // mi cuenta
          out.println ("<script src=\"OpenLayers/OpenLayers.js\"></script>"
                  + "<script src=\"proj4js.js\"></script>"
                  + "<script src=\"EPS32800.js\"></script>"
                  + "<script src=\"EPS6365.js\"></script>"
                  + "<script src=\"funciones_especiales.js\"></script>"
                  + "<script src=\"todo.js?v="+verjs+"\"></script>"
                  + "<script src=\"js_manzanas.js?v="+verjs+"\"></script>"
                  + "<script src=\"js_caserios.js?v="+verjs+"\"></script>"
                  + "<script src=\"js_localidades.js?v="+verjs+"\"></script>"
                  + "<script src=\"js_predig.js?v="+verjs+"\"></script>"
                  + "<script src=\"js_agebu.js?v="+verjs+"\"></script>"
                  + "<script src=\"js_polrur.js?v="+verjs+"\"></script>"
                  + "<script src=\"js_polext.js?v="+verjs+"\"></script>"
                  + "<script src=\"jsts-master/lib/javascript.util.js\"></script>"
                  + "<script src=\"jsts-master/lib/jsts.js\"></script>"
                  + "<script src=\"jscolor/jscolor.js\"></script>" );
          //out.println ("</head><body onload=\"init("+nivel+",'"+id+"',"+edicion+","+edicionmz+")\">"
           out.println ("</head><body onload='checkScriptLoaded();'>"
                  +"<Form method=\"post\" name=\"inicia\">"
                  + "<table border=0 width=\"100%\"><tr><td><div id='geoserv'></div><td>&nbsp;<td><div id='chgpass'></div><td width=\"32%\" align=\"left\" nowrap=\"nowrap\"><div id='encabezado'><font class='usuario'>"
                  + "&nbsp;&nbsp;<input class='boton' type='Button' onClick=\"regchange();\" Title=\"Recargar Sistema\" value=\"F5\"/>"
                  + "&nbsp;&nbsp;USUARIO:&nbsp;&nbsp;"+nombre+" "+txt1+"</form></font></div>"
                  + "<td width=\"30%\" style=\"text-align:center;\" nowrap=\"nowrap\"><div id='textomsg'></div>");

            %><td align="right" nowrap="nowrap" width="37%" style="text-align:right;">
                <div id="coords"></div></table>
               <div id="map"></div>
                <form name="busqueda">
                <table border=0 width="100%"><tr class='search'>
                <td nowrap="nowrap">
                                <b>BUSCAR:</b><td>
                                  <select name='capa' class='boton'>
                  <option value='0'>SELECCIONE...</option>
                  <option value='1'>CARTAS 1:50</option>
                  <option value='2'>ESTADOS</option>
                  <option value='3'>MUNICIPIOS</option>
                  <option value='4'>AGEBS</option>
                  <!--<option value='5'>LOC. URBANAS</option>
                  <option value='6'>LOC. RURALES (POL)</option>-->
                  <option value='7'>LOCALIDADES</option>
                  <option value='8'>ASENTAMIENTOS</option>
                  <option value='11' selected>MANZANAS</option>
                  <option value='9'>VIALIDADES</option>
                  <option value='10'>*CAPTURA</option>
                  <option value='12' style="background-color: green">GEOCODE-OSM</option>
                </select>
                <td class='search' nowrap>&nbsp;&nbsp;&nbsp;
                <td class='search' nowrap><input type='radio' name='tipo' value='0' class='search' class='boton' checked><td class='search'>CLAVE
                <td class='search' nowrap><input type='radio' name='tipo' value='1' class='search' class='boton'><td class='search' valign='top'>NOMBRE
                <td class='search' nowrap>&nbsp;&nbsp;&nbsp;
                <td class='search' nowrap><b>TEXTO&nbsp;A&nbsp;BUSCAR:</b><input type=text class='boton' name='buscar' size='12' >&nbsp;
              <td nowrap><img src="OpenLayers/theme/default/img/buscar.png" onClick="busca();" Title="Buscar"></img>
              <td>&nbsp;&nbsp;&nbsp;<b>PUNTO:</b>&nbsp;
              <td class="search" nowrap>LON(X),LAT(Y):<input title='Acepta sexagesimal, decimal y CCL (SEPARADAS POR COMA X,Y)' type="text" name="longitud" maxlength="40" size="18" class="boton" onKeypress="return datonumjuntos(event)">&nbsp;&nbsp;
              <!--<td class="search" nowrap>LAT(Y):<input title='Acepta sexagesimal, decimal y CCL' type="hidden" name="latitud" maxlength="20" size="8" class="boton" onKeypress="return datonum(event)">&nbsp;-->
              <input title='Acepta sexagesimal, decimal y CCL' type="hidden" name="latitud" maxlength="20" size="8" class="boton" onKeypress="return datonumjuntos(event)">&nbsp;
              <td nowrap><img src="OpenLayers/theme/default/img/punto.png" onClick="enviarjuntos();" Title="Agregar Coordenada"></img>
              <td nowrap>&nbsp;
              <td nowrap><img src="OpenLayers/theme/default/img/puntobor.png" onClick="borra();" Title="Borrar Puntos"></img>
                <td nowrap>&nbsp;
                  <td nowrap Title="Cambiar color de punto/linea/poligono" valign=top>
              <input type='hidden' id='colorin' name='colorin'>
              <input type='button' class='color' id='myColor' value='' onclick="document.getElementById('myColor').color.showPicker()" style='height:22px;width:24px;font-family: Arial; font-size: 10px; line-height: 1.3; font-weight: normal;'>
              <%
              out.println ("<td nowrap>&nbsp;<select name='opac' id='opac' title='Transparencia de punto/linea/poligono' onChange='cambiaOpac();'><option value=0.9>9</option><option value=0.8>8</option><option value=0.7>7</option><option value=0.6>6</option><option value=0.5 selected>5</option><option value=0.4>4</option><option value=0.3>3</option><option value=0.2>2</option><option value=0.1>1</option><option value=0.0>0</option></select>");
              if (nivel.equals("3")){
                out.println("<td nowrap>&nbsp;&nbsp;<td nowrap><img src=\"images/mapa.png\" onClick=\"tema();\" Title=\"Ver mapas tematicos e informativos\" ></img>");
              }
        if (!(nivel.equals("5"))){
              out.println("<td nowrap>&nbsp;&nbsp;<td nowrap><img src='images/desc.png' onClick='descargar();' Title='Descargar informacion'></img>");
              out.println("<td nowrap>&nbsp;&nbsp;<td nowrap><img src='images/bookmarks.png' onClick=\"anotaciones('"+pass+"');\" Title='Ver Anotaciones'></img>");
          }

              //if (edicion.equals("1") || nivel.equals("2") || nivel.equals("3")){
        if (!(nivel.equals("5"))){
                  out.println("<td nowrap>&nbsp;&nbsp;<input class='boton' type='Button' onClick=\"tel('"+pass+"','"+id+"','"+regid+"');\" Title=\"Ver Tablas de Equivalencia de coordenadas de localidades\" value=\" T-L \"/>");
              //}
              //if (edicionagpr.equals("1") || nivel.equals("2") || nivel.equals("3")){
          //if (!(nivel.equals("5"))){

              out.println("<td nowrap>&nbsp;&nbsp;<input class='boton' type='Button' onClick=\"modpre('"+pass+"','"+id+"','"+regid+"');\" Title=\"Ver informacion de predigitalizacion\" value=\" PRE \"/>");


                  out.println("<td nowrap>&nbsp;&nbsp;<input class='boton' type='Button' onClick=\"modaupr('"+pass+"','"+id+"','"+regid+"');\" Title=\"Ver informacion modificada de AU/PR/PE\" value=\" A/P/PE \"/>");
              //}
              //if (edicionmz.equals("1") || nivel.equals("2") || nivel.equals("3")){
                   out.println("<td nowrap>&nbsp;&nbsp;<input class='boton' type='Button' onClick=\"tem('"+pass+"','"+id+"','"+regid+"');\" Title=\"Ver Tablas de Equivalencia de manzanas\" value=\" T-M \"/>");


                   out.println("<td nowrap>&nbsp;&nbsp;<input class='boton' type='Button' onClick=\"temf('"+pass+"','"+id+"','"+regid+"');\" Title=\"Ver Tablas de Cambios de forma de manzanas\" value=\" T-F \"/>");

                   //out.println("<td nowrap>&nbsp;&nbsp;<input class='boton' type='Button' onClick=\"temj('"+pass+"','"+id+"','"+regid+"');\" Title=\"Ver Tablas de cambio de ambito\" value=\" T-M-J \"/>");
              //}


              // esto es lo del la CUR
              out.println("<td nowrap>&nbsp;&nbsp;<input class='boton'  style='background-color: #E7A4F9;' type='Button' onClick=\"moduloccCUR('"+pass+"','"+id+"','"+regid+"');\" Title=\"Ver informacion de manzanas provenientes del CU\" value=\" CUR \"/>");


           // lo del censor
              //out.println("<td nowrap>&nbsp;&nbsp;<input class='boton' type='Button' style='border-color:#e7d94a'; onClick=\"acca22('"+pass+"','"+id+"','"+regid+"');\" Title=\"Actualizaciones reportadas por los SE del EIC2025\" value=\" AC-EIC25 \"/>");


            // esto es lo del MCC
              //out.println("<td nowrap>&nbsp;&nbsp;<input class='boton' style='background-color: #F5A560;' type='Button' onClick=\"modulocc('"+pass+"','"+id+"','"+regid+"');\" Title=\"Ver informacion de manzanas a integrar del MCC\" value=\" MCC \"/>");

            // esto es lo de terrenos
              //out.println("<td nowrap>&nbsp;&nbsp;<input class='boton' type='Button' onClick=\"moduloni('"+pass+"','"+id+"','"+regid+"');\" Title=\"Ver informacion de actualizaciones de terrenos\" value=\" NI-CA \"/>");


                // out.println("<td nowrap>&nbsp;&nbsp;<input class='boton' type='Button' onClick=\"modtefr('"+pass+"','"+id+"','"+regid+"');\" Title=\"Ver informacion de Tablas de Frentes\" value=\" T-F \"/>");
        }
                %>
              <td width=90%><div id="output">MEDIR</div><div id="coords"></div>
                </table>
                </form>
             <div id='ventana-flotante'>
               <a class='cerrar' href='javascript:void(0);' onclick='alcerrar_capas();'>x</a>

               <div id='contenedor'>
                <% out.println("<iframe id='framecapas' src='capas.html?v="+verjs+"' width='242' height='"+(capasalto+capasextra)+"'></iframe>");%>
               </div>
            </div>
            <div id='ventana-flotante_sv'>
               <a class='cerrar' href='javascript:void(0);' onclick='alcerrar_sv();'>x</a>
               <div id='contenedor_sv'>
                <iframe id="framecapas_sv" src="" width="640" height="470"></iframe>
               </div>
            </div>
          <div id='ventana-flotante_inegiv'>
               <a class='cerrar' href='javascript:void(0);' onclick='alcerrar_inegiv();'>x</a>
               <div id='contenedor_inegiv'>
                <iframe id="framecapas_inegiv" src="" width="640" height="470"></iframe>
               </div>
            </div>
        <div id='ventana-flotante_te'>
               <a class='cerrar' href='javascript:void(0);' onclick='alcerrar_te();'>x</a>
               <div id='contenedor_te'>
                <iframe id="framecapas_te" src="" width="660" height="470"></iframe>
               </div>
            </div>


        <div id='ventana-flotante_ce'>
               <a class='cerrar' href='javascript:void(0);' onclick='alcerrar_ce();'>x</a>
               <div id='contenedor_ce'>
              <% out.println("<iframe id='framecapas_ce' src='capas_ce.html?v="+verjs+"' width='660' height='470'></iframe>");%>

               </div>
            </div>

 <div id='ventana-flotante_pre'>
               <a class='cerrar' href='javascript:void(0);' onclick='alcerrar_pre();'>x</a>
               <div id='contenedor_pre'>
              <% out.println("<iframe id='framecapas_pre' src='capas_pre.html?v="+verjs+"' width='660' height='470'></iframe>");%>

               </div>
            </div>

             <div id='ventana-flotante_qr'>
               <a class='cerrar' href='javascript:void(0);' onclick='alcerrar_qr();'>x</a>
               <div id='contenedor_qr'>
                <iframe id="framecapas_qr" src="" width="640" height="470"></iframe>

               </div>
            </div>


   <div class="containerce">
        <div class="tooltipce" id="tooltipce">
      <table>
        <tr><td bgcolor=#fac105 class=n>&nbsp;&nbsp;&nbsp;&nbsp;<td class=n nowrap>&nbsp;&nbsp;Distribucion de CMS MASIVO
        <tr><td bgcolor=#FFC0F4 class=n>&nbsp;&nbsp;&nbsp;&nbsp;<td class=n nowrap>&nbsp;&nbsp;Localidades Urbanas y Rurales
        <tr><td bgcolor=#B9B9B9 class=n>&nbsp;&nbsp;&nbsp;&nbsp;<td class=n nowrap>&nbsp;&nbsp;Corredores Industriales
        <tr><td bgcolor=#B6D5F1 class=n>&nbsp;&nbsp;&nbsp;&nbsp;<td class=n nowrap>&nbsp;&nbsp;Corredores Turisticos
        <tr><td bgcolor=#A8F1E8 class=n>&nbsp;&nbsp;&nbsp;&nbsp;<td class=n nowrap>&nbsp;&nbsp;Agebs Rurales (MUESTRA RURAL)
      </table>
        </div>
    </div>
  
   <div class="containerpob">
        <div class="tooltippob" id="tooltippob">
      <table>
        <tr><td bgcolor=#ebf2f7 class=n>&nbsp;&nbsp;&nbsp;&nbsp;<td class=n nowrap>&nbsp;&nbsp;0% de avance
        <tr><td bgcolor=#90cbf9  class=n>&nbsp;&nbsp;&nbsp;&nbsp;<td class=n nowrap>&nbsp;&nbsp;25% de avance
        <tr><td bgcolor=#41a7f5  class=n>&nbsp;&nbsp;&nbsp;&nbsp;<td class=n nowrap>&nbsp;&nbsp;50 de avance
        <tr><td bgcolor=#1477d2 class=n>&nbsp;&nbsp;&nbsp;&nbsp;<td class=n nowrap>&nbsp;&nbsp;75% de avance
        <tr><td bgcolor=#0747a1 class=n>&nbsp;&nbsp;&nbsp;&nbsp;<td class=n nowrap>&nbsp;&nbsp;100% de avance
      </table>
        </div>
    </div>
  <style>

.containerce {
    position: fixed;
    text-align: center;
    margin-top: 800px;
    z-index: 999;
    -webkit-animation: fadeIn 3s;
    animation: fadeIn 3s;

}


.containerpob {
    position: fixed;
    text-align: center;
    margin-top: 800px;
    z-index: 999;
    -webkit-animation: fadeIn 3s;
    animation: fadeIn 3s;

}
.tooltipce {
    display: none;
    position: fixed;
    background-color: #EFEFEF;
    color: white;
    padding: 10px;
    border-radius: 10px;
    border: 1px solid #888888;  /* Borde de la ventana */
    top: 50px;
    left: 228px;
    white-space: nowrap;
}
.tooltippob {
    display: none;
    position: fixed;
    background-color: #EFEFEF;
    color: white;
    padding: 10px;
    border-radius: 10px;
    border: 1px solid #888888;  /* Borde de la ventana */
    top: 50px;
    left: 204px;
    white-space: nowrap;
}





              .n{font-family: Arial; font-size: 8pt; line-height: 1.3; font-weight: bold;}

            #ventana-flotante {
            width: 242px;  /* Ancho de la ventana */
            height: <% out.print(capasalto+capasextra); %>px;  /* Alto de la ventana */
            background: #EFEFEF;  /* Color de fondo */
            position: fixed;
            top: 55px;
            right: 6px;
            border: 1px solid #888888;  /* Borde de la ventana */
            z-index:999;

            //filter: alpha(opacity=90);
            //opacity: 0.9;
            //-moz-opacity: 0.9;
            }
            #ventana-flotante .cerrar {
            float: right;
            border-bottom: 1px solid #bbb;
            border-left: 1px solid #bbb;
            color: #999;
            background: white;
            line-height: 17px;
            text-decoration: none;
            padding: 0px 14px;
            font-family: Arial;
            font-size: 18px;
            }
            #ventana-flotante .cerrar:hover {
            background: #ff6868;
            color: white;
            text-decoration: none;
            text-shadow: -1px -1px red;
            border-bottom: 1px solid red;
            border-left: 1px solid red;
            }

            .oculto {display:none}
            .mostrar {display:inline}


#ventana-flotante_sv {width: 640px;height: 470px;background: #EFEFEF;position: fixed;bottom: 45px;left: 6px;border: 1px solid #888888;z-index:999;}
#ventana-flotante_sv .cerrar {float: right;border-bottom: 1px solid #bbb;border-left: 1px solid #bbb;color: #999;background: white;line-height: 17px;text-decoration: none;padding: 0px 14px;font-family: Arial;font-size: 18px;}
#ventana-flotante_sv .cerrar:hover {background: #ff6868;color: white;text-decoration: none;text-shadow: -1px -1px red;border-bottom: 1px solid red;border-left: 1px solid red;}
.oculto_sv {display:none}
.mostrar_sv {display:inline}
#ventana-flotante_inegiv {width: 640px;height: 470px;background: #EFEFEF;position: fixed;bottom: 45px;left: 6px;border: 1px solid #888888;z-index:999;}
#ventana-flotante_inegiv .cerrar {float: right;border-bottom: 1px solid #bbb;border-left: 1px solid #bbb;color: #999;background: white;line-height: 17px;text-decoration: none;padding: 0px 14px;font-family: Arial;font-size: 18px;}
#ventana-flotante_inegiv .cerrar:hover {background: #ff6868;color: white;text-decoration: none;text-shadow: -1px -1px red;border-bottom: 1px solid red;border-left: 1px solid red;}
.oculto_inegiv {display:none}
.mostrar_inegiv {display:inline}

#ventana-flotante_te {width: 660px;height: 370px;background: #FFFFFF;position: fixed;bottom: 60px;left: 26px;border: 1px solid #888888;z-index:999;}

   .oculto_te {display:none}
   .mostrar_te {display:inline}


#ventana-flotante_te .cerrar {float: right;border-bottom: 1px solid #bbb;border-left: 1px solid #bbb;color: #999;background: white;line-height: 17px;text-decoration: none;padding: 0px 14px;font-family: Arial;font-size: 18px;}
#ventana-flotante_te .cerrar:hover {background: #ff6868;color: white;text-decoration: none;text-shadow: -1px -1px red;border-bottom: 1px solid red;border-left: 1px solid red;}





#ventana-flotante_ce {width: 190px;height: 135px;background: #EFEFEF;position: fixed;top: 455px;right: 244px;border: 1px solid #888888;z-index:900;-webkit-animation: fadeIn 1s; animation: fadeIn 1s;}
#ventana-flotante_ce .cerrar {float: right;border-bottom: 1px solid #bbb;border-left: 1px solid #bbb;color: #999;background: white;line-height: 17px;text-decoration: none;padding: 0px 14px;font-family: Arial;font-size: 18px;}
#ventana-flotante_ce .cerrar:hover {background: #ff6868;color: white;text-decoration: none;text-shadow: -1px -1px red;border-bottom: 1px solid red;border-left: 1px solid red;}
.oculto_ce {display:none}
.mostrar_ce {display:inline}


#ventana-flotante_pre {width: 190px;height: 135px;background: #EFEFEF;position: fixed;top: 455px;right: 244px;border: 1px solid #888888;z-index:900;-webkit-animation: fadeIn 1s; animation: fadeIn 1s;}
#ventana-flotante_pre .cerrar {float: right;border-bottom: 1px solid #bbb;border-left: 1px solid #bbb;color: #999;background: white;line-height: 17px;text-decoration: none;padding: 0px 14px;font-family: Arial;font-size: 18px;}
#ventana-flotante_pre .cerrar:hover {background: #ff6868;color: white;text-decoration: none;text-shadow: -1px -1px red;border-bottom: 1px solid red;border-left: 1px solid red;}
.oculto_pre {display:none}
.mostrar_pre {display:inline}


#ventana-flotante_qr {width: 140px;height: 175px;background: #EFEFEF;position: fixed;top: 50px;left: 68px;border: 1px solid #888888;z-index:900;-webkit-animation: fadeIn 1s; animation: fadeIn 1s;}
#ventana-flotante_qr .cerrar {float: right;border-bottom: 1px solid #bbb;border-left: 1px solid #bbb;color: #999;background: white;line-height: 17px;text-decoration: none;padding: 0px 14px;font-family: Arial;font-size: 18px;}
#ventana-flotante_qr .cerrar:hover {background: #ff6868;color: white;text-decoration: none;text-shadow: -1px -1px red;border-bottom: 1px solid red;border-left: 1px solid red;}
.oculto_qr {display:none}
.mostrar_qr {display:inline}



            </style>




   <%
     }

        rs.close();
        str.close();
        conexion.close();
     
     }   //ENTRA EL MAPA Y BAN

} //el if del mantenimiento


   } //try
   catch (SQLException ex){
        out.println (ex);
    }

    catch(Exception ex){
        out.println (ex);
    }
    finally {
        
   }

   %>
  </body>
  <script>

  function alcerrar_capas(){
    document.getElementById('ventana-flotante').className = 'oculto';
    alcerrar_ce();
    alcerrar_pre();
   }

  function alcerrar_sv(){
    document.getElementById('ventana-flotante_sv').className = 'oculto_sv';
   }
  function alcerrar_qr(){
    document.getElementById('ventana-flotante_qr').className = 'oculto_qr';
   }

   function alcerrar_inegiv(){
    document.getElementById('ventana-flotante_inegiv').className = 'oculto_inegiv';
   }

function alcerrar_te(){
    document.getElementById('ventana-flotante_te').className = 'oculto';
   }

function alcerrar_ce(){
    document.getElementById('ventana-flotante_ce').className = 'oculto';
   }

   function alcerrar_pre(){
    document.getElementById('ventana-flotante_pre').className = 'oculto';
   }


  document.getElementById('ventana-flotante_inegiv').className = 'oculto_inegiv';
  document.getElementById('ventana-flotante_te').className = 'oculto';
  document.getElementById('ventana-flotante_qr').className = 'oculto';
  document.getElementById('ventana-flotante_sv').className = 'oculto_sv';

function regchange(){
  var co = map.getExtent();
  co = co.toString();
  var coord = co.split(",");
  document.inicia.seltext.value=textsel;
  document.inicia.selcapa.value=capasel;
  document.inicia.selpuntos_ce.value=puntosel_ce;
  document.inicia.c1.value=coord[0];
  document.inicia.c2.value=coord[1];
  document.inicia.c3.value=coord[2];
  document.inicia.c4.value=coord[3];
  document.inicia.submit()
}


   </script>
  </html>