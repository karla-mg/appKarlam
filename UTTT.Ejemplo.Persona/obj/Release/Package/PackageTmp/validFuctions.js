
function maxValid() {
    var fields = [
        "txtClaveUnica"];
    for (i = 0; i < fields.length; i++) {
        document.getElementById(fields[i]).maxLength = 3;
    }
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


}