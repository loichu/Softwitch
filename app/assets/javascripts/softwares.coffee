# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
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

  $("#version-date").replaceWith("<div id='version-date' class='col-md-3'>" + version.date + "</div>")


$ ->
  console.log("DOM is ready")
  ajaxRequest()

  $("#select-version").change ->
    ajaxRequest()
