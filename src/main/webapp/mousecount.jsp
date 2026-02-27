<%@ page import="java.util.*" session="true" %>
<%@ page import="java.sql.*"%>
<%
HttpSession sesion = request.getSession(true);
if ((sesion != null && !sesion.isNew())) {
        //out.println("LA SESION SIGUE ACTIVA");
        String remotehost  = session.getAttribute("remotehost").toString();
        String regionalid  = session.getAttribute("regionalid").toString();
        out.println("1");
    }else{
        out.println("0");
    }
%>