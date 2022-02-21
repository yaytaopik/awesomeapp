import 'package:awesomeapp/models/picture_model.dart';
import 'package:awesomeapp/services/services.dart';
import 'package:flutter/material.dart';

class PictureProvider extends ChangeNotifier {
  int _page = 1;
  String _search = 'color';
  
  String get search => _search;

  set search(String value) {
    _search = value;
    notifyListeners();
  }

  int get page => _page;
  
  set page(int value) {
    _page = value;
    notifyListeners();
  }

  List<Photos> _photos = <Photos>[];

  List<Photos> get photos => _photos;

  set photos(List<Photos> value) {
    _photos = value;
  }

 Future<void> callPhotoApi() async {
    await PictureApi().getPhotos(_page, _search).then((response) {
      _page = _page + 1;

      addPhotosToList(PictureModel.fromJson(response).photos);
    });
    notifyListeners();
  }

  Future<void> fetchPhotoApi() async {
    notifyListeners();
  }

  void addPhotosToList(List<Photos> photoData) {
    _photos.addAll(photoData);
    notifyListeners();
  }

  void addAllPhotos(List<Photos> photoData) {
    _photos.addAll(photoData);
    notifyListeners();
  }
}