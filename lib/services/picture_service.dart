import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:awesomeapp/models/picture_model.dart';
import 'dart:io';
import 'dart:async';

class PictureService extends ChangeNotifier {
  List<dynamic> ListPicture = [];
  Future readApi() async {
    await http.get(Uri.parse('https://api.pexels.com/v1/curated?per_page=80'),
        headers: {
          'Authorization':
              '563492ad6f91700001000001a88679363b0b4db195bc85e02272f53b'
        }).then((value) {
      Map result = jsonDecode(value.body);
    });
    this.notifyListeners();
  }
}
