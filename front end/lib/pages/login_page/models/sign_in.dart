import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:the_gorgeous_login/config/request/methods.dart';
import 'package:the_gorgeous_login/config/routers/router_application.dart';
import 'package:the_gorgeous_login/config/theme.dart';
import 'package:the_gorgeous_login/pages/login_page/models/snackbar.dart';
import 'package:the_gorgeous_login/pages/login_page/provider/loginprovider.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  final FocusNode focusNodeEmail = FocusNode();
  final FocusNode focusNodePassword = FocusNode();

  bool _obscureTextPassword = true;

  @override
  void dispose() {
    focusNodeEmail.dispose();
    focusNodePassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 23.0),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: 300.0,
                  height: 190.0,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: focusNodeEmail,
                          controller: loginEmailController,
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(
                              fontFamily: 'WorkSansSemiBold',
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.envelope,
                              color: Colors.black,
                              size: 22.0,
                            ),
                            hintText: '邮箱或ID',
                            hintStyle: TextStyle(
                                fontFamily: 'WorkSansSemiBold', fontSize: 17.0),
                          ),
                          onSubmitted: (_) {
                            focusNodePassword.requestFocus();
                          },
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: focusNodePassword,
                          controller: loginPasswordController,
                          obscureText: _obscureTextPassword,
                          style: const TextStyle(
                              fontFamily: 'WorkSansSemiBold',
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: const Icon(
                              FontAwesomeIcons.lock,
                              size: 22.0,
                              color: Colors.black,
                            ),
                            hintText: '密码',
                            hintStyle: const TextStyle(
                                fontFamily: 'WorkSansSemiBold', fontSize: 17.0),
                            suffixIcon: GestureDetector(
                              onTap: _toggleLogin,
                              child: Icon(
                                _obscureTextPassword
                                    ? FontAwesomeIcons.eye
                                    : FontAwesomeIcons.eyeSlash,
                                size: 15.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          onSubmitted: (_) {
                            _toggleSignInButton();
                          },
                          textInputAction: TextInputAction.go,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 170.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: CustomTheme.loginGradientStart,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                    BoxShadow(
                      color: CustomTheme.loginGradientEnd,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                  ],
                  gradient: LinearGradient(
                      colors: <Color>[
                        CustomTheme.loginGradientEnd,
                        CustomTheme.loginGradientStart
                      ],
                      begin: FractionalOffset(0.2, 0.2),
                      end: FractionalOffset(1.0, 1.0),
                      stops: <double>[0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: MaterialButton(
                  minWidth: MediaQuery.of(context).size.width * 1 / 3,
                  highlightColor: Colors.transparent,
                  splashColor: CustomTheme.loginGradientEnd,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0),
                    child: Container(
                      child: Text(
                        '登录',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'WorkSansBold'),
                      ),
                    ),
                  ),
                  onPressed: () {
                    _toggleSignInButton();
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 250.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: CustomTheme.loginGradientStart,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                    BoxShadow(
                      color: CustomTheme.loginGradientEnd,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                  ],
                  gradient: LinearGradient(
                      colors: <Color>[
                        CustomTheme.loginGradientEnd,
                        CustomTheme.loginGradientStart
                      ],
                      begin: FractionalOffset(0.2, 0.2),
                      end: FractionalOffset(1.0, 1.0),
                      stops: <double>[0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width * 1 / 3,
                    highlightColor: Colors.transparent,
                    splashColor: CustomTheme.loginGradientEnd,
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 0.0, horizontal: 3.0),
                      child: const Text(
                        '离线模式',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 25.0,
                            fontFamily: 'WorkSansBold'),
                      ),
                    ),
                    onPressed: () {
                      ApplicationRouter.router.navigateTo(context, '/mode');
                    },
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _toggleSignInButton() async {
    Map<String, dynamic> data = {
      "id": "${loginEmailController.text}",
      "password": "${loginPasswordController.text}"
    };
    var content = await DioUtil.requestData("signin", formData: data);
    if (content["code"] != 0) {
      CustomSnackBar(context, Text('请输入正确的信息'));
      return;
    }
    print(content);

    final userdata = Provider.of<userData>(context, listen: false);
    userdata.updateuserid(loginEmailController.text);
    CustomSnackBar(context, Text('你好 ${content["data"]["username"]}'));
    Future.delayed(Duration(milliseconds: 1000), () {
      print("延时1秒执行");
      ApplicationRouter.router.navigateTo(context, '/loginmode');
    });
  }

  void _toggleLogin() {
    setState(() {
      _obscureTextPassword = !_obscureTextPassword;
    });
  }
}
