import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatelessWidget {
  double _marginV = 12, _marginH = 40,
      _boxHeight = 180, _padding = 25,
      _fontSize = 35;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.menu,
        ),
        title: Text(
          'Mostafa Alazhariy',
        ),
        actions: [
          Icon(
            Icons.notifications,
            color: Colors.white,
          ),
          Icon(
            Icons.search,
          ),
        ],
        backgroundColor: Colors.lightBlue,
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // image
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  )
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                margin: EdgeInsets.only(
                  top: _padding,
                  right: _padding+15,
                  left: _padding+15,
                ),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Image(
                      image: NetworkImage(
                        'https://scontent.fcai19-2.fna.fbcdn.net/v/t1.6435-9/187137835_3930767890343555_7817363124794517256_n.jpg?_nc_cat=106&ccb=1-3&_nc_sid=8bfeb9&_nc_ohc=MxTdZDmoLBYAX_DREq3&_nc_ht=scontent.fcai19-2.fna&oh=f7ba37bab008232b791f6d37be180794&oe=60CA90EB'
                      ),
                       height: 400,
                       width: 400,
                      fit: BoxFit.cover,

                    ),
                    Container(
                      // alignment: Alignment.center,
                      width: double.infinity,
                      color: Colors.black54,
                      padding: EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                      child: Text(
                        'اقفل البرنامج يا كلب!',
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // first hello world
              Container(
                height: _boxHeight,
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                  top: _marginV*2,
                  bottom: _marginV,
                  left: _marginH,
                  right: _marginH,
                ),
                padding: EdgeInsets.all(_padding),
                child: Text(
                  'Hello world first',
                  style: TextStyle(
                    fontSize: _fontSize,
                    color: Colors.white,
                  ),
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.center,
                ),
                color: Colors.deepOrange,
              ),
              Container(
                height: _boxHeight,
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(
                  horizontal: _marginH,
                  vertical: _marginV,
                ),
                padding: EdgeInsets.all(_padding),
                child: Text(
                  'Hello world',
                  style: TextStyle(
                    fontSize: _fontSize,
                    color: Colors.white,
                  ),
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.center,
                ),
                color: Colors.blue,
              ),
              Container(
                height: _boxHeight,
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(
                  horizontal: _marginH,
                  vertical: _marginV,
                ),
                padding: EdgeInsets.all(_padding),
                child: Text(
                  'Hello world',
                  style: TextStyle(
                    fontSize: _fontSize,
                    color: Colors.black,
                  ),
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.center,
                ),
                color: Colors.lightGreenAccent,
              ),
              Container(
                height: _boxHeight,
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(
                  horizontal: _marginH,
                  vertical: _marginV,
                ),
                padding: EdgeInsets.all(_padding),
                child: Text(
                  'Hello world',
                  style: TextStyle(
                    fontSize: _fontSize,
                    color: Colors.white,
                  ),
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.center,
                ),
                color: Colors.black,
              ),
              // عطية
              Container(
                height: _boxHeight *2,
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                top: _marginV,
                bottom: _marginV*2,
                left: _marginH,
                right: _marginH,
              ),
                padding: EdgeInsets.all(_padding),
                child: Text(
                  'عطية علق ومش بيذاكر',
                  style: TextStyle(
                    fontSize: _fontSize,
                     fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center,
                ),
                color: Colors.pink,
              ),
            ],
          ),
        ),
      ),
    );
  }

}