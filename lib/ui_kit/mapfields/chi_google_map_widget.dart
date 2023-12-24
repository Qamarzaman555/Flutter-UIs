part of '../local_pub.dart';

// ignore: must_be_immutable
class CHIGoogleMapWidget extends StatefulWidget {
  CHIGoogleMapWidget(
      {super.key, required this.googleMapWidgetData, this.selectedLatLng});
  LatLng? selectedLatLng;
  GoogleMapWidgetData googleMapWidgetData;
  @override
  State<CHIGoogleMapWidget> createState() => _CHIGoogleMapWidgetState();
}

class _CHIGoogleMapWidgetState extends State<CHIGoogleMapWidget> {
  StreamSubscription<Position>? positionStream;
  String googleMapsApiKey = 'AIzaSyDsef6naWlgUqZwYN1AB_lH611BDaSOxPY';
  Set<Marker> markers = {};
  Set<Circle> circles = {};
  Set<Polyline> polylines = {};
  GoogleMapController? mapController;
  List<SearchLocation> searchLocations = [];
  Timer? timer;
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    if (widget.selectedLatLng == null) {
      _onGetCurrentLocation(context);
      // onTrackLiveLocation();
    }
    super.initState();
  }

  @override
  void dispose() {
    positionStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: CHIAppBar(
        title: 'CHI Google Map',
        actions: [
          TextButton(
            child: const Text('Demo track location'),
            onPressed: () {
              onTrackLiveLocation();
            },
          )
        ],
      ),
      body: widget.selectedLatLng == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                _searchField(context),
                searchLocations.isEmpty
                    ? const SizedBox.shrink()
                    : Expanded(child: searchList()),
                Expanded(child: _googleMapWidget()),
              ],
            ),
      floatingActionButton: _currentLocationButton(context),
    ));
  }

  Widget _currentLocationButton(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'fab',
      shape: const StadiumBorder(),
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

  onTrackLiveLocation() async {
    const List<LatLng> testCoordinates = [
      LatLng(33.64614, 72.9961),
      LatLng(33.64617, 72.99597),
      LatLng(33.64619, 72.99583),
      LatLng(33.6462, 72.9957),
      LatLng(33.64621, 72.99557),
      LatLng(33.64556, 72.99606),
      LatLng(33.64492, 72.99654),
      LatLng(33.64452, 72.99682),
      LatLng(33.64411, 72.9971),
      LatLng(33.64419, 72.99723),
      LatLng(33.64427, 72.9974),
      LatLng(33.64404, 72.99765),
      LatLng(33.6438, 72.99779),
      LatLng(33.64361, 72.9975),
      LatLng(33.64332, 72.99688),
      LatLng(33.64324, 72.99672),
      LatLng(33.64315, 72.99655),
      LatLng(33.64312, 72.99652),
      LatLng(33.64309, 72.9965),
      LatLng(33.64306, 72.99649),
      LatLng(33.64303, 72.99648),
      LatLng(33.643, 72.99649),
      LatLng(33.64279, 72.99664),
      LatLng(33.64257, 72.9968),
      LatLng(33.64194, 72.9973),
      LatLng(33.6412, 72.99779),
      LatLng(33.64096, 72.99733),
      LatLng(33.64071, 72.99688),
      LatLng(33.64037, 72.99588),
      LatLng(33.63976, 72.99505),
      LatLng(33.63906, 72.99385),
      LatLng(33.63837, 72.99245),
      LatLng(33.63782, 72.99118),
      LatLng(33.63726, 72.99031),
      LatLng(33.63722, 72.99021),
      LatLng(33.63717, 72.99013),
      LatLng(33.63664, 72.99063),
      LatLng(33.63609, 72.99094),
      LatLng(33.63602, 72.99099),
      LatLng(33.63594, 72.99105),
      LatLng(33.63565, 72.99126),
      LatLng(33.63535, 72.99148),
      LatLng(33.63555, 72.99185),
      LatLng(33.63575, 72.99221),
      LatLng(33.63584, 72.99237),
      LatLng(33.63592, 72.99253),
      LatLng(33.63605, 72.99273),
      LatLng(33.63612, 72.99283),
      LatLng(33.63618, 72.99294),
      LatLng(33.63624, 72.99302),
      LatLng(33.6363, 72.9931),
    ];

    for (int i = 0; i < testCoordinates.length; i++) {
      debugPrint('enter loop: entering timer');
      await Future.delayed(const Duration(seconds: 1));
      debugPrint('in timer: selecting latlng $i ${DateTime.now()}');
      widget.selectedLatLng = testCoordinates[i];
      debugPrint('out timer: Making map');
      _onMapCreated(mapController!);
    }
  }

  _onGetCurrentLocation(BuildContext context) async {
    Position position = await Utils.getCurrentPosition(context);
    widget.selectedLatLng = LatLng(position.latitude, position.longitude);
    if (mapController != null) {
      _onMapCreated(mapController!);
    } else {
      if (widget.googleMapWidgetData.markers != null) await onAddMarkers();
      if (widget.googleMapWidgetData.circles != null) await onAddCircles();
      if (widget.googleMapWidgetData.polyline != null) await onAddPlylines();
      setState(() {});
    }
  }

  Widget _googleMapWidget() {
    return GoogleMap(
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      myLocationEnabled: true,
      mapType: MapType.normal,
      onMapCreated: (controller) {
        _onMapCreated(controller);
      },
      markers: markers,
      circles: circles,
      polylines: polylines,
      onTap: (latlng) {
        _onSelectLocation(latlng);
      },
      onLongPress: (latlng) {
        _onSelectLocation(latlng);
      },
      initialCameraPosition: CameraPosition(
          target: widget.selectedLatLng!, tilt: 59.440717697143555),
    );
  }

  _onMapCreated(GoogleMapController controller) async {
    mapController ??= controller;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: widget.selectedLatLng!, zoom: 15.0)));
    markers.removeWhere((element) => element.markerId == const MarkerId('M-1'));
    markers.add(Marker(
        markerId: const MarkerId('M-1'),
        infoWindow: InfoWindow(
            title: 'Address',
            snippet:
                await Utils.getAddressFromCoordinates(widget.selectedLatLng!),
            anchor: const Offset(0.5, 0.1)),
        icon: await onMakeMarker(widget.googleMapWidgetData.currentImage),
        position: widget.selectedLatLng!));

    setState(() {});
  }

  onAddMarkers() async {
    List<CHIMarker> mapMarkers = widget.googleMapWidgetData.markers ?? [];
    for (int i = 0; i < widget.googleMapWidgetData.markers!.length; i++) {
      markers.add(Marker(
          markerId: MarkerId('M$i'),
          infoWindow: InfoWindow(
              title: 'Address',
              snippet: await Utils.getAddressFromCoordinates(LatLng(
                  mapMarkers[i].lat ?? 0,
                  widget.googleMapWidgetData.markers![i].lng ?? 0)),
              anchor: const Offset(0.5, 0.1)),
          icon: await onMakeMarker(mapMarkers[i].image),
          position: LatLng(mapMarkers[i].lat ?? 0, mapMarkers[i].lng ?? 0)));
    }
    debugPrint('Marker added: $markers');
  }

  onAddCircles() async {
    List<CHICircle> mapCircles = widget.googleMapWidgetData.circles ?? [];
    for (int i = 0; i < mapCircles.length; i++) {
      markers.add(Marker(
          markerId: MarkerId('M0$i'),
          infoWindow: InfoWindow(
              title: 'Address',
              snippet: await Utils.getAddressFromCoordinates(
                  LatLng(mapCircles[i].lat ?? 0, mapCircles[i].lng ?? 0)),
              anchor: const Offset(0.5, 0.1)),
          icon: await onMakeMarker(mapCircles[i].image),
          position: LatLng(mapCircles[i].lat ?? 0, mapCircles[i].lng ?? 0)));
      circles.add(Circle(
          circleId: CircleId('M-$i'),
          radius: mapCircles[i].radius!.toDouble(),
          fillColor: mapCircles[i].color!.withOpacity(0.3),
          strokeWidth: 1,
          strokeColor: mapCircles[i].color!,
          center: LatLng(mapCircles[i].lat ?? 0, mapCircles[i].lng ?? 0)));
    }
  }

  onAddPlylines() async {
    List<CHIPolyline> mapPolylines = widget.googleMapWidgetData.polyline ?? [];

    for (int i = 0; i < mapPolylines.length; i++) {
      List<LatLng> mapPolylineCoordinates = mapPolylines[i]
          .coordinates!
          .map((e) => LatLng(e.lat!, e.lng!))
          .toList();
      polylines.add(Polyline(
          endCap: Cap.roundCap,
          startCap: Cap.roundCap,
          width: 4,
          polylineId: PolylineId('M_$i'),
          points: mapPolylineCoordinates,
          color: mapPolylines[i].color ?? Colors.green));
    }
    debugPrint('Marker added: $markers');
  }

  Future<BitmapDescriptor> onMakeMarker(String? image) async {
    if (image == null) {
      return BitmapDescriptor.defaultMarker;
    }
    List<int> imageData = await getBytesFromAsset(image, 72);
    Uint8List uint8List = Uint8List.fromList(imageData);
    BitmapDescriptor customIcon = BitmapDescriptor.fromBytes(uint8List);
    return customIcon;
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  _onSelectLocation(LatLng selectedLatLng) async {
    searchController.text = '';
    widget.selectedLatLng = selectedLatLng;
    _onMapCreated(mapController!);
  }

  Widget _searchField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: CHITextField(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        borderRadius: 60,
        controller: searchController,
        textAlignVertical: TextAlignVertical.center,
        hintText: 'Search for a place',
        suffixIcon: const Icon(
          Icons.search,
          color: Colors.grey,
        ),
        onChanged: (value) {
          if (timer != null) {
            timer?.cancel();
          }
          timer = Timer(const Duration(milliseconds: 500), () async {
            onSearch(value ?? '', context);
          });
        },
      ),
    );
  }

  Future<void> onSearch(String query, context) async {
    if (query.isEmpty) {
      searchLocations.clear();
      setState(() {});
      return;
    }

    final response = await http.get(
        Uri.parse(
            'https://maps.googleapis.com/maps/api/place/textsearch/json?key=$googleMapsApiKey&query=$query'),
        headers: {'Accept': 'application/json'});
    if (response.statusCode == 200) {
      final resp = json.decode(response.body);
      if (resp['status'] == 'OK') {
        searchLocations.clear();
        resp['results'].map((e) {
          searchLocations.add(SearchLocation(
              e['name'],
              e['formatted_address'],
              e['geometry']['location']['lat'],
              e['geometry']['location']['lng']));
        }).toList();
        debugPrint('==========searchLocations========== $searchLocations');
        setState(() {});
      } else {
        Utils.showErrorSnack(context, resp['error_message']);
      }
    }
  }

  Widget searchList() {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: searchLocations.length,
      itemBuilder: (context, index) {
        final result = searchLocations[index];
        return ListTile(
          onTap: () {
            onClickSearchedItem(result);
          },
          title: Text(result.name),
          subtitle: Text(result.address),
        );
      },
    );
  }

  onClickSearchedItem(SearchLocation searchLocation) async {
    searchController.text = searchLocation.name;
    FocusManager.instance.primaryFocus?.unfocus();
    searchLocations.clear();
    setState(() {});
    widget.selectedLatLng = LatLng(searchLocation.lat, searchLocation.lng);
    await _onMapCreated(mapController!);
  }
}

