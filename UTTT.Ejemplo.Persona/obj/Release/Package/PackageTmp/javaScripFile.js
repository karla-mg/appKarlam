function camposValid() {

    var sexo, nombre, clave, aPaterno, aMaterno;
    sexo = document.getElementById("ddlSexo").value;
    clave = document.getElementById("txtClaveUnica").value;
    nombre = document.getElementById("txtNombre").value;
    aPaterno = document.getElementById("txtAPaterno").value;
    aMaterno = document.getElementById("txtAMaterno").value;

    var fields = [
        "txtClaveUnica"];
    for (i = 0; i < fields.length; i++) {
        document.getElementById(fields[i]).maxLength = 3;
    }
    var fieldsNom = [
        "txtNombre"];
    for (i = 0; i > fields.length; i++) {
        document.getElementById(fields[i]).minLength = 3;
    }
    if (nombre == '' && aPaterno == '' && aMaterno == '' && sexo == 0) {
        alert("INGRESE TODOS LOS CAMPOS");
        return false;
    }

    if (clave == '') {
        document.getElementById("result1").innerHTML = "Ingresar clave Unica";
        return false;
    }
    if (fields == '') {
        var claveU = document.getElementById("txtClaveUnica");
        claveU.parentNode.innerHTML = claveU1.parentNode.innerHTML + "<p style='color:red'>La Clave Única solo debe contener 3 números</p>";
        var maxLength = document.getElementById("maxLength");

        var Max_Length = 3;
        var length = document.getElementById("txtClaveUnica").value.length;
        if (length > Max_Length) {
            var claveU = document.getElementById("txtClaveUnica");
            claveU.parentNode.innerHTML = claveU.parentNode.innerHTML + "<p style='color:red'>El máximo es de caracteres: " + Max_Length + " se alcanza el numero de  " + length + "characters</p>";
        }
        var claveU = document.getElementById("txtClaveUnica");
        claveU.onkeyup = validateMaxLength(e);
        return false;
    }
    if (fieldsNom == '') {
        var nombreM = document.getElementById("txtNombre");
        nombreM.parentNode.innerHTML = nombreM1.parentNode.innerHTML + "<p style='color:red'>La Clave Única  debe contener mas de 3 números</p>";
        var minLength = document.getElementById("minLength");

        var Min_Length = 3;
        var length = document.getElementById("txtNombre").value.length;
        if (length > Max_Length) {
            var nombreM = document.getElementById("txtNombre");
            nombreM.parentNode.innerHTML = nombreM.parentNode.innerHTML + "<p style='color:red'>El máximo es de caracteres: " + Min_Length + " se alcanza el numero de  " + length + "characters</p>";
        }
        var nombreM = document.getElementById("txtClaveUnica");
        nombreM.onkeyup = validateMinLength(e);
        return false;
    }
    if (nombre == '') {
        document.getElementById("result3").innerHTML = "Agrega Tu Nombre Completo";
        return false;
    }

    if (aPaterno == '') {
        document.getElementById("result4").innerHTML = "Agregue el Apellido Paterno";
        return false;
    }
    if (aMaterno == '') {
        document.getElementById("result5").innerHTML = "Agregue Apellido Materno";

        return false;
    }
    


    return true;




}  
