import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Test extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent
          //color set to transparent or set your own color
        )
    );

    return Scaffold(
      // backgroundColor: Colors.deepOrange,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Image(
              image: NetworkImage(
                  'https://mostaql.hsoubcdn.com/uploads/365677/6076e458c254c/logogolden-ratio2-copy.png'
              ),
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            ImageFiltered(
              imageFilter: ImageFilter.matrix(Matrix4.rotationX(180).storage),
              child: const Image(
                image: NetworkImage(
                    'https://blog.lingoda.com/wp-content/uploads/2020/10/How-To-Say-Hello-in-10-Languages.jpg'
                ),
                width: double.infinity,
                fit: BoxFit.cover,
                // colorBlendMode: BlendMode.darken,
              ),
            ),
          ],
        ),
      ),
    );
  }

}