const express = require("express");
const stream = require("stream");
const util = require("util");
const pipeline = util.promisify(stream.pipeline);
const app = express();
const PORT = 3001;

// TU TOKEN y asset_id (puedes actualizarlos dinámicamente si quieres)

 //const token = 'eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICIxMThSRENzZTlqUWR4UVRnSkt2ZXlvSHBaaWE4R0pIVEU5RjJPSmE1M3N3In0.eyJleHAiOjE3NTQ1OTI2NjEsImlhdCI6MTc1NDU4OTA2MSwianRpIjoib25ydG5hOjU0ZmVkNjRiLWM1YjAtNGVlOS1iMDZhLTUyY2Y1NmU3MDIzZCIsImlzcyI6Imh0dHBzOi8vYXV0aGVudGljYXRlLmZvdW5kYXRpb24uYXBpLm9uZWF0bGFzLmFpcmJ1cy5jb20vYXV0aC9yZWFsbXMvSURQIiwiYXVkIjoiSURQIiwidHlwIjoiQmVhcmVyIiwiYXpwIjoiSURQIiwic2lkIjoiOWIzZDZkOWYtYzg1ZC00NzMyLThiY2QtZWJmYjJhYjdkZDU0IiwiYWNyIjoiMSIsInNjb3BlIjoiIiwibmJmIjowLCJyb2xlIjoie1wiZ2VvLmFwcC5vYWRcIjpbXCJ1c2VyXCJdLFwiZ2VvLmlkcC5ub3RpZnlcIjpbXCJ1c2VyXCJdLFwiZ2VvLmFwcC5iYXNlbWFwXCI6W1widXNlclwiXSxcImdlby5pZHAuZGF0YXN0b3JlXCI6W1widXNlclwiXX0iLCJyb2xlcyI6eyJnZW8uYXBwLm9hZCI6WyJ1c2VyIl0sImdlby5pZHAubm90aWZ5IjpbInVzZXIiXSwiZ2VvLmFwcC5iYXNlbWFwIjpbInVzZXIiXSwiZ2VvLmlkcC5kYXRhc3RvcmUiOlsidXNlciJdfSwic3VpZCI6IjE4NjEzMjI4NzEiLCJ1dWlkIjoiNjM5MzA5MWQtYTc2YS00ZTk5LTY4NDktODY3YTUzNTMxNDVlIiwibG9hIjoxMDB9.678dvwGrGYvwoDRjgCpiVF1JvGG3lx2C1Fx-eExpNvz6Wkj3rlHW0ebkRwam0qCt-WG8S_UcbHC6sA4jazLawvnGuVj0R6kpF70Qb5G3aoeG5F6NaTN3Se-wUoNj6lWU2_SG-HDXM6vxdxNuUT7iVYViOo-O63UvPmIxNJDbFfLkC4mjk9oOvRgf7uzGGxpUGHyx-_kkASdYbS1KsuWcR8pQRLg23d0Ty6vq5kyTZHbG_aVsPkgHN1gUNr-H2XNonjAyXBAGtfNUvJIbMv1KKRqi8hfO61iZNJVoLNEwIB8McTx0jlNmNLYP4vnyozXPlk5KnxppENX6PZTbnyV7rQ';
// const asset_id = '7ba5ab08-221c-48a6-b210-a54177e4f5e2';
const blankPng = Buffer.from(
  "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAEklEQVR4nGMAAQAABQABDQottAAAAABJRU5ErkJggg==",
  "base64"
);


app.get('/wmts/tiles/:asset_id/:token/1.0.0/default/rgb/EPSG3857/:z/:x/:y.png', async (req, res) => {
  const { asset_id,token, z, x, y } = req.params;

  // Construimos la URL RESTful a Airbus
  const airbusUrl = `https://access.foundation.api.oneatlas.airbus.com/api/v1/items/${asset_id}/wmts/tiles/1.0.0/default/rgb/EPSG3857/${z}/${x}/${y}.png`;

  try {
    const response = await fetch(airbusUrl, {
      headers: {
        Authorization: `Bearer ${token}`
      }
    });

     if (!response.ok || !response.body) {
      //return res.status(response.status).json({ error: `Error Airbus: ${response.statusText}` });
		
      //console.warn(`Tile no disponible z=${z}, x=${x}, y=${y}, status: ${response.status}`);
     // Enviar imagen PNG transparente
      res.set("Content-Type", "image/png");
      return res.status(200).send(blankPng);

    }

    res.set("Content-Type", "image/png");
    await pipeline(response.body, res);

  } catch (err) {
    console.error("Error al solicitar tile:", err.message);
    res.status(500).json({ error: err.message });
  }
});

app.listen(PORT, () => {
  console.log(`Proxy corriendo en http://localhost:${PORT}`);
});


