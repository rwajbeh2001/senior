import 'dart:convert';

import 'package:doctor_pro/Helpers/enviroment.dart';
import 'package:doctor_pro/Helpers/storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileController {
  static final apiKey = Enviroment.apiKey;

  static logout() async {
    await StroageController.delete("loginToken");
    await StroageController.delete("user");
  }
}
