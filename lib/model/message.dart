class MessageModel {
  String? senderID;
  String? recieverId;
  String? dateTime;
  String? text;
  MessageModel({
    required this.senderID,
    required this.recieverId,
    required this.dateTime,
    required this.text,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    senderID = json['senderID'];
    recieverId = json['recieverId'];
    dateTime = json['dateTime'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['senderID'] = senderID;
    data['recieverId'] = recieverId;
    data['dateTime'] = dateTime;
    data['text'] = text;

    return data;
  }
}
