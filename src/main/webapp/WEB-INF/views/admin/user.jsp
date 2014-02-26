<script>
	window.location.hash = "p=" + '${pageUid}';
</script>
<h2> 
	Anv�ndare
</h2>

<br />
<table id="dataTable" class="userTable listtable">
	<thead>
		<tr>
			<th>
				Anv�ndarnamn
			</th>
			<th>
				Email
			</th>
			<th>
				F�rnamn
			</th>
			<th>
				Efternamn
			</th>
			<th>
				Roll
			</th>
			<th>
				Beg�rd beh�righet
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

function deleteUser(event, id){
	$('.error').text("");
	
	if (confirm('�r du s�ker p� att du vill ta bort denna anv�ndare?')) {
   
		$.ajax({
			url:baseUrl+'/api/brand/admin/remove_brand/' + id,
			type:'DELETE',
  		  	contentType:'application/json',
		  	accept:'application/json',
		  	processData:false,
			complete: function(response) {
	    		
	    		if(response.status == 200){
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
					$('.error').text("Error: " + textStatus + ", " + jqXHR);
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
		url: baseUrl+"/api/admin/user/all/",
		headers: {
			'Accept':"application/json",
			'Content-Type':"application/json"
		},
		dataType: "json",
		success: function (data, textStatus, jqXHR) {
			var arr = data;
			
			$(".supplierTable").append("<tbody>");
			for(var i = 0; i < arr.length; i++){
				var row = "<tr id=" + arr[i].id + ">" + "<td>";
				row += arr[i].username;
				row += '</td><td style="text-align:right;">';
				row += arr[i].email;
				row += "</td><td>";
				row += arr[i].firstName;
				row += "</td><td>";
				row += arr[i].lastName;
				row += "</td><td>";
				row += arr[i].role;
				row += "</td><td>";
				row += arr[i].requestedAuthority;
				row += "</td><td>";
				row += '</td><td style="text-align:center;">';
				row += '<a class="link" href="editUser/?id=' + arr[i].id + '"><i class="fa fa-pencil"></i></a>';
				row += '&nbsp;<a class="no_refresh" href="#" onclick="deleteUser(event, ' + arr[i].id + ')"><i class="fa fa-times"></i></a>';
				row += "</td></tr>";
				$(".supplierTable").append(row);
			}
			
			$(".userTable").append("</tbody>");
			
			oTable = $('.supplierTable').dataTable({
				"aLengthMenu": [
		            [25, 50, 100, -1],
		            [25, 50, 100, "All"]],
				"iDisplayLength" : -1,
		        "bScrollInfinite": true,
		        "bScrollCollapse": false,
		        "sScrollY": "300px",
				"oLanguage": {
					"sLengthMenu": "Visar _MENU_ anv�ndare per sida",
					"sZeroRecords": "Hittade inget - tyv�rr",
					"sInfo": "Visar _START_ till _END_ av _TOTAL_ anv�ndare",
					"sInfoEmpty": "Visar 0 av 0 anv�ndare",
					"sInfoFiltered": "(filtrerat fr�n _MAX_ anv�ndare)",
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