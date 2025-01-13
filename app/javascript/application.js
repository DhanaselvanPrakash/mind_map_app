// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
// import "@hotwired/turbo-rails"
import "controllers"

import $ from "jquery";
window.$ = $;
window.jQuery = $;

$(document).ready( () => {
  // logic to Add the mind_map
  $("#add-map-btn").on('click', (e) => {
    e.preventDefault()
    var userId = $("#user-id").val()
    var title = $("#map-title").val()
    var moto = $("#moto").val()
    const formData = { 
      title: title,
      user_id: userId,
      moto: moto
    }
    $.ajax({
      type: "POST",
      url: "/create_mind_map",
      data: formData,
      success: () => { },
      error: () => { }
    })
  })

  // logic to delete the mind_map
  // $(".delete-map-btn").on('click', (e) => {
  //   e.preventDefault()
  //   alert("Works")
  // })
})