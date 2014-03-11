$( document ).ready(function() {
	var newData;
	var fadeOutTime = 200;
	var fadeInTime = 200;
	
	function getMenu(){
	    var menuUrl = baseUrl + "/menu/user";
		
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
	
	function openMainPage(){
		openPageUrl(baseUrl + "/home/main/");
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
	
	function getUrl(p){
		if(p == '1a6d5630-8d75-11e3-baa8-0800200c9a66'){
			return  baseUrl + "/home/main";
		}
		if(p == 'fd2e63a0-8d76-11e3-baa8-0800200c9a66'){
			return  baseUrl + "/home/settings";
		}
		if(p == 'ecae7380-8d76-11e3-baa8-0800200c9a66'){
			return  baseUrl + "/home/help";
		}
		if(p == 'f5cb8520-8d76-11e3-baa8-0800200c9a66'){
			return  baseUrl + "/home/newgrocerybag";
		}
		if(p == 'ffcb8520-8d76-33e3-bcc8-3850211c9a66'){
			return baseUrl + "/home/editgrocerybag";
		}
        return "";

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