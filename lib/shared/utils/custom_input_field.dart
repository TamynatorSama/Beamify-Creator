// ignore_for_file: prefer_if_null_operators
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomInputField extends StatefulWidget {
  final TextEditingController controller;
  final InputDecoration decoration;
  final bool isPassword;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final bool disabled;
  final bool showLockIcon;
  final bool noBorders;
  final TextInputType? inputType;
  final String? Function(dynamic)? validator;
  final Function()? onTap;
  final List<TextInputFormatter>? formatter;
  final Function(String value)? onChange;
  final bool? readOnly;
  final bool showBorder;
  final bool showRightBorder;
  const CustomInputField(
      {super.key,
      required this.controller,
      this.noBorders = false,
      this.showRightBorder = true,
      this.formatter,
      this.isPassword = false,
      this.disabled = false,
      this.showLockIcon = true,
      this.readOnly,
      this.onChange,
      this.showBorder = true,
      this.onTap,
      this.prefixIcon,
      this.suffixIcon,
      this.hintText,
      this.validator,
      this.inputType = TextInputType.text,
      this.decoration = const InputDecoration()});

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool obscurePassword = true;

  void updatePassword() => setState(() => obscurePassword = !obscurePassword);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: widget.controller,
        keyboardType: widget.inputType,
        onTap: widget.onTap,
        readOnly: widget.readOnly ?? false,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: widget.isPassword ? obscurePassword : false,
        cursorColor:const  Color(0xffD9B38C),
        onChanged: widget.onChange,
        inputFormatters: widget.formatter,
        validator: widget.validator ??
            (string) {
              if (string.toString().isEmpty) {
                return "${widget.hintText} cannot be empty";
              }
              return null;
            },
        decoration: widget.decoration.copyWith(
            hintStyle: GoogleFonts.lato(
    color: Colors.white,
    fontWeight: FontWeight.w500,
    fontSize: 16
  )
                .copyWith(fontSize: 15, color: const Color(0xff8A8A8A)),
            hintText: widget.hintText,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            prefixIcon: widget.prefixIcon != null
                  ? Container(
                      constraints: const BoxConstraints(maxWidth: 70),
                      margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                          border: Border(
                              right: widget.showBorder
                                  ? const BorderSide(
                                      width: 2, color: Color(0xffE6E6E6))
                                  : BorderSide.none)),
                      child: SizedBox(width: 20,child: widget.prefixIcon,),
                    )
                  : null,
            suffixIcon: widget.suffixIcon != null
                ? Container(
                    constraints: const BoxConstraints(maxWidth: 70),
                    margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                        border: Border(
                            left: widget.isPassword || !widget.showRightBorder
                                ? BorderSide.none
                                : const BorderSide(
                                    width: 2, color: Color(0xffE6E6E6)))),
                    child:SizedBox(width: 20,child: widget.suffixIcon,) ,
                  )
                : null,
            focusedErrorBorder:widget.noBorders?InputBorder.none:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide:
                    const BorderSide(color: Color.fromARGB(255, 216, 55, 55))),
            errorBorder:widget.noBorders?InputBorder.none:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide:
                    const BorderSide(color: Color.fromARGB(255, 216, 55, 55))),
            border:  widget.noBorders?InputBorder.none: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Color(0xffE6E6E6))),
            focusedBorder:widget.noBorders?InputBorder.none:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Color(0xffE6E6E6))),
            enabledBorder: widget.noBorders?InputBorder.none: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Color(0xffE6E6E6)))),
        style: GoogleFonts.lato(
    color: Colors.white,
    fontWeight: FontWeight.w500,
    fontSize: 16
  ).copyWith(fontWeight: FontWeight.w700));
  }
}
