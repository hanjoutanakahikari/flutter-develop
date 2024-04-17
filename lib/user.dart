import 'package:flutter/rendering.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'user.g.dart';
part 'user.freezed.dart';

@freezed
class User with _$User {
  factory User(String name, int age) = _User;
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}