import 'package:flutter/material.dart';

class ShopLoginModel {
  bool status;
  String message;
  LoginUserData data;

  ShopLoginModel({
    @required Map<String, dynamic> loginData
  }){
    status = loginData['status'];
    message = loginData['message'];
    data = loginData['data']!=null
        ? LoginUserData.fromJson(data: loginData['data'])
        : null;
  }

}

class LoginUserData {
  int id;
  String name;
  String email;
  String phone;
  String image;
  int points;
  int credit;
  String token;


  LoginUserData.fromJson({
    @required Map<String, dynamic> data,
}){
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