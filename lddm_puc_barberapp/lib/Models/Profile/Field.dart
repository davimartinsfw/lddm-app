import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Field {
  final TextEditingController? controller;
  final Function? error;
  final List<MaskTextInputFormatter>? formatters;
  final TextInputType keyboardType;
  final String? label;
  final Function? onTap;
  final bool readOnly;
  final String? hintText;

  Field({
    this.controller,
    this.error,
    this.formatters,
    this.keyboardType = TextInputType.text,
    this.label,
    this.onTap,
    this.readOnly = false,
    this.hintText
  });
}