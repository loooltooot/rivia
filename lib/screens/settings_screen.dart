import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rivia/res/app_text_button.dart';
import 'package:rivia/res/constants.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(padding: EdgeInsets.only(top: 62)),
        Text(
          AppLocalizations.of(context)!.settings,
          style: const TextStyle(
            color: kDarkColor,
            fontSize: 30,
            fontWeight: FontWeight.w700
          ),
        ),
        const Padding(padding: EdgeInsets.only(top: 62)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextButton(title: AppLocalizations.of(context)!.generateTable),
            const Padding(padding: EdgeInsets.only(top: 6)),
            AppTextButton(title: AppLocalizations.of(context)!.getTable),
            const Padding(padding: EdgeInsets.only(top: 6)),
            AppTextButton(title: AppLocalizations.of(context)!.pasteTable)
          ],
        )
      ],
    );
  }
}
