import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:the_gorgeous_login/pages/gamemode_page/choosemode.dart';
import 'package:the_gorgeous_login/pages/gamemode_page/choosemodeonline.dart';
import 'package:the_gorgeous_login/pages/login_page/pages/login_page.dart';
import 'package:the_gorgeous_login/pages/pve_page/pages/charpters.dart';
import 'package:the_gorgeous_login/pages/pve_page/pages/pve_page.dart';
import 'package:the_gorgeous_login/pages/pvp_onlinepage/page/matching.dart';
import 'package:the_gorgeous_login/pages/pvp_onlinepage/page/pvpo_page.dart';
import 'package:the_gorgeous_login/pages/pvp_page/pages/gamepannel_page.dart';

Handler loginPageHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return LoginPage();
});

Handler gamepannelHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return PvPPage();
});

Handler modeHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return chooseModePage();
});

Handler loinmodeHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return chooseModeOnlinePage();
});

Handler pveHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return PvEPage();
});

Handler matchingHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return matching();
});

Handler PVPOHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return PvPOPage();
});

Handler cHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return chapter();
});
