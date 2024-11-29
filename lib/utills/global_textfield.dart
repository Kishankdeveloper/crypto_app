import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';

class GlobalTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final int? maxLength;
  final int? maxLines;
  final bool? readOnly;
  final bool? disable;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIcon;
  final VoidCallback? onTap;

  const GlobalTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.obscureText = false,
    this.maxLength,
    this.maxLines,
    this.readOnly,
    this.disable,
    this.inputFormatters,
    this.suffixIcon,
    this.onTap,
  });

  @override
  State<GlobalTextField> createState() => _GlobalTextFieldState();
}

class _GlobalTextFieldState extends State<GlobalTextField> {
  bool _isObscure = true;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _isObscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          obscureText: widget.obscureText && _isObscure,
          maxLength: widget.maxLength,
          inputFormatters: widget.inputFormatters,
          readOnly: widget.readOnly ?? false,
          enabled: widget.disable ?? true,
          onChanged: (value) {
            setState(() {
              _errorText = widget.validator?.call(value);
            });
          },
          // Ensure maxLines is set to 1 if obscureText is true
          maxLines: widget.obscureText ? 1 : widget.maxLines,
          style: TextStyle(
            fontFamily: 'madaRegular',
            fontSize: w * 0.04,
          ),
          onTap: widget.onTap,
          decoration: InputDecoration(
            labelText: widget.labelText,
            hintText: widget.hintText,
            counter: const SizedBox.shrink(),
            hintStyle: TextStyle(
                fontFamily: 'madaRegular',
                fontSize: h * 0.018),
            labelStyle: TextStyle(
                color: AppColors.white60,
                fontFamily: 'madaRegular',
                fontSize: h * 0.022),
            alignLabelWithHint: true,
            isDense: true,
            suffixIcon: widget.obscureText
                ? IconButton(
              icon: Icon(
                _isObscure ? Icons.visibility_off : Icons.visibility,
                color: AppColors.white60,
              ),
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                });
              },
            )
                : widget.suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(w * 0.04),
              borderSide: const BorderSide(color: AppColors.white60),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(w * 0.04),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(w * 0.04),
              borderSide: const BorderSide(color: AppColors.primary),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(w * 0.04),
              borderSide: const BorderSide(color: AppColors.error80),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(w * 0.04),
              borderSide: const BorderSide(color: AppColors.error80),
            ),
            errorText: _errorText,
            errorStyle: TextStyle(
              color: Colors.red,
              fontSize: w * 0.03,
            ),
            contentPadding: EdgeInsets.symmetric(
                horizontal: w * 0.03, vertical: h * 0.02),
            filled: true,
            fillColor: AppColors.white100,
          ),
        ),
      ],
    );
  }
}
