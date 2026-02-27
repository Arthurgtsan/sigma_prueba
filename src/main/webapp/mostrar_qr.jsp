<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>
SIGMA
</title>
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-Q856GDCQ02"></script>
<script src="qrcode.min.js"></script>
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

  </head>
<body>

<%
int n=0;
int n1=0;
String  ent = "",regid = "",
        latitud = request.getParameter("lat"),
        longitud = request.getParameter("lon"),
        zoom = request.getParameter("zoom"),
         obs="",observa="",lobs="",obs1="";

HttpSession sesion = request.getSession(true);
if ((sesion != null && !sesion.isNew())) {
        //out.println("LA SESION SIGUE ACTIVA");

String remotehost  = session.getAttribute("remotehost").toString();
String regionalid  = session.getAttribute("regionalid").toString();

out.println("<table><tr title='Click izquierdo para abrir en google maps, Click derecho para guardar imagen.'><td ><div id='qrcode' onclick=\"window.open('https://www.google.com.mx/maps/@"+latitud+","+longitud+","+zoom+"z','Street','scrollbars=no,toolbar=no,resizable=no')\"></div><tr><td align=center class=n>Escaneame");
out.println("<script>const url = 'https://www.google.com.mx/maps/@"+latitud+","+longitud+","+zoom+"z';");
%>


 // Crear un nuevo código QR
 const qr = new QRCode(document.getElementById('qrcode'), {
 text: url,
 width: 120,
 height: 120,
 colorDark : "#000000",
 colorLight : "#ffffff",
 correctLevel : QRCode.CorrectLevel.H
 });
</script>

<%



    }else{
          out.println("<script>opener.cerrarSesion();window.close();</script>");
    }


%>
</table>
</body>
</html>
