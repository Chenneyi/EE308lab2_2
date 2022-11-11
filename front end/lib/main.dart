import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:the_gorgeous_login/pages/login_page/pages/login_page.dart';
import 'package:fluro/fluro.dart' as fluro;
import 'package:the_gorgeous_login/pages/pve_page/provider/PvEprovider.dart';
import 'package:the_gorgeous_login/pages/pvp_page/provider/PvPprovider.dart';
import 'config/routers/router_application.dart';
import 'config/routers/routers.dart';
import 'pages/login_page/provider/loginprovider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'pages/pvp_onlinepage/provider/pvpoprovider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final gamedata = PvPData();
  final pvedata = PvEData();
  final userdata = userData();
  final pvpdata = PvPOData();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: gamedata),
        ChangeNotifierProvider.value(value: userdata),
        ChangeNotifierProvider.value(value: pvedata),
        ChangeNotifierProvider.value(value: pvpdata)
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final router = fluro.Router();
    ApplicationRouter.router = router;
    // 完成路由全局配置和路由定义
    Routes.configureRoutes(router);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mid-Autumn Festival King Competition',
      home: LoginPage(),
      builder: EasyLoading.init(),
    );
  }
}
