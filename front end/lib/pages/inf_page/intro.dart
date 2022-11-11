import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

List<Widget> il = [
  Column(
    children: [
      Text(
        "group mode",
        style: TextStyle(
            color: Colors.white, fontSize: 50.0, fontFamily: 'WorkSansBold'),
      ),
      Container(
        child: Image(
          image: const AssetImage('assets/img/i0.PNG'),
          fit: BoxFit.fill,
        ),
      ),
    ],
  ),
  Column(
    children: [
      Text(
        "Click here to stop the dice",
        style: TextStyle(
            color: Colors.white, fontSize: 50.0, fontFamily: 'WorkSansBold'),
      ),
      Container(
        child: Image(
          image: const AssetImage('assets/img/i1.PNG'),
          fit: BoxFit.fill,
        ),
      ),
    ],
  ),
  Column(
    children: [
      Text(
        "1.3 消除规则",
        style: TextStyle(
            color: Colors.white, fontSize: 50.0, fontFamily: 'WorkSansBold'),
      ),
      Container(
        child: Image(
          image: const AssetImage('assets/img/i2.PNG'),
          fit: BoxFit.fill,
        ),
      ),
    ],
  ),
  Column(
    children: [
      Text(
        "Results:",
        style: TextStyle(
            color: Colors.white, fontSize: 50.0, fontFamily: 'WorkSansBold'),
      ),
      Container(
        child: Image(
          image: const AssetImage('assets/img/i3.PNG'),
          fit: BoxFit.fill,
        ),
      ),
    ],
  ),
];

class rule extends StatefulWidget {
  rule({Key key}) : super(key: key);

  @override
  _ruleState createState() => _ruleState();
}

class _ruleState extends State<rule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(135, 206, 250, 1),
        title: Text("Rules"),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/img/mode.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.center,
        child: Swiper(
          viewportFraction: 0.8,
          scale: 0.3,
          itemBuilder: (BuildContext context, int index) {
            return il[index];
          },
          itemCount: 4,
          pagination: SwiperPagination(),
          control: SwiperControl(),
        ),
      ),
    );
  }
}
