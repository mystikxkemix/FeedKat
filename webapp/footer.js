
$(function() {
	$( "[data-role='navbar']" ).navbar();
	$( "[data-role='header'], [data-role='footer']" ).toolbar();

});

/*
	$(document).on('click', "#Accueil",function (e) {
		if(e.handled !== true)
		{
			$.mobile.pageContainer.pagecontainer("change", "index.php", reload : false});
			e.handled = true;
		}		
	});
	
	$(document).on('click', "#Chats",function (e) {
		if(e.handled !== true)
		{
			$.mobile.pageContainer.pagecontainer("change", "chats.php", {data : {'id' : '0'}, reload : false});
			e.handled = true;
		}		
	});
	
	$(document).on('click', "#Options",function (e) {
		if(e.handled !== true)
		{
			$.mobile.pageContainer.pagecontainer("change", "settings.php", reload : false});
			e.handled = true;
		}		
	});
*/


// Update the contents of the toolbars
$( document ).on( "pagecontainerchange", function() {
	// Each of the four pages in this demo has a data-title attribute
	// which value is equal to the text of the nav button
	// For example, on first page: <div data-role="page" data-title="Info">
	var current = $( ".ui-page-active" ).jqmData( "title" );
	// Change the heading
	$( "[data-role='header'] h1" ).text( current );
	// Remove active class from nav buttons
	$( "[data-role='navbar'] a.ui-btn-active" ).removeClass( "ui-btn-active" );
	// Add active class to current nav button
	$( "[data-role='navbar'] a" ).each(function() {
		if( $( this ).attr('id') === current ){
			$( this ).addClass( "ui-btn-active" );
		}
	});
});

