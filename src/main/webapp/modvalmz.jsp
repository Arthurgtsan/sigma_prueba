<%@ page import="java.util.*" session="true" %>
<%@ page import="java.sql.*"%>
<%

String  id = request.getParameter("id");
String  val = request.getParameter("val");
String  cgo = request.getParameter("cgo");
String  cons = request.getParameter("cons");
String tipo = request.getParameter("tipoval");
String tipote = request.getParameter("tipote");
String consulta="";
String base="";
HttpSession sesion = request.getSession(false);
String remotehost  = session.getAttribute("remotehost").toString();
try {
  Calendar fecha = Calendar.getInstance();
  String m1="",d1="",fec1="",fec2="",filreg="",selreg="";
  if (fecha.get(Calendar.MONTH)<9)m1="0";   // supongo que el mes empieza por 0
  if (fecha.get(Calendar.DATE)<10)d1="0";
  fec1=fecha.get(Calendar.YEAR) + "-" + m1 + (fecha.get(Calendar.MONTH)+1) + "-" + d1 + fecha.get(Calendar.DATE);



	if (tipote.equals("TEF")){
		base="te_mza_coord_fr";
	}else if (tipote.equals("TEM")){
		base="te_mza";
	}else{
    base="te_mza_cd";
  }
  if (tipo.equals("R")){
    if (val.equals("N")){
        consulta = "Update "+base+" set vreg='N',usre=NULL,fvre=NULL where oid="+id;
    }else if (val.equals("S")){
        consulta = "Update "+base+" set vreg='S',usre="+cons+",fvre=current_date where oid="+id;
    }else{
        consulta = "Update "+base+" set vreg='R',usre="+cons+",fvre=current_date where oid="+id;
    }
  }else{
      if (val.equals("N")){
        consulta = "Update "+base+" set voc='N',usoc=NULL,fvoc=NULL where oid="+id;
    }else if (val.equals("S")){
        consulta = "Update "+base+" set voc='S',usoc="+cons+",fvoc=current_date where oid="+id;
    }else{
        consulta = "Update "+base+" set voc='R',usoc="+cons+",fvoc=current_date where oid="+id;
    }
}
      ResultSet rs = null;
      Statement str = null;
      Connection conexion = null;
      Class.forName("org.postgresql.Driver");
      String hostbd  = session.getAttribute("hostbd").toString();
      String remotehostbd  = session.getAttribute("remotehostbd").toString();
      conexion = DriverManager.getConnection("jdbc:postgresql://"+remotehostbd+":5434/"+hostbd,"actcar","actcar");
    str = conexion.createStatement(rs.TYPE_SCROLL_SENSITIVE, rs.CONCUR_UPDATABLE);
    str.executeUpdate( consulta );
    str.close();
    conexion.close();
    out.println("y");
    }
    catch (SQLException ex){
      out.println("x");
  }
      catch(Exception ex){
        out.println("x");
    }

%>
