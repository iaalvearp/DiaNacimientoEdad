<%-- 1. Importamos las clases de Java que necesitamos --%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.DayOfWeek"%>
<%@page import="java.time.Period"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%-- 2. Este es el bloque de lógica Java (Scriptlet) --%>
<%
    // Ponemos valores por defecto
    String fechaTexto = "";
    String resultadoDia = "";
    String resultadoEdad = "";
    String error = "";

    // Obtenemos la fecha que el usuario envió desde el formulario
    // Es el reemplazo de tu "Scanner"
    fechaTexto = request.getParameter("fechaNacimiento");

    // Solo ejecutamos la lógica si el usuario ya envió una fecha
    if (fechaTexto != null && !fechaTexto.isEmpty()) {
        try {
            // Convertir texto a fecha (misma lógica que tenías)
            LocalDate fechaNacimiento = LocalDate.parse(fechaTexto);

            // Calcular día de la semana
            DayOfWeek diaSemana = fechaNacimiento.getDayOfWeek();

            // Traducir manualmente el día al español
            String[] dias = {
                "lunes", "martes", "miércoles", "jueves", "viernes", "sábado", "domingo"
            };
            String diaEnEspanol = dias[diaSemana.getValue() - 1];

            // Calcular edad actual
            LocalDate hoy = LocalDate.now();
            Period edad = Period.between(fechaNacimiento, hoy);

            // Preparar los resultados para mostrarlos en el HTML
            resultadoDia = "Naciste un " + diaEnEspanol + ".";
            resultadoEdad = "Tienes " + edad.getYears() + " años, "
                                    + edad.getMonths() + " meses y "
                                    + edad.getDays() + " días.";

       } catch (Exception e) {
            // Manejo de error si pone una fecha mal
            error = "Formato incorrecto. Usa el formato AAAA-MM-DD.";
       }
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Calculadora de Edad</title>
        <style>
            body { font-family: sans-serif; display: grid; place-items: center; min-height: 20vh; background-color: #f4f4f4; }
            div { background: #fff; padding: 2rem; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); }
            input, button { font-size: 1.2rem; padding: 8px; margin: 5px; }
            h2 { color: #0056b3; }
            p.error { color: #d93025; }
        </style>
    </head>
    <body>
        
        <div>
            <h1>Tu Calculadora de Nacimiento y Edad</h1>

            <form method="get" action="index.jsp">
                <label for="fecha">Ingresa tu fecha de nacimiento:</label>
                <input type="date" id="fecha" name="fechaNacimiento" required>
                <button type="submit">Calcular</button>
            </form>

            <hr>

            <%-- La etiqueta <%= ... %> imprime el valor de una variable Java --%>
            
            <h2><%= resultadoDia %></h2>
            <h3><%= resultadoEdad %></h3>
            
            <%-- Mostramos el error si existe --%>
            <% if (!error.isEmpty()) { %>
                <p class="error"><%= error %></p>
            <% } %>
            
        </div>
        
    </body>
</html>
