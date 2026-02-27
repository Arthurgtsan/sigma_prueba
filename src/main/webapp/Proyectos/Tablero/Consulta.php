<html>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="es" xml:lang="es">
<head>
<title>INEGI - Subdireccion de Marco Geoestadistico</title>
 <meta http-equiv="Content-Style-Type" content="text/css" />
   <meta name="mgn"  content="text/html;" http-equiv="content-type" charset="latin1">
 
</head>
  <?php 
header('Content-Type: text/html; charset=UTF-8');
?>
<?PHP


	 $clave=$_GET["gid"];
  include("conexpg.php"); 
  $link=Conectarse(); 
    //$consulta = "select gid,numero,desc_cap,evidencia_cap,remitente,fecha_cap,  desc_sol,documento_sol,evidencia_sol,responsable,fecha_sol,solucion from tab_casos where gid='$clave'";
	$consulta = "select gid,numero,desc_cap,evidencia_cap,remitente,fecha_cap,  desc_sol,documento_sol,evidencia_sol,responsable,fecha_sol,solucion from tab_casos where gid=$clave;";
	$result=pg_query($link,$consulta);

	  while($row = pg_fetch_array($result)) { 
		$gid=$row[0];
		$numero=$row[1];		
		$desc_cap=$row[2];
		$evidencia_cap=$row[3];
		$remitente=$row[4];
		$fecha_cap=$row[5];
		
		$desc_sol=$row[6];
		$documento_sol=$row[7];
		$evidencia_sol=$row[8];
		$responsable=$row[9];
		$fecha_sol=$row[10];
		$solucion=$row[11];
  }
					if ($numero=='1'){			
			$numero='1. Predigitalizacion';
		}else if($numero=='2'){			
			$numero='2. Revision CU';
		}else if($numero=='3'){			
			$numero='3. SIGMA';
		}else if($numero=='4'){			
			$numero='4. Descargas a GDB';
		}else if($numero=='5'){			
			$numero='5. Validacion MGR';
		}else if($numero=='6'){			
			$numero='6. Censo Agrope 2022';
		}

			   if ($remitente=='1'){			
			$remitente='Ludim Castillo';
		}else if($remitente=='2'){			
			$remitente='Armando Parra';
		}else if($remitente=='3'){			
			$remitente='Antonio Vela';
		}else if($remitente=='4'){			
			$remitente='Neatil Ceballos';
		}
		
		
					   if ($responsable=='1'){			
			$responsable='Ludim Castillo';
		}else if($responsable=='2'){			
			$responsable='Armando Parra';
		}else if($responsable=='3'){			
			$responsable='Antonio Vela';
		}else if($responsable=='4'){			
			$responsable='Neatil Ceballos';
		}
		
		$gid = str_pad($gid, 3, '0', STR_PAD_LEFT);
		$archivoDesc = substr($evidencia_cap, -3);
		//$evidencia_cap = str_replace("%body%", "black", "<body text='%body%'>");
		
		//D:/Sitio/apps/wwwroot/
		//http://dc046068asdggma:8888/
		
		//$evidencia_capRem = str_replace("D:/Sitio/apps/wwwroot/", "http://dc046068asdggma:8888/",$evidencia_cap);
		$evidencia_capLink="http://dc046068asdggma:8888/Proyectos/Reporte_Casos/evidencia/".$evidencia_cap;
		$documento_solLink="http://dc046068asdggma:8888/Proyectos/Reporte_Casos/soluciones/".$documento_sol;
		$evidencia_solLink="http://dc046068asdggma:8888/Proyectos/Reporte_Casos/soluciones/".$evidencia_sol;
		
		$archivoDocDesc = substr($documento_sol, -4);
		$archivoDescSol = substr($evidencia_sol, -3);
		
		
		//echo $bodytag;

		
?>
<script language="javascript">
 var entidad = "<?php echo "$entidad"; ?>";
 



function datonum(e){
  key = (document.all) ? e.keyCode : e.which;
  if (key==8) return true;
  if (key < 48 || key > 57) return false;
}


function validaenviar(){

if (confirm("Los datos son correctos?")){
document.captura.submit();
}}


//var tot='';
//var val1='';




</script>

<?php
 //include("menu.include");
?>


<?PHP
$val='';
$fecha=(date("Y-m-d"));
$fecha2=(date("Y-m-d"));
//include("conex.php");
			

?>

<script language="javascript">



//alert("informacion");	

</script>


<!--<br><br>
<font color='red'>* Solo sera una captura unica</font>-->

<form enctype="multipart/form-data" name="captura" action="rep_capSol.php" method="post">
<!--<form enctype="multipart/form-data" name="captura" action="rep_capC.php" method="post">
-------------------------------------------------------------------------------------------------------> 


<table  align="center" border="1" cellpadding="0" cellspacing="0" width="55%"  bgcolor="#ECfafd"><tr><td>
<h1><CENTER CLASS=T><FONT FACE="arial" >Consulta<br></h1>
<CENTER>
<table border="0" align="center">


