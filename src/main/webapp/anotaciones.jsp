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
window.resizeTo(700,600);


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


function borra(gid) {
    var ajax=nuevoAjax();
    ajax.open("GET",'borra_mark.jsp?gid='+gid, true);
    ajax.onreadystatechange=function()
    {
        if(ajax.readyState==4)  {
             var vale=ajax.responseText;
            if (parseInt(vale)==1){
                alert ("No se pudo borrar el registro!!");
            }else{
                location.reload();
            }
        }
    }
    ajax.send(null);
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
        //out.println("<script>window.opener.location.reload(false);window.close();</script>");
         // out.println("<script>window.opener.location.reload(false);window.close();</script>");
        //out.println("LA SESION SIGUE ACTIVA");

    }else{
          out.println("<script>opener.cerrarSesion();window.close();</script>");

    }

      ResultSet rs = null;
      Statement str = null;
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
    Integer us=(Integer) rs.getObject(6);
    Integer nivel=(Integer) rs.getObject(1);

//out.println( consultapas );


Calendar fecha = Calendar.getInstance();
String m1="",d1="",fec1="",fec2="",filreg="",selreg="";
//out.println("<br>"+fecha.get(Calendar.MONTH));
//out.println("<br>"+fecha.get(Calendar.DATE));
String filniv="";
if (nivel==1){
  filniv = "and cve_ent='"+ent+"'";
}
if (fecha.get(Calendar.MONTH)<9)m1="0";   // supongo que el mes empieza por 0
if (fecha.get(Calendar.DATE)<10)d1="0";
fec1=fecha.get(Calendar.YEAR) + "-" + m1 + (fecha.get(Calendar.MONTH)+1) + "-" + d1 + fecha.get(Calendar.DATE);
fec2=fecha.get(Calendar.YEAR) + "-" + m1 + (fecha.get(Calendar.MONTH)+1) + "-" + d1 + fecha.get(Calendar.DATE);
filfe1 = request.getParameter("filfe1");
filfe2 = request.getParameter("filfe2");

