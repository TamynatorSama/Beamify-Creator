import 'package:beamify_creator/shared/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Future showErrorFeedback(BuildContext context, {String? message,bool isError = true}) async {
  BuildContext? dialogBuildContext;
 showDialog(
      context: context,
      builder: (context) {
        dialogBuildContext = context;
        return Dialog(
          backgroundColor: AppTheme.backgroundColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          insetPadding: const EdgeInsets.all(24),
          child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                isError?SvgPicture.string(
                  """<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24"><path fill="currentColor" d="m21.171 15.398l-5.912-9.854C14.483 4.251 13.296 3.511 12 3.511s-2.483.74-3.259 2.031l-5.912 9.856c-.786 1.309-.872 2.705-.235 3.83C3.23 20.354 4.472 21 6 21h12c1.528 0 2.77-.646 3.406-1.771c.637-1.125.551-2.521-.235-3.831M12 17.549c-.854 0-1.55-.695-1.55-1.549c0-.855.695-1.551 1.55-1.551s1.55.696 1.55 1.551c0 .854-.696 1.549-1.55 1.549m1.633-7.424c-.011.031-1.401 3.468-1.401 3.468c-.038.094-.13.156-.231.156s-.193-.062-.231-.156l-1.391-3.438a1.776 1.776 0 0 1-.129-.655c0-.965.785-1.75 1.75-1.75a1.752 1.752 0 0 1 1.633 2.375"/></svg>""",
                  width: 50,
                  theme: const SvgTheme(
                      currentColor: Color.fromARGB(255, 216, 71, 55)),
                ) : SvgPicture.string(
                  """<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 48 48"><g fill="none" stroke="#00ff00" stroke-linecap="round" stroke-linejoin="round" stroke-width="4"><path d="m24 4l5.253 3.832l6.503-.012l1.997 6.188l5.268 3.812L41 24l2.021 6.18l-5.268 3.812l-1.997 6.188l-6.503-.012L24 44l-5.253-3.832l-6.503.012l-1.997-6.188l-5.268-3.812L7 24l-2.021-6.18l5.268-3.812l1.997-6.188l6.503.012z"/><path d="m17 24l5 5l10-10"/></g></svg>""",
                  width: 50,
                  
                ),
                
                isError ?Text(
                  "Error",
                  style: AppTheme.headerStyle
                      .copyWith(color: const Color.fromARGB(255, 216, 71, 55)),
                ) :Text(
                  "Suceess",
                  style: AppTheme.headerStyle
                      .copyWith(color: const Color(0xff00ff00)),
                ),
                const SizedBox(
                  height: 5,
                ),
                if (message != null)
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: AppTheme.bodyText,
                  )
              ],
            ),
          ),
        );
      });

  await Future.delayed(const Duration(seconds: 2), () {
    if (dialogBuildContext != null && dialogBuildContext!.mounted) {
      Navigator.pop(dialogBuildContext!);
    }
  });
}
