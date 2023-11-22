import 'package:chat_app/Feature/Auth/login/view/widget/custom_text_button.dart';
import 'package:flutter/material.dart';

class CustomRowText extends StatelessWidget {
  final String text;
  final String authText;
  final void Function() onPressed;
  const CustomRowText(
      {super.key,
      required this.text,
      required this.authText,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(text),
        CustomTextButton(
          text: authText,
          onPressed: onPressed,
        )
      ],
    );
  }
}
