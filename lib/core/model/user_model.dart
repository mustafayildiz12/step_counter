import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

UserModel userFromJson(String str) => UserModel.fromJson(json.decode(str));

String userToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel(
      {this.name,
      this.step,
      this.email,
      this.uid,
      this.date,
      this.pass,
      this.profileUrl});

  String? name;
  String? email;
  String? uid;
  Timestamp? date;
  String? pass;
  String? profileUrl;
  int? step;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      name: json["name"],
      email: json["email"],
      uid: json["uid"],
      date: json["date"],
      pass: json["pass"],
      step: json["step"],
      profileUrl: json['profileUrl']);

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "uid": uid,
        "date": date,
        "pass": pass,
        "profileUrl": profileUrl,
        "step": step
      };
}
