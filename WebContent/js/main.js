function search() {
    let input, filter, ul, li, a, i, txtValue;
    input = document.getElementById("myInput");
    filter = input.value.toUpperCase();
    ul = document.getElementById("myUL");
    li = ul.getElementsByTagName("li");
    for (i = 0; i < li.length; i++) {
        a = li[i].getElementsByTagName("a")[0];
        txtValue = a.textContent || a.innerText;
        if (txtValue.toUpperCase().indexOf(filter) > -1) {
            li[i].style.display = "";
        } else {
            li[i].style.display = "none";
        }
    }
}

function passwordCheck () {
    if (document.getElementById('psw').value ===
        document.getElementById('pswConfirmation').value) {
        document.getElementById('message').style.color = 'green';
        document.getElementById('message').innerHTML = 'Passwords Match';
    } else {
        document.getElementById('message').style.color = 'red';
        document.getElementById('message').innerHTML = "Passwords Don't Match!";
    }
}

function showPassword() {
    const x = document.getElementById("psw");
    if (x.type === "password") {
        x.type = "text";
    } else {
        x.type = "password";
    }
}

function showPasswordWithConfirmation() {
    const x = document.getElementById("psw");
    const y = document.getElementById("pswConfirmation");
    if (x.type === "password") {
        x.type = "text";
        y.type = "text";
    } else {
        x.type = "password";
        y.type = "password";
    }
}