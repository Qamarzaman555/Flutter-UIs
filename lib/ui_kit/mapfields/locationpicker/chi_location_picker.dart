part of '../../local_pub.dart';

// ignore: must_be_immutable
class CHILocationPicker extends StatelessWidget {
  CHILocationPicker({
    super.key,
    required this.pickerTitle,
    required this.onGetLatLng,
    this.selectedLatLng,
    this.forDirection = false,
  });
  String pickerTitle;
  LatLng? selectedLatLng;
  final Function(LatLng latlng) onGetLatLng;
  bool forDirection;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return CHICard(
        // color: forDirection ? Colors.white : null,
        padding: forDirection ? const EdgeInsets.all(8) : null,
        border: Border.all(
            color: Colors.grey[400]!), //forDirection ? Border.all() : null,
        onTap: () {
          CHIRouter.push(
              context,
              CHIGoogleMap(
                selectedLatLng: selectedLatLng,
              )).then((value) async {
            if (value != null) {
              selectedLatLng = value;
              onGetLatLng(selectedLatLng!);
              pickerTitle = await Utils.getAddressFromCoordinates(value);
              setState(() {});
            }
          });
        },
        child: Row(
          children: [
            Expanded(
                child: Text(
              pickerTitle,
              maxLines: forDirection ? 1 : 2,
              overflow: TextOverflow.ellipsis,
            )),
            forDirection
                ? const SizedBox.shrink()
                : Icon(
                    Icons.location_on,
                    color: Theme.of(context).primaryColor,
                  )
          ],
        ),
      );
    });
  }
}
