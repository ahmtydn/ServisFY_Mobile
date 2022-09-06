import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:custom_marker/marker_icon.dart';


class ParentLokationTrackerPage extends StatefulWidget {
  const ParentLokationTrackerPage({Key? key}) : super(key: key);

  @override
  State<ParentLokationTrackerPage> createState() =>
      _ParentLokationTrackerPageState();
}

//40.1953, 28.9815  40.1998, 28.9774
class _ParentLokationTrackerPageState extends State<ParentLokationTrackerPage> {
  late BitmapDescriptor konumIconSchool;
  late BitmapDescriptor konumIconHome;
  GoogleMapController? googleMapController;
  GoogleMapController? newGoogleMapController;
  final Completer<GoogleMapController> _controller = Completer();
  static const LatLng sourceLocation = LatLng(40.1953, 28.9815);
  static const LatLng destination = LatLng(40.1997, 28.9814);


  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;

  homeIconCreat(context) {
    ImageConfiguration configuration = createLocalImageConfiguration(context);
    BitmapDescriptor.fromAssetImage(configuration, "images/home.png")
        .then((icon) {
      konumIconHome = icon;
    });
  }

  schoolIconCreat(context) {
    ImageConfiguration configuration = createLocalImageConfiguration(context);
    BitmapDescriptor.fromAssetImage(configuration, "images/school.png")
        .then((icon) {
      konumIconSchool = icon;
    });
  }

  void getCurLocation() async {
    await getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    Location location = Location();

    location.getLocation().then((location) {
      currentLocation = location;
    });
    if (!mounted) {
      setState(() {});
    }

    googleMapController = await _controller.future;
    location.onLocationChanged.listen(
      (newLoc) {
        currentLocation = newLoc;
        googleMapController!.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
                zoom: 16,
                target: LatLng(newLoc.latitude!, newLoc.longitude!))));
        if (!mounted) {
          setState(() {});
        }
      },
    );
  }

  var konumIcon = null;
  var isLoading = true;
  @override
  void initState() {
    // getPolyPoints();
    super.initState();
    getCurLocation();
  }
//background_video.mp4
  currentLcoationIconCreat(context) async {
    konumIcon = await MarkerIcon.downloadResizePictureCircle(
        'https://i.hizliresim.com/pwktvzy.png',
        size: 150,
        addBorder: true,
        borderColor: Colors.white,
        borderSize: 15);
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    googleMapController!.dispose();
    newGoogleMapController!.dispose();
    super.dispose();

  }


  @override
  Widget build(BuildContext context) {
    currentLcoationIconCreat(context);
    schoolIconCreat(context);
    homeIconCreat(context);
    var size = MediaQuery.of(context).size;
    return currentLocation == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            backgroundColor: Colors.grey[100],
            body: isLoading == true
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Stack(children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: size.height / 2,
                            width: size.width,
                            child: GoogleMap(
                              initialCameraPosition: CameraPosition(
                                target: LatLng(currentLocation!.latitude!,
                                    currentLocation!.longitude!),
                                zoom: 16,
                              ),
                              zoomControlsEnabled: false,
                              markers: {
                                Marker(
                                  markerId: MarkerId("currentLocation"),
                                  icon: konumIcon,
                                  position: LatLng(currentLocation!.latitude!,
                                      currentLocation!.longitude!),
                                ),
                                Marker(
                                    markerId: MarkerId("source"),
                                    position: sourceLocation,
                                    icon: konumIconHome),
                                Marker(
                                    markerId: MarkerId("destination"),
                                    position: destination,
                                    icon: konumIconSchool),
                              },
                              onMapCreated: (mapController) {
                                _controller.complete(mapController);
                                /*newGoogleMapController = mapController;
                                googleMapsDarkStyle();*/
                              },
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              color: Colors.black,
                              shape: BeveledRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      "Sürücü: Ahmet",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              color: Colors.black,
                              shape: BeveledRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      "Öğrenci: Sinan",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]));
  }
}