<table border="0" align="center">
  <td class=n2 align=lefth><FONT FACE="arial"  SIZE=4>Reporte No:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<INPUT type="text" NAME="report" class="input" readonly value="<?php echo $gid; ?> " >
  </td>
<tr>
  <td class=n2 align=lefth><FONT FACE="arial"  SIZE=4>Fecha de Captura:
<INPUT type="text" NAME="fecha_cap" class="input" readonly value="<?php echo $fecha_cap; ?> " >
  </td>
<tr>
  <td class=n2 align=lefth><FONT FACE="arial"  SIZE=4>Actividad:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<INPUT type="text" NAME="actividad" class="input" readonly value="<?php echo $numero; ?> " >
  </td>
<tr>
  <td  class=n2 align=lefth><FONT FACE="arial"  SIZE=4>Remitente:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<INPUT type="text" NAME="remit"  class="input" readonly value="<?php echo $remitente; ?> " >
  </td>
<tr>

<td class=n2 align=center>
<CENTER class=n2><FONT FACE="arial"  SIZE=4>Descripcion: 
</td>
<tr>
<td colspan="2" align=center>
<textarea id="descrip" name="descrip" rows="20" cols="120" readonly  placeholder="<?php echo $desc_cap; ?>" >
</textarea >
</td>
<tr>



<?php
 if($archivoDesc=='jpg'){
?>
<td colspan=1 align=lefth><br><FONT FACE="arial"  SIZE=4>Descargar Evidencia(<?php echo $gid; ?>.JPG):&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="<?php echo $evidencia_capLink; ?>" target="_blank"><FONT FACE="arial"  SIZE=4>Descargar</a>
<?php
 }else if($archivoDesc=='zip'){
?>
<td colspan=1 align=lefth><br><FONT FACE="arial"  SIZE=4>Descargar Evidencia(<?php echo $gid; ?>.ZIP):&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="<?php echo $evidencia_capLink; ?>" target="_blank"><FONT FACE="arial"  SIZE=4>Descargar</a>
<?php
 }else{
?>
<td colspan=1 align=lefth><br><FONT FACE="arial"  SIZE=4>Sin Evidencia para descargar</a>
<?php
 }
?>

</td>
<tr>
<td>
<h1><CENTER CLASS=T><FONT FACE="arial" >Respuesta<br></h1>
</td>
<tr>
  <td class=n2 align=lefth><FONT FACE="arial"  SIZE=4>Responsable:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<INPUT type="text" NAME="respons" class="input" readonly value="<?php echo $responsable; ?> " >
  </td>
<tr>
 <td class=n2 align=lefth><FONT FACE="arial"  SIZE=4>Fecha de Respuesta:
<INPUT type="text" NAME="fecha_sol" class="input" readonly value="<?php echo $fecha_sol; ?> " >
  </td>
<tr>

<td class=n2 align=center>
<CENTER class=n2><FONT FACE="arial"  SIZE=4>Descripcion de Solucion: 
</td>
<tr>
<td colspan="2" align=center>
<textarea id="solu" name="solu" rows="20" cols="120" readonly  placeholder="<?php echo $desc_sol; ?>" >
</textarea >
</td>
<tr>
<?php
 if($archivoDocDesc=='docx'){
?>
<td colspan=1 align=lefth><br><FONT FACE="arial"  SIZE=4>Descargar Evidencia Documento(<?php echo $gid; ?>.docx):&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="<?php echo $documento_solLink; ?>" target="_blank"><FONT FACE="arial"  SIZE=4>Descargar</a>
<?php
 }else{
?>
<td colspan=1 align=lefth><br><FONT FACE="arial"  SIZE=4>Sin Evidencia para descargar .docx</a>
<?php
 }
?>

<tr>


<?php
 if($archivoDescSol=='zip'){
?>
<td colspan=1 align=lefth><FONT FACE="arial"  SIZE=4><br>Descargar Evidencia Zip de Archivos(<?php echo $gid; ?>.ZIP):&nbsp;&nbsp;&nbsp;<a href="<?php echo $evidencia_solLink; ?>" target="_blank"><FONT FACE="arial"  SIZE=4>Descargar</a>
<?php
 }else{
?>
<td colspan=1 align=lefth><FONT FACE="arial"  SIZE=4><br>Sin Evidencia para descargar .zip</a>
<?php
 }
?>






<tr>




<td colspan=1 align=center>
<input class="input" name="fcap" cols=45 type="text" align=center value=<?PHP echo $fecha;?> style="visibility:hidden">
</td>
<tr>
<td colspan=1 align=center>

</td>
<tr>
<td colspan=1 align=lefth>
<A HREF="http://dc046068asdggma:8888/Proyectos/Reporte_Casos/Tablero.php"><FONT FACE="arial"  SIZE=4>Regresar...</a>
</td>
  <center><br>
</center>
</CENTER>

</form>

<!--------------------------------------------------------------------------------------------------------->
</tr>
</table><br><br></table><tr>
</body>
</html>