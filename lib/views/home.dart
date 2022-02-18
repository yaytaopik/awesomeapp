import 'package:awesomeapp/services/picture_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PictureService())
      ],
      child: Scaffold(
        body: Consumer<PictureService>(
          builder: (context, providerPicture, child) {
            return NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      elevation: 0,
                      title: Text(
                        'Awesome app',
                        style: TextStyle(color: Colors.black, fontSize: 27),
                      ),
                    expandedHeight: 100,
                    floating: true,
                    pinned: false,
                    snap: false,
                    backgroundColor: Colors.white,
                    )
                  ];
                },
                body: Text('awesome'));
          },
        ),
      ),
    );
  }
}
