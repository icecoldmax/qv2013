function onYouTubePlayerAPIReady() {
  // console.log("onyoutubeplayerapiready called");

    ytplayer = new YT.Player('ytplayer', {
      width: '100%',
      height: '100%',
      //videoId: getParameterByName('vid0'),
      playerVars: { 'autoplay': 0, 'controls': 0, 'wmode': 'opaque',
                  //'playlist': vids.join(),
                    // 'origin': 'http://localhost:3000/',
                    'modestbranding': 1, 'showinfo': 0 
                  },
      events: {
        'onReady': onPlayerReady,
        'onStateChange': onPlayerStateChange,
        'onError': onPlayerError
              }
    });
  }

  function onPlayerReady(evt) {

    // setInterval(updatePlayerInfo, 1000);
    // updatePlayerInfo();
    // interval = getParameterByName('interval');
    // ytplayer.loadPlaylist(vids);
    //initIFrameClick();
    //  evt.target.playVideo();
    console.log("Player is ready");

    ytplayer.loadPlaylist(gon.videos);
  }
   
  function onPlayerStateChange(evt) {
    console.log("player state change");
    // var newState = evt.data;
    // updateHTML("playerState", newState);
    // console.log("newState: " + newState);
    // if (newState == 0 || newState == 2 || newState == 3 || newState == 5) {
    //   clearInterval(t);
    //   console.log("clearInterval ran (state change)");
    // } else if (newState == 1) {
    //   t = setInterval(stopAtTime, 1000, interval);
    // }

  }

  // This function is called when an error is thrown by the player
  function onPlayerError(errorCode) {
    alert("An error occured of type:" + errorCode);
  }