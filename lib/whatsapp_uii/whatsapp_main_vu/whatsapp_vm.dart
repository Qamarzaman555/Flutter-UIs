import 'package:stacked/stacked.dart';

class WhatsappVM extends BaseViewModel {
  int initialIndex = 1;
  onChangeTab(int index) {
    initialIndex = index;
    notifyListeners();
  }
}
