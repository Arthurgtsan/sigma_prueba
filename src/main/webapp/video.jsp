<!DOCTYPE html>
<html lang='en'>
<head>
 <meta charset='utf-8' />

<style type="text/css">
  body {
    margin: 0; /* Elimina el margen predeterminado del cuerpo */
    display: flex;
    align-items: center;
    justify-content: center;
    height: 100vh;
  }
  #videoContainer {
    width: 80%; /* Ancho del contenedor de video */
    height: auto; /* Altura automática según el ancho */
    position: relative; /* Establece la posición relativa para que el botón se pueda posicionar de forma absoluta dentro de este contenedor */
  }
  #cerrarVentana {
    position: absolute; /* Posición absoluta dentro del contenedor de video */
    bottom: 10px; /* 10px de margen desde la parte inferior */
    right: 10px; /* 10px de margen desde la derecha */
  }
</style>

</head>
<body>

<div id="videoContainer">
  <video width="100%" height="auto" controls>
    <source src="images/shp_sigma.mp4" type="video/mp4">
    Tu navegador no soporta el elemento de video.
  </video>
  <!-- Botón para cerrar la ventana -->
  <button id="cerrarVentana">Cerrar Video</button>
</div>

<script type='text/javascript'>
  window.resizeTo(1250,1050);

  // Obtener el botón de cerrar ventana por su ID
  var cerrarVentanaBtn = document.getElementById('cerrarVentana');

  // Agregar un controlador de eventos para el clic en el botón de cerrar ventana
  cerrarVentanaBtn.addEventListener('click', function() {
    // Cerrar la ventana actual
    window.close();
  });
</script>

</body>
</html>