part of '../local_pub.dart';

// ignore: must_be_immutable
class CHIGoogleMap extends StatefulWidget {
  CHIGoogleMap({super.key, this.selectedLatLng});
  LatLng? selectedLatLng;
  @override
  State<CHIGoogleMap> createState() => _CHIGoogleMapState();
}

class _CHIGoogleMapState extends State<CHIGoogleMap> {
  StreamSubscription<Position>? positionStream;
  String googleMapsApiKey = 'AIzaSyDsef6naWlgUqZwYN1AB_lH611BDaSOxPY';
  Set<Marker> marker = {};
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
        title: 'Pick Your Location',
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              Navigator.pop(context, widget.selectedLatLng);
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
                    : searchList(),
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
        // _onTestLiveLocation();
      },
      child: Icon(
        Icons.my_location_rounded,
        color: Theme.of(context).extension<CHITheme>()?.secondryColor,
      ),
    );
  }

  _onGetCurrentLocation(BuildContext context) async {
    Position position = await Utils.getCurrentPosition(context);
    widget.selectedLatLng = LatLng(position.latitude, position.longitude);
    if (mapController != null) {
      _onMapCreated(mapController!);
    } else {
      setState(() {});
    }
  }

  // onTrackLiveLocation() async {
  //   positionStream = Geolocator.getPositionStream().listen((event) {
  //     debugPrint('Event occure on tracking');
  //     widget.selectedLatLng = LatLng(event.latitude, event.longitude);
  //     if (mapController != null) {
  //       Utils.showSnack(context, 'Map updating');
  //       _onMapCreated(mapController!);
  //     }
  //   });
  // }

  Widget _googleMapWidget() {
    return GoogleMap(
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      myLocationEnabled: true,
      mapType: MapType.normal,
      onMapCreated: (controller) {
        _onMapCreated(controller);
      },
      markers: marker,
      onTap: (latlng) {
        _onSelectLocation(latlng);
      },
      onLongPress: (latlng) {
        _onSelectLocation(latlng);
      },
      initialCameraPosition: CameraPosition(
          target: widget.selectedLatLng!, tilt: 59.440717697143555, zoom: 16),
    );
  }

  _onMapCreated(GoogleMapController controller) async {
    mapController ??= controller;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: widget.selectedLatLng!, zoom: 16.0)));
    marker = {
      Marker(
          markerId: const MarkerId('G1'),
          infoWindow: InfoWindow(
              title: 'Address',
              snippet:
                  await Utils.getAddressFromCoordinates(widget.selectedLatLng!),
              anchor: const Offset(0.5, 0.1)),
          icon: BitmapDescriptor.defaultMarker,
          position: widget.selectedLatLng!)
    };
    setState(() {});
  }

  _onSelectLocation(LatLng selectedLatLng) async {
    searchController.text = '';
    widget.selectedLatLng = selectedLatLng;
    _onMapCreated(mapController!);
  }

  _onTestLiveLocation() async {
    List<LatLng> testCoordinates = [
      const LatLng(33.64614, 72.9961),
      const LatLng(33.64619, 72.99583),
      const LatLng(33.64621, 72.99557),
      const LatLng(33.64492, 72.99654),
      const LatLng(33.64411, 72.9971),
      const LatLng(33.64427, 72.9974),
      const LatLng(33.6438, 72.99779),
      const LatLng(33.64332, 72.99688),
      const LatLng(33.64315, 72.99655),
      const LatLng(33.64309, 72.9965),
      const LatLng(33.64303, 72.99648),
      const LatLng(33.643, 72.99649),
      const LatLng(33.64257, 72.9968),
      const LatLng(33.6412, 72.99779),
      const LatLng(33.64071, 72.99688),
      const LatLng(33.63976, 72.99505),
      const LatLng(33.63837, 72.99245),
      const LatLng(33.63726, 72.99031),
      const LatLng(33.63717, 72.99013),
      const LatLng(33.63609, 72.99094),
      const LatLng(33.63594, 72.99105),
      const LatLng(33.63535, 72.99148),
      const LatLng(33.63575, 72.99221),
      const LatLng(33.63592, 72.99253),
      const LatLng(33.63618, 72.99294),
      const LatLng(33.6363, 72.9931)
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

  Widget searchList() {
    return Container(
      height: searchLocations.length < 4 ? searchLocations.length * 80 : 300,
      color: Colors.white,
      child: ListView.builder(
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
      ),
    );
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

  onClickSearchedItem(SearchLocation searchLocation) async {
    searchController.text = searchLocation.name;
    FocusManager.instance.primaryFocus?.unfocus();
    searchLocations.clear();
    setState(() {});
    widget.selectedLatLng = LatLng(searchLocation.lat, searchLocation.lng);
    await _onMapCreated(mapController!);
  }
}

class SearchLocation {
  String name;
  String address;
  double lat;
  double lng;

  SearchLocation(this.name, this.address, this.lat, this.lng);
}
