// Initialize an OpenTok Session object
var session = TB.initSession(sessionId);

// Initialize a Publisher, and place it into the element with id="publisher"
var publisher = TB.initPublisher(apiKey, 'publisher');
var msgHistory = document.querySelector('#history');
var quesHistory = document.querySelector('#questionHistory');
subscriber = null;
// Attach event handlers
session.on({

  // This function runs when session.connect() asynchronously completes
  sessionConnected: function(event) {
    // Publish the publisher we initialzed earlier (this will trigger 'streamCreated' on other
    // clients)
    // publisher.publishVideo(false) 
    session.publish(publisher);
    publisher.publishVideo(false);
    



  },

  // This function runs when another client publishes a stream (eg. session.publish())
  streamCreated: function(event) {
    // Create a container for a new Subscriber, assign it an id using the streamId, put it inside
    // the element with id="subscribers"
    var subContainer = document.createElement('div');
    subContainer.id = 'stream-' + event.stream.streamId;
    document.getElementById('subscribers').appendChild(subContainer);

    // Subscribe to the stream that caused this event, put it inside the container we just made
    subscriber = session.subscribe(event.stream, subContainer);
  }
});

session.on('signal:msg', function(event) {
    console.log("Message Recieved");
    var msg = document.createElement('p');
    msg.innerHTML = event.data;
    msg.className = event.from.connectionId === session.connection.connectionId ? 'mine' : 'theirs';
    msgHistory.appendChild(msg);
    msg.scrollIntoView();
  });

session.on('signal:stop', function(event) {
    console.log("Message Recieved");
    publisher.publishVideo(false);
    publisher.publishAudio(false);
  });

session.on('signal:start', function(event) {
    console.log("Message Recieved");
    publisher.publishVideo(true);
    publisher.publishAudio(true);
  });

session.on('signal:ques', function(event) {
    var msg = document.createElement('p');
    msg.innerHTML = event.data;
    msg.className = event.from.connectionId === session.connection.connectionId ? 'mine' : 'theirs';
    quesHistory.appendChild(msg);
    msg.scrollIntoView();
  });

session.on('signal:sht', function(event) {
    if (role != 'patient') {
      publisher.publishVideo(false);
      var image = publisher.getImgData();
      var a = document.createElement('a');
      a.href = 'data:image/png;base64,'+image;
      a.download = Date.now()+".png";
      a.click();
      a.remove();
      publisher.publishVideo(true);    
    }
});



// Connect to the Session using the 'apiKey' of the application and a 'token' for permission
session.connect(apiKey, token);
