class WhatsappModel {
  String name;
  String message;
  int number;

  WhatsappModel({
    required this.number,
    required this.message,
    required this.name,
  });
}

class ChatStatusModel {
  String name;
  String time;

  ChatStatusModel({
    required this.name,
    required this.time,
  });
}
