// UserModel class

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String? fullName;
  final String? phone;
  final String? email;
  final String? nickName;
  final String? nationality;

  UserModel({
    this.id,
    this.fullName,
    this.nickName,
    this.phone,
    this.email,
    this.nationality,
  });

  toJson() {
    return {
      'fullName': fullName,
      'nickName': nickName,
      'phone': phone,
      'email': email,
      'nationality': nationality,
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      id: document.id,
      fullName: data['fullName'],
      phone: data['phone'],
      nickName: data['nickName'],
      email: data['email'],
      nationality: data['nationality'],
    );
  }

  @override
  String toString() {
    return 'UserModel(fullName: $fullName, phone: $phone, email: $email, nickName: $nickName, id: $id, nationality: $nationality)';
  }
}
