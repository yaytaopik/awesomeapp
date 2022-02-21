import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:photo_view/photo_view.dart';

class PhotoDetails extends StatefulWidget {
  final String url;
  final String tag;

  const PhotoDetails({Key? key, required this.tag, required this.url})
      : super(key: key);

  @override
  _PhotoDetailsState createState() => _PhotoDetailsState();
}

class _PhotoDetailsState extends State<PhotoDetails> {
  late PhotoViewScaleStateController scaleStateController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scaleStateController = PhotoViewScaleStateController();
  }

  void dispose() {
    scaleStateController.dispose();
    super.dispose();
  }

  void goBack() {
    scaleStateController.scaleState = PhotoViewScaleState.originalSize;
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
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
                color: Colors.grey.shade200.withOpacity(0.5),
              ),
              filter: ui.ImageFilter.blur(sigmaX: 18.0, sigmaY: 18.0),
            ),
          ),
          Hero(
            transitionOnUserGestures: true,
            tag: widget.tag,
            child: Container(
              color: Colors.transparent,
              height: h,
              width: w,
              child: Scaffold(
                appBar: AppBar(
                  title: Text('Kembali'),
                ),
                body: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      child: PhotoView(
                          imageProvider: NetworkImage(widget.url),
                          initialScale: 1.0),
                    ),
                    Positioned(
                        width: w / 1,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                          ),
                          child: Wrap(
                            children: [
                              Row(
                                children: [
                                  Text('Tag:',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    widget.tag,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ],
                              ),
                              Text(
                                widget.url,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
