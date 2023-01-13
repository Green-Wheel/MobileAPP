import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

//ICONS: https://hatscripts.github.io/circle-flags/gallery
class LanguageSelectorWidget extends StatefulWidget {
  const LanguageSelectorWidget({super.key});

  @override
  State<LanguageSelectorWidget> createState() => _LanguageSelectorWidgetState();
}

class _LanguageSelectorWidgetState extends State<LanguageSelectorWidget> {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text("language_selector_title".tr()),
      children: [
        SimpleDialogItem(
          icon_code: 'es-ct',
          text: 'Català',
          onPressed: () {
            context.setLocale(const Locale('ca', 'ES'));
            Navigator.pop(context);
          },
        ),
        SimpleDialogItem(
          icon_code: 'es',
          text: 'Castellano',
          onPressed: () {
            context.setLocale(const Locale('es', 'ES'));
            Navigator.pop(context);
          },
        ),
        SimpleDialogItem(
          icon_code: 'gb',
          text: 'English',
          onPressed: () {
            context.setLocale(const Locale('en', 'US'));
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

class SimpleDialogItem extends StatelessWidget {
  const SimpleDialogItem(
      {super.key,
      required this.icon_code,
      required this.text,
      required this.onPressed});

  final String icon_code;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SimpleDialogOption(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/icons/$icon_code.png', width: 36, height: 36),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 16.0),
            child: Text(text),
          ),
        ],
      ),
    );
  }
}
