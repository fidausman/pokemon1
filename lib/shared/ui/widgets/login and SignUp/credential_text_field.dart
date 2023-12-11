import 'package:app/theme/textStyles.dart';
import 'package:flutter/material.dart';

class CredentialTextField extends StatelessWidget {
  const CredentialTextField({
    super.key,
    required this.icon,
    required this.textFromField,
    required this.hint,
    this.inputType,
    this.inputAction,
    required this.validator,
  });

  final String? Function(String?) validator;
  final IconData icon;
  final String hint;
  final TextEditingController textFromField;
  final TextInputType? inputType;
  final TextInputAction? inputAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[600]?.withOpacity(
                0.7,
              ),
              borderRadius: BorderRadius.circular(16)),
          child: TextFormField(
            controller: textFromField,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 20),
                border: InputBorder.none,
                hintText: hint,
                hintStyle: kBodyText,
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Icon(icon, size: 30),
                ),
                prefixIconColor: MaterialStateColor.resolveWith((states) =>
                    states.contains(MaterialState.focused)
                        ? Colors.red
                        : Colors.grey.shade800)),
            validator: validator,
            style: kBodyText,
            keyboardType: inputType,
            textInputAction: inputAction,
          )),
    );
  }
}

// Widget credentialTextField(
//     {required final IconData icon,
//     required final String hint,
//     required TextEditingController textFromField,
//     final TextInputType? inputType,
//     final TextInputAction? inputAction,
//     bool passText = false}) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(vertical: 12),
//     child: Container(
//         decoration: BoxDecoration(
//             color: Colors.grey[700]?.withOpacity(
//               0.7,
//             ),
//             borderRadius: BorderRadius.circular(16)),
//         child: TextFormField(
//           controller: textFromField,
//           decoration: InputDecoration(
//               contentPadding: const EdgeInsets.symmetric(vertical: 20),
//               border: InputBorder.none,
//               hintText: hint,
//               hintStyle: kBodyText,
//               prefixIcon: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Icon(icon, size: 30),
//               ),
//               prefixIconColor: MaterialStateColor.resolveWith((states) =>
//                   states.contains(MaterialState.focused)
//                       ? Colors.red
//                       : Colors.grey.shade800)),
//           style: kBodyText,
//           obscureText: passText,
//           keyboardType: inputType,
//           textInputAction: inputAction,
//         )),
//   );
// }
