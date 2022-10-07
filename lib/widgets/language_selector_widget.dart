import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:greenwheel/services/LanguagesService.dart';
import 'package:provider/provider.dart';

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
          icon: Icons.account_circle,
          color: Colors.orange,
          text: 'Català',
          onPressed: () {
            Provider.of<LocaleLanguage>(context, listen: false)
                .changeLanguage(const Locale('ca', 'ES'));
            Navigator.pop(context);
          },
        ),
        SimpleDialogItem(
          icon: Icons.flag,
          color: Colors.green,
          text: 'Castellano',
          onPressed: () {
            Provider.of<LocaleLanguage>(context, listen: false)
                .changeLanguage(const Locale('es', 'ES'));
            Navigator.pop(context);
          },
        ),
        SimpleDialogItem(
          icon: Icons.add_circle,
          color: Colors.grey,
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
      required this.icon,
      required this.color,
      required this.text,
      required this.onPressed});

  final IconData icon;
  final Color color;
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
          Icon(icon, size: 36.0, color: color),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 16.0),
            child: Text(text),
          ),
        ],
      ),
    );
  }
}
