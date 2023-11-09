import 'package:app/theme/textStyles.dart';
import 'package:flutter/material.dart';

Widget PasswordInput({
  required final IconData icon,
  required final String hint,
  final TextInputAction? inputAction,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12),
    child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[700]?.withOpacity(
              0.7,
            ),
            borderRadius: BorderRadius.circular(16)),
        child: TextField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 20),
            border: InputBorder.none,
            hintText: hint,
            hintStyle: kBodyText,
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Icon(icon, size: 30),
            ),
          ),
          obscureText: true,
          style: kBodyText,
          textInputAction: inputAction,
        )),
  );
}
