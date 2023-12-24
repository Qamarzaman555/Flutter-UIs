part of '../local_pub.dart';

class Utils {
  static showSnack(BuildContext context, String msg, {Duration? duration}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      duration: duration ?? const Duration(milliseconds: 4000),
    ));
  }

  static showErrorSnack(BuildContext context, String msg,
      {Duration? duration}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(msg),
          backgroundColor: CHIStyles.primaryErrorColor,
          duration: duration ?? const Duration(milliseconds: 4000)),
    );
  }

  static showSuccessSnack(BuildContext context, String msg,
      {Duration? duration}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(msg),
          backgroundColor: CHIStyles.primarySuccessColor,
          duration: duration ?? const Duration(milliseconds: 4000)),
    );
  }

  static Future<String> getAddressFromCoordinates(LatLng latlng) async {
    String address = '';
    const apiKey = 'AIzaSyDsef6naWlgUqZwYN1AB_lH611BDaSOxPY';
    final apiUrl =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${latlng.latitude},${latlng.longitude}&key=$apiKey';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);

        if (decodedResponse['status'] == 'OK') {
          final results = decodedResponse['results'];
          if (results.isNotEmpty) {
            address = results[0]['formatted_address'];
            return address;
          }
        }
      }
      return address;
    } catch (e) {
      return 'Error getting address: $e';
    }
  }

  static Future<String> getAddressFromCoordinates2(LatLng latlng) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latlng.latitude, latlng.longitude);

    if (placemarks.isEmpty) {
      return "No address found";
    }

    Placemark first = placemarks[0];
    String address =
        "${first.street}, ${first.subLocality}, ${first.locality}, ${first.country}";

    return address;
  }

  static Future<Position> getCurrentPosition(context) async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Utils.showErrorSnack(
          context, 'Please enable your location first and restart you app');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Utils.showErrorSnack(context, 'You denied location permissions');
        getCurrentPosition(context);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Utils.showErrorSnack(context,
          'Location permissions are permanently denied, we cannot request permissions.');
      await Geolocator.openLocationSettings();
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}
