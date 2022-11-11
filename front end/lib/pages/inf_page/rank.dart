import 'package:flutter/material.dart';
import 'package:the_gorgeous_login/config/theme.dart';

class rank extends StatelessWidget {
  rank({Key key}) : super(key: key);

  List<Widget> rl = [
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [Text("Patton"), Text("28 victories")],
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [Text("Nicole"), Text("27 victories")],
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [Text("Anthony"), Text("23 victories")],
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [Text("Zane"), Text("19 victories")],
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [Text("Venus"), Text("16 victories")],
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [Text("Ann"), Text("13 victories")],
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [Text("Anne"), Text("12 victories")],
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [Text("Anita"), Text("11 victories")],
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [Text("Beata"), Text("10 victories")],
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [Text("Belle"), Text("5 victories")],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(135, 206, 250, 1),
          title: Text("Rank"),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: <Color>[
                  CustomTheme.loginGradientStart,
                  CustomTheme.loginGradientEnd
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 1.0),
                stops: <double>[0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: ListView.builder(
              itemCount: 10,
              itemExtent: 50.0, //强制高度为50.0
              itemBuilder: (BuildContext context, int index) {
                return rl[index];
              }),
        ));
  }
}
