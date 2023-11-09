import 'package:app/theme/textStyles.dart';
import 'package:flutter/material.dart';

@override
Widget roundedButton(
    {required final String buttonText, required final Function() onpress}) {
  return Container(
      decoration: BoxDecoration(
          color: Colors.red, borderRadius: BorderRadius.circular(16)),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: TextButton(
            onPressed: onpress,
            child: Text(
              buttonText,
              style: kBodyText.copyWith(color: Colors.white),
            )),
      ));
}
