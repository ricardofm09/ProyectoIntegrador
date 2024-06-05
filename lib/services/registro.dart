import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String uid;
  String nombre;
  String apellido;
  String email;
  String edad;

  UserModel({

    required this.uid,
    required this.nombre,
    required this.apellido,
    required this.email,
    required this.edad,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    uid: json["uid"],
    nombre: json["nombre"],
    apellido: json["apellido"],
    email: json["email"],
    edad: json["edad"],
  );

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "nombre": nombre,
    "apellido": apellido,
    "email": email,
    "edad": edad,
  };
}
