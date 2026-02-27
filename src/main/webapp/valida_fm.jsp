<%@ page import="java.util.*" session="true" %>
<%@ page import="java.sql.*"%>
<%
//String tip=request.getParameter("tipo");
//int  tipo = Integer.parseInt(tip);

String  cve = request.getParameter("cve");
String  baseimg = request.getParameter("baseimg");
String  iduser = request.getParameter("iduser");
String  escala = request.getParameter("escala");
HttpSession sesion = request.getSession(false);
String remotehost  = session.getAttribute("remotehost").toString();
try {
String consulta1="";
String consulta2="";
if (baseimg==null)baseimg="";
if (iduser==null)iduser="0";

      consulta2 = "select a_revisa_fm('"+cve+"','"+baseimg+"','"+iduser+"','"+escala+"')";
      Statement str = null;
      ResultSet rs = null;
      Connection conexion = null;
      Class.forName("org.postgresql.Driver");
      String hostbd  = session.getAttribute("hostbd").toString();
      String remotehostbd  = session.getAttribute("remotehostbd").toString();
      conexion = DriverManager.getConnection("jdbc:postgresql://"+remotehostbd+":5434/"+hostbd,"actcar","actcar");
      str = conexion.createStatement(rs.TYPE_SCROLL_SENSITIVE, rs.CONCUR_UPDATABLE);
      rs = str.executeQuery( consulta2 );
      rs.next();
      String resp  = rs.getObject(1).toString();
      str.close();
      conexion.close();
      out.println(resp);
    }
   catch (SQLException ex){
     out.println("1");
    }

    catch(Exception ex){
     out.println("1");
    }

%>