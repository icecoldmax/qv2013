# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# alert gon.ass

$ ->

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


    window.playVideo = playVideo
    window.pauseVideo = pauseVideo
    window.stopVideo = stopVideo
    window.muteVideo = muteVideo
    window.unmuteVideo = unmuteVideo
    window.loadVideo = loadVideo