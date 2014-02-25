<script>
	window.location.hash = "p=" + "${pageUid}";
	
	
	function createDiv(){
		return "<div>TEST</div>";
	}
</script>
<h2>API Hj�lp</h2>
<br />
<div>
	<p>Information om API, allt i {} ska ers�ttas med ett id text "{userId}" borde ers�ttas med r�tt id tex. "2"</p>
	<p>S�kerhet: st�r f�r vilka som har r�tt att g�ra det. tex. "S�kerhet: admin" s� �r det bara admin som kan g�ra det.</p>
	<p>All data skickas som JSON str�ngar: {"name":"butik1","orgNumber":"9384284","address":"denv�gen 3","phone":"047099999"} �r tex. en Leverant�r.</p>
	<p>Svar p� alla f�rfr�gningar ges med korrekt svarstatus och en svarstr�ng.</p>
	<p>Inget som anv�nds kan tas bort.</p>
	<p>Rubriken st�r f�r vilken metod som ska anv�ndas: GET, POST, PUT, DELETE</p>
</div>
<br />
<div>
	<h3>GET</h3>
	<br />
	<h4>/api/store/all</h4>
	<p>Listar alla butiker, S�kerhet: Alla anv�ndare.</p>
	<h4>/api/store/{id}</h4>
	<p>H�mta enskild butik, S�kerhet: Alla anv�ndare.</p>
	<h4>/api/store/owner/{userId}</h4>
	<p>H�mtar butik/butiker som anv�ndare �r butiks�gare f�r, S�kerhet: Bara satt butiks�gare.</p>
	<h4>/api/brand/all</h4>
	<p>Listar alla leverant�rer, S�kerhet: Alla anv�ndare.</p>
	<h4>/api/brand/{id}</h4>
	<p>H�mtar enskild leverant�r, S�kerhet: Alla anv�ndare.</p>
	<h4>/api/brand/owner/{ownerId}</h4>
	<p>H�mtar leverant�r/leverant�rer som anv�ndare �r leverant�r�gare f�r, S�kerhet: Bara satt leverant�r�gare.</p>
	<h4>/api/category/all</h4>
	<p>Listar alla kategorier, S�kerhet: Alla anv�ndare.</p>
	<h4>/api/category/{id}</h4>
	<p>H�mtar enskild kategori, S�kerhet: Alla anv�ndare.</p>
	<h4>/api/grocerylist/all</h4>
	<p>Listar alla shoppinglistor, S�kerhet: Admin</p>
	<h4>/api/grocerylist/{id}</h4>
	<p>H�mtar enskild shoppinglista, S�kerhet: Alla anv�ndare.</p>
	<h4>/api/grocerylist/user/{userId}</h4>
	<p>Listar shoppinglistor f�r anv�ndare, S�kerhet: Bara list�gare.</p>
	<h4>/api/product/all</h4>
	<p>Listar alla produkter, S�kerhet: Alla anv�ndare.</p>
	<h4>/api/product/{id}</h4>
	<p>H�mtar enskild product, S�kerhet: Alla anv�ndare</p>
	<h4>/api/product/category/{categoryId}</h4>
	<p>Listar alla produkter som tillh�r kategori, S�kerhet: Alla anv�ndare.</p>
	<h4>/api/admin/user/all</h4>
	<p>Listar alla anv�ndare, S�kerhet: Admin</p>
	<h4>/api/user/{userName}</h4>
	<p>H�mtar enskild anv�ndare, S�kerhet: Du kan bara se din egen anv�ndare.</p>
	<h4>/api/admin/user/shop_managers</h4>
	<p>Listar alla anv�ndare som �r butiks�gare, S�kerhet: Admin</p>
	<h4>/api/admin/user/brand_managers</h4>
	<p>Listar alla anv�ndare som �r leverant�rs�gare, S�kerhet: Admin</p>
	<h4>/api/admin/get_users_requesting_higher_authority</h4>
	<p>Listar alla anv�ndare som ans�kt om h�gre beh�righet, S�kerhet: Admin</p>
</div>
<br />
<br />
<div>
	<h3>POST</h3>
	<br />
	<h4>/api/store/admin/add_store/{userId}</h4>
	<p>Skapa butik, S�kerhet: Admin</p>
	<h4>/api/brand/admin/add_brand/{userId}</h4>
	<p>Skapa leverant�r, S�kerhet: Admin</p>
	<h4>/api/category/admin/add_category</h4>
	<p>Skapa kategori, S�kerhet: Admin</p>
	<h4>/api/grocerylist/add_grocery_list/{userId}</h4>
	<p>Skapa shoppinglist f�r anv�ndare, S�kerhet: Kan bara skapa listor till din egen anv�ndare</p>
	<h4>/api/product/add_product/category/{categoryId}/brand/{brandId}</h4>
	<p>L�gg till produkt till ditt varum�rke, S�kerhet: Bara leverant�rs�gare kan l�gga till produkter till sitt varum�rke.</p>
	<h4>/api/product/add_product_to_store/{storeId}/product/{productId}/store_category/{storeCategory}</h4>
	<p>L�gg till produkt till din butik, pris skickas som JSON ex: 144, S�kerhet: Bara butiks�garen kan l�gga till produkter till sin butik.</p>
	<h4>/api/user/new_user</h4>
	<p>Skapa ny anv�ndare, S�kerhet: Ingen.</p>
