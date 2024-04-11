import 'package:beamify_creator/shared/utils/app_theme.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final Function()? onTap;
  final double? maxWidth;
  final String text;
  final bool? isLoading;
  const CustomButton(
      {super.key,
      this.onTap,
      required this.text,
      this.isLoading,
      this.maxWidth});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints:
          BoxConstraints(maxWidth: widget.maxWidth ?? double.maxFinite),
      child: Material(
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: () async {
            if ((widget.isLoading ?? isLoading)) return;
            FocusScope.of(context).unfocus();
            if (widget.onTap != null) {
              setState(() {
                isLoading = true;
              });
              widget.onTap!.call();
              setState(() {
                isLoading = false;
              });
            }
          },
          splashColor: const Color.fromARGB(46, 255, 255, 255),
          child: Ink(
              width: double.maxFinite,
              height: 55,
              decoration: BoxDecoration(
                color: AppTheme.btnColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: (widget.isLoading ?? isLoading)
                    ? ConstrainedBox(
                        constraints:
                            const BoxConstraints(maxHeight: 23, maxWidth: 23),
                        child: const CircularProgressIndicator(
                          strokeWidth: 5,
                          color: Colors.black,
                        ))
                    : Text(
                        widget.text,
                        style: AppTheme.buttonStyle,
                      ),
              )),
        ),
      ),
    );
  }
}
