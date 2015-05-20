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
				var par = $("#"+item_id).parent("li");
				$("#"+item_id).remove();
				par.append("<a href='#!' class='secondary-content delete' id='"+item_id+"'><i class='mdi-content-remove-circle'></i></a>");
				//$("#"+item_id).html("<i class='mdi-content-remove-circle'></i>").removeClass("register").addClass("delete");
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
				var par = $("#"+item_id).parent("li");
				$("#"+item_id).remove();
				par.append("<a href='#!' class='secondary-content register' id='"+item_id+"'><i class='mdi-content-add-circle'></i></a>");
			}
			else{
				alert("effort failed")
			}
		});
		e.preventDefault();
	});

	$(document).on("click",".view-details",function(){
		$(this).siblings(".details").slideToggle("slow");
	})
});