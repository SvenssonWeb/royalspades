<script>
	window.location.hash = "p=" + "${pageUid}";
</script>
<h2>
Ny matkasse
</h2>
<br />
<table>
	<tr>
		<td>
			<label for="groceryName">Namn:</label>
		</td>
		<td>
			<input id="groceryName"  name="name" type="text" />
			<input id="userId"  name="userId" type="hidden" />
		</td>
	</tr>
	<tr>
		<td>
			<label for="groceryDate">Skapad:</label>
		</td>
		<td>
			<input id="groceryDate" name="date" type="text" />
		</td>
	</tr>
</table>
<br />

<table id="dataTable" class="groceryTable listtable">
	<thead>
		<tr>
			<th>
				Varunamn
			</th>
			<th>
				M�ngd
			</th>
			<th>
				M�tt
			</th>
			<th>
				Leverant�r
			</th>
			<th>
				Kategori
			</th>
			<th>
				Antal
			</th>
			<th>
				L�gg till
			</th>
		</tr>	
	</thead>
</table>
<input type="submit" id="save" value="Skapa matkasse">
<br />
<br />
<div class="error"></div>
<div class="response"></div>
<script>
$( document ).ready(function() {	

	groceryStart("${username}");

});
</script>