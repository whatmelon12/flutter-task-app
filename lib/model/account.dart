import 'package:json_annotation/json_annotation.dart';

part 'account.g.dart';

// flutter packages pub run build_runner build

@JsonSerializable()
class Account {
  String email;
  String password;

  Account({this.email, this.password});

  factory Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);

  Map<String, dynamic> toJson() => _$AccountToJson(this);
}