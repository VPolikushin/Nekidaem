import 'package:json_annotation/json_annotation.dart';

part 'auth_jwt_model.g.dart';

@JsonSerializable()
class UserJwt {
  String token;

  UserJwt({required this.token});

  factory UserJwt.fromJson(Map<String, dynamic> json) =>
      _$UserJwtFromJson(json);
  Map<String, dynamic> toJson() => _$UserJwtToJson(this);
}