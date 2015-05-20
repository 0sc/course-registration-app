$(document).ready(function(){
	$(document).on("click",".register",function(e){
		 //alert("Begin Ajax Add")
		 var val = $(this).parent("li");
		 
		 var item_id = $(this).attr("id");
		$.ajax({
			type: "POST",
			url: "/register",
			data: {id: item_id},
		}).done(function(data){
			if(data.status == 'done'){
				val.remove();
				$("#registered-classes").append("<li class='collection-item avatar'>"+val.html()+"</li>");
				$("#"+item_id).html("<i class='mdi-content-remove-circle'></i>").removeClass("register").addClass("delete");
			}
			else{
				alert("effort failed")
			}
		});
		e.preventDefault();
		 
	});

	$(document).on("click",".delete",function(e){
		 //alert("Begin Ajax Delete")
		 var val = $(this).parent("li");
		 var item_id = $(this).attr("id");
		$.ajax({
			type: "POST",
			url: "/delete",
			data: {id: item_id},
		}).done(function(data){
			if(data.status == 'done'){
				val.remove();
				$("#available-classes").append("<li class='collection-item avatar'>"+val.html()+"</li>");
				$("#"+item_id).html("<i class='mdi-content-add-circle'></i>").removeClass("delete").addClass("register");
			}
			else{
				alert("effort failed")
			}
		});
		e.preventDefault();
	});
});