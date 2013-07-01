# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# alert gon.ass

Array::remove = (e) -> @[t..t] = [] if (t = @indexOf(e)) > -1

rand = (min, max) ->
  Math.round(Math.random() * (max - min)) + min

window.rand = rand

$ ->

  if current_page is 'setup'

    $.getScript("https://gdata.youtube.com/feeds/api/videos?v=2&alt=json-in-script&callback=searchVideos&q=disney&max-results=8&format=5&safeSearch=strict");

    $('#videoSearchButton').click (e) ->
      searchString = $('#searchInput').val()
      $.getScript("https://gdata.youtube.com/feeds/api/videos?v=2&alt=json-in-script&callback=searchVideos&q=" + searchString + "&max-results=8&format=5&safeSearch=strict");
      e.preventDefault()

    addToPlaylist = (title, videoID) -> 
      # html = "<div class=\"input-append\">
      #   <input class=\"span2\" id=\"quiz_videos_\" name=\"quiz[videos][]\" type=\"text\" value=\"#{videoID}\">
      #   <button class=\"btn remove\" type=\"button\">
      #     <i class=\"icon-remove\"></i>
      #   </button>
      #   </div>"

      html = "<div class=\"input-append\">
        <input class=\"span2\" type=\"text\" value=\"#{title}\" readonly>
        <button class=\"btn remove\" type=\"button\">
          <i class=\"icon-remove\"></i>
        </button>
        <input type=\"hidden\" id=\"quiz-videos_\" name=\"quiz[videos][]\" value=\"#{videoID}\">
        </div>"

      
      if $('#videosForm .input-append').length is 0
        $('#videosForm').append(html)
        $('#emptyPlaylist').hide()
      else
        $('#videosForm .input-append:last').after(html)

    $('body').on "click", "button.remove", ->
      $(this).parent().remove()
      if $('#videosForm .input-append').length is 0
        $('#emptyPlaylist').show()

    searchVideos = (data) ->
      feed = data.feed
      entries = feed.entry || false
      html = []

      if entries
        for entry in entries
          title = entry.title.$t.substr(0, 20) + "..."
          thumbnailUrl = entry.media$group.media$thumbnail[0].url
          videoID = entry.media$group.yt$videoid.$t
          html.push "<li onclick=\"addToPlaylist('#{title}', '#{videoID}')\" class=\"span2\" id=\"#{videoID}\"><span class=\"videoTitle\">#{title}</span><br/><img src='#{thumbnailUrl}'></li>"


        html = html.join('')
      else
        html = "<p>No results</p>"

      $('#searchResults ul').html(html)
  
    window.searchVideos = searchVideos
    window.addToPlaylist = addToPlaylist
    
  if current_page is 'quiz'

# Youtube Stuff
    # console.log gon.arithmetic
    questionTypes = { "enabled": [] }

    tag = document.createElement('script');
    tag.src = "https://www.youtube.com/player_api";
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


