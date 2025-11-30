import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:travel_hub/navigation/land_mark/models/land_mark_model.dart';



class EgLandMark {
  static Future<List<LandMark>> getLandMark() async {
    final response = await rootBundle.loadString(
      "assets/data/egypt_landmarks_detailed.json",
    );
    final decoded = jsonDecode(response);
    final List landMark = decoded;
    final shuffled = landMark..shuffle();
    return shuffled.map((e) => LandMark.fromJson(e)).toList();
  }
}