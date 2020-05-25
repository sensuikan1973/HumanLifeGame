let config_url;
if(window.location.hostname === 'localhost'){
 config_url = "http://localhost:5000/__/firebase/init.json"
} else {
 config_url = "/__/firebase/init.json";
}
fetch(config_url).then( res => res.json() ).then( json => {
 firebase.initializeApp(json);
 firebase.analytics();
 // See: https://firebase.google.com/docs/auth/web/auth-state-persistence
 // See: https://github.com/FirebaseExtended/flutterfire/issues/1714
 // firebase.auth().setPersistence(firebase.auth.Auth.Persistence.LOCAL);
});
