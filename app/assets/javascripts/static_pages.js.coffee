# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# alert gon.ass

$ ->

  if current_page is 'setup'

    $('#videoSearchButton').click (e) ->
      searchString = $('#searchInput').val()
      $.getScript("http://gdata.youtube.com/feeds/api/videos?v=2&alt=json-in-script&callback=searchVideos&q=" + searchString + "&max-results=6&format=5&safeSearch=strict");
      e.preventDefault()

    addToPlaylist = (videoID) -> 
      html = "<div class=\"input-append\">
        <input class=\"span3\" id=\"quiz_videos_\" name=\"quiz[videos][]\" type=\"text\" value=\"#{videoID}\">
        <button class=\"btn remove\" type=\"button\">
          <i class=\"icon-remove\"></i>
        </button>
        </div>"
      
      if $('#videosForm .input-append').length is 0
        $('#videosForm input[type="submit"]').before(html)
      else
        $('#videosForm .input-append:last').after(html)

    $('body').on "click", "button.remove", ->
      $(this).parent().remove()

    searchVideos = (data) ->
      feed = data.feed
      entries = feed.entry || false
      html = []

      if entries
        for entry in entries
          title = entry.title.$t.substr(0, 30)
          thumbnailUrl = entry.media$group.media$thumbnail[0].url
          videoID = entry.media$group.yt$videoid.$t
          html.push "<li onclick=\"addToPlaylist('#{videoID}')\" class=\"span2\" id=\"#{videoID}\"><span class=\"videoTitle\">#{title}</span><br/><img src='#{thumbnailUrl}'></li>"


        html = html.join('')
      else
        html = "<p>No results</p>"

      $('#searchResults ul').html(html)
  
    window.searchVideos = searchVideos
    window.addToPlaylist = addToPlaylist
    # window.removeFromPlaylist = removeFromPlaylist

    
    # $('#add-video').click (e) ->
    #   html = '<input id="quiz_videos_" name="quiz[videos][]" type="text">'
    #   $('#videosForm input[name="quiz[videos][]"]:last').after(html)
    #   e.preventDefault()



  if current_page is 'quiz'

    tag = document.createElement('script');
    tag.src = "http://www.youtube.com/player_api";
    firstScriptTag = document.getElementsByTagName('script')[0];
    firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
    
    playVideo = ->
      ytplayer.playVideo() if ytplayer

    pauseVideo = ->
      ytplayer.pauseVideo() if ytplayer

    stopVideo = ->
      ytplayer.stopVideo() if ytplayer

    muteVideo = ->
      ytplayer.mute() if ytplayer

    unmuteVideo = ->
      ytplayer.unMute() if ytplayer

    loadVideo = (id) ->
      ytplayer.loadVideoById(id) if ytplayer

    loadPlaylist = (playlist) ->
      ytplayer.loadPlaylist(playlist) if ytplayer

    nextVideo = ->
      ytplayer.nextVideo() if ytplayer

    prevVideo = ->
      ytplayer.previousVideo() if ytplayer

    window.playVideo = playVideo
    window.pauseVideo = pauseVideo
    window.stopVideo = stopVideo
    window.muteVideo = muteVideo
    window.unmuteVideo = unmuteVideo
    window.loadVideo = loadVideo
    window.loadPlaylist = loadPlaylist
    window.nextVideo = nextVideo
    window.prevVideo = prevVideo
