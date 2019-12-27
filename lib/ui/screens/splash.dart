import 'package:flutter/material.dart';
import 'package:mc_jsi/core/constants.dart';
import 'package:mc_jsi/core/functions.dart';
import 'package:mc_jsi/ui/widgets.dart/widget_helpers.dart';
//import 'package:video_player/video_player.dart';

class Splash1 extends StatefulWidget {
  Splash1({Key key}) : super(key: key);

  @override
  _Splash1State createState() => _Splash1State();
}

class _Splash1State extends State<Splash1> {
  //VideoPlayerController _controller;
  @override
  void initState() { 
    super.initState();
     /* _controller = VideoPlayerController.asset(
        'logo.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        _controller.play();
        setState(() {});
      });  */
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushNamed(context, Constants.ROUTE_SPLASH2);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: screenW(1, context),
        height: screenH(1, context),
        padding: EdgeInsets.only(
          left: screenW(0.25, context),
          right:screenW(0.25, context)
        ),
        color: Colors.white,
         child: /*  _controller.value.initialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Container()  */
            Hero(
             tag: 'logo',
             child: fireSvgwidth(screenW(0.5, context), 'label', 'assets/logo.svg')
             ) 
             )
      
    );
  }
}