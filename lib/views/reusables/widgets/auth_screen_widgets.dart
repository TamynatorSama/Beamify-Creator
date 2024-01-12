import 'package:flutter/material.dart';

Widget customButton(String txt, [double width = double.maxFinite]) => Container(
      height: 50,
      width: width,
      decoration: BoxDecoration(
        color: const Color(0xFFFF7848),
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: Text(
        txt,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ),
      ),
    );


Widget loginTiles(String img) => Container(
      height: 60,
      width: 53,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: Colors.white.withOpacity(0.22),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: Image.asset(img),
    );

Widget customTextField({
  bool isPassword = false,
  String hintText = '',
  TextEditingController? ctrl,
}) =>
    TextField(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.white.withOpacity(0.45),
          fontWeight: FontWeight.w400,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        suffixIcon: isPassword
            ? const Icon(
                Icons.remove_red_eye,
                color: Colors.white,
              )
            : null,
      ),
      controller: ctrl,
      obscureText: isPassword,
    );
