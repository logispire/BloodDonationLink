import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants.dart';

class MyTextFormField extends StatefulWidget {
  final bool autoFocus;
  final String hintText;
  final String? label;
  final TextInputType? keyboardType;
  final int? maxLength;
  final FocusNode? focusNode;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? suffixIcon;
  final TextCapitalization textCapitalization;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final bool isPassword;
  final bool readOnly;
  final bool isEnableInteractiveSelection;
  final bool isEnable;
  final Widget? icon;
  final int? maxLines;
  final int? minLines;
  final List<TextInputFormatter>? inputFormatters;

  const MyTextFormField(
      {Key? key,
      this.hintText = "",
      this.keyboardType,
      this.label,
      this.maxLength,
      this.focusNode,
      this.suffixIcon,
      this.textCapitalization = TextCapitalization.sentences,
      this.validator,
      this.onChanged,
      this.onFieldSubmitted,
      this.controller,
      this.textInputAction,
      this.isPassword = false,
      this.readOnly = false,
      this.isEnableInteractiveSelection = true,
      this.icon,
      this.maxLines,
      this.minLines,
      this.contentPadding,
      this.inputFormatters,
      this.isEnable = true,
      this.autoFocus = false})
      : super(key: key);

  @override
  _MyTextFormFieldState createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  bool isPassword = false;

  @override
  void initState() {
    super.initState();
    isPassword = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label == null
            ? const SizedBox()
            : Text(
                widget.label!,
                style: TextStyle(
                  fontSize: 13,
                  color: appPrimaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
        const SizedBox(
          height: 6,
        ),
        TextFormField(
          autofocus: widget.autoFocus,
          enabled: widget.isEnable,
          enableInteractiveSelection: widget.isEnableInteractiveSelection,
          readOnly: widget.readOnly,
          controller: widget.controller,
          textCapitalization: widget.textCapitalization,
          keyboardType: widget.keyboardType,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
          maxLength: widget.maxLength,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          focusNode: widget.focusNode,
          // textAlignVertical: TextAlignVertical.bottom,
          onChanged: widget.onChanged,
          validator: widget.validator,
          textInputAction: widget.textInputAction,
          obscureText: widget.isPassword,
          inputFormatters: widget.inputFormatters,
          onFieldSubmitted: widget.onFieldSubmitted,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            constraints: const BoxConstraints(minHeight: 40),
            hintText: widget.hintText,
            hintStyle: const TextStyle(fontSize: 12),
            alignLabelWithHint: true,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            counterText: "",
            contentPadding:
                const EdgeInsets.symmetric(vertical: 14.0, horizontal: 12),
            errorStyle: TextStyle(
                color: Colors.red.shade500,
                fontWeight: FontWeight.w500,
                fontSize: 12),
            prefixIcon: widget.icon,
            suffixIcon: widget.suffixIcon,
            errorMaxLines: 1,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: const BorderSide(width: 0.5, color: Colors.grey)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: const BorderSide(width: 0.5, color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: BorderSide(width: 1, color: appPrimaryColor),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide:
                  BorderSide(width: 0.5, color: Colors.grey.withOpacity(0.2)),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: const BorderSide(width: 0.5, color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: const BorderSide(
                width: 0.5,
                color: Colors.red,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
