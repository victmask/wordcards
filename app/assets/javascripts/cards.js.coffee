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
    "<img class='google-image' src='" + result.url + "' onmouseover='highlightImage(this);populateImageUrl(this);' />"
  )

lookupImages = (word) ->
  imageSearch = new google.search.ImageSearch()
#  TODO comment out restrictions later
  imageSearch.setRestriction(
    google.search.ImageSearch.IMAGESIZE_MEDIUM,
    google.search.ImageSearch.RESTRICT_RIGHTS,
    google.search.ImageSearch.RIGHTS_COMMERCIAL_MODIFICATION
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


@mySideChange = (front) ->
  if front
    $(this).parent('div.front').show()
    $(this).parent('div.back').hide()
  else
    $(this).parent('div.front').hide()
    $(this).parent('div.back').show()

$ ->
  $("article.card").hover(
    -> $(this).find("div").stop().rotate3Di('flip', 250,{direction: 'clockwise', sideChange: mySideChange}),
    -> $(this).find("div").stop().rotate3Di('unflip', 500, {sideChange: mySideChange})
  )











