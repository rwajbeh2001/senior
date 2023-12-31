import 'dart:html';
import 'dart:io';

import 'package:doctor_pro/Helpers/enviroment.dart';
import 'package:doctor_pro/Helpers/storage.dart';
import 'package:doctor_pro/constant/constant.dart';
import 'package:doctor_pro/pages/login_signup/login.controller.dart';
import 'package:doctor_pro/pages/screens.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginController {
  static String? loginToken;
  static final apiKey = Enviroment.apiKey;
  Constructor() {
    LoginController.loginToken = null;
  }

  static isLoggedIn(context) async {
    final loggedIn = await StroageController.get("loginToken");
    final isloggedIn = loggedIn != null && loggedIn != "" ? true : false;
    if (!isloggedIn) {
      Navigator.push(
          context,
          PageTransition(
              duration: Duration(milliseconds: 600),
              type: PageTransitionType.fade,
              child: Login()));
    } else {
      Navigator.push(
          context,
          PageTransition(
              duration: Duration(milliseconds: 600),
              type: PageTransitionType.fade,
              child: BottomBar()));
    }
  }

  static login(context, email, password) async {
    print(email);
    print(password);
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$apiKey');
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
    if (res["localId"] != "" && res["localId"] != null) {
      final String id = res["localId"] ?? "";
      final url =
          'https://firestore.googleapis.com/v1/projects/psychiatristapp-c31a8/databases/(default)/documents:runQuery?key=$apiKey';
      final urli = Uri.parse(url);

      final requestBody = jsonEncode({
        'structuredQuery': {
          'select': {
            'fields': [
              {'fieldPath': 'id'},
              {'fieldPath': 'name'},
              {'fieldPath': 'gender'},
              {'fieldPath': 'country'},
              {'fieldPath': 'phone'},
              // Add other fields you want to retrieve
            ],
          },
          'from': [
            {'collectionId': 'Patient-Info'},
          ],
          'where': {
            'fieldFilter': {
              'field': {'fieldPath': 'id'},
              'op': 'EQUAL',
              'value': {'stringValue': id},
            },
          },
        },
      });

      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: requestBody,
      );
      final responseData = json.decode(response.body);

      final user = responseData[0]["document"]["fields"];
      final userData = {
        "id": responseData[0]["document"]["fields"]["id"]["stringValue"],
        "country": responseData[0]["document"]["fields"]["country"]
            ["stringValue"],
        "gender": responseData[0]["document"]["fields"]["gender"]
            ["stringValue"],
        "name": responseData[0]["document"]["fields"]["name"]["stringValue"],
        "phone": responseData[0]["document"]["fields"]["phone"]["stringValue"],
      };
      await StroageController.set("loginToken", res["idToken"]);
      await StroageController.set("user", jsonEncode(userData));
      Navigator.push(
          context,
          PageTransition(
              duration: Duration(milliseconds: 600),
              type: PageTransitionType.fade,
              child: BottomBar()));
    } else {
      LoginController.showCustomToast("Invalid Email Or Password", context);
    }
  }

  static showCustomToast(String msg, BuildContext context) {
    final double toastWidth = MediaQuery.of(context).size.width * 0.8;
    final double toastHeight = 45.0;
    final double fontSize = 16.0;

    OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
        bottom: 100, // Adjust the position as needed
        left: (MediaQuery.of(context).size.width - toastWidth) / 2,
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: toastWidth,
            height: toastHeight,
            decoration: BoxDecoration(
              color:
                  Colors.grey.withOpacity(0.2), // More transparent gray color
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Center(
              child: Text(
                msg,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize,
                ),
              ),
            ),
          ),
        ),
      );
    });

    Overlay.of(context)?.insert(overlayEntry);

    // Remove the toast after a certain duration
    Future.delayed(Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }

  static goToRegister(context) {
    Navigator.push(
        context,
        PageTransition(
            duration: Duration(milliseconds: 600),
            type: PageTransitionType.fade,
            child: Register()));
  }
}
