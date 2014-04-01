<%-- 
    Document   : login02
    Created on : Dec 30, 2013, 1:18:26 PM
    Author     : rafa
--%>
<%@page import="net.daw.bean.UsuarioBean"%>
<% UsuarioBean oUsuario = (UsuarioBean) request.getSession().getAttribute("usuarioBean"); %>
<% if (oUsuario==null){ %>
    <h1>Vd. no ha entrado en el sistema</h1>
    <h4>Ha habido un problema con su autenticación. Revise su login o su password.</h4>
<% } else { %>
    <h1>Vd. ha entrado en el sistema</h1>
    <h4>Bienvenido, <%=oUsuario.getLogin() %>. Ahora puede operar con los menús de la aplicación.</h4>
<% } %>
