<script>
	window.location.hash = "p=" + "${pageUid}";
</script>
<h2>
	Kategorier
</h2>
<p>
	Här kan du uppdatera kategorier
</p>
<fieldset class="newCategory">
	<legend>Ny kategori</legend>
	<form name="addCategory" action="#" method="post">
		<table class="formtable">
			<tr>
				<td>
					<label for="category">Namn: </label>
				</td>
				<td>
					<input type="text" id="category">
				</td>
			</tr>
			<tr>
				<td>
					<input type="Submit" value="Lägg till">
				</td>
			</tr>
		</table>
	</form>
</fieldset>

<fieldset class="allCategories">
	<legend>Alla kategorier</legend>
	<table class="listtable">
		<tr>
			<th>
				Kategori &darr;
			</th>
			<th>
				&nbsp;
			</th>
		</tr>
		<tr>
			<td>
				Mejeri
			</td>
			<td>
				<a href="#"><img src="http://i.imgur.com/vwJIAvn.png" width="20"></a>
			</td>
		</tr>
		<tr>
			<td>
				Frukt o Grönt
			</td>
			<td>
				<a href="#"><img src="http://i.imgur.com/vwJIAvn.png" width="20"></a>
			</td>
		</tr>
		<tr>
			<td>
				Kött
			</td>
			<td>
				<a href="#"><img src="http://i.imgur.com/vwJIAvn.png" width="20"></a>
			</td>
		</tr>
		<tr>
			<td>
				Läskeblask
			</td>
			<td>
				<a href="#"><img src="http://i.imgur.com/vwJIAvn.png" width="20"></a>
			</td>
		</tr>
	</table>
</fieldset>