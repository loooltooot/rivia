import 'package:flutter/material.dart';
import 'package:rivia/res/constants.dart';

class AppTextButton extends StatelessWidget {
  final String title;
  final Function() onPressed;

  const AppTextButton({Key? key, required this.title, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
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
