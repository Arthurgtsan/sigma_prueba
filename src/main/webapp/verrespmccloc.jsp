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
String consulta="";
String fig="";
HttpSession sesion = request.getSession(false);
String remotehost  = session.getAttribute("remotehost").toString();
try {
    consulta= "select id,cgo1,ent_ant,mun_ant,loc_ant,ageb_ant,ent_Act,mun_act,loc_act,ageb_act,nom_loc,plano from bd_loc where fcap>='2025-01-01' and id_prov="+gid;

      Statement str = null;
      ResultSet rs = null;
      Connection conexion = null;
      Class.forName("org.postgresql.Driver");
      String hostbd  = session.getAttribute("hostbd").toString();
      String remotehostbd  = session.getAttribute("remotehostbd").toString();
      conexion = DriverManager.getConnection("jdbc:postgresql://10.153.3.25:5434/actcargeo10","actcar","actcar");
      str = conexion.createStatement(rs.TYPE_SCROLL_SENSITIVE, rs.CONCUR_UPDATABLE);
      rs = str.executeQuery( consulta );
      String cgo1="",ent_ant="",mun_ant="",loc_ant="",ageb_ant="",ent_act="",mun_act="",loc_act="",ageb_act="",nom_loc="",plano="",cgotxt="";
      int gid2=0;
      Integer bans=0;
      while(rs.next()){
        if (bans==0){
        bans=1;
        gid2=(Integer)(rs.getObject(1));
        cgo1=rs.getObject(2).toString();
        ent_ant=rs.getObject(3).toString();
        mun_ant=rs.getObject(4).toString();
        loc_ant=rs.getObject(5).toString();
        ageb_ant=rs.getObject(6).toString();
        ent_act=rs.getObject(7).toString();
        mun_act=rs.getObject(8).toString();
        loc_act=rs.getObject(9).toString();
        ageb_act=rs.getObject(10).toString();
        nom_loc=rs.getObject(11).toString();
        plano=rs.getObject(12).toString();
      switch(cgo1){
             case "C":cgotxt="Baja por Servicio";break;
             case "R":cgotxt="Inexistente";break;
             case "T":cgotxt="Tapias o ruinas";break;
             case "D":cgotxt="Fusion";break;
             case "E":cgotxt="Conurbacion";break;
             case "H":cgotxt="Cambio de municipio";break;
             case "I":cgotxt="Cambio de entidad";break;
             case "M":cgotxt="Creacion de Municipio";break;
      }

      out.println("<br><center>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font class='n'>Registro de respuesta para: "+clave+"</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</center><br><table border=1 align=center><tr>");
      out.println("<tr><th class='n'>&nbsp;&nbsp;Clave Anterior&nbsp;&nbsp;<th class='n'>Codigo<br>&nbsp;&nbsp;Definitivo&nbsp;&nbsp;<th class='n'>&nbsp;&nbsp;Clave Actual&nbsp;&nbsp;<th class='n'>&nbsp;&nbsp;Plano&nbsp;&nbsp;");
      out.println("<tr><td class='c' align='center'>&nbsp;&nbsp;"+ent_ant+"&nbsp;"+mun_ant+"&nbsp;"+loc_ant+"&nbsp;"+ageb_ant+"&nbsp;&nbsp;");
      out.println("<td class='c' align='center' title='"+cgotxt+"'>&nbsp;&nbsp;"+cgo1+"&nbsp;&nbsp;");
        out.println("<td class='c' align='center'>&nbsp;&nbsp;"+ent_act+"&nbsp;"+mun_act+"&nbsp;"+loc_act+"&nbsp;"+ageb_act+"&nbsp;&nbsp;");
          //out.println("<td class='c' align='center'>&nbsp;&nbsp;"+nom_loc+"&nbsp;&nbsp;");
            out.println("<td class='c' align='center'>&nbsp;&nbsp;"+plano+"&nbsp;&nbsp;");

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