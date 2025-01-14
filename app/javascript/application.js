// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
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

  // logic to add the step
  $("#add-step-btn").on('click', (e) => {
    e.preventDefault()
    var stepTitle = $("#step-title").val()
    var mapId = $("#map-id").val()
    $.ajax({
      type: "POST",
      url: "/create_step",
      data: { title: stepTitle, map_id: mapId },
      success: () => { },
      error: { }
    })
  })

  // logic to add the implementation
  $("#add-implementaion-btn").on('click', (e) => {
    e.preventDefault()
    var details = $("#details").val()
    var stepId = $("step-id").val()
    var mapId = $("#map-id").val()
    $.ajax({
      type: "POST",
      url: "/create_implementation",
      data: { details: details, step_id: stepId, map_id: mapId },
      success: () => {},
      error: () => {}
    })
  })

  // logic to open the add step modal
  $("#step-model-btn").on('click', ()=> {
    $("#step-modal").removeClass('hidden').addClass('flex')
  })

  // logic to close the add step modal
  $("#close-step-model-btn").on('click', ()=> {
    $("#step-modal").removeClass('flex').addClass('hidden')
  })

  // logic to open the implementaion modal
  $("#implementaion-model-btn").on('click', ()=> {
    $("#implementaion-modal").removeClass('hidden').addClass('flex')
  })

  // logic to close the implementaion modal
  $("#close-implementaion-model-btn").on('click', ()=> {
    $("#implementaion-modal").removeClass('flex').addClass('hidden')
  })
})