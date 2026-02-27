<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>
SIGMA
</title>
<style type="text/css">
table {
  border-collapse: collapse;
}
.t{font-size: 12pt; font-family: Arial; font-weight: bold; color: #000000;}
.c{font-family: Arial; font-size: 10pt; line-height: 1; font-weight: normal;}
.n{font-family: Arial; font-size: 10pt; line-height: 1.3; font-weight: bold;}
.boton{font-family: Arial; font-size: 10px; line-height: 1; font-weight: normal;}
.f{font-family: Arial; font-size: 9px; line-height: 1; font-weight: normal;}
a.liga2:link {font-family: Arial;color: black; font-size: 9pt; text-decoration: underline}
a.liga2:visited {font-family: Arial;color: black; font-size: 9pt; text-decoration: underline}
a.liga2:hover {font-family: Arial;color: black; font-size: 9pt; text-decoration: underline; background-color: #FFFFFF}


</style>

<script language="javascrpt" type="text/javascript">
window.resizeTo(640,380);

function close_tab() {

    window.close();
  
}

</script>
</head>


<body><table BORDER=1><center><table   border="0"  bgcolor="#dddddd" width=80% align="center">

<%
String correo= request.getParameter("prodId");
String pass_sigma= request.getParameter("pas_sigma");
String pass_new= request.getParameter("new_pas");  
String conf_pass= request.getParameter("conf_pas"); 
correo=correo.toUpperCase();
pass_sigma=pass_sigma.toUpperCase();
pass_new=pass_new.toUpperCase();
conf_pass=conf_pass.toUpperCase();


 String valor="uno";
 String valor1="dos"; 
 String valor3="0";
 Integer conteo=0;
 Integer acceso=0;
 Integer valorC=0;

String count="";


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
		  consulta ="select count(*) from usuarios where password='"+pass_sigma+"'";
          rs = str.executeQuery( consulta );	  		  
            while(rs.next()){               
                conteo=Integer.parseInt(rs.getObject(1).toString());
              }
			
		if(conteo==0){	  
			out.println( "<center><br><br><br><br><h3>Password de Sigma no Encontrado en la Base de Datos</h3></center>");
		}else{
			if (pass_new.equals(conf_pass)){
				String consulta4="";
						 consulta4 = "update  usuarios set password='"+pass_new+"' where password='"+pass_sigma+"';";					
						 str.executeUpdate(consulta4);
			}
			out.println("<center><br><br><br><br><h3>Se Cambio el Password de la cuenta de SIGMA </h3></center>"); 
		}
			
		str.close();
		conexion.close();

%>
</table></table>
<center><br>
<Form >
   
 <a href="javascript:close_tab();">Cerrar</a>
  </form>
</center>
</body>

</html>