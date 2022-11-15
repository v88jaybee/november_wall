$(document).ready(function(){
    $("body")
        .on("submit", "#message_form", function(e){
            e.preventDefault();
            submit_wall_form($(this));
        })
        .on("submit", ".delete_message_form", function(e){
            e.preventDefault();
            submit_wall_form($(this));
        })
        .on("submit", ".comment_form", function(e){
            e.preventDefault();
            submit_wall_form($(this));
        })
        .on("submit", ".delete_comment_form", function(e){
            e.preventDefault();
            submit_wall_form($(this));
        })
});

function submit_wall_form(form){
    $.post(form.attr("action"), form.serialize(), function(message_result){
        if(message_result.status){
            location.reload();
        }
        else{
            alert(message_result.message);
        }
    }, "json");

    return false;
}