// ignore_for_file: unused_field
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myapp/pages/login/model/login_model.dart';
import 'package:myapp/pages/login/repository/userService.dart';
import 'package:myapp/shared/widget/password_field.dart';
import 'package:myapp/shared/widget/textbox_field.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../shared/widget/button.dart';

class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({Key? key}) : super(key: key);

  @override
  State<LoginPageWidget> createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  late LoginPageModel _model;

  @override
  void initState() {
    super.initState();
    _model = LoginPageModel();
    _model.userNameField ??= TextEditingController();
    _model.passwordField ??= TextEditingController();
  }

  @override
  void dispose() {
    _model.dispose();
    _unfocusNode.dispose();
    super.dispose();
  }

  handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    final dynamic result = await UserService().login(_model.toJson());

    if (result["error"] == null) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Error al iniciar sesión",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(147, 148, 173, 137),
                    Color.fromARGB(87, 188, 155, 150),
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.zero,
              child: FractionallySizedBox(
                  widthFactor: 1.0,
                  child: Align(
                      alignment: AlignmentDirectional.topEnd,
                      child: SvgPicture.asset(
                        "assets/svg/Group 350.svg",
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.20,
                        fit: BoxFit.fill,
                      ))),
            ),
            Align(
                alignment: const AlignmentDirectional(0, 1),
                child: FractionallySizedBox(
                  widthFactor: 1.0,
                  child: SvgPicture.asset(
                    'assets/svg/Group351.svg',
                    fit: BoxFit.cover,
                  ),
                )),
            Align(
              alignment: const AlignmentDirectional(0, 0),
              child: Container(
                  width: 323,
                  height: 442.9,
                  decoration: const BoxDecoration(
                    color: Color(0x00FFFFFF),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Dragon ball Tournament!',
                            style: TextStyle(
                              color: Color(0xFF2F455D),
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        TextBoxField(
                          text: 'User',
                          icon: Icons.person,
                          obscureTextVal: false,
                          model: _model.userNameField,
                          validator: LoginPageModel.validateName,
                        ),
                        PassWordField(
                          text: 'Password',
                          model: _model.passwordField,
                          validator: LoginPageModel.validatePassword,
                        ),
                        Button(
                          text: 'Login my account',
                          onPress: () {
                            if (_formKey.currentState!.validate()) {
                              handleSubmit();
                            }
                          },
                        ),
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
