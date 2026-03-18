<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>

<%@ page import="javax.sql.rowset.*" %> 
<%@ page import="com.sun.rowset.CachedRowSetImpl" %>
<%@ page import="mx.org.inegi.AdministradorDataSource_Sigma"%>
<%@ page import="mx.org.inegi.Constructor_de_Consultas"%>


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
String correo= request.getParameter("prodIdco");
String pass_sigma= request.getParameter("pas_sigma");
String pass_new= request.getParameter("new_pas");


correo=correo.toUpperCase();
pass_sigma=pass_sigma.toUpperCase();

 String valor="uno";
 String valor1="dos";
 String valor3="0";
 Integer conteo=0;
 Integer acceso=0;
 Integer valorC=0;

String count="";
/*
 out.println( "<H2><CENTER CLASS=n ALIGN=CENTER> Actualizar Password de Imagenes Digitalglobe (securewatch) <br> para el usuario:"+correo+"</H2>");
out.println( "<H2><CENTER CLASS=n ALIGN=CENTER> Actualizar Password de Imagenes Digitalglobe (securewatch) <br> para el usuario:"+pass_sigma+"</H2>");
out.println( "<H2><CENTER CLASS=n ALIGN=CENTER> Actualizar Password de Imagenes Digitalglobe (securewatch) <br> para el usuario:"+pass_new+"</H2>");
*/

 Statement str = null;
		  CachedRowSet rs = null;
		  /* 
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
          */
          try {
        	  
              String consulta="";
              rs = Constructor_de_Consultas.zedit_act_consulta("act10", pass_sigma, null, null, 0);  
          
            while(rs.next()){
                conteo=Integer.parseInt(rs.getObject(1).toString());
              }

		if(conteo==0){
			out.println( "<center><br><br><br><br><h3>Password de Sigma no Encontrado en la Base de Datos</h3></center>");
		}else{
			//String consulta1="";
			//consulta1 = "select count(*) from usuarios where password='"+pass_sigma+"' and encdg='"+correo+"'";
			//rs = str.executeQuery( consulta1 );
            rs = Constructor_de_Consultas.zedit_act_consulta("act10", pass_sigma, correo, null, 1);  

            while(rs.next()){
                conteo=Integer.parseInt(rs.getObject(1).toString());
              }
			if(conteo==0){
				out.println( "<center><br><br><br><br><h3>El correo es diferente al del usuario que inicio sesion en SIGMA</h3></center>");
			}
			else{
			acceso=1;
			}
		}
			if(acceso==1){
				//String consulta2="";
				//consulta2 = "select correo,encdg,userdg from usuarios where password='"+pass_sigma+"' and encdg='"+correo+"'";
			  //rs = str.executeQuery(consulta2);
			rs = Constructor_de_Consultas.zedit_act_consulta("act10", pass_sigma, correo, null, 2);  
  
			  
			  while(rs.next()){
				valor=rs.getObject(1).toString().toUpperCase();
				valor1=rs.getObject(2).toString().toUpperCase();
				valor3=rs.getObject(3).toString();
			  }
			  if (valor.equals(valor1)){
				  //String consulta3="";
				  //consulta3 = "select count(*) from usuarios where userdg='"+valor3+"'";
					//rs = str.executeQuery(consulta3);
					
					rs = Constructor_de_Consultas.zedit_act_consulta("act10", null, null, valor3, 3);
					while(rs.next()){
						valorC=Integer.parseInt(rs.getObject(1).toString());
					}
					 if (valorC>0){
						 //String consulta4="";
						 //consulta4 = "update  usuarios set passdg='"+pass_new+"' where userdg='"+valor3+"';";
						 //str.executeUpdate(consulta4);
						 //str.executeUpdate( consulta2 );
						 rs = Constructor_de_Consultas.zedit_act_consulta("act10", pass_new, null, valor3, 4);
						 
					 }
					out.println("<center><br><br><br><br><h3>Se Cambio el Password a "+valorC+" Registros</h3></center>");

			  }else{
				  out.println("<center><br><br><br><br><h3>No se cambio el password<br>No coincide el Correo con el Userdg</h3></center>");
			  }

			  }
          
          
      }
      catch(Exception ex){
        out.println("<script>");
        String error_sq  = AdministradorDataSource_Sigma.error_sql;
        out.println("  alert(\"Se genero la expresion de SQL: "+error_sq+" !\");");
        out.println("</script>");
      }
      
  	finally {
  	    // Cerrar el objeto ResultSet
  		if (rs != null) {
  	        try {
  	           rs.close();
  	           rs = null; // Eliminar referencia
  	           //CachedRowSet rs2 = Constructor_de_Consultas.getRowSet();
  	           
  	       	
  	        } catch (SQLException e) {
  	            e.printStackTrace();
  	        }
  	    }
  	}
          
        //  str.close();
		//conexion.close();

%>

</table></table>
<center><br>
<Form >

 <a href="javascript:close_tab();">Cerrar</a>
  </form>
</center>
</body>

</html>