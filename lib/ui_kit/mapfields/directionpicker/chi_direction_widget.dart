part of '../../local_pub.dart';

class CHIDirectionWidget extends StatefulWidget {
  const CHIDirectionWidget({super.key, this.selectedDirectionPolyline});
  final DirectionPolyline? selectedDirectionPolyline;

  @override
  State<CHIDirectionWidget> createState() => _CHIDirectionWidgetState();
}

class _CHIDirectionWidgetState extends State<CHIDirectionWidget> {
  @override
  void initState() {
    _onGetCurrentLocation(context);
    super.initState();
  }

  String googleMapsApiKey = 'AIzaSyDsef6naWlgUqZwYN1AB_lH611BDaSOxPY';
  final TextEditingController searchController = TextEditingController();
  String destinationAddress = 'Select Your Destination';
  String originAddress = 'Select Your Origin';
  GoogleMapController? googleMapController;
  List<CHIDirection> searchLocations = [];
  List<LatLng> polygonCoordinates = [];
  List<LatLng> coordinates = [];
  Set<Polyline> polylines = {};
  LatLng? destinationLatLng;
  Set<Polygon> polygon = {};
  Set<Marker> markers = {};
  LatLng? currentLatLng;
  LatLng? originLatLng;
  String? duration;
  String? distance;
  Timer? timer;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: CHIAppBar(
            title: 'Directions',
            actions: [
              IconButton(
                  onPressed: coordinates.isEmpty
                      ? null
                      : () {
                          Navigator.pop(
                              context,
                              coordinates.isEmpty
                                  ? null
                                  : DirectionPolyline(
                                      coordinates,
                                      originLatLng,
                                      destinationLatLng,
                                      originAddress,
                                      destinationAddress,
                                      distance ?? '--',
                                      duration ?? '--'));
                        },
                  icon: const Icon(
                    Icons.check,
                  ))
            ],
          ),
          body: currentLatLng == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    _directionSearchFields(context),
                    Expanded(child: _googleMapWidget(context)),
                  ],
                ),
          floatingActionButton: _currentLocationButton(context),
          bottomSheet: coordinates.isNotEmpty
              ? _directionsDetails()
              : const SizedBox.shrink()),
    );
  }

  Widget _currentLocationButton(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'fab',
      shape: const StadiumBorder(),
      mini: true,
      backgroundColor: Colors.white,
      onPressed: () {
        _onGetCurrentLocation(context);
      },
      child: Icon(
        Icons.my_location_rounded,
        color: Theme.of(context).extension<CHITheme>()?.secondryColor,
      ),
    );
  }

  Widget _directionSearchFields(BuildContext context) {
    return CHICard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      borderRadius: BorderRadius.circular(0),
      child: Column(
        children: [
          _directionOriginRow(context),
          6.spaceY,
          _directionDestinationRow(context),
        ],
      ),
    );
  }

  Widget _directionDestinationRow(context) {
    return Row(
      children: [
        const Icon(Icons.location_on_rounded, color: Colors.red),
        8.spaceX,
        Expanded(
          child: CHILocationPicker(
            forDirection: true,
            selectedLatLng: destinationLatLng,
            pickerTitle: destinationAddress,
            onGetLatLng: (latlng) async {
              destinationLatLng = latlng;
              destinationAddress =
                  await Utils.getAddressFromCoordinates(latlng);
              _onMakePolyline(context);
            },
          ),
        )
      ],
    );
  }

  Widget _directionOriginRow(context) {
    return Row(
      children: [
        const Icon(Icons.circle_outlined),
        8.spaceX,
        Expanded(
          child: CHILocationPicker(
            forDirection: true,
            selectedLatLng: originLatLng,
            pickerTitle: originAddress,
            onGetLatLng: (latlng) async {
              originLatLng = latlng;
              originAddress = await Utils.getAddressFromCoordinates(latlng);
              if (destinationLatLng != null) {
                _onMakePolyline(context);
              }
            },
          ),
        )
      ],
    );
  }

  Widget _googleMapWidget(BuildContext context) {
    return GoogleMap(
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      myLocationEnabled: true,
      onMapCreated: (controller) {
        _onMapCreated(controller, context);
      },
      markers: markers,
      polylines: polylines,
      polygons: polygon,
      onTap: (selectedLatlng) {
        polygonCoordinates.add(selectedLatlng);
        markers.add(Marker(markerId: MarkerId('${selectedLatlng.latitude}')));
        debugPrint('polygonCoordinates : $polygonCoordinates');
        if (polygonCoordinates.length > 2) {
          _onMakePolygon();
        }
      },
      // onLongPress: (selectedLatlng) {
      //   polygonCoordinates.add(selectedLatlng);
      //   markers.add(Marker(markerId: MarkerId('${selectedLatlng.latitude}')));
      //   debugPrint('polygonCoordinates : $polygonCoordinates');
      //   if (polygonCoordinates.length > 2) {
      //     _onMakePolygon();
      //   }
      // },
      initialCameraPosition: CameraPosition(
          target: widget.selectedDirectionPolyline != null
              ? widget.selectedDirectionPolyline!.originLatLng!
              : currentLatLng!,
          zoom: widget.selectedDirectionPolyline != null ? 12 : 0),
    );
  }

  Widget _directionsDetails() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      height: 100,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            distanceRow(),
            8.spaceY,
            const Text('ٖFastest route now due to traffic conditions'),
            // 12.spaceY,
            // btnsRow()
          ],
        ),
      ),
    );
  }

  Widget btnsRow() {
    return Row(
      children: [
        ElevatedButton(
            style: btnStyle(isFilled: true),
            onPressed: () {},
            child: bottomBtnChildRow(Icons.arrow_circle_up, 'Start',
                isFilled: true)),
        8.spaceX,
        OutlinedButton(
            style: btnStyle(),
            onPressed: () {},
            child: bottomBtnChildRow(Icons.menu, 'Steps')),
        8.spaceX,
        OutlinedButton(
            style: btnStyle(),
            onPressed: () {},
            child: bottomBtnChildRow(Icons.push_pin_sharp, 'Pin'))
      ],
    );
  }

  Widget distanceRow() {
    return Row(
      children: [
        Text(
          duration ?? '--',
          style: CHIStyles.xlMediumStyle.copyWith(color: Colors.green),
        ),
        Text(
          ' (${distance ?? '--'})',
          style: CHIStyles.xlMediumStyle,
        ),
      ],
    );
  }

  ButtonStyle btnStyle({bool isFilled = false}) {
    return ElevatedButton.styleFrom(
      backgroundColor: isFilled
          ? Theme.of(context).extension<CHITheme>()?.secondryColor
          : null,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }

  Widget bottomBtnChildRow(IconData icon, String title,
      {bool isFilled = false}) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: isFilled
              ? Colors.white
              : Theme.of(context).extension<CHITheme>()?.secondryColor,
        ),
        Text(
          '    $title',
          style: TextStyle(
              color: isFilled
                  ? Colors.white
                  : Theme.of(context).extension<CHITheme>()?.secondryColor),
        )
      ],
    );
  }

  _onMapCreated(GoogleMapController controller, context) async {
    googleMapController ??= controller;
    controller.animateCamera(
      polylines.isNotEmpty
          ? CameraUpdate.newLatLngBounds(
              LatLngBounds(
                  southwest: LatLng(
                      coordinates.first.latitude <= coordinates.last.latitude
                          ? coordinates.first.latitude
                          : coordinates.last.latitude,
                      coordinates.first.longitude <= coordinates.last.longitude
                          ? coordinates.first.longitude
                          : coordinates.last.longitude),
                  northeast: LatLng(
                      coordinates.first.latitude <= coordinates.last.latitude
                          ? coordinates.last.latitude
                          : coordinates.first.latitude,
                      coordinates.first.longitude <= coordinates.last.longitude
                          ? coordinates.last.longitude
                          : coordinates.first.longitude)),
              100)
          : CameraUpdate.newCameraPosition(
              CameraPosition(
                target: currentLatLng!,
                zoom: 16.0,
              ),
            ),
    );
    markers.add(Marker(
        markerId: const MarkerId('MArker1'),
        position: polylines.isNotEmpty ? coordinates.last : currentLatLng!));
    setState(() {});
  }

  _onGetCurrentLocation(BuildContext context) async {
    if (widget.selectedDirectionPolyline != null) {
      originAddress = widget.selectedDirectionPolyline!.originAddress;
      destinationAddress = widget.selectedDirectionPolyline!.destinationAddress;
      coordinates = widget.selectedDirectionPolyline!.polylinePoints;
      originLatLng = widget.selectedDirectionPolyline!.originLatLng;
      destinationLatLng = widget.selectedDirectionPolyline!.destinationLatLng;
      distance = widget.selectedDirectionPolyline!.distance;
      duration = widget.selectedDirectionPolyline!.duration;
      debugPrint('Plyline Coordinates: $coordinates');

      polylines = {
        Polyline(
          startCap: Cap.roundCap,
          endCap: Cap.roundCap,
          polylineId: const PolylineId('polyline_id'),
          color: Colors.blue,
          points: coordinates,
          width: 5,
        )
      };
    }
    Position position = await Utils.getCurrentPosition(context);
    currentLatLng = LatLng(position.latitude, position.longitude);
    if (googleMapController != null) {
      googleMapController!
          .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: currentLatLng!,
        zoom: 16.0,
      )));
    }
    setState(() {});
  }

  _onMakePolyline(context) async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result;
    if (originLatLng == null) {
      originAddress = 'Current Location';
      originLatLng = currentLatLng;
    }

    result = await polylinePoints.getRouteBetweenCoordinates(
        googleMapsApiKey,
        PointLatLng(originLatLng!.latitude, originLatLng!.longitude),
        PointLatLng(destinationLatLng!.latitude, destinationLatLng!.longitude));
    if (result.points.isNotEmpty) {
      distance = result.distance;
      duration = result.duration;
      coordinates =
          result.points.map((e) => LatLng(e.latitude, e.longitude)).toList();
      debugPrint(coordinates.toString());
      polylines = {
        Polyline(
          startCap: Cap.roundCap,
          endCap: Cap.roundCap,
          polylineId: const PolylineId('polyline_id'),
          color: Colors.blue,
          points: coordinates,
          width: 5,
        )
      };
      _onMapCreated(googleMapController!, context);
    }
  }

  _onMakePolygon() {
    polygon = {
      Polygon(
          polygonId: const PolygonId('1'),
          points: polygonCoordinates,
          fillColor: Colors.transparent,
          strokeColor: Colors.green,
          strokeWidth: 2)
    };
    setState(() {});
  }
}

class CHIDirection {
  String name;
  String address;
  double lat;
  double lng;

  CHIDirection(this.name, this.address, this.lat, this.lng);
}
