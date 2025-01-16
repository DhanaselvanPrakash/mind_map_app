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

  // Section to visualize the mindMap
  const width = 1000;
  const height = 500;

  // creating the svg container to draw the mindmap
  const svg = d3.select("#mindmap")
    .append("svg")
    .attr("width", width)
    .attr("height", height)
    .append("g")
    .attr("transform", "translate(350, -50)")

  const mindMapId = $("#mind-map-id").val();
  fetch(`/visualize/${mindMapId}`)
    .then(res => res.json())
    .then(data => renderMindMap(data));

  function renderMindMap(data) {
    const root = d3.hierarchy(data);

    const treeLayout = d3.tree().size([(width-50)/2, (height)/2]);
    const treeData = treeLayout(root);

    const diagonal = d3.linkHorizontal()
    .x(d => d.y)
    .y(d => d.x);

    svg.selectAll(".link")
    .data(root.links())
    .enter()
    .append("path")
    .attr("class", "link")
    .attr("d", diagonal)
    .style("fill", "none")
    .style("stroke", "#ccc")
    .style("stroke-width", 5);

    const nodes = svg.selectAll(".node")
      .data(treeData.descendants())
      .enter()
      .append("g")
      .attr("class", "node")
      .attr("transform", d => `translate(${d.y}, ${d.x})`);

    nodes.append("circle")
      .attr("r", 10)
      .style("fill", "#69b3a2");

    nodes.append("text")
      .attr("dy", ".35em")
      .attr("x", d => (d.children ? -20 : 20))
      .style("text-anchor", d => (d.children ? "end" : "start"))
      .text(d => d.data.name);
  }
})