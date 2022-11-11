import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_gorgeous_login/config/routers/router_application.dart';
import 'package:the_gorgeous_login/config/theme.dart';
import 'package:the_gorgeous_login/pages/inf_page/intro.dart';
import 'package:the_gorgeous_login/pages/inf_page/rank.dart';
import 'package:the_gorgeous_login/pages/pve_page/provider/PvEprovider.dart';

class chooseModeOnlinePage extends StatelessWidget {
  const chooseModeOnlinePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/img/mode.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.purple,
                    offset: Offset(1.0, 6.0),
                    blurRadius: 20.0,
                  ),
                ],
                gradient: LinearGradient(
                    colors: <Color>[Colors.purple, Colors.blue],
                    begin: FractionalOffset(0.2, 0.2),
                    end: FractionalOffset(1.0, 1.0),
                    stops: <double>[0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
              child: MaterialButton(
                highlightColor: Colors.transparent,
                splashColor: CustomTheme.loginGradientEnd,
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 42.0),
                  child: Text(
                    'Matching',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontFamily: 'WorkSansBold'),
                  ),
                ),
                onPressed: () {
                  ApplicationRouter.router.navigateTo(context, '/matching');
                },
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.blue,
                    offset: Offset(1.0, 6.0),
                    blurRadius: 20.0,
                  ),
                ],
                gradient: LinearGradient(
                    colors: <Color>[Colors.blue, Colors.green],
                    begin: FractionalOffset(0.2, 0.2),
                    end: FractionalOffset(1.0, 1.0),
                    stops: <double>[0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
              child: MaterialButton(
                highlightColor: Colors.transparent,
                splashColor: CustomTheme.loginGradientEnd,
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 42.0),
                  child: Text(
                    'Matching',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontFamily: 'WorkSansBold'),
                  ),
                ),
                onPressed: () {
                  ApplicationRouter.router.navigateTo(context, '/gamepannel');
                },
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.green,
                    offset: Offset(1.0, 6.0),
                    blurRadius: 20.0,
                  ),
                ],
                gradient: LinearGradient(
                    colors: <Color>[Colors.green, Colors.yellow],
                    begin: FractionalOffset(0.2, 0.2),
                    end: FractionalOffset(1.0, 1.0),
                    stops: <double>[0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
              child: MaterialButton(
                  highlightColor: Colors.transparent,
                  splashColor: CustomTheme.loginGradientEnd,
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 42.0),
                    child: Text(
                      'individual mode',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontFamily: 'WorkSansBold'),
                    ),
                  ),
                  onPressed: () {
                    ApplicationRouter.router.navigateTo(context, '/charpter');

                    final data = Provider.of<PvEData>(context, listen: false);
                    data.reset(context);
                    data.turn = 1;
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 42.0),
                    child: Text(
                      'Rules',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.white,
                          fontSize: 25.0,
                          fontFamily: 'WorkSansBold'),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return rule();
                    }));
                  },
                ),
                TextButton(
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 42.0),
                    child: Text(
                      'Ranks',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.white,
                          fontSize: 25.0,
                          fontFamily: 'WorkSansBold'),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return rank();
                    }));
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
