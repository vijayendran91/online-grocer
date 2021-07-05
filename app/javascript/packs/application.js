// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require jquery.easing
//= require scrollreveal
//= require jquery.magnific-popup
//= require welcomes
require("@rails/ujs").start()
require("turbolinks").start()
require("channels")

import "../stylesheets/application.scss"
import 'bootstrap-icons/font/bootstrap-icons.css'

var jQuery = require("jquery");
global.$ = global.jQuery = jQuery;
window.$ = window.jQuery = jQuery;

require("bootstrap");
document.addEventListener("turbolinks:load", ()=> {
  $('[data-toggle="tooltip"]').tooltip()
})

$(document).ready(function () {
  $('#navburger').click(function(){
      $('#navbarMenu').collapse("toggle");
  })
});


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
