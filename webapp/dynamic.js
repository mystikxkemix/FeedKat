

/**********************************************************
 *
 *			Javascript pour index.php
 *
 *********************************************************/
 
$(document).on('pagebeforeshow', '#page-info',function () {

	$.getJSON('http://feedkat.ddns.net/api/index.php/cat/user/'+userID, function(data)
	{	
		var output_block = "";
		var output_block_a = "";
		var output_block_b = "";
		var icon_info = "";
		
		for(let i = 0; i < data.cats.length; i++)		
		{
			if(data.cats[i].photo == "")
			{
				data.cats[i].photo = "icons/Logo_FeedKat_300px.png";
			}
			
			if(data.cats[i].ok == 1)
			{
				icon_info = "<img src=\"icons/icon_check.png\" height=\"70\" width=\"70\">";
			}
			else if(data.cats[i].ok == 0)
			{
				icon_info = "<img src=\"icons/icon_cross.png\" height=\"70\" width=\"70\">";
			}
			
			output_block = 
			"<div class=\"ui-shadow ui-tile-info\" id=\"index-cat" + i + "\">" +
				"<div class=\"tile-photo\">" +
					"<img src=" + data.cats[i].photo + " height=\"150\" width=\"150\">" +
				"</div>" +
				"<div class=\"tile-description\">" +
					"<div class=\"tile-title\" >" +
						data.cats[i].name +
					"</div>" +
					"<div class=\"tile-icon-info\">" +
						icon_info +
					"</div>" +
					"<div class=\"tile-text\" >" +
						data.cats[i].status +
					"</div>" +
				"</div>" +	
			"</div>";
			
			if(i%2 == 0) 
			{
				output_block_a += output_block;
			}
			else
			{
				output_block_b += output_block;
			}

			$(document).on('click', "#index-cat"+i,function (e) {
				if(e.handled !== true)
				{
					$.mobile.pageContainer.pagecontainer("change", "chats.php", {data : {'id' : i }, reload : true});
					e.handled = true;
				}
			});
			
			
		}
	
		$('.index-block-chat-a').html(output_block_a);
		$('.index-block-chat-b').html(output_block_b);
	
	});
	
	
	
	$.getJSON('http://feedkat.ddns.net/api/index.php/dispenser/user/'+userID, function(data)
	{	
		var output_block_distrib = "";
		var output_block_distrib_a = "";
		var output_block_distrib_b = "";
		var icon_info = "";
		
		//data.dispensers[0].stock = 80;
		
		for(let i = 0; i < data.dispensers.length; i++)		
		{	
			output_block_distrib = 			
			"<div class=\"ui-shadow ui-tile-info\" style=\"cursor: default;\">" +
				"<div class=\"tile-photo\">" +
					"<img src=\"icons/icon_dis.png\" height=\"150\" width=\"150\">" +
				"</div>" +
				"<div class= \"tile-description\">" +
					"<div class=\"tile-title\">" +
						data.dispensers[i].name + 
					"</div>" +
					"<div class=\"tile-details-distrib\">" +
						"<div>Niveau de croquettes :</div>" +
						"<div style=\"width:100%; height:1.25em; border:1px solid #333333;\">" +
							"<div style=\"width:" + data.dispensers[i].stock + "%; height:100%; background:";
							
			if(data.dispensers[i].stock >= 75)
			{
				output_block_distrib += "#6EFF6E";//"#B3E7CB";
			}
			else if(data.dispensers[i].stock >= 50)
			{
				output_block_distrib += "#FFFF50";
			}
			else if(data.dispensers[i].stock >= 25)
			{
				output_block_distrib += "#FFB450";
			}
			else
			{
				output_block_distrib += "#ff6E6E";
			}
							
							
							
			output_block_distrib += 					
							";\"></div>" +
						"</div>" +
					"</div>" + 
				"</div>" +
			"</div>";
			
			if(i%2 == 0) 
			{
				output_block_distrib_a += output_block_distrib;
			}
			else
			{
				output_block_distrib_b += output_block_distrib;
			}
			
		}
	
		$('.index-block-distrib-a').html(output_block_distrib_a);
		$('.index-block-distrib-b').html(output_block_distrib_b);
	
	});
	
	
	
}); 


