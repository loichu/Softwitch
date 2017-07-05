# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


#$('#details a').click (e) ->
#  e.preventDefault()
#  $(this).tab('show')


#$('#presentation a').click (e) ->
#  e.preventDefault()
#  $(this).tab('show')


cleanOsIcons = () ->
  $("#version-os-windows").empty()
  $("#version-os-linux").empty()
  $("#version-os-apple").empty()

ajaxRequest = () ->
  version_id = $("#select-version").val()

  $.ajax
    method: "GET",
    url: "/versions/" + version_id + ".json",
    data: {
      id: version_id
    }
    success: (version) ->
      populate(version)

populate = (version) ->
  $("#version-name").replaceWith("<div id='version-name' class='col-md-3'>" + version.name + "</div>")
  cleanOsIcons()
  # ToDo : handle os
  # os = {}
  #os = version.operating_systems
  for os in version.operating_systems
    if os.name == "Windows"
      $("#version-os-windows").append("<i class='fa fa-windows' aria-hidden='true'></i>")

    if os.name == "Linux"
      $("#version-os-linux").append("<i class='fa fa-linux' aria-hidden='true'></i>")

    if os.name == "Mac"
      $("#version-os-apple").append("<i class='fa fa-apple' aria-hidden='true'></i>")

  if version.distrilog
    $("#version-distrilog").replaceWith("<div id='version-distrilog' class='col-md-3'>available</div>")
  else
    $("#version-distrilog").replaceWith("<div id='version-distrilog' class='col-md-3'><b>not</b> available</div>")

  if version.date
    $("#version-date").replaceWith("<div id='version-date' class='col-md-3'>" + version.date + "</div>")
  else
    $("#version-date").replaceWith("<div id='version-date' class='col-md-3'>not specified</div>")


$ ->
  console.log("DOM is ready")
  ajaxRequest()
  $('.nav-tabs a[href="#details"]').tab('show')

  $("#select-version").change ->
    ajaxRequest()
