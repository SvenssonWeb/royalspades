<script>
	window.location.hash = "p=" + "${pageUid}";
	
	
	function createDiv(){
		return "<div>TEST</div>";
	}
</script>
<h2>API Hjälp</h2>
<br />
<div>
	<p>Information om API, allt i {} ska ersättas med ett id text "{userId}" borde ersättas med rätt id tex. "2"</p>
	<p>Säkerhet: står för vilka som har rätt att göra det. tex. "Säkerhet: admin" så är det bara admin som kan göra det.</p>
	<p>All data skickas som JSON strängar: {"name":"butik1","orgNumber":"9384284","address":"denvägen 3","phone":"047099999"} är tex. en Leverantör.</p>
	<p>Svar på alla förfrågningar ges med korrekt svarstatus och en svarsträng.</p>
	<p>Inget som används kan tas bort.</p>
	<p>Rubriken står för vilken metod som ska användas: GET, POST, PUT, DELETE</p>
</div>
<br />
<div>
	<h3>GET</h3>
	<br />
	<h4>/api/store/all</h4>
	<p>Listar alla butiker, Säkerhet: Alla användare.</p>
	<h4>/api/store/{id}</h4>
	<p>Hämta enskild butik, Säkerhet: Alla användare.</p>
	<h4>/api/store/owner/{userId}</h4>
	<p>Hämtar butik/butiker som användare är butiksägare för, Säkerhet: Bara satt butiksägare.</p>
	<h4>/api/brand/all</h4>
	<p>Listar alla leverantörer, Säkerhet: Alla användare.</p>
	<h4>/api/brand/{id}</h4>
	<p>Hämtar enskild leverantör, Säkerhet: Alla användare.</p>
	<h4>/api/brand/owner/{ownerId}</h4>
	<p>Hämtar leverantör/leverantörer som användare är leverantörägare för, Säkerhet: Bara satt leverantörägare.</p>
	<h4>/api/category/all</h4>
	<p>Listar alla kategorier, Säkerhet: Alla användare.</p>
	<h4>/api/category/{id}</h4>
	<p>Hämtar enskild kategori, Säkerhet: Alla användare.</p>
	<h4>/api/grocerylist/all</h4>
	<p>Listar alla shoppinglistor, Säkerhet: Admin</p>
	<h4>/api/grocerylist/{id}</h4>
	<p>Hämtar enskild shoppinglista, Säkerhet: Alla användare.</p>
	<h4>/api/grocerylist/user/{userId}</h4>
	<p>Listar shoppinglistor för användare, Säkerhet: Bara listägare.</p>
	<h4>/api/product/all</h4>
	<p>Listar alla produkter, Säkerhet: Alla användare.</p>
	<h4>/api/product/{id}</h4>
	<p>Hämtar enskild product, Säkerhet: Alla användare</p>
	<h4>/api/product/category/{categoryId}</h4>
	<p>Listar alla produkter som tillhör kategori, Säkerhet: Alla användare.</p>
	<h4>/api/admin/user/all</h4>
	<p>Listar alla användare, Säkerhet: Admin</p>
	<h4>/api/user/{userName}</h4>
	<p>Hämtar enskild användare, Säkerhet: Du kan bara se din egen användare.</p>
	<h4>/api/admin/user/{id}</h4>
	<p>Hämtar enskild användare, Säkerhet: Admin</p>
	<h4>/api/admin/user/shop_managers</h4>
	<p>Listar alla användare som är butiksägare, Säkerhet: Admin</p>
	<h4>/api/admin/user/brand_managers</h4>
	<p>Listar alla användare som är leverantörsägare, Säkerhet: Admin</p>
	<h4>/api/admin/get_users_requesting_higher_authority</h4>
	<p>Listar alla användare som ansökt om högre behörighet, Säkerhet: Admin</p>
</div>
<br />
<br />
<div>
	<h3>POST</h3>
	<br />
	<h4>/api/store/admin/add_store/{userId}</h4>
	<p>Skapa butik, Säkerhet: Admin</p>
	<h4>/api/brand/admin/add_brand/{userId}</h4>
	<p>Skapa leverantör, Säkerhet: Admin</p>
	<h4>/api/category/admin/add_category</h4>
	<p>Skapa kategori, Säkerhet: Admin</p>
	<h4>/api/grocerylist/add_grocery_list/{userId}</h4>
	<p>Skapa shoppinglist för användare, Säkerhet: Kan bara skapa listor till din egen användare</p>
	<h4>/api/product/add_product/category/{categoryId}/brand/{brandId}</h4>
	<p>Lägg till produkt till ditt varumärke, Säkerhet: Bara leverantörsägare kan lägga till produkter till sitt varumärke.</p>
	<h4>/api/product/add_product_to_store/{storeId}/product/{productId}/store_category/{storeCategory}</h4>
	<p>Lägg till produkt till din butik, pris skickas som JSON ex: 144, Säkerhet: Bara butiksägaren kan lägga till produkter till sin butik.</p>
	<h4>/api/user/new_user</h4>
	<p>Skapa ny användare, Säkerhet: Ingen.</p>
