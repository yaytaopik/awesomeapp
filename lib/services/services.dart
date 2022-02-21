import 'dart:convert';

import 'package:dio/dio.dart';

class PictureApi {
  Dio dio = new Dio();
  getPhotos(int page, String search) async {
      final response = await dio.get("https://api.pexels.com/v1/curated?per_page=80&page=$page",  options: Options(headers: {'Authorization': 'Bearer 563492ad6f91700001000001a88679363b0b4db195bc85e02272f53b'})); 
      // final response = await dio.get("https://api.pexels.com/v1/search?query=$search&per_page=10&page=$page",  options: Options(headers: {'Authorization': 'Bearer 563492ad6f91700001000001a88679363b0b4db195bc85e02272f53b'})); 
      print(response.data);
      return response.data;
  }
}