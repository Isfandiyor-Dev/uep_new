import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MyAuthTextField extends StatefulWidget {
  final String title;
  final String hintText;
  final TextInputType textInputType;
  final bool isObscurely;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final String? errorText;
  const MyAuthTextField({
    super.key,
    this.errorText,
    required this.title,
    required this.hintText,
    required this.textInputType,
    required this.controller,
    this.isObscurely = false,
    this.validator,
  });

  @override
  State<MyAuthTextField> createState() => _MyAuthTextFieldState();
}

class _MyAuthTextFieldState extends State<MyAuthTextField> {
  bool isObscure = true;

  Widget? suffixIcon() {
    if (widget.isObscurely) {
      return IconButton(
        onPressed: () {
          setState(() {
            isObscure = !isObscure;
          });
        },
        icon: Icon(
          isObscure ? CupertinoIcons.eye_slash_fill : CupertinoIcons.eye_solid,
        ),
      );
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(
            color: Color(0xff7D8592),
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        TextFormField(
          controller: widget.controller,
          obscureText: widget.isObscurely && isObscure,
          keyboardType: widget.textInputType,
          validator: widget.validator,
          decoration: InputDecoration(
            errorText: widget.errorText,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            hintText: widget.hintText,
            hintStyle: const TextStyle(
              fontSize: 15,
              color: Color(0xff7D8592),
            ),
            suffixIcon: suffixIcon(),
          ),
        ),
      ],
    );
  }
}
