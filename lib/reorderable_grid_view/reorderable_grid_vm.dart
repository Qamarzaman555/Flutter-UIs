import 'package:stacked/stacked.dart';

class ReorderableGridVM extends BaseViewModel {
  double? oldIndex;
  double? newIndex;
  bool get loading => false;

  List<String> patientsList = ['qamar', 'sayad', 'zaman'];
}
