
function calculateAge() {
    var d = document.getElementById("txtFecha").value;
    var inDate = new Date(d);
    var anio = inDate.getFullYear();
    var fec_actual = new Date();
    var fec_anio = fec_actual.getFullYear();
    var edad = fec_anio - anio;
    if (edad < 18) {
        document.getElementById("result2").innerHTML = "Tu edad debe ser mayor a 18 años";
        return false;
    }
}