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
					openPageUrlAndUpdateHash(this.href, this.id.replace("topMenuLink",""));
				});
		});
	}
	
	function openMainPage(){
		openPageUrl(baseUrl + "/admin/main/");
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
		
		$(".link").click(function (event){
			event.preventDefault();
			openPageUrl(this.href);
		});
	}
	
	function getUrl(p){
		if(p == '9e60de60-8d77-11e3-baa8-0800200c9a66'){
			return  baseUrl + "/admin/main";
		}
		if(p == 'a82b9520-8d77-11e3-baa8-0800200c9a66'){
			return  baseUrl + "/admin/shops";
		}
		if(p == 'ae8fef60-8d77-11e3-baa8-0800200c9a66'){
			return  baseUrl + "/admin/suppliers";
		}
		if(p == '39af771a-f069-4e2a-bce9-bd2e2f8b383a'){
			//redirect to shops since no id
			return  baseUrl + "/admin/shops";
		}
		if(p == 'cf3daa14-80ef-4da3-9d4e-e00ad67174cf'){
			return  baseUrl + "/admin/newShop";
		}
		if(p == '9d175af0-f947-4827-8e93-cd44a8531d1a'){
			return  baseUrl + "/admin/editShop";
		}
		if(p == 'cfcd9e0b-c1cd-4122-9486-b96cb026bb3c'){
			return  baseUrl + "/admin/editSupplier";
		}
		if(p == 'ad1gef60-8d22-33r3-baa8-0555020c9r66'){
			return  baseUrl + "/admin/newSupplier";
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