// UserModel class

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String? fullName;
  final String? phone;
  final String? email;
  final String? nickName;
  final int? gender;
  DateTime? birthDate;
  final String? imageUrl;
  final String? nationality;

  UserModel({
    this.id,
    this.fullName,
    this.nickName,
    this.phone,
    this.email,
    this.gender,
    this.birthDate,
    this.imageUrl,
    this.nationality,
  });

  toJson() {
    return {
      'fullName': fullName,
      'nickName': nickName,
      'phone': phone,
      'email': email,
      'gender': gender,
      'birthDate': birthDate,
      'imageUrl': imageUrl,
      'nationality': nationality,
    };
  }

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserModel(
      fullName: data['fullName'],
      phone: data['phone'],
      nickName: data['nickName'],
      email: data['email'],
      gender: data['gender'],
      nationality: data['nationality'],
      birthDate: data['birthDate'] != null
          ? (data['birthDate'] as Timestamp).toDate()
          : null,
      id: doc.id,
      imageUrl: data['imageUrl'],
    );
  }

  @override
  String toString() {
    return 'UserModel(fullName: $fullName, phone: $phone, email: $email, nickName: $nickName, gender: $gender,  birthDate: $birthDate, id: $id, imageUrl: $imageUrl, nationality: $nationality)';
  }
}
