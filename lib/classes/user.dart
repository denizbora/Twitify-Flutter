import 'package:flutter/material.dart';

class MyUser {
  String? username;
  String? bio;
  String? authToken;
  String? authTokenSecret;
  String? profileImage;
  String? newBio;
  String? spotifyKey;
  ValueNotifier<bool> isLogin;

  MyUser({ this.username,  this.bio,  this.authToken,  this.authTokenSecret,this.profileImage,required this.isLogin});
}