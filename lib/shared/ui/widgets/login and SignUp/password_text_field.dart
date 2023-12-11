import 'package:app/theme/textStyles.dart';
import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField(
      {super.key,
      required this.icon,
      required this.textFromField,
      required this.hint,
      this.inputType,
      this.inputAction,
      required this.validator});

  final IconData icon;
  final String hint;
  final TextEditingController textFromField;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final String? Function(String?) validator;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  var _isObscured;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isObscured = true;
  }

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
            controller: widget.textFromField,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 20),
                border: InputBorder.none,
                hintText: widget.hint,
                hintStyle: kBodyText,
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isObscured = !_isObscured;
                      });
                    },
                    icon: _isObscured
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off)),
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Icon(widget.icon, size: 30),
                ),
                prefixIconColor: MaterialStateColor.resolveWith((states) =>
                    states.contains(MaterialState.focused)
                        ? Colors.red
                        : Colors.grey.shade800)),
            validator: widget.validator,
            style: kBodyText,
            obscureText: _isObscured,
            keyboardType: widget.inputType,
            textInputAction: widget.inputAction,
          )),
    );
  }
}
