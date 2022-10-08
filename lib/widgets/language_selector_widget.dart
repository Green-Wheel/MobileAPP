import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:greenwheel/services/generalServices/LanguagesService.dart';
import 'package:provider/provider.dart';

//ICONS: https://hatscripts.github.io/circle-flags/gallery
class LanguageSelectorWidget extends StatefulWidget {
  const LanguageSelectorWidget({super.key});

  @override
  State<LanguageSelectorWidget> createState() => _LanguageSelectorWidgetState();
}

class _LanguageSelectorWidgetState extends State<LanguageSelectorWidget> {
  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    return SimpleDialog(
      title: Text(tr.language_selector),
      children: [
        SimpleDialogItem(
          icon_code: 'es-ct',
          text: 'Català',
          onPressed: () {
            Provider.of<LocaleLanguage>(context, listen: false)
                .changeLanguage(const Locale('ca', 'ES'));
            Navigator.pop(context);
          },
        ),
        SimpleDialogItem(
          icon_code: 'es',
          text: 'Castellano',
          onPressed: () {
            Provider.of<LocaleLanguage>(context, listen: false)
                .changeLanguage(const Locale('es', 'ES'));
            Navigator.pop(context);
          },
        ),
        SimpleDialogItem(
          icon_code: 'gb',
          text: 'English',
          onPressed: () {
            Provider.of<LocaleLanguage>(context, listen: false)
                .changeLanguage(const Locale('en', 'US'));
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
