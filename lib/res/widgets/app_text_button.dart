import 'package:flutter/material.dart';
import 'package:rivia/res/constants.dart';

class AppTextButton extends StatelessWidget {
  final String title;

  const AppTextButton({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero)
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: kDarkColor,
          fontSize: 24
        ),
      )
    );
  }
}
