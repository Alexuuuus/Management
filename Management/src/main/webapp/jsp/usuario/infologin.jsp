
<%-- 
    Document   : infologin
    Created on : Jan 19, 2013, 9:28:49 AM
    Author     : rafa
--%>
<%@page import="net.daw.bean.UsuarioBean"%>
<%UsuarioBean user = (UsuarioBean) request.getSession().getAttribute("usuarioBean");%>                   
<p class="navbar-text pull-right">           
    <%if (user != null) {%>
    <%
        String us = user.getLogin();
        String usuario = us.substring(0, 1).toUpperCase() + us.substring(1);
    %>
    Estás logueado como <%=usuario%> / <%=user.getTipoUsuario()%>&nbsp;&nbsp;&nbsp;&nbsp;
    <a class="navbar-link" href="jsp?ob=usuario&op=logout">(Salir del sistema)</a>
    <%} else {%>
    <a class="navbar-link" href="jsp?op=login01&ob=usuario">Login</a>
    <%}%>
</p>