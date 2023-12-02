import 'package:app/shared/ui/widgets/login%20and%20SignUp/credential_text_field.dart';
import 'package:app/shared/ui/widgets/login%20and%20SignUp/password_text_field.dart';
import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        CredentialTextField(
            icon: Icons.link,
            textFromField: TextEditingController(),
            hint: 'Hi',
            validator: (value) {
              return null;
            }),
        PasswordTextField(
            icon: Icons.home,
            textFromField: TextEditingController(),
            hint: 'We',
            validator: (value) {
              return null;
            })
      ],
    ));
  }
}
