import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  final String labelText;
  final String? hintText;
  final IconData? icon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool readOnly;
  void Function()? onTap;

  CustomTextField({
    super.key,
    required this.labelText,
    this.hintText,
    this.icon,
    this.controller,
    this.validator,
    required this.readOnly,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 15),
        TextFormField(
          controller: controller,
          readOnly: readOnly,
          validator: validator,
          onTap: onTap,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[500]),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.grey.shade300,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.grey.shade300,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.blue.shade300,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