# Prepping the Quiz
    
    if gon.arithmetic['add_on'] is '1'
      questionTypes["add"] =
       "from": gon.arithmetic['add_from']
       "to": gon.arithmetic['add_to']
      questionTypes["enabled"].push "add"

    if gon.arithmetic['sub_on'] is '1'
      questionTypes["sub"] =
        "from": gon.arithmetic['sub_from']
        "to": gon.arithmetic['sub_to']
      questionTypes["enabled"].push "sub"

    if gon.arithmetic['multi_on'] is '1'
      questionTypes["multi"] =
        "from": gon.arithmetic['multi_from']
        "to": gon.arithmetic['multi_to']
      questionTypes["enabled"].push "multi"

    if gon.arithmetic['div_on'] is '1'
      questionTypes["div"] =
        "from": gon.arithmetic['div_from']
        "to": gon.arithmetic['div_to']
      questionTypes["enabled"].push "div"
    
    console.log questionTypes

    quizAnswerSpans = $('.quizAnswerSpan')

    insertQuestionText = (rand1, rand2, symbol, flip) ->
      if not flip
        $('#questionText').html "What is <span id='rand1'>#{rand1}</span> <span id='operand'>#{symbol}</span> <span id='rand2'>#{rand2}</span>?"
      else
        $('#questionText').html "What is <span id='rand1'>#{rand2}</span> <span id='operand'>#{symbol}</span> <span id='rand2'>#{rand1}</span>?"

    generateQuestion = (start, end, operator, randoms) ->
      start = parseInt(start, 10)
      end = parseInt(end, 10) 
      rand1 = rand(start, end)
      rand2 = rand(start, end)
      flip = false
      # console.log(rand1 + " and " + rand2)

      switch operator
        when "add"
          correctAns = rand1 + rand2
          operatorSymbol = "+"
        when "sub"
          operatorSymbol = "-"
          if rand1 >= rand2
            correctAns = rand1 - rand2
          else
            correctAns = rand2 - rand1
            flip = true
        when "multi"
          operatorSymbol = "x"
          correctAns = rand1 * rand2
        when "div"
          operatorSymbol = "/"
          # console.log "here is gon.arithmetic[div_by_from']: #{gon.arithmetic['div_by_from']}"
          rand1 = rand1 * rand2
          
          correctAns = rand1 / rand2


      if not randoms
        insertQuestionText rand1, rand2, operatorSymbol, flip
        # console.log "#{rand1} #{operatorSymbol} #{rand2}. correctAns is #{correctAns}"
      else
        # console.log "random:"
      end

      return correctAns
      
# Showing the Quiz

    showQuiz = ->
      pauseVideo()

      $('#quizResult').text ""
      
      answerPositions = [0, 1, 2, 3]
      correctAnswerPosition = rand(0, 3)
      randomAnswers = []

      questionTypesCount = questionTypes["enabled"].length
      console.log "#{questionTypesCount} question types enabled"

      thisQuestionType = questionTypes["enabled"][rand(0, (questionTypesCount-1))]
      console.log "ThisQuestionType is #{thisQuestionType}"

      start = questionTypes[thisQuestionType]["from"]
      end = questionTypes[thisQuestionType]["to"]
      operator = thisQuestionType

      # console.log "start: #{start}, end: #{end}, operator: #{operator}"
      correctAns = generateQuestion start, end, operator, false
      window.correctAns = correctAns
      $(quizAnswerSpans[correctAnswerPosition]).text correctAns
      answerPositions.remove correctAnswerPosition

      for answerPos in answerPositions
      # if thisQuestionType is "add" or thisQuestionType is "sub" or thisQuestionType is "multi"
        randomAnswer = generateQuestion start, end, operator, true
        
        while randomAnswer is correctAns or randomAnswer in randomAnswers
          randomAnswer += 1

        randomAnswers.push randomAnswer 

        $(quizAnswerSpans[answerPos]).text randomAnswer

      $('#quizModal').modal 'show'

# Catching the answers
    
    $('#quizAnswerTable td').click ->
      clickedAnswer = parseInt $(this).text()
      # console.log "Clicked #{clickedAnswer} - correctAns is #{correctAns}"

      if clickedAnswer is correctAns or parseInt clickedAnswer is correctAns
        # console.log "clickedAnswer == correctAns"
        $('#quizResult').text "Correct!"
        $('#quizModal').css "background-color": "lightgreen"
        $('#quizModal').animate "background-color": "green", 600
        
        setTimeout (->
          $('#quizModal').modal 'hide'
        ), 500

      else
        $('#quizResult').text "Try again :("
        $('#quizModal').css "background-color": "pink"
        $('#quizModal').animate "background-color": "rgb(220,20,60)", 600

    $('#quizModal').on "hidden", ->
      $('#quizModal').css "background-color": "black"
      playVideo()



    window.playVideo = playVideo
    window.pauseVideo = pauseVideo
    window.stopVideo = stopVideo
    window.muteVideo = muteVideo
    window.unmuteVideo = unmuteVideo
    window.loadVideo = loadVideo
    window.loadPlaylist = loadPlaylist
    window.nextVideo = nextVideo
    window.prevVideo = prevVideo
    
    window.generateQuestion = generateQuestion
    window.showQuiz = showQuiz
