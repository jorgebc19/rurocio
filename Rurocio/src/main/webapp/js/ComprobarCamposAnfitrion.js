
function comprobarCamposNoVacios() {
    var login = document.getElementsByName("login").value;
    var name = document.getElementById("name").value;
    var email = document.getElementById("email").value;
//    dejo nif porque el id sigue siendo nif (para que no afecte al css)
    var cif = document.getElementById("nif").value;
    var pwd = document.getElementById("pwd").value;
    var pwd2 = document.getElementById("pwd2").value;
    
    console.log("login :  " + login);
    console.log("name :  " + name);
    console.log("email :  " + email);
    console.log("cif :  " + cif);
    console.log("pwd :  " + pwd);
    console.log("pwd2 :  " + pwd2);


    if (login === "" || name === "" || email === "" || cif === "" ||
            pwd === "" || pwd2 === "" ) {
        alert("Alguno de los campos no se ha rellanado correctamente. Por favor, rellene todos los campos");
    }
    
    if (pwd !== pwd2) {
        alert("La contraseña debe ser igual en ambos campos");
    }
}