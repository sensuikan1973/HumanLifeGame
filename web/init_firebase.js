if(window.location.hostname === 'localhost'){
  const firebaseConfig = {
     apiKey: "AIzaSyC__1zDF8-3wqj6-6srMTkNbRPYQzD52B4",
     authDomain: "human-life-game-dev.firebaseapp.com",
     databaseURL: "https://human-life-game-dev.firebaseio.com",
     projectId: "human-life-game-dev",
     storageBucket: "human-life-game-dev.appspot.com",
     messagingSenderId: "273276530293",
     appId: "1:273276530293:web:fcadec7fa9ba2f159ad23c",
     measurementId: "G-P10ZHWT57Q"
  };
  firebase.initializeApp(firebaseConfig);
} else {
  fetch("/__/firebase/init.json").then( res => res.json() ).then( json => {
   firebase.initializeApp(json);
  });
}

firebase.analytics();
// See: https://firebase.google.com/docs/auth/web/auth-state-persistence
// See: https://github.com/FirebaseExtended/flutterfire/issues/1714
// firebase.auth().setPersistence(firebase.auth.Auth.Persistence.LOCAL);
