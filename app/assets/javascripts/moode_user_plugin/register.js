// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(function () {
  $("#fetch_verify_code_link").click(function () {
    fetch_verify_code_for_phone($("#user_phone").val());
  })
})

function fetch_verify_code_for_phone (phone) {
  $.ajax({
    url: "/phone/" + phone + "/vcode",
    success: function (result) {
      show_result("验证码已发送。")
    },
    error: function(xhr, textStatus, errorThrown) {
      console.log(xhr.responseText)
      show_result("发送验证码出错")
    }
  })
}

function show_result(msg) {
  alert(msg)
}