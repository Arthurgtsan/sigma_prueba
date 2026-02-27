var xmlhttp;

function ejecutarvalidacion(capa, filtro)
{
 xmlhttp=GetXmlHttpObject();

  if (xmlhttp==null)
  {
   alert ("Tu navegador no soporta Ajax HTTP");
   return;
  }

    var url="valida.jsp?capa="+capa+"&filtro="+filtro;
    //xmlhttp.onreadystatechange=getOutput;
    xmlhttp.open("GET",url,true);
    xmlhttp.send(null);
}

/*function getOutput()   //con esto puedo regresar algun resultado
{
  if (xmlhttp.readyState==4)
  {
  document.getElementById("prtCnt").innerHTML=xmlhttp.responseText;
  }
}
*/

function GetXmlHttpObject()
{
    if (window.XMLHttpRequest)
    {
       return new XMLHttpRequest();
    }
    if (window.ActiveXObject)
    {
      return new ActiveXObject("Microsoft.XMLHTTP");
    }
 return null;
}