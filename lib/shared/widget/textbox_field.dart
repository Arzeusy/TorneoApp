import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextBoxField extends StatelessWidget {
  String text;
  TextEditingController? model;
  String? Function(String?)? validator;
  IconData? icon;
  bool obscureTextVal = false;
  VoidCallback? onPress;

  TextBoxField(
      {Key? key,
      required this.text,
      this.model,
      this.validator,
      this.icon,
      required this.obscureTextVal,
      this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: model,
      validator: validator,
      autofocus: false,
      obscureText: obscureTextVal,
      decoration: InputDecoration(
          labelText: text,
          labelStyle: const TextStyle(
            color: Color(0xFF2F455D),
            fontWeight: FontWeight.w500,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xFF2F455D),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xFFB56A5C),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.redAccent,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.redAccent,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Colors.transparent,
          suffixIcon: InkWell(
            onTap: onPress,
            focusNode: FocusNode(skipTraversal: true),
            child: Icon(
              icon,
              color: Color(0xFF2F455D),
              size: 20,
            ),
          )),
      style: const TextStyle(
        color: Color(0xFF2F455D),
        // fontFamily: 'Inter',
      ),
      textAlign: TextAlign.start,
      // validator: _model.textController1Validator.asValidator(context),
    );
  }
}
