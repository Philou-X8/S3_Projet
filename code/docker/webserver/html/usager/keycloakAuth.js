var keycloak;

function initKeycloak() {
    keycloak = new Keycloak({
        "realm": "usager",
        "auth-server-url": "http://localhost:8180/",
        "ssl-required": "external",
        "clientId": "frontend",
        "public-client": true,
        "confidential-port": 0
    });
    keycloak.init({onLoad: 'login-required'}).then(function (authenticated) {
        //alert(authenticated ? 'authenticated' : 'not authenticated');

    }).catch(function () {
        alert('failed to initialize');
    });
}



function logout() {
    //   let logoutURL = "http://localhost:8080//realms/usager/protocol/openid-connect/logout"
    //   window.location.href = logoutURL;
}