import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_gorgeous_login/config/request/methods.dart';
import 'package:the_gorgeous_login/pages/login_page/provider/loginprovider.dart';
import 'package:the_gorgeous_login/pages/pvp_onlinepage/moduel/pannel.dart';
import 'package:the_gorgeous_login/pages/pvp_onlinepage/provider/pvpoprovider.dart';

class PvPOPage extends StatefulWidget {
  const PvPOPage({Key key}) : super(key: key);
  @override
  _PvPOPageState createState() => _PvPOPageState();
}

class _PvPOPageState extends State<PvPOPage> {
  @override
  Widget build(BuildContext context) {
    final gamedata = Provider.of<PvPOData>(context, listen: true);
    final userdata = Provider.of<userData>(context, listen: true);
    gamedata.connect(userdata.userid, context);

    return Scaffold(
        appBar: AppBar(
            elevation: 2.0,
            backgroundColor: Color.fromRGBO(135, 206, 250, 1),
            title: Container(child: Consumer<PvPOData>(
              builder: (context, gamedata, _) {
                return Text(
                  gamedata.turn == 0 ? "Opponents' turn" : "Your turn",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25.0,
                      fontFamily: 'WorkSansBold'),
                );
              },
            )),
            leading: MaterialButton(
              shape: StadiumBorder(side: BorderSide.none),
              child: Icon(Icons.arrow_back_ios),
              onPressed: () {
                showCupertinoDialog(
                    context: context,
                    builder: (context) {
                      return CupertinoAlertDialog(
                        title: Text('hint'),
                        content: Text('Are you sure to leave?'),
                        actions: <Widget>[
                          CupertinoDialogAction(
                            child: Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop('cancel');
                            },
                          ),
                          CupertinoDialogAction(
                            child: Text('Leave'),
                            onPressed: () async {
                              gamedata.reset(context);

                              Map<String, dynamic> data = {
                                "userId1": "${userdata.getuserid}",
                                "userId2": "${gamedata.opponent}"
                              };
                              var content = await DioUtil.requestData("quit",
                                  formData: data);
                              print(content);
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                              // ApplicationRouter.router
                              //     .navigateTo(context, '/mode', replace: true);
                            },
                          ),
                        ],
                      );
                    });
              },
            )),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage('assets/img/mode.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Row(children: [
            Expanded(
              flex: 1,
              child: Container(
                decoration:
                    BoxDecoration(color: Color.fromRGBO(200, 200, 200, 0.3)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Consumer<PvPOData>(builder: (context, gamedata, _) {
                      return Text(
                        "point\n${gamedata.uppoint}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontFamily: 'WorkSansBold'),
                      );
                    }),
                    Consumer<PvPOData>(builder: (context, gamedata, _) {
                      return Text(
                        "point\n${gamedata.downpoint}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontFamily: 'WorkSansBold'),
                      );
                    })
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [Pannelai(), Pannel(position: 1), get_move()],
              ),
            ),
          ]),
        ));
  }
}

class get_move extends StatefulWidget {
  get_move({Key key}) : super(key: key);

  @override
  State<get_move> createState() => _get_moveState();
}

class _get_moveState extends State<get_move> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        OutlinedButton(
            child: Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.width * 1 / 8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(3.0)),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.blue, Colors.green],
                  ),
                ),
                child: Text(
                  "Click here to stop the dice",
                  style: TextStyle(color: Colors.white),
                )),
            onPressed: () {
              final data = Provider.of<PvPOData>(context, listen: false);
              if (data.turn == 1) {
                data.getnum();
              }
            }),
        NumSource()
      ],
    );
  }
}

List<int> parse(String mat) {
  List<int> d;
  for (int i = 1; i < 26; i += 3) {
    d.add(int.parse(mat[i]));
  }
}
