import 'package:practice/whatsapp_uii/whatsapp_model/whatsapp_model.dart';
import 'package:stacked/stacked.dart';

class ChatsVM extends BaseViewModel {
  List<WhatsappModel> chats = [
    WhatsappModel(
      message: 'whatever',
      name: 'Qamar Zaman',
      number: 92333333333,
    ),
    WhatsappModel(
      message: 'something',
      name: 'Tahir Zaman',
      number: 92333333333,
    ),
    WhatsappModel(
      message: 'whatever',
      name: 'Sayad Afridi',
      number: 92333333333,
    ),
    WhatsappModel(
      message: 'whatever',
      name: 'Fahad Afridi',
      number: 92333333333,
    ),
    WhatsappModel(
      message: 'whatever',
      name: 'Shayan Afridi',
      number: 92333333333,
    ),
    WhatsappModel(
      message: 'whatever',
      name: 'Faraz Khan',
      number: 92333333333,
    ),
  ];

  onUpdateChat(int index, WhatsappModel chat) {
    chats[index] = chat;
    notifyListeners();
  }

  onAddChat(chat) {
    chats.add(chat);
    notifyListeners();
  }

  onDelteChat(chat) {
    chats.removeAt(chat);
    notifyListeners();
  }
}
