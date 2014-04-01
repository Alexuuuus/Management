<%-- 
    Document   : login
    Created on : Jan 15, 2013, 11:54:03 AM
    Author     : rafa
--%>

<form id="loginForm" action="jsp" class="form-horizontal" method="post">
    <h1>Formulario de entrada al sistema</h1>
    <input type="hidden" name="ob" value="usuario" />
    <input type="hidden" name="op" value="login02" />
    <div class="control-group">
        <label class="control-label" for="inputLogin">Usuario:</label>
        <div class="controls">
            <input type="text" id="inputLogin" autofocus="autofocus" placeholder="Nombre de usuario" name="login">
        </div>
    </div>
    <div class="control-group">
        <label class="control-label" for="inputPassword">Password:</label>
        <div class="controls">
            <input type="password" id="inputPassword" placeholder="Password" name="password">
        </div>
    </div>
    <div class="control-group">
        <div class="controls">
            <button id="entrarBTN" type="submit" class="btn">Entrar</button>
        </div>
    </div>
</form>

