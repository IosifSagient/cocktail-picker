<!DOCTYPE html>
<html>
<head>
    <title>Cocktail Picker</title>

    <link rel="stylesheet" href="css/style.css">
    <style>
        .custom-map-control-button {
            background-color: #fff;
            border: 0;
            border-radius: 2px;
            box-shadow: 0 1px 4px -1px rgba(0, 0, 0, 0.3);
            margin: 10px;
            padding: 0 0.5em;
            font: 400 18px Roboto, Arial, sans-serif;
            overflow: hidden;
            height: 40px;
            cursor: pointer;
        }
        .custom-map-control-button:hover {
            background: #ebebeb;
        }
        .pac-card {
            background-color: #fff;
            border: 0;
            border-radius: 2px;
            box-shadow: 0 1px 4px -1px rgba(0, 0, 0, 0.3);
            margin: 10px;
            padding: 0 0.5em;
            font: 400 18px Roboto, Arial, sans-serif;
            overflow: hidden;
            font-family: Roboto;
            padding: 0;
        }

        #pac-container {
            padding-bottom: 12px;
            margin-right: 12px;
        }

        .pac-controls {
            display: inline-block;
            padding: 5px 11px;
        }

        .pac-controls label {
            font-family: Roboto;
            font-size: 13px;
            font-weight: 300;
        }

        #pac-input {
            background-color: #fff;
            border: 0;
            margin: 10px;
            padding: 0 0.5em;
            font-family: Roboto;
            font-size: 15px;
            font-weight: 300;
            margin-left: 12px;
            padding: 0 11px 0 13px;
            text-overflow: ellipsis;
            width: 400px;
            height: 40px;
        }

        #pac-input:focus {
            border-color: #4d90fe;
        }
    </style>

</head>
<body style="background-image: url(images/cocktails.jpg);">

<!-- Google Maps -->
<script>
    var map, service, infoWindow;
    var myLoc = {lat: 37.9808552, lng: 23.7304957};

    function initMap() {
        map = new google.maps.Map(document.getElementById('map'), {
            center: myLoc,
            zoom: 15
        });
        infoWindow = new google.maps.InfoWindow();

        var request = {
            location: myLoc,
            radius: 8024,
            types: ['bar']
        }

        service = new google.maps.places.PlacesService(map);
        service.nearbySearch(request, callback);

        // Create Pan to Current Location button
        const locationButton = document.createElement("button");

        locationButton.textContent = "Pan to Current Location";
        locationButton.classList.add("custom-map-control-button");
        map.controls[google.maps.ControlPosition.TOP_CENTER].push(locationButton);
        locationButton.addEventListener("click", () => {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(
                    (position) => {
                        const pos = {
                            lat: position.coords.latitude,
                            lng: position.coords.longitude,
                        };

                        infoWindow.setPosition(pos);
                        infoWindow.setContent("Location found.");
                        infoWindow.open(map);
                        map.setCenter(pos);
                        service = new google.maps.places.PlacesService(map);
                        service.nearbySearch({
                            location: pos,
                            radius: 5000,
                            types: ['bar'] }, callback);
                    },
                    () => {
                        handleLocationError(true, infoWindow, map.getCenter());
                    }
                );
            } else {
                // Browser doesn't support Geolocation
                handleLocationError(false, infoWindow, map.getCenter());
            }
        });

        // Create the search box and link it to the UI element.
        const input = document.getElementById("pac-input");
        const searchBox = new google.maps.places.SearchBox(input);

        map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);
        // Bias the SearchBox results towards current map's viewport.
        map.addListener("bounds_changed", () => {
            searchBox.setBounds(map.getBounds());
        });

        let markers = [];

        // Listen for the event fired when the user selects a prediction and retrieve
        // more details for that place.
        searchBox.addListener("places_changed", () => {
            const places = searchBox.getPlaces();

            if (places.length == 0) {
                return;
            }

            // Clear out the old markers.
            markers.forEach((marker) => {
                marker.setMap(null);
            });
            markers = [];

            // For each place, get the icon, name and location.
            const bounds = new google.maps.LatLngBounds();

            places.forEach((place) => {
                if (!place.geometry || !place.geometry.location) {
                    console.log("Returned place contains no geometry");
                    return;
                }

                const icon = {
                    url: place.icon,
                    size: new google.maps.Size(71, 71),
                    origin: new google.maps.Point(0, 0),
                    anchor: new google.maps.Point(17, 34),
                    scaledSize: new google.maps.Size(25, 25),
                };

                // Create a marker for each place.
                markers.push(
                    new google.maps.Marker({
                        map,
                        icon,
                        title: place.name,
                        position: place.geometry.location,
                    })
                );
                if (place.geometry.viewport) {
                    // Only geocodes have viewport.
                    bounds.union(place.geometry.viewport);
                } else {
                    bounds.extend(place.geometry.location);
                }
            });
            map.fitBounds(bounds);
        });
    }

    function callback(results, status) {
        if (status == google.maps.places.PlacesServiceStatus.OK) {
            console.log(results.length);
            for (var i = 0; i < results.length; i++) {
                createMarker(results[i]);
            }
        }
    }

    function createMarker(place) {
        var marker = new google.maps.Marker({
            map: map,
            position: place.geometry.location,
            title: place.name
        });
        var request = { reference: place.place_id };
        service.getDetails(request, function(details, status) {
            google.maps.event.addListener(marker, 'click', function() {
                infoWindow.setContent(details.name + "<br />" + details.formatted_address + "<br />" + details.formatted_phone_number);
                infoWindow.open(map, this);
            });
        });
    }

    function handleLocationError(browserHasGeolocation, infoWindow, pos) {
        infoWindow.setPosition(pos);
        infoWindow.setContent(
            browserHasGeolocation
                ? "Error: The Geolocation service failed."
                : "Error: Your browser doesn't support geolocation."
        );
        infoWindow.open(map);
    }
</script>

<!--header-->
<div class="header">
    <a id="back" href="javascript:history.back()" class="navbar-brand scroll-top" style="float: left; border: 2px solid darkred;">BACK</a>
    <div class="container">
        <h1 style="text-align:center; font-size: 40px; color: white; display:block;">Find nearest bar</h1>
    </div>
</div>
<input
        id="pac-input"
        class="controls"
        type="text"
        placeholder="Search Box"
/>
<div id="map" style="width:100%; height:600px;"></div>

<!-- Async script executes immediately and must be after any DOM elements used in callback. -->
<script
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBaSgU8JV7VZSce0m0SDzQTN_pLIFavT_8&callback=initMap&libraries=places&v=weekly"
        async
></script>

</body>
</html>
