import 'package:doctor_pro/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:doctor_pro/pages/screens.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegistrationController {
  static register(context, email, password, name, phone, gender) async {
    print("herreee");
    print(email.text);
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyBWsODoUUCHwyWAaC5XXDJIOxuQk0lKJvI');
    final response = await http.post(
      url,
      body: json.encode({
        'email': email.text,
        'password': password.text,
        'returnSecureToken': true,
      }),
    );
    final res = json.decode(response.body);
    print(res);
    if (res['localId'] != null) {
      // Signup successful
      final user = json.encode({
        'fields': {
          'id': {'stringValue': res['localId']},
          'name': {'stringValue': name.text},
          'phone': {'stringValue': phone.text},
          'country': {'stringValue': name.text},
          'gender': {'stringValue': gender}
        }
      });

      const url =
          'https://firestore.googleapis.com/v1/projects/psychiatristapp-c31a8/databases/(default)/documents/Patient-Info?key=AIzaSyBWsODoUUCHwyWAaC5XXDJIOxuQk0lKJvI';
      final uri = Uri.parse(url);
      final adduser = await http.post(uri, body: user);
      final responseData = json.decode(adduser.body);
      print(responseData);
      Navigator.push(
          context,
          PageTransition(
              duration: Duration(milliseconds: 600),
              type: PageTransitionType.fade,
              child: BottomBar()));
      // Store the token and user ID or perform any necessary actions
    } else {
      // Signup failed
      final responseData = json.decode(response.body);
      final String? errorMessage = responseData['error']['message'];

      // Handle the error appropriately
    }
  }
}
