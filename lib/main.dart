import 'package:flutter/material.dart';
import 'package:awesomeapp/views/picturelist.dart';
import 'package:awesomeapp/provider/pictureprovider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => PictureProvider(),
    child: new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'awesome app',
      theme: ThemeData(fontFamily: 'Montserrat'),
      home: PictureListView(),
    ),
  ));
}
