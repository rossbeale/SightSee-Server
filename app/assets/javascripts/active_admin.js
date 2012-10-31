//= require active_admin/base

jQuery(document).ready(function ($) {

  	$('<div id="map" style="display:block;margin:10px;height:250px;"></div>').insertBefore('#location_lat_input');
  
  	var map = new google.maps.Map(document.getElementById('map'), {
  		zoom: 15,
  		mapTypeId: google.maps.MapTypeId.ROADMAP
  	});
  
	var location;
	var marker;
	
 	if (document.getElementById('location_lat').value && document.getElementById('location_lng').value) {
		location = new google.maps.LatLng(document.getElementById('location_lat').value, document.getElementById('location_lng').value);
		setMarker();
	}else if (navigator.geolocation) {
		navigator.geolocation.getCurrentPosition(function(position) {
			location = new google.maps.LatLng(position.coords.latitude,position.coords.longitude);
			setMarker();
		}, function() {
			location = new google.maps.LatLng(51.458809, -0.919594);
			setMarker();
		});
	}else{
		location = new google.maps.LatLng(51.458809, -0.919594);
		setMarker();
	}
	
	function setMarker(){
		document.getElementById('location_lat').value = location.lat();
		document.getElementById('location_lng').value = location.lng();
		marker = new google.maps.Marker({
			 position: location,
			 title: "Drag Me!",
			 draggable: true
		});
		marker.setMap(map);
		map.setCenter(location);
	}
	
	$('#location_lat').on('change', function() {
		if(marker) marker.setMap(null);
		if (document.getElementById('location_lat').value && document.getElementById('location_lng').value) {
			var location = new google.maps.LatLng(document.getElementById('location_lat').value, document.getElementById('location_lng').value);
			marker = new google.maps.Marker({
				 position: location,
				 title: "Drag Me!",
				 draggable: true
			});
			marker.setMap(map);
			map.setCenter(location);
		}
	});
	
	$('#location_lng').on('change', function() {
		if(marker) marker.setMap(null);
		if (document.getElementById('location_lat').value && document.getElementById('location_lng').value) {
			var location = new google.maps.LatLng(document.getElementById('location_lat').value, document.getElementById('location_lng').value);
			marker = new google.maps.Marker({
				 position: location,
				 title: "Drag Me!",
				 draggable: true
			});
			marker.setMap(map);
			map.setCenter(location);
		}
	});
	
	google.maps.event.addListener(marker, 'dragend', function() {
	    location = marker.getPosition();
		document.getElementById('location_lat').value = location.lat();
		document.getElementById('location_lng').value = location.lng();
	  });
					
});