if (filfe1==null){filfe1=fec1; filfe1="2016-12-01";}
if (filfe2==null){filfe2=fec2;}
    consulta="select gid,cve_ent,descripcion,fact,ST_AsText(the_geom) from cat_marks where fact between '"+filfe1+"' and '"+ filfe2 +"' "+filniv+" order by gid";
    String filult="";
  if(loc != null && !loc.isEmpty()){
      consulta="select gid,cve_ent,descripcion,fact,ST_AsText(the_geom) from cat_marks where descripcion ilike '" + loc + "%' "+filniv+" order by gid";
}

       out.println( "<center class='t'>Anotaciones</center>"
                + "<form action=\"anotaciones.jsp\" method=\"post\" name=\"enviar\">"
                + "<center><br>"
                + "&nbsp;&nbsp;&nbsp;&nbsp;<font class=n>De:</font>&nbsp;<input class='boton' name='filfe1' type='text' id='p1id' onClick=\"popUpCalendar(this, enviar.p1id, 'yyyy-mm-dd');\" size='10' readOnly value='"+filfe1.substring(0,10)+"'>"
                + "&nbsp;&nbsp;&nbsp;&nbsp;<font class=n>a:</font>&nbsp;<input class='boton' name='filfe2' type='text' id='p2id' onClick=\"popUpCalendar(this, enviar.p2id, 'yyyy-mm-dd');\" size='10' readOnly value='"+filfe2.substring(0,10)+"'>"
                + "<input type='hidden' name='ban' value='1'>&nbsp;&nbsp;&nbsp;&nbsp;<input class='boton' type='button' value=' Buscar ' onclick='envia(1)''><br><br><font class=n>Por descripcion:&nbsp;&nbsp;</font>"
                + "<input type='text' maxlength=22 size=20 name='loc' value='"+loc+"' class='boton'><input type='hidden' name='pass' value='"+pass+"'>&nbsp;&nbsp;&nbsp;&nbsp;<input class='boton' type='button' value=' Buscar ' onclick='envia(2)'></form><br><br>");
  out.println( "<table border=1><tr class=n bgcolor=#BBBBBB>");
  out.println("<th>&nbsp;&nbsp;Ver&nbsp;&nbsp;<th>&nbsp;&nbsp;Gid&nbsp;&nbsp;<th>&nbsp;&nbsp;Estado/&nbsp;&nbsp;<br>&nbsp;&nbsp;Regional&nbsp;&nbsp;<th>&nbsp;&nbsp;Fecha&nbsp;&nbsp;<th>&nbsp;&nbsp;Descripcion&nbsp;&nbsp;");
  out.println("<th><img src=images/borra.gif>");
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
//    out.println(consulta);

    while(rs.next()){
    //gid,cve_ent,carta,sup,fact,nm,nf,ne
      String gid=rs.getObject(1).toString();
      String cve_ent=rs.getObject(2).toString();
      String descrip="";
      if (rs.getString(3) != null){
        descrip=rs.getString(3);
      }else{
        descrip="";
      }
      String fact=rs.getObject(4).toString();
      String geom=rs.getObject(5).toString();

      String salida = geom.replace("POINT(","");
      salida = salida.replace(")","");
      salida = salida.replace(" ",",");
      String[] salvec = salida.split(",");

      out.println("<tr class=c bgcolor=''>");
      out.println("<td align=center nowrap>&nbsp;<input type=button onclick=\"window.opener.crearUnPunto("+salvec[0]+","+salvec[1]+",'3857');\" value=' Ver ' class='boton'>&nbsp;");
              out.println("<td align=center nowrap>&nbsp;"+gid+"&nbsp;");

      out.println("<td align=center nowrap>&nbsp;"+cve_ent+"&nbsp;");
      out.println("<td align=center nowrap>&nbsp;&nbsp;"+fact+"&nbsp;&nbsp;");
      out.println("<td align=left>&nbsp;"+descrip+"&nbsp;");
      out.println("<td align=center nowrap>&nbsp;&nbsp;<img title='Borrar anotacion' src=images/borra.gif onclick='borra("+gid+")';>&nbsp;&nbsp;");
      n++;
       }
    rs.close();
  out.println( "</table><br><center><table align=center><tr align=center><td><font class=n>Total de Registros: " + totalRows +"</font><br><br>");

 //String export = consulta.replace("%", "-");
  //out.println ("<table><tr><td nowrap><input class='boton' type='Button' onClick='exp(\""+export.replace("'","*")+"\");' value=' Exportar a DBF '/>");

String barra="";
if(startIndex != 0) {
barra="<a class=liga1 href='anotaciones.jsp?filent="+filent+"&filtipo="+filtipo+"&filfe1="+filfe1+"&filfe2="+filfe2+"&loc="+loc+"&pass="+pass+"&ban="+ban+"&startIndex="+(startIndex-numRecordsPerPage)+"'>&nbsp;<<&nbsp; </a>";
}

for (n =0 ; n<numPages; n++){
  if (n*numRecordsPerPage == startIndex) {
    // Si el numero de pagina es la actual ($_pagi_actual). Se escribe el numero, pero sin enlace y en negrita.
    barra+="<b>&nbsp;<font class=liga>"+(n+1)+"</font>&nbsp; </b>";
  }else{
    // Si es cualquier otro. Se escibe el enlace a dicho numero de pagina.
    barra+="<a class=liga1 href='anotaciones.jsp?filent="+filent+"&filtipo="+filtipo+"&filfe1="+filfe1+"&filfe2="+filfe2+"&loc="+loc+"&pass="+pass+"&ban="+ban+"&startIndex="+(numRecordsPerPage*n)+"'>&nbsp;"+(n+1)+"&nbsp; </a>";
  }
 }




if(startIndex+numRecordsPerPage <= totalRows){
  barra+="<a class=liga1 href='anotaciones.jsp?filent="+filent+"&filtipo="+filtipo+"&filfe1="+filfe1+"&filfe2="+filfe2+"&loc="+loc+"&pass="+pass+"&ban="+ban+"&startIndex="+(startIndex+numRecordsPerPage)+"'>&nbsp;>>&nbsp;</a>";
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
</table>
</body>
</html>
