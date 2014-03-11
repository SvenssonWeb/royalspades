$( document ).ready(function() {
	var newData;
	var fadeOutTime = 200;
	var fadeInTime = 200;
	
	function getMenu(){
	    var menuUrl = baseUrl + "/menu/admin";
		
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
		openPageUrl(baseUrl + "/admin/main/");
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
	    //setTimeout(refreshLinks, 250);
	    setTimeout(refreshLinks, 500);
	   // setTimeout(refreshLinks, 2000);
	 }
		 
	function refreshLinks(){
		$('.link').off();
		$(".link").click(function (event){
			event.preventDefault();
		    openPageUrl(this.href);
		});
	}
	
	function getUrl(p){
		if(p == '9e60de60-8d77-11e3-baa8-0800200c9a66'){
			//Start page
			return  baseUrl + "/admin/main";
		}
		if(p == 'a82b9520-8d77-11e3-baa8-0800200c9a66'){
			//Butiker
			return  baseUrl + "/admin/shops";
		}
		if(p == 'cf3daa14-80ef-4da3-9d4e-e00ad67174cf'){
			//Ny butik
			return  baseUrl + "/admin/newShop";
		}
		if(p == '39af771a-f069-4e2a-bce9-bd2e2f8b383a'){
			//Ändra butik - redirect till shops eftersom inget id
			return  baseUrl + "/admin/shops";
		}
		if(p == 'ae8fef60-8d77-11e3-baa8-0800200c9a66'){
			//Leverantör
			return  baseUrl + "/admin/suppliers";
		}
		if(p == 'ad1gef60-8d22-33r3-baa8-0555020c9r66'){
			//Ny leverantör
			return  baseUrl + "/admin/newSupplier";
		}
		if(p == 'cfcd9e0b-c1cd-4122-9486-b96cb026bb3c'){
			//Ändra leverantör - redirect till suppliers eftersom inget id
			return  baseUrl + "/admin/suppliers";
		}
		if(p == 'cf3daa14-80ef-4da3-7f9a-e00ad67174cf'){
			//Kategorier
			return baseUrl + "/admin/categories";
		}
		if(p == 'aa33de21-23cc-44e3-baa8-2230222c9a66'){
			//Inställningar
			return baseUrl + "/admin/settings";
		}
		if(p == 'b8d6db00-8d77-11e3-baa8-0800200c9a66'){
			//Användare
			return baseUrl + "/admin/users";
		}
		if(p == '1c63de21-99cc-21e3-baa8-9830222c9a66'){
			//Hjälp
			return baseUrl + "/admin/help";
		}
		if(p == '1c33de21-22cc-21e3-b1a8-1830222c9a66'){
			//API-hjälp
			return baseUrl + "/admin/apihelp";
		}
		/*if(p == ''){
			//
			return baseUrl + "";
		}*/
		
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