# Function :
cleanOsIcons = () ->
  $("#version-os-windows").empty()
  $("#version-os-linux").empty()
  $("#version-os-apple").empty()

ajaxVersionDetails = () ->
  version_id = $("#select-version").val()

  $.ajax
    method: "GET",
    url: "/versions/" + version_id + ".json"
    success: (version) ->
      populate(version)

populate = (version) ->
  $("#version-name").replaceWith("<div id='version-name' class='col-md-1'>" + version.name + "</div>")
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
    $('#dl-link').attr("href", version.install_link)
    #$('#dl-link').removeClass("disabled")
    $('#dl-link').attr("disabled", false)
  else
    $('#dl-link').attr("href", "#")
    $('#dl-link').addClass("disabled")

  if version.website
    $('#doc-link').attr("href", version.website)
    $('#doc-link').removeClass("disabled")
  else
    $('#doc-link').attr("href", "#")
    $('#doc-link').addClass("disabled")

confirmDelete = () ->
  return confirm('Are you sure ?')

ajaxDeleteVersion = () ->
  version_id = $("#select-version").val()
  # TODO:
  # Confirmation message, select first in select-version, populate
  $.ajax
    method: 'DELETE'
    url: "/versions/" + version_id + ".json"
    success: ->
      $('#select-version option[value=' + version_id + ']').remove()
      alert("deleted")

# Jquery :
ready = () ->
  console.log("DOM is ready")

  if $(".show").length > 0
    ajaxVersionDetails()

  $('.nav-tabs a[href="#details"]').tab('show')

  $(".show #select-version").select2(
    theme: "bootstrap"
  )

  $(".show #select-version").change ->
    ajaxVersionDetails()

  $('.show #destroy-version').click ->
    if confirmDelete()
      console.log('okay')

  $('.show #edit-version').click ->
    window.location.replace("/versions/" + $('#select-version').val() + "/edit")

# Triggers :
$ ->
  ready()

$(document).on('page:change', ready)
