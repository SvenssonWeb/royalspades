$( document ).ready(function() {
	var superadmin = false;
	var producer = false;
	var shopOwner = false;
	var newData;
	var fadeOutTime = 200;
	var fadeInTime = 200;
	
	function getMenu(){
		var menuUrl =  baseUrl + "/menu/shopowner";
		
		$.ajax({
			url: menuUrl,
			context: document.body
			}).done(function(data) {
			
				$(".headermenu").html(data);
				
				$(".menulink").click(function (event){
					event.preventDefault();
					$(".menulink").removeClass("active");
					$(this).addClass("active");
					openPageUrlAndUpdateHash(this.href, this.id.replace("topMenuLink",""));
				});
		});
	}
	
	function openMainPage(){
		openPageUrl( baseUrl + "/shopowner/main/");
	}
	
	function openPageUrl(pageUrl){
		$.ajax({
			url: pageUrl,
			context: document.body
			}).done(function(data) {
				$(".maincontent").fadeOut(fadeOutTime);
				newData = data;
				setTimeout(switchData, fadeOutTime);
				$(".maincontent").fadeIn(fadeInTime);
		});
	}
	
	function openPageUrlAndUpdateHash(pageUrl, page){
		$.ajax({
			url: pageUrl,
			context: document.body
			}).done(function(data) {
				$(".maincontent").fadeOut(fadeOutTime);
				newData = data;
				setTimeout(switchData, fadeOutTime);
				$(".maincontent").fadeIn(fadeInTime);
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
	
	function getUrl(p){
		if(p == '7ada6860-8d79-11e3-baa8-0800200c9a66'){
			return  baseUrl + "/shopowner/main";
		}
		if(p == '83bf04e0-8d79-11e3-baa8-0800200c9a66'){
			return baseUrl + "/shopowner/help";
		}
		if(p == '8f93bc70-8d79-11e3-baa8-0800200c9a66'){
			return baseUrl + "shopowner/settings";
		}
		
	}
	
	var hashArray = window.location.hash.replace("#", "").split('&');
	var page = "";
	for(var i = 0; i < hashArray.length; i++){
		if(hashArray[i][0] == 'p'){
			page = hashArray[i].replace("p=", "");
			openPageUrlAndUpdateHash(getUrl(page), page);
		}
	}
	
	if(page == ""){
		openMainPage();
	}
	getMenu();
});