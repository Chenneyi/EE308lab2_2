import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart' as fluro;
import 'router_handler.dart';

class Routes {
  static String root = '/';
  static String loginPage = '/login';
  static String gamepannelPage = '/gamepannel';
  static String mode = '/mode';
  static String loginmode = '/loginmode';
  static String pve = '/pve';
  static String matching = '/matching';
  static String pvpo = '/pvpo';
  static String c = '/charpter';

  static void configureRoutes(fluro.Router router) {
    router.notFoundHandler = new fluro.Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return Text('Page not found');
    });

    // 创建pageRoute
    router.define(loginPage, handler: loginPageHandler);
    router.define(gamepannelPage, handler: gamepannelHandler);
    router.define(mode, handler: modeHandler);
    router.define(loginmode, handler: loinmodeHandler);
    router.define(pve, handler: pveHandler);
    router.define(matching, handler: matchingHandler);
    router.define(pvpo, handler: PVPOHandler);
    router.define(c, handler: cHandler);
  }
}
