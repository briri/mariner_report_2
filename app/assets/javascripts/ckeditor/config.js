
if(typeof(CKEDITOR) != 'undefined')
{
 CKEDITOR.editorConfig = function(config) {
   config.uiColor = "#004b99";
   config.toolbar = [
    [ 'Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript' ],
    [ 'NumberedList', 'BulletedList', 'HorizontalRule', 'Outdent', 'Indent' ],
    [ 'Cut', 'Copy', 'Paste', 'PasteText', 'PasteFromWord', '-', 'Undo', 'Redo', 'Find', 'Replace' ],
   config.contentsCss = '/stylesheets/ckeditor.css'
 ];
}
} else{
  console.log("ckeditor not loaded")
}