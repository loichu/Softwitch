# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
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

  # ToDo : handle os
  for os in version.operating_systems
    if os.name = "windows"
      $("#version-os-windows").replaceWith("<i id='version-os-windows' class='fa fa-windows' aria-hidden='true'></i>")
    else
      $("#version-os-windows").replaceWith("<div id='version-os-windows' class='col-md-1'></div>")

    if os.name = "linux"
      $("#version-os-linux").replaceWith("<i class='fa fa-linux' aria-hidden='true'></i>")
    else
      $("#version-os-linux").replaceWith("<div id='version-os-linux' class='col-md-1'></div>")

    if os.name = "mac"
      $("#version-os-apple").replaceWith("<i class='fa fa-apple' aria-hidden='true'></i>")
    else
      $("#version-os-apple").replaceWith("<div id='version-os-apple' class='col-md-1'></div>")

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
