const express = require("express");
//const fetch = require("node-fetch"); // Si usas Node.js < 18
const stream = require("stream"); // Para manejar el stream
const util = require("util");
const pipeline = util.promisify(stream.pipeline); // Promisificar pipeline para usar async/await

const app = express();
const PORT = 3000;

app.get("/wms", async (req, res) => {
  const { token, a_id } = req.query;

  if (!token) {
    return res.status(401).json({ error: "Token no proporcionado" });
  }

  if (!a_id) {
    return res.status(400).json({ error: "Falta el parámetro a_id" });
  }

  const queryString = new URLSearchParams(req.query).toString();
  let wmsUrl = `${a_id}?${queryString.replace("token=" + token, "")}`;

  //console.log(`Redirigiendo a: ${wmsUrl}`);

  try {
    const response = await fetch(wmsUrl, {
      method: "GET",
      headers: {
        "Authorization": `Bearer ${token}`,
        "Connection": "keep-alive"
      }
    });

    if (!response.ok) {
      return res.status(response.status).json({ error: `Error al obtener la imagen WMS: ${response.statusText}` });
    }

    // Redirigir encabezados CORS
    res.set("Access-Control-Allow-Origin", "*");
    res.set("Access-Control-Allow-Methods", "GET");
    res.set("Access-Control-Allow-Headers", "Authorization, Content-Type");

    // Usar stream.pipeline para redirigir el contenido de la respuesta al cliente
    await pipeline(response.body, res);
  } catch (err) {
    console.error("Error al obtener la imagen WMS:", err);
    return res.status(500).json({ error: `Error al obtener la imagen WMS: ${err.message}` });
  }
});

app.listen(PORT, () => {
  console.log(`Servidor proxy corriendo en http://localhost:${PORT}`);
});
