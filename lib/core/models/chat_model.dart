import 'dart:convert';

ChatModel chatFromJson(String str) => ChatModel.fromJson(json.decode(str));

String chatToJson(ChatModel data) => json.encode(data.toJson());

class ChatModel {
  ChatModel({this.uid, this.message});

  String? message;
  String? uid;
  // Timestamp? date;

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        uid: json["uid"],
        //   date: json["date"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "name": message,
        "uid": uid,
        //  "date": date,
      };
}
