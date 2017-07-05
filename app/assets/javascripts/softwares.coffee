# Function :
openInNewTab = (url) ->
  win = window.open(url, '_blank')
  win.focus()

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

  if version.install_link
    $('#dl-link').attr("data-url", version.install_link)
    $('#dl-link').attr("disabled", false)
  else
    $('#dl-link').attr("data-url", "#")
    $('#dl-link').attr("disabled", true)

  if version.website
    $('#doc-link').attr("data-url", version.website)
    $('#doc-link').attr("disabled", false)
  else
    $('#doc-link').attr("data-url", "#")
    $('#doc-link').attr("disabled", true)



# Jquery :
$ ->
  console.log("DOM is ready")
  ajaxRequest()
  $('.nav-tabs a[href="#details"]').tab('show')

  $("#select-version").change ->
    ajaxRequest()

  $(".extern-link").click ->
    console.log("im in !")
    url = $(this).data(url)
    console.dir(openInNewTab(url))