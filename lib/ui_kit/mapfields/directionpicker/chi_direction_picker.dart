part of '../../local_pub.dart';

// ignore: must_be_immutable
class CHIDirectionPicker extends StatelessWidget {
  CHIDirectionPicker(
      {super.key,
      required this.pickerTitle,
      required this.onGetDirectionPolyline,
      this.selectedDirectionPolyline});
  DirectionPolyline? selectedDirectionPolyline;
  String pickerTitle;
  final Function(DirectionPolyline directionPolyline) onGetDirectionPolyline;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return CHICard(
        onTap: () {
          CHIRouter.push(
                  context,
                  CHIDirectionWidget(
                      selectedDirectionPolyline: selectedDirectionPolyline))
              .then((value) async {
            if (value != null) {
              pickerTitle = '${value.distance}, ${value.duration}';
              onGetDirectionPolyline(value);
              setState(() {});
            }
          });
        },
        child: Row(
          children: [
            Expanded(child: Text(pickerTitle, maxLines: 2)),
            Icon(
              Icons.location_searching_rounded,
              color: Theme.of(context).primaryColor,
            )
          ],
        ),
      );
    });
  }
}

class DirectionPolyline {
  List<LatLng> polylinePoints;
  String originAddress;
  String destinationAddress;
  String distance;
  String duration;
  LatLng? originLatLng;
  LatLng? destinationLatLng;

  DirectionPolyline(
      this.polylinePoints,
      this.originLatLng,
      this.destinationLatLng,
      this.originAddress,
      this.destinationAddress,
      this.distance,
      this.duration);
}
