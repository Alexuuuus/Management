<%@page import="net.daw.bean.UsuarioBean"%>
<%UsuarioBean user = (UsuarioBean) request.getSession().getAttribute("usuarioBean");%>

<!DOCTYPE html>
<!--[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]> <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]> <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!-->
<html class="no-js">
    <!--<![endif]-->
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <title>Ajax Yield</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width">
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <style>
            body {
                padding-top: 60px;
                padding-bottom: 40px;
            }
        </style>
        <link rel="stylesheet" href="css/bootstrap-responsive.min.css">
        <link rel="stylesheet" href="css/main.css">
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
        <script>window.jQuery || document.write('<script src="js/vendor/jquery-1.10.2.min.js"><\/script>')</script>
        <script src="js/vendor/modernizr-2.6.2-respond-1.1.0.min.js"></script>
        <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css" />
        <script src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script>
        <script src="./js/vendor/jquery.validate.min.js"></script>

    </head>
    <body>
        <!--[if lt IE 7]>
        <p class="chromeframe">You are using an outdated browser. <a href="http://browsehappy.com/">Upgrade your browser today</a> or <a href="http://www.google.com/chromeframe/?redirect=true">install Google Chrome Frame</a> to better experience this site.</p>
        <![endif]-->


        <div class="navbar navbar-inverse navbar-fixed-top">
            <div class="navbar-inner">
                <div class="container-fluid">
                    <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse"> 
                        <span class="icon-bar"></span> 
                        <span class="icon-bar"></span> 
                        <span class="icon-bar"></span>
                    </a> 
                    <a class="brand" href="jsp">Ajax Stock</a>                   
                    <div class="nav-collapse collapse">
                        <%if (user != null) {%>
                        <jsp:include page="jsp/menuSuperior.jsp" />   
                        <% }%>
                        <jsp:include page="jsp/usuario/infologin.jsp" />                        
                    </div>
                </div>
            </div>
        </div>

        <div class="container-fluid">
            <div class="row-fluid">
                <%
                    if (user != null) {
                        out.print("<div class=\"span2\">");
                %>
                <jsp:include page="jsp/menuLateral.jsp" />
                <%
                        out.print("</div>");
                    }
                %>
                <%
                    if (user != null) {
                        out.print("<div class=\"span10\">");
                        out.print("<div id=\"indexContenido\"></div>");
                    } else {
                        out.print("<div class=\"span12\">");
                    }
                %>
                <div id="indexContenidoJsp">
                    <jsp:include page='<%=(String) request.getAttribute("contenido")%>' />                
                </div>
                <%
                    out.print("</div>");
                %>    
                <div class="row-fluid">
                    <div class="span12"><hr><footer><p>&copy; Rafael Aznar (2013)</p></footer></div>   
                </div>
            </div>
        </div>                    

        <!-- carga de javascript -->

        <script src="js/vendor/bootstrap.min.js"></script>

        <script src="js/vendor/bootstrap-transition.js"></script>
        <script src="js/vendor/bootstrap-alert.js"></script>
        <script src="js/vendor/bootstrap-modal.js"></script>
        <script src="js/vendor/bootstrap-dropdown.js"></script>
        <script src="js/vendor/bootstrap-scrollspy.js"></script>
        <script src="js/vendor/bootstrap-tab.js"></script>
        <script src="js/vendor/bootstrap-tooltip.js"></script>
        <script src="js/vendor/bootstrap-popover.js"></script>
        <script src="js/vendor/bootstrap-button.js"></script>
        <script src="js/vendor/bootstrap-collapse.js"></script>
        <script src="js/vendor/bootstrap-carousel.js"></script>
        <script src="js/vendor/bootstrap-typeahead.js"></script>    

        <script src="js/util.js" charset="UTF-8"></script>
        <script src="js/main.js" charset="UTF-8"></script>

        <script src="js/control/usuario.js" charset="UTF-8"></script>
        <script src="js/control/paciente.js" charset="UTF-8"></script>
        <script src="js/control/receta.js" charset="UTF-8"></script>
        <script src="js/control/consulta.js" charset="UTF-8"></script>
        <script src="js/control/historial.js" charset="UTF-8"></script>
        <script src="js/control/medico.js" charset="UTF-8"></script>
        <script src="js/control/medicamento.js" charset="UTF-8"></script>
        <script src="js/control/servicio.js" charset="UTF-8"></script>

        <script>

            $(document).ready(function() {
                inicializacion();

                $('#lnkUsuario').unbind('click');
                $('#lnkUsuario').click(function() {
                    var usuario = objeto('usuario', '<%=request.getContextPath()%>');
                    var usuarioView = vista(usuario, '<%=request.getContextPath()%>');

                    $('#indexContenidoJsp').empty();
                    $('#indexContenido').empty().append(usuarioView.getEmptyList());

                    var usuarioControl = control_usuario_list('<%=request.getContextPath()%>');
                    usuarioControl.inicia(usuarioView, 1, null, null, 10, null, null, null, null);
                    return false;
                });

                $('#lnkPaciente').unbind('click');
                $('#lnkPaciente').click(function() {
                    var paciente = objeto('paciente', '<%=request.getContextPath()%>');
                    var pacienteView = vista(paciente, '<%=request.getContextPath()%>');

                    $('#indexContenidoJsp').empty();
                    $('#indexContenido').empty().append(pacienteView.getEmptyList());

                    var pacienteControl = control_paciente_list('<%=request.getContextPath()%>');
                    pacienteControl.inicia(pacienteView, 1, null, null, 10, null, null, null, null);
                    return false;
                });

                $('#lnkConsulta').unbind('click');
                $('#lnkConsulta').click(function() {
                    var consulta = objeto('consulta', '<%=request.getContextPath()%>');
                    var consultaView = vista(consulta, '<%=request.getContextPath()%>');

                    $('#indexContenidoJsp').empty();
                    $('#indexContenido').empty().append(consultaView.getEmptyList());

                    var consultaControl = control_consulta_list('<%=request.getContextPath()%>');
                    consultaControl.inicia(consultaView, 1, null, null, 10, null, null, null, null);
                    return false;
                });

                $('#lnkReceta').unbind('click');
                $('#lnkReceta').click(function() {
                    var receta = objeto('receta', '<%=request.getContextPath()%>');
                    var recetaView = vista(receta, '<%=request.getContextPath()%>');

                    $('#indexContenidoJsp').empty();
                    $('#indexContenido').empty().append(recetaView.getEmptyList());

                    var recetaControl = control_receta_list('<%=request.getContextPath()%>');
                    recetaControl.inicia(recetaView, 1, null, null, 10, null, null, null, null);
                    return false;
                });

                $('#lnkHistorial').unbind('click');
                $('#lnkHistorial').click(function() {
                    var historial = objeto('historial', '<%=request.getContextPath()%>');
                    var historialView = vista(historial, '<%=request.getContextPath()%>');

                    $('#indexContenidoJsp').empty();
                    $('#indexContenido').empty().append(historialView.getEmptyList());

                    var historialControl = control_historial_list('<%=request.getContextPath()%>');
                    historialControl.inicia(historialView, 1, null, null, 10, null, null, null, null);
                    return false;
                });
                $('#lnkServicio').unbind('click');
                $('#lnkServicio').click(function() {
                    var servicio = objeto('servicio', '<%=request.getContextPath()%>');
                    var servicioView = vista(servicio, '<%=request.getContextPath()%>');

                    $('#indexContenidoJsp').empty();
                    $('#indexContenido').empty().append(servicioView.getEmptyList());

                    var servicioControl = control_servicio_list('<%=request.getContextPath()%>');
                    servicioControl.inicia(servicioView, 1, null, null, 10, null, null, null, null);
                    return false;
                });
                $('#lnkMedico').unbind('click');
                $('#lnkMedico').click(function() {
                    var medico = objeto('medico', '<%=request.getContextPath()%>');
                    var medicoView = vista(medico, '<%=request.getContextPath()%>');

                    $('#indexContenidoJsp').empty();
                    $('#indexContenido').empty().append(medicoView.getEmptyList());

                    var medicoControl = control_medico_list('<%=request.getContextPath()%>');
                    medicoControl.inicia(medicoView, 1, null, null, 10, null, null, null, null);
                    return false;
                });
                $('#lnkMedicamento').unbind('click');
                $('#lnkMedicamento').click(function() {
                    var medicamento = objeto('medicamento', '<%=request.getContextPath()%>');
                    var medicamentoView = vista(medicamento, '<%=request.getContextPath()%>');

                    $('#indexContenidoJsp').empty();
                    $('#indexContenido').empty().append(medicamentoView.getEmptyList());

                    var medicamentoControl = control_medicamento_list('<%=request.getContextPath()%>');
                    medicamentoControl.inicia(medicamentoView, 1, null, null, 10, null, null, null, null);
                    return false;
                });
            });

        </script>
    </body>
</html>

