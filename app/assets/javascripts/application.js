// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery
//= require turbolinks
//= require_tree .

const readImage = (fileField, preview, options) => {
    let id = fileField.attr("id");
    $(`#${id}`).on('change', fileField, function (e) {
        file = e.target.files[0];
        first_fileField = $('#icon_file_first');
        reader = new FileReader(),
            reader.onload = (function (file) {
                return function (e) {
                    first_fileField.remove();
                    preview.empty();
                    let attributes = {
                        src: e.target.result,
                        title: file.name
                    };
                    preview.append($('<img>').attr(Object.assign(attributes, options)));
                };
            })(file);
        reader.readAsDataURL(file);
    });
}

$(function () {
    if ($('#icon_file').length) {
        console.log("Hi");
        fileField = $('#icon_file');
        preview = $('#icon_image');
        options = {
            width: "120px",
            height: "120px",
            style: 'border-radius:60px;'
        }
    } else {
        return
    }
    readImage(fileField, preview, options);
});