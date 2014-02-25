<script>
	window.location.hash = "p=" + '${pageUid}';
</script>
<h2> 
	Butiker
</h2>
<a class="link" href="newShop">Ny butik</a>
<br />
<table id="dataTable" class="shopTable listtable">
	<thead>
		<tr>
			<th>
				Namn
			</th>
			<th>
				Adress
			</th>
			<th>
				Postnummer
			</th>
			<th>
				Stad
			</th>
			<th>
				Org. nr
			</th>
			<th>
				Telefonnummer
			</th>
			<th>
				Kontaktperson
			</th>
			<th>
				
			</th>
		</tr>	
	</thead>
</table>
<br />
<div class="error"></div>

<script>
var oTable;

function deleteShop(event, id){
	$('.error').text("");
	
	if (confirm('är du säker på att du vill ta bort affären?')) {
   
		$.ajax({
			url:'/royalspades/api/store/admin/remove_store/' + id, 
			type:'DELETE',
  		 	contentType:'application/json',
		    accept:'application/json',
		    processData:false,
		    complete: function(response) {
	    		
	    		if(response.status == 200) {
	    			// shop was removed
		    		// remove from table
	    			var pos = oTable.fnGetPosition( $('#' + id)[0]);
	    	        oTable.fnDeleteRow(pos);
	    			$('#' + id).remove();
	    		} else {
	    			// can't remove that shop
	    			$('.error').text(response.responseText);
	    		}
			},
			error: function (response, data, textStatus, jqXHR) {
				if(response.status != 200){
					$('error').text("Error: " + textStatus + ", " + jqXHR);
				}
			}
	    });
    }
	return false;
}	

$( document ).ready(function() {	

	function preZero(s){
		s += "";
		if(s.length < 2){
			s = "0" + s;
		}
		return s;
	}
	
	var d = new Date();
	$("input[name$='date']").val(d.getFullYear() + "-" + preZero(d.getMonth()+1) + "-" + preZero(d.getDate()) + " " + preZero(d.getHours()) + ":" + preZero(d.getMinutes())).prop('disabled', true);
	
	$.ajax({
		type: "GET",
		url: "/royalspades/api/store/all/",
		headers: {
			'Accept':"application/json",
			'Content-Type':"application/json"
		},
		dataType: "json",
		success: function (data, textStatus, jqXHR) {
			var arr = data;
			
			$(".shopTable").append("<tbody>");
			for(var i = 0; i < arr.length; i++){
				var row = "<tr id=" + arr[i].id + ">" + "<td>";
				row += arr[i].name;
				row += '</td><td style="text-align:right;">';
				row += arr[i].address;
				row += "</td><td>";
				row += arr[i].postalCode;
				row += "</td><td>";
				row += arr[i].city;
				row += "</td><td>";
				row += arr[i].orgNumber;
				row += "</td><td>";
				row += arr[i].phone;
				row += "</td><td>";
				
				if($.isNumeric(arr[i].user)){
				    for(var j = 0; j < arr.length; j++){
				     if(arr[j].user['@id'] == arr[i].user){
				      arr[i].user = arr[j].user;
						row += arr[i].user.firstName + " " + arr[i].user.lastName + " (" + arr[i].user.email + ")";
				     }
				    }
				   } else {
						row += arr[i].user.firstName + " " + arr[i].user.lastName + " (" + arr[i].user.email + ")";
				   }

				row += '</td><td style="text-align:center;">';
				row += '<a class="link" href="editShop/?id=' + arr[i].id + '"><i class="fa fa-pencil"></i></a>';
				row += '&nbsp;<a class="no_refresh" href="#" onclick="deleteShop(event, ' + arr[i].id + ')"><i class="fa fa-times"></i></a>';
				row += "</td></tr>";
				$(".shopTable").append(row);
			}
			
		    $(".shopTable").append("</tbody>");
		    
			oTable = $('.shopTable').dataTable({
				"aLengthMenu": [
		            [25, 50, 100, -1],
		            [25, 50, 100, "All"]],
				"iDisplayLength" : -1,
		        "bScrollInfinite": true,
		        "bScrollCollapse": false,
		        "sScrollY": "300px",
				"oLanguage": {
					"sLengthMenu": "Visar _MENU_ butiker per sida",
					"sZeroRecords": "Hittade inget - tyvärr",
					"sInfo": "Visar _START_ till _END_ av _TOTAL_ varor",
					"sInfoEmpty": "Visar 0 av 0 butiker",
					"sInfoFiltered": "(filtrerat från _MAX_ varor)",
					"sSearch": "Filtrera: "
				}		
			});
		},
		error: function (data, textStatus, jqXHR) {
			alert("Error: " + textStatus + ", " + jqXHR);
		}
	});
	
});
</script>