</div>
<br />
<br />
<div>
	<h3>PUT</h3>
	<br />
	<h4>/api/grocerylist/add_product_to_grocery_list/{listid}/product/{productId}</h4>
	<p>Lägg till product till din shoppinglista, volym skickas som JSON ex. {"volume":"12"}, Säkerhet: Du kan bara lägga till i listor du själv äger.</p>
	<h4>/api/store/admin/edit_store/{storeId}</h4>
	<p>Ändra butik, Säkerhet: Admin.</p>
	<h4>/api/store/edit_my_store</h4>	
	<p>Ändra din butik, Säkerhet: Du kan bara ändra din egen butik. Som du är ägare för.</p>
	<h4>/api/brand/admin/edit_brand/{brandId}</h4>
	<p>Ändra leverantör, Säkerhet: Admin.</p>
	<h4>/api/brand/edit_my_brand</h4>
	<p>Ändra din leverantör, Säkerhet: Du kan bara ändra din leverantör. Som du är ägare för.</p>
	<h4>/api/category/admin/edit_category</h4>
	<p>Editera kategory, Säkerhet: Admin.</p>
	<h4>/api/grocerylist/edit_grocery_list/{listId}</h4>
	<p>Ändra shoppinglista, Säkerhet: Du kan bara ändra din egen lista.</p>
	<h4>/api/product/edit_brand_product/category/{categoryId}/brand/{brandId}</h4>
	<p>Ändra ditt varumärke, Säkerhet: Du kan bara ändra det varumärket du är ägare för.</p>
	<h4>/api/admin/user/edit_user</h4>
	<p>Ändra användarkonto, Säkerhet: Admin</p>
	<h4>/api/user/edit_account</h4>
	<p>Ändra ditt användarkonto, Säkerhet: Du kan bara ändra ditt eget konto.</p>
	<h4>/api/user/edit_password</h4>
	<p>Ändra ditt lösenord, (JSON ex. {"userId":"23","password":"hej","repeatPassword":"haa","oldPassword":"daa"}) Säkerhet: Du kan bara ändra ditt eget konto.</p>
	<h4>/api/admin/set_new_password/user/{userId}</h4>
	<p>Sätt nytt lösenord för användare, skicka lösenord i body som "lösenord", Säkerhet: Admin.</p>
	<h4>/api/user/{userId}/request_authority</h4>
	<p>Begär högre behörighet på ditt konto. Skicka behörigheten som ex: "producer", Säkerhet: Alla användare.</p>
	<h4>/api/admin/authorize/user/{userId}</h4>
	<p>Bekräfta ansökning om högre behörighet.Skicka behörigheten som ex: "producer", Säkerhet: Admin.</p>
</div>
<br />
<br />
<div>
	<h3>DELETE</h3>
	<br />
	<h4>/api/store/admin/remove_store/{storeId}</h4>
	<p>Ta bort butik, Säkerhet: Admin.</p>
	<h4>/api/brand/admin/remove_brand/{brandId}</h4>
	<p>Ta bort leverantör, Säkerhet: Admin.</p>
	<h4>/api/category/admin/remove_category/{id}</h4>
	<p>Ta bort kategori, Säkerhet: Admin.</p>
	<h4>/api/admin/remove_user/{userId}</h4>
	<p>Ta bort användare, Säkerhet: Admin</p>
	<h4>/api/product/remove_product/{productId}</h4>
	<p>Ta bort product ifrån leverantör, Säkerhet: Du kan bara ta bort produkter ifrån ditt varumärke.</p>
	<h4>/api/product/remove_product_from_store/{storeId}/product/{productId}/category/{categoryId}</h4>
	<p>Ta bort produkt ifrån Butik, Säkerhet: Du kan bara ta bort produkter ifrån butiker du är butiksägare för.</p>
	<h4>/api/grocerylist/delete_product_from_groery_list/{listId}/product/{productId}</h4>
	<p>Ta bort produkt ifrån shoppinglista, Säkerhet: Du kan bara ta bort produkter ifrån din egen shoppinglista.</p>
	<h4>/api/grocerylist/remove_grocery_list/{listId}</h4>
	<p>Ta bort shoppinglista, Säkerhet: Du kan bara ta bort dina egna shoppinglistor.</p>
</div>