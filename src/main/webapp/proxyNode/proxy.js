const http = require("http");
const httpProxy = require("http-proxy");

const proxy = httpProxy.createProxyServer({});

const server = http.createServer((req, res) => {
  console.log(`Solicitud recibida: ${req.method} ${req.url}`);

  proxy.web(req, res, { target: "http://example.com" }, (err) => {
    console.error("Error en el proxy:", err);
    res.writeHead(500);
    res.end("Error en el proxy");
  });
});

server.listen(3000, () => {
  console.log("Proxy corriendo en http://localhost:3000");
});
