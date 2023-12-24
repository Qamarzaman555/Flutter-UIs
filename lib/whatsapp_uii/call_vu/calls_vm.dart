import 'package:practice/whatsapp_uii/whatsapp_model/whatsapp_model.dart';
import 'package:stacked/stacked.dart';

class CallsVM extends BaseViewModel {
  List<ChatStatusModel> callList = [
    ChatStatusModel(time: '32 minutes ago', name: 'Ali Hassan Cheema'),
    ChatStatusModel(time: '50 minutes ago', name: 'Raheel Hassan'),
    ChatStatusModel(time: 'Today, 7:46 PM', name: 'Faraz Khan'),
    ChatStatusModel(time: 'Yesterday, 8:40 PM', name: 'Ihsan Afridi'),
    ChatStatusModel(time: 'Yesterday, 9:50 PM', name: 'Sayad Afridi'),
  ];
}
