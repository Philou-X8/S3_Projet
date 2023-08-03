
function start(){
    initKeycloak();
    //editMode();

}


function requestStudent() {
    const div = document.getElementById('title');
    const span = div.firstElementChild;
    axios.get("http://localhost:8888/api/student", {
        headers: {
            'Authorization': 'Bearer ' + keycloak.token
        }
    })
        .then(function (response) {
            console.log("Response: ", response.status);
            span.innerHTML = '<br> <strong>' + response.data.cip + '</strong> </br>' +
                '<br> <strong>' + response.data.last_name + '</strong> </br>' +
                '<br> <strong>' + response.data.first_name + '</strong> </br>' +
                '<br> <strong>' + response.data.email + '</strong> </br>' +
                '<br> <strong>' + response.data.roles + '</strong> </br>'
        })
        .catch(function (error) {
            console.log('refreshing');
            keycloak.updateToken(5).then(function () {
                console.log('Token refreshed');
            }).catch(function () {
                console.log('Failed to refresh token');
            })
        });
    span.innerHTML = '<br> <strong>' + "Vous n'avez pas le role d'étudiant" + '</strong> </br>'
}

function requestTeacher() {
    const div = document.getElementById('title');
    const span = div.firstElementChild;
    axios.get("http://localhost:8888/api/teacher", {
        headers: {
            'Authorization': 'Bearer ' + keycloak.token
        }
    })
        .then(function (response) {
            console.log("Response: ", response.status);
            span.innerHTML = '<br> <strong>' + response.data.cip + '</strong> </br>' +
                '<br> <strong>' + response.data.last_name + '</strong> </br>' +
                '<br> <strong>' + response.data.first_name + '</strong> </br>' +
                '<br> <strong>' + response.data.email + '</strong> </br>' +
                '<br> <strong>' + response.data.roles + '</strong> </br>'
        })
        .catch(function (error) {
            console.log('refreshing');
            keycloak.updateToken(5).then(function () {
                console.log('Token refreshed');
            }).catch(function () {
                console.log('Failed to refresh token');
            })
        });
    span.innerHTML = '<br> <strong>' + "Vous n'avez pas le role d'enseignant" + '</strong> </br>'
}


function requestFuniButton() {
    const div = document.getElementById('title');
    const span = div.firstElementChild;
    axios.get("http://localhost:8888/api/getBook", {
        headers: {
            'Authorization': 'Bearer ' + keycloak.token
        }
    })
        .then(function (response) {
            console.log("Response: ", response.status);
            span.innerHTML = '<br> <strong>' + 'button clicked' + '</strong> </br>' +
                '<br> <strong>' + response.data.label + '</strong> </br>'
        })
        .catch(function (error) {
            console.log('refreshing');
            span.innerHTML = '<br> <strong>' + 'error with the button' + '</strong> </br>' +
                '<br> <strong>' + error.toString() + '</strong> </br>'
            keycloak.updateToken(5).then(function () {
                console.log('Token refreshed');
            }).catch(function () {
                console.log('Failed to refresh token');
            })
        });
    span.innerHTML = '<br> <strong>' + "Loading..." + '</strong> </br>'
}


function viewerMode() {



            document.getElementById('in_author').hidden=true;
            document.getElementById('in_title').hidden=true;
            document.getElementById('add_btn').hidden=true;
            document.getElementById('in_editor').hidden=true;
            document.getElementById('in_isbn').hidden=true;
            document.getElementById('in_url').hidden=true;
            document.getElementById('in_language').hidden=true;
            document.getElementById('in_class').hidden=true;
            document.getElementById('in_BookID').hidden=true;
            document.getElementById('delete_btn').hidden=true
            document.getElementById('in_date').hidden=true
            document.getElementById('in_format').hidden=true

}

function editMode() {

    axios.get("http://localhost:8888/api/editer", {
        headers: {
            'Authorization': 'Bearer ' + keycloak.token
        }
    })
        .then(function (response) {

            document.getElementById('in_author').hidden=false;
            document.getElementById('in_title').hidden=false;
            document.getElementById('add_btn').hidden=false;
            document.getElementById('in_editor').hidden=false;
            document.getElementById('in_isbn').hidden=false;
            document.getElementById('in_url').hidden=false;
            document.getElementById('in_language').hidden=false;
            document.getElementById('in_class').hidden=false;
            document.getElementById('in_BookID').hidden=false;
            document.getElementById('delete_btn').hidden=false;
            document.getElementById('in_date').hidden=false
            document.getElementById('in_format').hidden=false

        })
        .catch(function (error){
            alert("error en loadant edit mode");
        });
}

function selectBook(){
    document.getElementById('affichageImage').hidden=false;
    var table = document.getElementById('book_table');
    let row  = -1;
    for (let i=1;i<table.rows.length;i++){
        let radio = table.rows[i].cells[0].querySelector('input[type="radio"]');
        if(radio && radio.checked){
            row =i;
            break;

        }
    }


    if(row==-1){
        return
    }
    var title= table.rows[row].cells[1].innerHTML
    var isbn= table.rows[row].cells[3].innerHTML
    document.getElementById('Book_name_encadre').innerHTML = title;
    var img= document.getElementById('img')
    img.src = "../images/"+isbn+".jpg"
    img.style.height = 7*75+'px'
    img.style.width = 5*75+'px'


    axios.get("http://localhost:8888/api/getBookInfo/" + isbn, {
        headers: {
            'Authorization': 'Bearer ' + keycloak.token
        }
    })
        .then(function (response) {
            console.log("Response: ", response.status);

            document.getElementById('isbn_field').innerHTML = response.data.isbn_label;
            document.getElementById('date_field').innerHTML = response.data.date_label;
            document.getElementById('url_field').innerHTML = '<a href="' + response.data.url_label + '" target="_blank">COOP</a>'; //response.data.url_label;
            document.getElementById('author_field').innerHTML = response.data.author_label;
            document.getElementById('editor_field').innerHTML = response.data.editor_label;
            document.getElementById('domain_field').innerHTML = response.data.field_label;
            document.getElementById('format_field').innerHTML = response.data.format_label;
            document.getElementById('language_field').innerHTML = response.data.language_label;
            document.getElementById('program_field').innerHTML = response.data.program_label;
            document.getElementById('type_field').innerHTML = response.data.typeformat_label;
            document.getElementById('sigle_field').innerHTML = response.data.sigle_label;
            document.getElementById('ap_field').innerHTML = response.data.ap_label;

        })
        .catch(function (error) {
            console.log('refreshing');
            span.innerHTML = '<br> <strong>' + 'error with the button: ' + error.toString() + '</strong> </br>'
            keycloak.updateToken(5).then(function () {
                console.log('Token refreshed');
            }).catch(function () {
                console.log('Failed to refresh token');
            })
        });


}