</div>
<br />
<br />
<div>
	<h3>PUT</h3>
	<br />
	<h4>/api/grocerylist/add_product_to_grocery_list/{listid}/product/{productId}</h4>
	<p>L�gg till product till din shoppinglista, volym skickas som JSON ex. {"volume":"12"}, S�kerhet: Du kan bara l�gga till i listor du sj�lv �ger.</p>
	<h4>/api/store/admin/edit_store/{storeId}</h4>
	<p>�ndra butik, S�kerhet: Admin.</p>
	<h4>/api/store/edit_my_store</h4>	
	<p>�ndra din butik, S�kerhet: Du kan bara �ndra din egen butik. Som du �r �gare f�r.</p>
	<h4>/api/brand/admin/edit_brand/{brandId}</h4>
	<p>�ndra leverant�r, S�kerhet: Admin.</p>
	<h4>/api/brand/edit_my_brand</h4>
	<p>�ndra din leverant�r, S�kerhet: Du kan bara �ndra din leverant�r. Som du �r �gare f�r.</p>
	<h4>/api/category/admin/edit_category</h4>
	<p>Editera kategory, S�kerhet: Admin.</p>
	<h4>/api/grocerylist/edit_grocery_list/{listId}</h4>
	<p>�ndra shoppinglista, S�kerhet: Du kan bara �ndra din egen lista.</p>
	<h4>/api/product/edit_brand_product/category/{categoryId}/brand/{brandId}</h4>
	<p>�ndra ditt varum�rke, S�kerhet: Du kan bara �ndra det varum�rket du �r �gare f�r.</p>
	<h4>/api/admin/user/edit_user</h4>
	<p>�ndra anv�ndarkonto, S�kerhet: Admin</p>
	<h4>/api/user/edit_account</h4>
	<p>�ndra ditt anv�ndarkonto, S�kerhet: Du kan bara �ndra ditt eget konto.</p>
	<h4>/api/user/edit_password</h4>
	<p>�ndra ditt l�senord, (JSON ex. {"userId":"23","password":"hej","repeatPassword":"haa","oldPassword":"daa"}) S�kerhet: Du kan bara �ndra ditt eget konto.</p>
	<h4>/api/admin/set_new_password/user/{userId}</h4>
	<p>S�tt nytt l�senord f�r anv�ndare, S�kerhet: Admin.</p>
	<h4>/api/user/{userId}/request_authority</h4>
	<p>Beg�r h�gre beh�righet p� ditt konto. Skicka beh�righeten som ex: ""producer", S�kerhet: Alla anv�ndare.</p>
	<h4>/api/admin/authorize/user/{userId}</h4>
	<p>Bekr�fta ans�kning om h�gre beh�righet, S�kerhet: Admin.</p>
</div>
<br />
<br />
<div>
	<h3>DELETE</h3>
	<br />
	<h4>/api/store/admin/remove_store/{storeId}</h4>
	<p>Ta bort butik, S�kerhet: Admin.</p>
	<h4>/api/brand/admin/remove_brand/{brandId}</h4>
	<p>Ta bort leverant�r, S�kerhet: Admin.</p>
	<h4>/api/category/admin/remove_category/{id}</h4>
	<p>Ta bort kategori, S�kerhet: Admin.</p>
	<h4>/api/admin/remove_user/{userId}</h4>
	<p>Ta bort anv�ndare, S�kerhet: Admin</p>
	<h4>/api/product/remove_product/{productId}</h4>
	<p>Ta bort product ifr�n leverant�r, S�kerhet: Du kan bara ta bort produkter ifr�n ditt varum�rke.</p>
	<h4>/api/product/remove_product_from_store/{storeId}/product/{productId}/category/{categoryId}</h4>
	<p>Ta bort produkt ifr�n Butik, S�kerhet: Du kan bara ta bort produkter ifr�n butiker du �r butiks�gare f�r.</p>
	<h4>/api/grocerylist/delete_product_from_groery_list/{listId}/product/{productId}</h4>
	<p>Ta bort produkt ifr�n shoppinglista, S�kerhet: Du kan bara ta bort produkter ifr�n din egen shoppinglista.</p>
	<h4>/api/grocerylist/remove_grocery_list/{listId}</h4>
	<p>Ta bort shoppinglista, S�kerhet: Du kan bara ta bort dina egna shoppinglistor.</p>
</div>