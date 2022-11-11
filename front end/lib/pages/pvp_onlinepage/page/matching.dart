import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:the_gorgeous_login/config/request/methods.dart';
import 'package:the_gorgeous_login/config/routers/router_application.dart';
import 'package:the_gorgeous_login/pages/login_page/provider/loginprovider.dart';
import 'package:the_gorgeous_login/pages/pvp_onlinepage/provider/pvpoprovider.dart';

class matching extends StatefulWidget {
  matching({Key key}) : super(key: key);

  @override
  State<matching> createState() => _matchingState();
}

class _matchingState extends State<matching> {
  int button = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/img/mode.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 1 / 3,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 2 / 3,
            width: MediaQuery.of(context).size.width * 2 / 3,
            child: RaisedButton(
              color: Color.fromRGBO(
                100,
                149,
                237,
                0.5,
              ),
              child: Text(
                button == 0 ? "匹配" : "取消",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width * 1 / 10,
                    fontFamily: 'WorkSansMedium'),
              ),
              onPressed: () async {
                if (button == 0) {
                  EasyLoading.show(status: 'loading...');
                  final userdata =
                      Provider.of<userData>(context, listen: false);
                  final pvpdata = Provider.of<PvPOData>(context, listen: false);

                  setState(() {
                    button = 1;
                  });
                  EasyLoading.show(status: 'matching...');
                  var content;
                  bool flag = true;
                  while (flag) {
                    content = await DioUtil.match(
                        'http://120.77.79.99:8085/matchRival/${userdata.userid}');
                    if (content["code"] == 0) {
                      print("\n\n\n");
                      print(content["data"]["rivalId"]);
                      print(content["data"]["oder"]);

                      pvpdata.opponent = content["data"]["rivalId"];
                      pvpdata.turn = content["data"]["oder"] == "front" ? 1 : 0;

                      flag = false;
                      setState(() {
                        button = 0;
                      });
                      EasyLoading.dismiss();
                      EasyLoading.showSuccess('匹配成功');
                      EasyLoading.dismiss();

                      Future.delayed(Duration(milliseconds: 1000), () {
                        ApplicationRouter.router.navigateTo(context, '/pvpo');
                      });
                    }
                  }
                } else {
                  setState(() {
                    button = 0;
                  });
                  EasyLoading.dismiss();
                }
              },
              shape: CircleBorder(),
            ),
          ),
        ]),
      ),
    );
  }
}
