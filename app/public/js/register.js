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
				val.empty().html("<p><i class= 'mdi-action-thumb-up'></i>&emsp;Course has been added successfully to your schedule.</p>");
			}
			else{
				alert("effort failed")
			}
		});
		e.preventDefault();
		 
	});

	$(document).on("submit","form.delete",function(e){
		 //alert("Begin Ajax Delete");
		  var formData = $(this)
		 //var formData = $(this).serializeArray();
		 //alert (formData);
		  rm = []
		  mk = []
		  formData.find("input[type='checkbox']").each(function(){

		  		if($(this).is(":checked")){
		  			rm.push($(this).val());
		  		}
		  		else{
		  			mk.push($(this).val())
		  		}
		  });

		 
		$.ajax({
			type: "POST",
			url: "/update",
			data: {rm : rm, mk : mk},
		}).done(function(data){
			if(data.status == 'done'){
				//update the time field to show changes
				var newTimeVal = []

				if(mk.length > 0){
					for (var i = 0; i < mk.length; i++){
						var txt = $("#rm_"+mk[i]).next("label").text();
						txt = txt.replace("Remove ","");
						txt = txt.replace(" schedule","");

						newTimeVal.push(txt);
					}
					newTimeVal.join(", ")
				}
				else{
					newTimeVal = "You have successfully deleted this course."
				}

				formData.parents("li").children(".time-list").html("<span >"+newTimeVal+"</span>");
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

	 $(document).on("click",".edit",function(){
		$(this).siblings(".edit-section").slideToggle("slow");
	 })	
});