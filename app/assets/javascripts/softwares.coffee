# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ajaxRequest = () ->
  version_id = $("#select-version").val()

  $.ajax
    method: "POST",
    url: "/get-version-details",
    data: {
      id: version_id
    }
    success: (version) ->
      populate(version)

populate = (version) ->
  $("#version-name").replaceWith("<div id='version-name'>" + version.name + "</div>")
  # ToDo : handle os
  if version.distrilog
    $("#version-distrilog").replaceWith("<div id='version-distrilog'>available</div>")
  else
    $("#version-distrilog").replaceWith("<div id='version-distrilog'><b>not</b> available</div>")
  $("#version-date").replaceWith("<div id='version-date'>" + version.date + "</div>")

$ ->
  console.log("DOM is ready")
  ajaxRequest()

  $("#select-version").change ->
    ajaxRequest()
