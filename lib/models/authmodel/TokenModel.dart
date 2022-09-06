// To parse this JSON data, do
//
//     final tokenModel = tokenModelFromJson(jsonString);

import 'dart:convert';

TokenModel tokenModelFromJson(String str) => TokenModel.fromJson(json.decode(str));

String tokenModelToJson(TokenModel data) => json.encode(data.toJson());

class TokenModel {
  TokenModel({
    required this.tokenZexly,
  });

  String tokenZexly;

  factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
    tokenZexly: json["tokenZexly"],
  );

  Map<String, dynamic> toJson() => {
    "tokenZexly": tokenZexly,
  };
}