class GoogleMapWidgetData {
  String? currentImage;
  List<CHICircle>? circles;
  List<CHIMarker>? markers;
  List<CHIPolyline>? polyline;

  GoogleMapWidgetData(
      {this.circles, this.markers, this.polyline, this.currentImage});
  GoogleMapWidgetData.fromJson(Map<String, dynamic> json) {
    currentImage = json["currentImage"];
    if (json['circles'] != null) {
      circles = <CHICircle>[];
      json['circles'].forEach((v) {
        circles!.add(CHICircle.fromJson(v));
      });
    }
    if (json['markers'] != null) {
      markers = <CHIMarker>[];
      json['markers'].forEach((v) {
        markers!.add(CHIMarker.fromJson(v));
      });
    }
    if (json['polyline'] != null) {
      polyline = <CHIPolyline>[];
      json['polyline'].forEach((v) {
        polyline!.add(CHIPolyline.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currentImage'] = currentImage;
    if (circles != null) {
      data['circles'] = circles!.map((v) => v.toJson()).toList();
    }
    if (markers != null) {
      data['markers'] = markers!.map((v) => v.toJson()).toList();
    }
    if (polyline != null) {
      data['polyline'] = polyline!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CHICircle {
  double? lat;
  double? lng;
  String? image;
  num? radius;
  Color? color;

  CHICircle({this.lat, this.lng, this.image, this.radius, this.color});

  CHICircle.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
    image = json['image'];
    radius = json['radius'] ?? 0;
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    data['image'] = image;
    data['radius'] = radius;
    data['color'] = color;
    return data;
  }
}

class CHIMarker {
  double? lat;
  double? lng;
  String? image;

  CHIMarker({this.lat, this.lng, this.image});

  CHIMarker.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    data['image'] = image;
    return data;
  }
}

class CHIPolyline {
  Color? color;
  List<Coordinates>? coordinates;

  CHIPolyline({this.color, this.coordinates});

  CHIPolyline.fromJson(Map<String, dynamic> json) {
    color = json['color'];
    if (json['coordinates'] != null) {
      coordinates = <Coordinates>[];
      json['coordinates'].forEach((v) {
        coordinates!.add(Coordinates.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['color'] = color;
    if (coordinates != null) {
      data['coordinates'] = coordinates!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Coordinates {
  double? lat;
  double? lng;

  Coordinates({this.lat, this.lng});

  Coordinates.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}




    // List<LatLng> testCoordinates = const [
    //   LatLng(33.64938, 72.99999),
    //   LatLng(33.64614, 72.9961),
    //   LatLng(33.64616, 72.99606),
    //   LatLng(33.64618, 72.99602),
    //   LatLng(33.64981, 73.0013),
    //   LatLng(33.64922, 72.9999),
    //   LatLng(33.65464, 72.99573),
    //   LatLng(33.65541, 72.99601),
    //   LatLng(33.65639, 72.99529),
    //   LatLng(33.65567, 72.9928),
    //   LatLng(33.65247, 72.98649),
    //   LatLng(33.65696, 72.99468),
    //   LatLng(33.67964, 73.03784),
    //   LatLng(33.69386, 73.06515),
    //   LatLng(33.69512, 73.06668),
    //   LatLng(33.69588, 73.06639),
    //   LatLng(33.69603, 73.06522),
    //   LatLng(33.69545, 73.06467),
    //   LatLng(33.69405, 73.06515),
    //   LatLng(33.68793, 73.06973),
    //   LatLng(33.67343, 73.08061),
    //   LatLng(33.65039, 73.09783),
    //   LatLng(33.60448, 73.13222),
    //   LatLng(33.54821, 73.17416),
    //   LatLng(33.54175, 73.17902),
    //   LatLng(33.53907, 73.18054),
    //   LatLng(33.53619, 73.18127),
    //   LatLng(33.52861, 73.18054),
    //   LatLng(33.51768, 73.17906),
    //   LatLng(33.51389, 73.17861),
    //   LatLng(33.51164, 73.1794),
    //   LatLng(33.50806, 73.18434),
    //   LatLng(33.50366, 73.19138),
    //   LatLng(33.50052, 73.19547),
    //   LatLng(33.4923, 73.19728),
    //   LatLng(33.47501, 73.19626),
    //   LatLng(33.47202, 73.19642),
    //   LatLng(33.46964, 73.19836),
    //   LatLng(33.45781, 73.21411),
    //   LatLng(33.45308, 73.22028),
    //   LatLng(33.44978, 73.22283),
    //   LatLng(33.43927, 73.22766),
    //   LatLng(33.4361, 73.22858),
    //   LatLng(33.433, 73.22856),
    //   LatLng(33.42578, 73.22577),
    //   LatLng(33.42133, 73.22337),
    //   LatLng(33.41885, 73.22297),
    //   LatLng(33.40713, 73.22337),
    //   LatLng(33.40204, 73.22386),
    //   LatLng(33.39801, 73.2259),
    //   LatLng(33.38213, 73.23446),
    //   LatLng(33.37586, 73.2374),
    //   LatLng(33.36964, 73.23927),
    //   LatLng(33.35555, 73.24352),
    //   LatLng(33.33855, 73.24916),
    //   LatLng(33.33392, 73.25122),
    //   LatLng(33.3307, 73.25365),
    //   LatLng(33.32766, 73.25579),
    //   LatLng(33.32346, 73.25758),
    //   LatLng(33.31969, 73.25895),
    //   LatLng(33.31626, 73.25905),
    //   LatLng(33.31241, 73.25917),
    //   LatLng(33.31019, 73.25994),
    //   LatLng(33.30115, 73.26643),
    //   LatLng(33.29128, 73.27349),
    //   LatLng(33.28785, 73.27623),
    //   LatLng(33.28261, 73.28442),
    //   LatLng(33.28062, 73.28638),
    //   LatLng(33.27416, 73.29012),
    //   LatLng(33.26735, 73.29396),
    //   LatLng(33.26375, 73.29693),
    //   LatLng(33.23988, 73.32173),
    //   LatLng(33.2362, 73.32422),
    //   LatLng(33.23294, 73.32539),
    //   LatLng(33.22543, 73.3272),
    //   LatLng(33.22087, 73.33069),
    //   LatLng(33.20855, 73.33643),
    //   LatLng(33.20138, 73.34023),
    //   LatLng(33.19449, 73.34624),
    //   LatLng(33.19201, 73.3492),
    //   LatLng(33.18789, 73.35858),
    //   LatLng(33.18547, 73.36267),
    //   LatLng(33.18239, 73.36557),
    //   LatLng(33.1784, 73.36879),
    //   LatLng(33.1758, 73.3725),
    //   LatLng(33.17276, 73.37906),
    //   LatLng(33.17089, 73.38154),
    //   LatLng(33.16789, 73.38445),
    //   LatLng(33.16414, 73.38735),
    //   LatLng(33.1567, 73.39115),
    //   LatLng(33.1495, 73.39542),
    //   LatLng(33.14522, 73.39555),
    //   LatLng(33.14253, 73.39744),
    //   LatLng(33.14089, 73.39947),
    //   LatLng(33.13758, 73.40196),
    //   LatLng(33.13459, 73.40418),
    //   LatLng(33.13346, 73.40611),
    //   LatLng(33.13307, 73.41233),
    //   LatLng(33.13188, 73.41765),
    //   LatLng(33.13134, 73.42229),
    //   LatLng(33.12593, 73.43424),
    //   LatLng(33.12353, 73.44044),
    //   LatLng(33.12119, 73.44356),
    //   LatLng(33.11877, 73.4449),
    //   LatLng(33.11453, 73.4467),
    //   LatLng(33.11103, 73.44634),
    //   LatLng(33.10444, 73.44477),
    //   LatLng(33.10058, 73.44305),
    //   LatLng(33.0966, 73.44205),
    //   LatLng(33.0923, 73.4426),
    //   LatLng(33.08969, 73.44413),
    //   LatLng(33.08634, 73.44728),
    //   LatLng(33.0831, 73.44957),
    //   LatLng(33.07876, 73.45027),
    //   LatLng(33.07542, 73.45313),
    //   LatLng(33.07353, 73.45644),
    //   LatLng(33.07095, 73.45915),
    //   LatLng(33.06683, 73.46127),
    //   LatLng(33.06494, 73.45928),
    //   LatLng(33.06383, 73.45898),
    //   LatLng(33.06312, 73.45938),
    //   LatLng(33.06264, 73.46229),
    //   LatLng(33.0606, 73.47012),
    //   LatLng(33.06166, 73.47405),
    //   LatLng(33.06065, 73.47725),
    //   LatLng(33.05892, 73.48119),
    //   LatLng(33.05553, 73.49229),
    //   LatLng(33.0483, 73.51815),
    //   LatLng(33.04467, 73.52878),
    //   LatLng(33.04231, 73.53328),
    //   LatLng(33.04437, 73.5409),
    //   LatLng(33.04432, 73.54772),
    //   LatLng(33.0438, 73.55007),
    //   LatLng(33.04025, 73.55379),
    //   LatLng(33.03903, 73.55565),
    //   LatLng(33.03827, 73.55937),
    //   LatLng(33.03574, 73.56601),
    //   LatLng(33.03405, 73.56886),
    //   LatLng(33.03271, 73.57555),
    //   LatLng(33.03153, 73.58181),
    //   LatLng(33.03156, 73.585),
    //   LatLng(33.03188, 73.58828),
    //   LatLng(33.03143, 73.59071),
    //   LatLng(33.02585, 73.60769),
    //   LatLng(33.02042, 73.62504),
    //   LatLng(33.0181, 73.63231),
    //   LatLng(33.0171, 73.63641),
    //   LatLng(33.01324, 73.64718),
    //   LatLng(33.01008, 73.65582),
    //   LatLng(33.00745, 73.66002),
    //   LatLng(33.00488, 73.66218),
    //   LatLng(32.99882, 73.66576),
    //   LatLng(32.99617, 73.66682),
    //   LatLng(32.99399, 73.66849),
    //   LatLng(32.98971, 73.67252),
    //   LatLng(32.98444, 73.67766),
    //   LatLng(32.97561, 73.68614),
    //   LatLng(32.96903, 73.69251),
    //   LatLng(32.95072, 73.71079),
    //   LatLng(32.94906, 73.71229),
    //   LatLng(32.94573, 73.7132),
    //   LatLng(32.93932, 73.715),
    //   LatLng(32.92482, 73.71948),
    //   LatLng(32.9201, 73.71966),
    //   LatLng(32.91845, 73.72021),
    //   LatLng(32.91576, 73.72292),
    //   LatLng(32.91038, 73.72853),
    //   LatLng(32.90602, 73.73335),
    //   LatLng(32.90504, 73.73738),
    //   LatLng(32.90701, 73.7473),
    //   LatLng(32.90678, 73.74856),
    //   LatLng(32.90677, 73.74861),
    //   LatLng(32.90104, 73.75391),
    //   LatLng(32.89489, 73.76148),
    //   LatLng(32.89331, 73.76411),
    //   LatLng(32.88946, 73.77048),
    //   LatLng(32.88505, 73.77871),
    //   LatLng(32.88267, 73.78241),
    //   LatLng(32.87943, 73.78436),
    //   LatLng(32.8681, 73.79693),
    //   LatLng(32.86279, 73.80349),
    //   LatLng(32.86038, 73.80657),
    //   LatLng(32.85607, 73.8092),
    //   LatLng(32.8529, 73.81506),
    //   LatLng(32.85056, 73.81945),
    //   LatLng(32.84897, 73.82113),
    //   LatLng(32.8433, 73.82407),
    //   LatLng(32.84125, 73.82558),
    //   LatLng(32.84024, 73.82714),
    //   LatLng(32.83489, 73.82847),
    //   LatLng(32.83377, 73.82929),
    //   LatLng(32.83129, 73.83496),
    //   LatLng(32.82835, 73.84387),
    //   LatLng(32.82766, 73.84699),
    //   LatLng(32.82669, 73.84864),
    //   LatLng(32.82114, 73.85393),
    //   LatLng(32.81438, 73.86118),
    //   LatLng(32.80895, 73.86635),
    //   LatLng(32.79878, 73.87453),
    //   LatLng(32.78412, 73.88631),
    //   LatLng(32.76291, 73.9034),
    //   LatLng(32.74301, 73.92059),
    //   LatLng(32.7262, 73.93444),
    //   LatLng(32.7182, 73.94052),
    //   LatLng(32.71268, 73.94509),
    //   LatLng(32.69384, 73.96072),
    //   LatLng(32.67798, 73.97378),
    //   LatLng(32.65575, 73.99222),
    //   LatLng(32.61242, 74.0288),
    //   LatLng(32.60137, 74.03885),
    //   LatLng(32.59598, 74.04355),
    //   LatLng(32.59314, 74.04411),
    //   LatLng(32.5748, 74.04217),
    //   LatLng(32.56681, 74.04132),
    //   LatLng(32.56261, 74.0414),
    //   LatLng(32.55578, 74.04519),
    //   LatLng(32.5521, 74.04762),
    //   LatLng(32.54856, 74.05117),
    //   LatLng(32.53597, 74.06374),
    //   LatLng(32.53322, 74.06652),
    //   LatLng(32.5299, 74.06877),
    //   LatLng(32.51394, 74.07822),
    //   LatLng(32.49836, 74.08717),
    //   LatLng(32.4959, 74.08845),
    //   LatLng(32.49157, 74.08952),
    //   LatLng(32.48314, 74.09176),
    //   LatLng(32.47675, 74.09343),
    //   LatLng(32.47414, 74.09678),
    //   LatLng(32.47147, 74.10188),
    //   LatLng(32.46703, 74.10445),
    //   LatLng(32.45559, 74.11136),
    //   LatLng(32.44472, 74.11125),
    //   LatLng(32.43972, 74.11138),
    //   LatLng(32.43757, 74.11311),
    //   LatLng(32.43338, 74.11516),
    //   LatLng(32.4339, 74.11509),
    //   LatLng(32.43615, 74.11393),
    //   LatLng(32.43732, 74.11431),
    //   LatLng(32.44035, 74.11737),
    //   LatLng(32.44055, 74.12091),
    //   LatLng(32.44177, 74.12331),
    //   LatLng(32.4429, 74.12524),
    //   LatLng(32.44317, 74.12726),
    //   LatLng(32.44396, 74.13334),
    //   LatLng(32.44548, 74.1452),
    //   LatLng(32.4474, 74.16025),
    //   LatLng(32.45122, 74.18188),
    //   LatLng(32.45696, 74.20811),
    //   LatLng(32.46737, 74.25405),
    //   LatLng(32.47261, 74.2985),
    //   LatLng(32.47664, 74.33263),
    //   LatLng(32.47751, 74.33982),
    //   LatLng(32.47764, 74.34126),
    //   LatLng(32.47747, 74.34228),
    //   LatLng(32.4761, 74.34275),
    //   LatLng(32.47334, 74.34383),
    //   LatLng(32.46985, 74.34506),
    //   LatLng(32.46321, 74.34761),
    //   LatLng(32.45162, 74.352),
    //   LatLng(32.43625, 74.35751),
    //   LatLng(32.42892, 74.35992),
    //   LatLng(32.42678, 74.36108),
    //   LatLng(32.42299, 74.36192),
    //   LatLng(32.41128, 74.36441),
    //   LatLng(32.3876, 74.35932),
    //   LatLng(32.38328, 74.35848),
    //   LatLng(32.37875, 74.35833),
    //   LatLng(32.36428, 74.35813),
    //   LatLng(32.35634, 74.35803),
    //   LatLng(32.35028, 74.35686),
    //   LatLng(32.3463, 74.35671),
    //   LatLng(32.34349, 74.35605),
    //   LatLng(32.34252, 74.35623),
    //   LatLng(32.34243, 74.35685),
    //   LatLng(32.34135, 74.35899),
    //   LatLng(32.33668, 74.36664),
    //   LatLng(32.33636, 74.36825),
    //   LatLng(32.33627, 74.3675)
    // ];
