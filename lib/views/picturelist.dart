import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:awesomeapp/provider/pictureprovider.dart';
import 'package:awesomeapp/views/picturedetail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:simple_connection_checker/simple_connection_checker.dart';

class PictureListView extends StatefulWidget {
  const PictureListView({Key? key}) : super(key: key);

  @override
  _PictureListViewState createState() => _PictureListViewState();
}

class _PictureListViewState extends State<PictureListView> {
  bool isGrid = true;
  bool? isConnected;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  final ScrollController _controller = ScrollController();
  fetchData() {
    Provider.of<PictureProvider>(context, listen: false).callPhotoApi();
  }

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      fetchData();
    });

    // TODO: implement initState
    super.initState();
    _controller.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      fetchData();
    }
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_UpdateConnectionState);
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print("Error Occurred: ${e.toString()} ");
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }
    return _UpdateConnectionState(result);
  }

  Future<void> _UpdateConnectionState(ConnectivityResult result) async {
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
    setState(() {
      isConnected == true;
    });
    } else {
     setState(() {
       isConnected == false;
     });
    }
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              pinned: true,
              floating: false,
              snap: false,
              actions: <Widget>[
                isGrid
                    ? new IconButton(
                        onPressed: () {
                          setState(() {
                            isGrid = false;
                          });
                        },
                        icon: FaIcon(FontAwesomeIcons.thList))
                    : new IconButton(
                        onPressed: () {
                          setState(() {
                            isGrid = true;
                          });
                        },
                        icon: FaIcon(FontAwesomeIcons.thLarge))
              ],
              expandedHeight: 220.0,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: false,
                  titlePadding:
                      EdgeInsets.symmetric(vertical: 17, horizontal: 10),
                  title: Text(
                    'Awesome app',
                    style: TextStyle(
                      fontFamily: 'JosefinSans',
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  background: Image.network(
                    'https://images.pexels.com/photos/8850944/pexels-photo-8850944.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
                    fit: BoxFit.cover,
                  )),
            ),
          ];
        },
        body: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              height: h,
              color: Colors.transparent,
              child: FlutterLogo(),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              child: BackdropFilter(
                child: Container(
                  height: h,
                  color: Colors.white24.withOpacity(0.5),
                ),
                filter: ui.ImageFilter.blur(sigmaX: 18.0, sigmaY: 18.0),
              ),
            ),
            OrientationBuilder(
              builder: (context, orientation) {
                return Consumer<PictureProvider>(
                  builder: (context, data, __) {
                    if (data != null ||
                        data.photos != null ||
                        data.photos.length != 0) {
                      if (orientation == Orientation.portrait) {
                        if (isGrid == true) {
                          return gridPic(data);
                        } else {
                          return body(data);
                        }
                      } else {
                        return Row(
                          children: [
                            Expanded(flex: 5, child: body(data)),
                            Expanded(
                                flex: 5,
                                child: Center(
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Text('Awesome App'),
                                        Text(
                                          'Developed by Yayang Taopik',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                      ],
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                    ),
                                  ),
                                ))
                          ],
                        );
                      }
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget gridPic(data) {
    double h = MediaQuery.of(context).size.height;
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 0,
          crossAxisSpacing: 0,
        ),
        itemCount: data.photos.length,
        itemBuilder: (context, index) {
          if (index == data.photos.length - 1) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => PhotoDetails(
                          tag: data.photos[index].id.toString(),
                          url: data.photos[index].src.large2x.toString())));
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              height: h / 20,
              margin: EdgeInsets.all(h / 50),
              child: Hero(
                transitionOnUserGestures: true,
                tag: data.photos[index].id.toString(),
                child: Container(
                  child: Image.network(
                    data.photos[index].src.medium.toString(),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget body(data) {
    double h = MediaQuery.of(context).size.height;
    return ListView.builder(
        controller: _controller,
        itemCount: data.photos.length,
        itemBuilder: (context, index) {
          if (index == data.photos.length - 1) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => PhotoDetails(
                          tag: data.photos[index].id.toString(),
                          url: data.photos[index].src.large2x.toString())));
            },
            child: Container(
              height: h / 2,
              margin: EdgeInsets.all(h / 18),
              child: Hero(
                transitionOnUserGestures: true,
                tag: data.photos[index].id.toString(),
                child: Image.network(
                  data.photos[index].src.medium.toString(),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        });
  }
}
