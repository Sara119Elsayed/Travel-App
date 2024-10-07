import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_maps_webservices/places.dart' as google_maps_webservices;
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geocoding/geocoding.dart'; // Import geocoding package
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_autocomplete_text_field/model/prediction.dart';
import 'package:graduation_project/repository/repo.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'model/place_model/place_model.dart';

Color color = const Color(0xFFD79977);

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({Key? key}) : super(key: key);

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  late GoogleMapController _controller; // Not constant
  Position? _currentPosition;
  LatLng _currentLatLng = const LatLng(31.2357, 30.0444);
  String currentLocationName = "Fetching Location...";
  TextEditingController placeController = TextEditingController();
  List<LatLng> polylinePoints = [];
  List<Prediction> nearbyPlaces = [];
  bool isNearbyPlacesVisible = true;

  @override
  void initState() {
    super.initState();
    checkLocationPermission();
  }

  void checkLocationPermission() async {
    var permissionStatus = await Permission.location.status;
    if (permissionStatus.isDenied || permissionStatus.isRestricted) {
      showLocationEnableDialog(context);
    } else {
      getLocation();
    }
  }

  void showLocationEnableDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Enable Location Access"),
          content: Text("Please enable location access in app settings to use this feature."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings(); // Open app settings
              },
              child: Text("الاعدادات"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("الغاء"),
            ),
          ],
        );
      },
    );
  }

  void getLocation() async {
    _currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    _currentLatLng = LatLng(_currentPosition!.latitude, _currentPosition!.longitude);

    // Get the address from the coordinates
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        _currentLatLng.latitude,
        _currentLatLng.longitude,
      );
      if (placemarks.isNotEmpty) {
        setState(() {
          currentLocationName = placemarks[0].name ?? "Current Location";
        });
      }
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  Future<LatLng> getDestinationCoordinates(String destinationAddress) async {
    try {
      List<Location> locations = await locationFromAddress(destinationAddress);
      if (locations.isNotEmpty) {
        return LatLng(locations[0].latitude, locations[0].longitude);
      } else {
        throw Exception("No coordinates found for the destination address");
      }
    } catch (e) {
      throw Exception("Error getting destination coordinates: $e");
    }
  }

  Future<List<LatLng>> getRouteCoordinates(LatLng start, LatLng destination) async {
    List<LatLng> coordinates = [];

    String apiKey = "AIzaSyAGf0VB5bufPCJpUGbbteig5_yXRoJafqo";
    String url = "https://maps.googleapis.com/maps/api/directions/json?"
        "origin=${start.latitude},${start.longitude}&"
        "destination=${destination.latitude},${destination.longitude}&"
        "key=$apiKey";

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<dynamic> routes = data["routes"];
      routes.forEach((route) {
        List<dynamic> legs = route["legs"];
        legs.forEach((leg) {
          List<dynamic> steps = leg["steps"];
          steps.forEach((step) {
            String polyline = step["polyline"]["points"];
            List<LatLng> decodedPolyline = decodeEncodedPolyline(polyline);
            coordinates.addAll(decodedPolyline);
          });
        });
      });
    } else {
      throw Exception("Failed to fetch route coordinates");
    }

    return coordinates;
  }

  List<LatLng> decodeEncodedPolyline(String encoded) {
    List<LatLng> poly = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      double latDouble = lat / 1E5;
      double lngDouble = lng / 1E5;

      LatLng position = LatLng(latDouble, lngDouble);
      poly.add(position);
    }

    return poly;
  }

  void drawPolyline() async {
    if (placeController.text.isEmpty) {
      // No destination selected, don't draw polyline
      return;
    }

    try {
      LatLng destinationLatLng = await getDestinationCoordinates(placeController.text);

      List<LatLng> routeCoordinates = await getRouteCoordinates(_currentLatLng, destinationLatLng);

      setState(() {
        polylinePoints = routeCoordinates;
      });
    } catch (e) {
      print("Error drawing polyline: $e");
      // Handle error here
    }
  }

  void searchNearbyHotels() async {
    try {
      var places = google_maps_webservices.GoogleMapsPlaces(apiKey: 'AIzaSyAGf0VB5bufPCJpUGbbteig5_yXRoJafqo');
      var hotelResponse = await places.searchNearbyWithRadius(
        google_maps_webservices.Location(
          lat: _currentLatLng.latitude,
          lng: _currentLatLng.longitude,
        ),
        5000,
        type: "lodging", // Fetch nearby hotels
      );

      setState(() {
        nearbyPlaces = hotelResponse.results.map((result) {
          return Prediction(
            description: result.name ?? '',
            structuredFormatting: StructuredFormatting(
              mainText: result.name ?? '',
              secondaryText: result.vicinity ?? '',
            ),
          );
        }).toList();
      });
    } catch (e) {
      print("Error searching nearby hotels: $e");
      // Handle error here
    }
  }

  void searchNearbySports() async {
    try {
      var places = google_maps_webservices.GoogleMapsPlaces(apiKey: 'AIzaSyAGf0VB5bufPCJpUGbbteig5_yXRoJafqo');
      var SportResponse = await places.searchNearbyWithRadius(
        google_maps_webservices.Location(
          lat: _currentLatLng.latitude,
          lng: _currentLatLng.longitude,
        ),
        5000,
        type: "gym", // Fetch nearby sport
      );

      setState(() {
        nearbyPlaces = SportResponse.results.map((result) {
          return Prediction(
            description: result.name ?? '',
            structuredFormatting: StructuredFormatting(
              mainText: result.name ?? '',
              secondaryText: result.vicinity ?? '',
            ),
          );
        }).toList();
      });
    } catch (e) {
      print("Error searching nearby sports: $e");
      // Handle error here
    }
  }
  void searchNearbyHistoricalPlaces() async {
    try {
      var places = google_maps_webservices.GoogleMapsPlaces(apiKey: 'AIzaSyAGf0VB5bufPCJpUGbbteig5_yXRoJafqo');
      var historicalPlacesResponse = await places.searchNearbyWithRadius(
        google_maps_webservices.Location(
          lat: _currentLatLng.latitude,
          lng: _currentLatLng.longitude,
        ),
        5000,
        type: "museum", // تحديد نوع المعالم الأثرية
      );

      setState(() {
        nearbyPlaces = historicalPlacesResponse.results.map((result) {
          return Prediction(
            description: result.name ?? '',
            structuredFormatting: StructuredFormatting(
              mainText: result.name ?? '',
              secondaryText: result.vicinity ?? '',
            ),
          );
        }).toList();
      });
    } catch (e) {
      print("Error searching nearby historical places: $e");
      // Handle error here
    }
  }

  void searchNearbyWaterParks() async {
    try {
      var places = google_maps_webservices.GoogleMapsPlaces(apiKey: 'AIzaSyAGf0VB5bufPCJpUGbbteig5_yXRoJafqo');
      var waterParksResponse = await places.searchNearbyWithRadius(
        google_maps_webservices.Location(
          lat: _currentLatLng.latitude,
          lng: _currentLatLng.longitude,
        ),
        5000,
        type: "amusement_park", // تحديد نوع الملاهي والألعاب المائية
      );

      setState(() {
        nearbyPlaces = waterParksResponse.results.map((result) {
          return Prediction(
            description: result.name ?? '',
            structuredFormatting: StructuredFormatting(
              mainText: result.name ?? '',
              secondaryText: result.vicinity ?? '',
            ),
          );
        }).toList();
      });
    } catch (e) {
      print("Error searching nearby water parks: $e");
      // Handle error here
    }
  }


  void searchNearbyPlaces() async {
    try {
      var places = google_maps_webservices.GoogleMapsPlaces(apiKey: 'AIzaSyAGf0VB5bufPCJpUGbbteig5_yXRoJafqo');
      var response = await places.searchNearbyWithRadius(
        google_maps_webservices.Location(
          lat: _currentLatLng.latitude,
          lng: _currentLatLng.longitude,
        ),
        5000,
        type: "restaurant",
      );

      setState(() {
        nearbyPlaces = response.results.map((result) {
          // Convert PlacesSearchResult to Prediction manually
          return Prediction(
            description: result.name ?? '',
            structuredFormatting: StructuredFormatting(
              mainText: result.name ?? '',
              secondaryText: result.vicinity ?? '',
            ),
          );
        }).toList();
      });
    } catch (e) {
      print("Error searching nearby places: $e");
      // Handle error here
    }
  }
  String buildPhotoUrl(String photoReference) {
    const apiKey = 'AIzaSyAGf0VB5bufPCJpUGbbteig5_yXRoJafqo';
    return 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=$photoReference&key=$apiKey';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: _currentPosition == null
            ? Center(
          child: CircularProgressIndicator(),
        )
            : Stack(
          children: [
            GoogleMap(
              myLocationButtonEnabled: false,
              myLocationEnabled: true,
              zoomControlsEnabled: false,
              initialCameraPosition: CameraPosition(zoom: 16, target: _currentLatLng),
              onMapCreated: (controller) async {
                setState(() {
                  _controller = controller;
                });
              },
              markers: {
                Marker(
                  markerId: MarkerId("1"),
                  position: _currentLatLng,
                ),
              },
              polylines: {
                if (polylinePoints.isNotEmpty)
                  Polyline(
                    polylineId: PolylineId('polyline'),
                    points: polylinePoints,
                    color: Colors.blue, // Color of the polyline
                    width: 3, // Width of the polyline
                  ),
              },
            ),
            Container(
              // Set background color to white
              margin: EdgeInsets.only(left: 20, right: 20, top: 40),
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: searchNearbyPlaces,
                            child: Text("اقرب المطاعم", style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                                color: Color(0xFFD79977),
                            ),),
                          ),
                          SizedBox(width: 10), // Add some space between the buttons
                          ElevatedButton(
                            onPressed: searchNearbyHotels,
                            child: Text("اقرب الفنادق",
                              style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFD79977),
                            ),),
                          ),
                          SizedBox(width: 10), // Add some space between the buttons
                          ElevatedButton(
                            onPressed: searchNearbySports,
                            child: Text("اقرب صاله العاب",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFD79977),
                              ),),
                          ),
                          SizedBox(width: 10), // Add some space between the buttons
                          ElevatedButton(
                            onPressed: searchNearbyHistoricalPlaces, // تعيين دالة للبحث عن المعالم الأثرية
                            child: Text("معالم أثرية", style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFD79977),
                            ),), // تعيين نص للزرار
                          ),
                          SizedBox(width: 10), // Add some space between the buttons
                          ElevatedButton(
                            onPressed: searchNearbyWaterParks, // تعيين دالة للبحث عن الملاهي والألعاب المائية
                            child: Text("ملاهي وألعاب مائية", style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFD79977),
                            ),), // تعيين نص للزرار
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12),
                    autoComplete(),
                    SizedBox(height: 12),
                    locationsWidget(),
                    SizedBox(height: 10),
                    confirmButton(),
                    SizedBox(height: 400),
                    Visibility(
                      visible: isNearbyPlacesVisible && nearbyPlaces.isNotEmpty,
                      child: SizedBox(
                        height:80, // Adjust the height as needed
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: nearbyPlaces.length,
                          itemBuilder: (context, index) {
                            final place = nearbyPlaces[index];

                            return Container(
                              width: 250, // Adjust the width as needed
                              margin: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Card(
                                elevation: 3,
                                color: Color(0xFFD79977), // Set background color to white
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            place.structuredFormatting?.mainText ?? 'No main text',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            place.structuredFormatting?.secondaryText ?? 'No secondary text',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[700],
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


  Widget confirmButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: Size(double.infinity, 40),
      ),
      onPressed: () {
        drawPolyline(); // Draw polyline when the button is pressed
      },
      child: Text(
        "تأكيد",
        style: GoogleFonts.lato(
          fontSize: 18,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget autoComplete() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.8),
            blurRadius: 8.0,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      child: TypeAheadFormField<Description?>(
        onSuggestionSelected: (suggestion) {
          setState(() {
            placeController.text = suggestion?.structured_formatting?.main_text ?? "";
          });
        },
        getImmediateSuggestions: true,
        keepSuggestionsOnLoading: true,
        textFieldConfiguration: TextFieldConfiguration(
          style: GoogleFonts.lato(),
          controller: placeController,
          decoration: InputDecoration(
            isDense: false,
            fillColor: Colors.transparent,
            filled: false,
            suffixIcon: Icon(CupertinoIcons.search, color: color),
            prefixIcon: InkWell(
              onTap: () {
                setState(() {
                  placeController.clear();
                });
              },
              child: Icon(Icons.clear, color: Color(0xFFD79977)),
            ),
            hintText: "الى اين تريد الذهاب ؟",
            hintStyle: GoogleFonts.lato(),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          ),
        ),
        itemBuilder: (context, Description? itemData) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: SingleChildScrollView(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 18,
                    color: Colors.grey,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${itemData?.structured_formatting?.main_text}",
                        style: TextStyle(color: Colors.green),
                      ),
                      Text("${itemData?.structured_formatting?.secondary_text}"),
                      Divider(),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        noItemsFoundBuilder: (context) {
          return Container();
        },
        suggestionsCallback: (String pattern) async {
          var predictionModel = await Repo.placeAutoComplete(placeInput: pattern);

          if (predictionModel != null) {
            return predictionModel.predictions!.where((element) => element.description!.toLowerCase().contains(pattern.toLowerCase()));
          } else {
            return [];
          }
        },
      ),
    );
  }


  Widget locationsWidget() {
    return Container(
      margin: EdgeInsets.zero,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 10.0,
            spreadRadius: 1,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Row(
                children: [
                  Wrap(
                    direction: Axis.vertical,
                    children: [
                      Text(
                        "الوجهه المقصوده",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: Text(
                          placeController.text.isEmpty ? "Select Destination" : placeController.text,
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Container(
                  //   height: 15,
                  //   width: 15,
                  //   decoration: BoxDecoration(
                  //     color: color,
                  //     shape: BoxShape.circle,
                  //   ),
                  // ),
                ],
              ),
              // Container(
              //   margin: const EdgeInsets.only(left: 10),
              //   child: Divider(
              //     height: 8,
              //     color: color.withOpacity(0.6),
              //   ),
              // ),
              Row(
                children: [
                  Wrap(
                    direction: Axis.vertical,
                    children: [
                      Text(
                        "موقعك الحالى ",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        currentLocationName,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  // Container(
                  //   height: 15,
                  //   width: 15,
                  //   decoration: BoxDecoration(
                  //     border: Border.all(color: color, width: 4),
                  //     shape: BoxShape.circle,
                  //   ),
                  // ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
