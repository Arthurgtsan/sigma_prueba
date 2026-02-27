<%@ page import="java.util.*" session="true" %>
<%@ page import="java.sql.*"%>
<%
//String tip=request.getParameter("tipo");
//int  tipo = Integer.parseInt(tip);

int  tipo = Integer.parseInt(request.getParameter("tipo"));
int  id = Integer.parseInt(request.getParameter("id"));
String  filterid = request.getParameter("filterid");
HttpSession sesion = request.getSession(false);
String remotehost  = session.getAttribute("remotehost").toString();
try {
String consulta1="";
String consulta2="";
if (tipo==1 || tipo==2){
    if (tipo==1){  //localidad
      //aqui estaria la funcion si decido validar algo despues de que se guarde correctamente
      //consulta = "select a_revisa_ins_mza_te()";
    }else if (tipo==2){  //manzana primero reviso el cambio de forma, despues se revisa el codigo y sus atributos o sobreposiciones
      //consulta1 = "select a_revisa_ins_mza_geo("+id+")";    <-- agregue un trigger after en la tabla de te_mza_coord
      consulta2 = "select a_revisa_ins_mza_te('"+filterid+"')";
    }

      Statement str = null;
      ResultSet rs = null;
      Connection conexion = null;
      Class.forName("org.postgresql.Driver");
      String hostbd  = session.getAttribute("hostbd").toString();
      String remotehostbd  = session.getAttribute("remotehostbd").toString();
      conexion = DriverManager.getConnection("jdbc:postgresql://"+remotehostbd+":5434/"+hostbd,"actcar","actcar");
      str = conexion.createStatement(rs.TYPE_SCROLL_SENSITIVE, rs.CONCUR_UPDATABLE);
      //rs = str.executeQuery( consulta1 );
      rs = str.executeQuery( consulta2 );
      String n = "0";
      while(rs.next()){
        n=rs.getObject(1).toString();
      }
      str.close();
      conexion.close();
      out.println(n);
}else{
      out.println("999");
}
    }
   catch (SQLException ex){
     out.println("999");
    }

    catch(Exception ex){
     out.println("999");
    }

%>