/**********************************************************
 *
 *			Javascript pour chats.php
 *
 *********************************************************/

$(document).on('pagebeforeshow', '#page-cat',function(event){ 

	var currentCat = 0;
	var param = window.location.href.split("?")[1];//$(this).data("url").split("?")[1];
	if(param == undefined)
	{
		param = 0;
	}
	else
	{
		param = param.split("=")[1];
	}
	
	$.getJSON('http://feedkat.ddns.net/api/index.php/cat/user/'+userID, function(data)
	{
		
		refreshInfo(param);
		currentCat = param;
	
		var output_list_cat = "";
		
		for(let i = 0; i < data.cats.length; i++)		
		{
			output_list_cat +=
			"<div class=\"ui-tile-btn ui-shadow\" id=\"cat"+ i +"\">" + data.cats[i].name + "</div>" ;

			$(document).on( "click", "#cat"+i, function() {
				refreshInfo(i);
				currentCat = i;
				if (window.history.replaceState) {
				    window.history.replaceState({page:'chats.php?id='+i}, 'titre', 'chats.php?id='+i);
				}
			});
		}
		
		output_list_cat +=
		"<div class=\"ui-tile-btn ui-shadow\" style=\"text-align:center;\">" + 
			"<img src=\"icons/plus-black.png\">" +
		"</div>";
		
		//document.getElementById('list-cat').innerHTML = output_list_cat;
		$('.list-cat').html(output_list_cat);
	

		function refreshInfo(parameter) 
		{		
			if(data.cats[parameter].photo == "")
			{
				data.cats[parameter].photo = "icons/Logo_FeedKat_300px.png";
			}
			
			var output =
			"<div class=\"tile-photo\">" +
				"<img src=" + data.cats[parameter].photo + " height=\"150\" width=\"150\">" +
			"</div>" +
			"<div class=\"tile-description\">" +
				"<div class=\"tile-title\">" +
					data.cats[parameter].name +
				"</div>" +
				"<img src=\"icons/edit-64.png\" class=\"tile-icon-edit\" id=\"icon-edit\" height=\"40\" width=\"40\">";

				if(data.cats[parameter].ok == 0)
				{
					output +=
					"<div class=\"tile-details-a\" style=\"padding-bottom:0.5em; color:#ff6E6E;\">" +
					"Votre chat n'a pas mangé depuis 3 jours" +
					"</div>";
				}
				else if(data.cats[parameter].ok == 1)
				{
					output +=
					"<div class=\"tile-details-a\" style=\"padding-bottom:0.5em;\">" +
					"Votre chat a mangé il y a 6 heures" +
					"</div>";
				} 
				
				output +=				
				"<div class=\"ui-grid-a\">" +
				
					"<div class=\"ui-block-a\">" +
						"<div class=\"tile-details-a\">" +
							"<div>Date de naissance :</div>" +
							"<div>Poids :</div>" +
							"<div>Activité :</div>" +
							"<div>Batterie collier :</div>" +
						"</div>" +
					"</div>" +
					
					"<div class=\"ui-block-b\">" +
						"<div class=\"tile-details-b\">" +
							"<div>" + data.cats[parameter].birth + "</div>" +
							"<div>" + "8 Kg" + "</div>" +
							"<div>" + "Ok" + "</div>" +
							"<div>" + "100% (6 mois)" + "</div>" +
						"</div>" +
					"</div>" +
					
				"</div>" +
				
				
			"</div>";
			
			//document.getElementById('info-content').innerHTML = output;
			$('.info-content').html(output);
			
			
			
 
		}
		/*
				$(document).on( "click", "#icon-edit", function() {
					//currentCat = i;
					//alert("lol");
					
					$.post( "http://feedkat.ddns.net/api/index.php/cat", { id_cat: 2, name: "Oni lololololol" } );
				});
		*/
	});
	
});


/**********************************************************
 *
 *			Javascript pour settings.php
 *
 *********************************************************/