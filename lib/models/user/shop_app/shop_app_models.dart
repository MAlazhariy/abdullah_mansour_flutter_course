// ignore_for_file: unused_import

import 'package:flutter/material.dart';

class ShopLoginModel {
  late bool status;
  late String message;
  LoginUserData? data;

  ShopLoginModel({
    required Map<String, dynamic> loginData,
  }) {
    status = loginData['status'];
    message = loginData['message'];
    data = loginData['data'] != null
        ? LoginUserData.fromJson(data: loginData['data'])
        : null;
  }
}

class LoginUserData {
  late int id;
  late String name;
  late String email;
  late String phone;
  late String image;
  late int points;
  late int credit;
  late String token;

  LoginUserData.fromJson({
    required Map<String, dynamic> data,
  }) {
    id = data['id'];
    name = data['name'];
    email = data['email'];
    phone = data['phone'];
    image = data['image'];
    points = data['points'];
    credit = data['credit'];
    token = data['token'];
  }
}
