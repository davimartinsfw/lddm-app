import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'Field.dart';

class ProfileField extends Field {
  final String controllerName;
  final Function? error;
  List<MaskTextInputFormatter>? formatters;
  final TextInputType keyboardType;
  final String? label;
  final Function? onTap;
  final bool readOnly;
  final String? mask;
  final Map<String, RegExp>? maskFilter;
  final MaskAutoCompletionType? maskType;
  final String? hintText;

  ProfileField({
    required this.controllerName,
    this.error,
    this.formatters,
    this.keyboardType = TextInputType.text,
    this.label,
    this.onTap,
    this.readOnly = false,
    this.mask,
    this.maskFilter,
    this.maskType,
    this.hintText
  }) : super(
      error: error,
      formatters: formatters,
      keyboardType: keyboardType,
      label: label,
      onTap: onTap,
      readOnly: readOnly,
      hintText: hintText);
}