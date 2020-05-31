if(window.location.hostname === 'localhost'){
 firebase.initializeApp({
    apiKey: "AIzaSyC__1zDF8-3wqj6-6srMTkNbRPYQzD52B4",
    appId: "1:273276530293:web:fcadec7fa9ba2f159ad23c",
    authDomain: "human-life-game-dev.firebaseapp.com",
    databaseURL: "https://human-life-game-dev.firebaseio.com",
    measurementId: "G-P10ZHWT57Q",
    messagingSenderId: "273276530293",
    projectId: "human-life-game-dev",
    storageBucket: "human-life-game-dev.appspot.com"
 });
} else {
  fetch("/__/firebase/init.json").then( res => res.json() ).then( json => {
   firebase.initializeApp(json);
  });
}

firebase.analytics();
// See: https://firebase.google.com/docs/auth/web/auth-state-persistence
// See: https://github.com/FirebaseExtended/flutterfire/issues/1714
// firebase.auth().setPersistence(firebase.auth.Auth.Persistence.LOCAL);
