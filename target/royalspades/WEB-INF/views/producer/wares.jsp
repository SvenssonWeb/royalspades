<script>
	window.location.hash = "p=" + "${pageUid}";
</script>
<h2>
	Varor
</h2>
<p>
	H�r kan du uppdatera dina varor.
</p>
<fieldset class="newWare">
	<legend>Ny vara</legend>
	<form name="addWare" action="#" method="post">
		<table class="formtable">
			<tr>
				<td>
					<label for="name">Namn: </label>
				</td>
				<td>
					<input type="text" id="name">
				</td>
			</tr>
			<tr>
				<td>
					<label for="category">Kategori: </label>
				</td>
				<td>
					<select>
						<option value="mej">Mejeri</option>
						<option value="fog">Frukt o Gr�nt</option>
						<option value="kot">K�tt</option>
						<option value="las">L�skeblask</option>
					</select>
				</td>		
			</tr>
			<tr>
				<td>
					<input type="Submit" value="L�gg till">
				</td>
				<td>
				</td>
			</tr>
		</table>
	</form>
</fieldset>
<fieldset class="allWares">
	<legend>Alla varor</legend>
	<table class="listtable">
		<tr>
			<th>
				Namn &darr;
			</th>
			<th>
				Kategori &darr;
			</th>
			<th>
				&nbsp;
			</th>
		</tr>
		<tr>
			<td>
				Fanta
			</td>
			<td>
				L�skeblask
			</td>
			<td>
				<a href="#"><img src="http://i.imgur.com/vwJIAvn.png" width="20"></a>
			</td>
		</tr>
	</table>
</fieldset>