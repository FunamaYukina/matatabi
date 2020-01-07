
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