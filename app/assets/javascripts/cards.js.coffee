# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#= require google_jsapi

google.load('search', '1')

@toggleSpinner = -> $("#spinner").toggle()

@lookup = (word) ->
  lookupDefinition(word, $('#card_definition')[0])
  lookupExample(word, $('#card_example')[0])
  lookupTranslation(word, $('#card_translation')[0])
  lookupImages(word);


lookupDefinition = (word, resultContainer) ->
  lookupService("/lookup/definition", word, resultContainer)

lookupExample = (word, resultContainer) ->
  lookupService("/lookup/example", word, resultContainer)

lookupTranslation = (word, resultContainer) ->
  lookupService("/lookup/translation", word, resultContainer)


@highlightImage = (image) ->
  $('.google-image').css('border','none').each( -> transformImage(this, "none"))
  transformImage(image, "scale(1.1) rotate(-2deg)" )
  $(image).css('border','3px solid black')

@populateImageUrl = (image) ->
  $("#card_image_src").val($(image).attr("src"))


transformImage = (image, transformationString) ->
  $(image).css("-webkit-transform", transformationString)
  $(image).css("-moz-transform", transformationString)
  $(image).css("-o-transform", transformationString)
  $(image).css("transform", transformationString)


searchComplete = (searcher) ->
  if searcher.results and searcher.results.length > 0
    contentDiv = $('#google-images-content')
    contentDiv.html('')

    results = searcher.results
    printSearch result, contentDiv for result in results

printSearch = (result, contentDiv) ->
  contentDiv.append(
#    "<div>"
    "<img class='google-image' src='" + result.url + "' onmouseover='highlightImage(this);populateImageUrl(this);' />"
#    + "</div>"
  )
#  newImg = document.createElement('img')
#  newImg.setAttribute('id', 'google-image-' + index)
#  newImg.setAttribute('class', 'google-image')
#  newImg.src = result.url
#  newImg.setAttribute('onmouseover', 'rotateImage(this);populateImageUrl(this);')
#  contentDiv.append(newImg)
#  contentDiv.appendChild(newImg)

lookupImages = (word) ->
  imageSearch = new google.search.ImageSearch()
#  TODO comment out restrictions later
  imageSearch.setRestriction(
    google.search.ImageSearch.IMAGESIZE_MEDIUM
#      google.search.ImageSearch.RESTRICT_RIGHTS,
#      google.search.ImageSearch.RIGHTS_COMMERCIAL_MODIFICATION
  )
  imageSearch.setSearchCompleteCallback(this, searchComplete, [imageSearch])
  imageSearch.execute(word)

lookupService = (url, word, resultContainer) ->
  $.ajax({
    url: url,
    data: {word: word},
    dataType: "json",
    success: (data) -> $(resultContainer).val(data.result)
  });


$ ->
  alert($(".ajax-form").length)
  $("form[data-remote]")
      .bind('ajax:before', -> alert('before'))
      .bind('ajax:complete', -> alert('complete'))
      .bind('ajaxComplete', -> alert('success'))
  $(".ajax-link")
      .bind('ajax:before', -> alert('before'))
      .bind('ajax:complete', -> alert('complete'))
      .bind('ajaxComplete', -> alert('success'))

#      .bind('ajax:before', toggleSpinner)
#      .bind('ajax:complete', toggleSpinner)
#  $("article.card-thumb").click ->
#    $(this).rotate3Di('flip', 500)
#    $(this).find("div").stop().rotate3Di('flip', 250);












