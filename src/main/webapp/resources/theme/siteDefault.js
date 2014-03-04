baseUrl = baseUrl;
$( document ).ready(function() {
	
	var newData;
	var fadeOutTime = 200;
	var fadeInTime = 200;
	
	
	
	function openMainPage(){    //main
		openPageUrl( baseUrl + "/login/");
	}
	
	
	function getUrl(p){

		if(p == '2f5gdd560-8d75-11e3-cdd8-0220230c9a66'){
			return  baseUrl + "/login/";
		}
        return "";
	}

	
	function getMenu(){
		
		var menuUrl =  baseUrl + '/menu/default';
		
		$.ajax({
			url: menuUrl,
			context: document.body
			}).done(function(data) {
			
				$(".headermenu").html(data);
				
				$(".menulink").click(function (event){
					event.preventDefault();
					$(".menulink").removeClass("active");
					$(this).addClass("active");
					openPageUrl(this.href);
				});
		});
	}
	
	function openPageUrl(pageUrl){
        var temp = $(".maincontent");
        $.ajax({
			url: pageUrl,
			context: document.body
			}).done(function(data) {
				temp.fadeOut(fadeOutTime);
				newData = data;
				setTimeout(switchData, fadeOutTime);
				temp.fadeIn(fadeInTime);
		});
	}
	
	function openPageUrlAndUpdateHash(pageUrl, page){
        var temp = $(".maincontent");
        $.ajax({
			url: pageUrl,
			context: document.body
			}).done(function(data) {
				temp.fadeOut(fadeOutTime);
				newData = data;
				setTimeout(switchData, fadeOutTime);
				temp.fadeIn(fadeInTime);
				window.location.hash = "p=" + page;
		});
	}
	
	function switchData(){
		$(".maincontent").html(newData);
		refreshLinks();
		setTimeout(refreshLinks, 250);
		setTimeout(refreshLinks, 500);
		setTimeout(refreshLinks, 2000);
		  
	 }
		 
	function refreshLinks(){
		$('.link').off();
		$(".link").click(function (event){
			event.preventDefault();
			openPageUrl(this.href);
		 });
	}
	
	var hashArray = window.location.hash.replace("#", "").split('&');
	var page = "";
	for(var i = 0; i < hashArray.length; i++){
		if(hashArray[i][0] == 'p'){
			page = hashArray[i].replace("p=", "");
			openPageUrlAndUpdateHash(getUrl(page), page);
		}
	}
	
    openMainPage();
	
	getMenu();
	
});



/*
function openLoginPage(){
	$.ajax({
		url: "/login/",
		context: document.body
		}).done(function(data) {
			//document.getElementById('popupbox').style.visibility="hidden";
			$("body").append(data);
			$(".loginLink").click(function() {
				temp = document.getElementById('popupbox').getAttribute("style");
				console.log(temp);
				if(temp == "visibility: visible;"){
					console.log("if");
					document.getElementById('popupbox').style.visibility="hidden";
				}else{
					console.log("else");
					document.getElementById('popupbox').style.visibility="visible";
				}
			});
		});
  	$("div.modal-bg").fadeTo("slow", .5);
	
	$(".loginLink").click(function() {
		if($("#popupbox").is(':visible')){
			console.log("if");
			$('#popupbox').show();
		}else{
			console.log("else");
			$('#popupbox').hide();
		}
	});
}
   */