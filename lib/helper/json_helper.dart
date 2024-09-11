import 'dart:convert';

import 'package:animator/models/planet_model.dart';
import 'package:flutter/services.dart';

class JsonHelper {
  JsonHelper._();

  static JsonHelper jsonHelper = JsonHelper._();

  Future<List<PlanetModel>?> loadJson() async {
    late String loadJsonString;
    loadJsonString = await rootBundle.loadString('assets/json/planets.json');

    if (loadJsonString.isNotEmpty) {
      Map? planetMap = jsonDecode(loadJsonString);
      List planetList = planetMap!['planets'];
      List<PlanetModel>? planetListModel;
      return planetListModel =
          planetList.map((e) => PlanetModel.fromMap(data: e)).toList();
    } else {
      return null;
    }
  }
}
