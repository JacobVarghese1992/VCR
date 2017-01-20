// Give the service worker access to Firebase Messaging.
// Note that you can only use Firebase Messaging here, other Firebase libraries
// are not available in the service worker.
importScripts('https://www.gstatic.com/firebasejs/3.5.2/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/3.5.2/firebase-messaging.js');

    // Initialize Firebase
var config = {
      apiKey: "AIzaSyBeCK7L0N6njG4RbNSQGyPT14ZvNW57X2E",
      authDomain: "medimailhub.firebaseapp.com",
      databaseURL: "https://medimailhub.firebaseio.com",
      storageBucket: "medimailhub.appspot.com",
      messagingSenderId: "916203777994"
    };
firebase.initializeApp(config);


const messaging = firebase.messaging();