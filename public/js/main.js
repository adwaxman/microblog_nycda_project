$(document).ready(function(){

	// $('.open-menu').click(function(){
	// 	$('.drop-menu').animate({right: "0px"}, 200)
	// });
	//
	// $('.close-menu').click(function(){
	// 	$('.drop-menu').animate({right: "-200px"}, 200);
	// });

	$('.open-menu').click(function(){
		$('.drop-menu').toggle("slide")
	});

	$('.close-menu').click(function(){
		$('.drop-menu').toggle("slide")
	});


});;
