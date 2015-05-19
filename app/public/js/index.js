$(document).ready(function(){
	$(".registration-field").hide();
	$("#isNewUser").prop("checked",false)
	 $("#isNewUser").click(function(){
	 	 $("#registration-field").toggleClass("hide").toggle("slow");
	 });
});