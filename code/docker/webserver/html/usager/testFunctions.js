
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
    const div = document.getElementById('edit_pan');
    const span  = div.firstElementChild;

    axios.get("http://localhost:8888/api/viewer" , {
        headers: {
            'Authorization': 'Bearer ' + keycloak.token
        }
    })

        .then(function (response){
          
            document.getElementById('in_author').hidden=true;
            document.getElementById('in_title').hidden=true;
            document.getElementById('add_btn').hidden=true;
            document.getElementById('in_editor').hidden=true;
            document.getElementById('in_isbn').hidden=true;
            document.getElementById('in_url').hidden=true;
            document.getElementById('in_language').hidden=true;
            document.getElementById('in_class').hidden=true;
            document.getElementById('in_BookID').hidden=true;
            document.getElementById('delete_btn').hidden=true;

        })

        .catch(function (error){
            alert("Il y a un bug");

        })





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

        })
        .catch(function (error){
            alert("error en loadant edit mode");
        });


}

