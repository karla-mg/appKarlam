
function camposValid() {

    var  clave, nombre, aPaterno, aMaterno, correo, cp, rfc;
    clave = document.getElementById("txtClaveUnica").value;
    nombre = document.getElementById("txtNombre").value;
    aPaterno = document.getElementById("txtAPaterno").value;
    aMaterno = document.getElementById("txtAMaterno").value;
    correo = document.getElementById("txtCorreo").value;
    cp = document.getElementById("txtCP").value;
    rfc = document.getElementById("txtRFC").value;
    
    if (nombre == '' && aPaterno == '' && aMaterno == '' && sexo == 0) {
        alert("INGRESE TODOS LOS CAMPOS");
        return false;
    }


if (clave == '') {
    document.getElementById("lblMensaje").innerHTML = "Ingresar clave Unica";
        return false;
    }
    
    
    if (nombre == '') {
        document.getElementById("lblMensaje").innerHTML = "Agrega Tu Nombre Completo";
        return false;
    }

    if (aPaterno == '') {
        document.getElementById("lblMensaje").innerHTML = "Agregue el Apellido Paterno";
        return false;
    }
if (aMaterno == '') {
    document.getElementById("lblMensaje").innerHTML = "Agregue Apellido Materno";
    return false;
    }

    if (correo == '') {
        document.getElementById("lblMensaje").innerHTML = "Agregue E-Mail";
        return false;
    }

    if (cp == '') {
        document.getElementById("lblMensaje").innerHTML = "Agregue Código Postal";
        return false;
    }
    if (rfc == '') {
        document.getElementById("result8").innerHTML = "Agregue RFC";
        return false;
    }
    return true;


}  
