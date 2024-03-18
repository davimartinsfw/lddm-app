import 'package:lddm_puc_barberapp/Models/Profile/Field.dart';

import '../../Common/Util.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController textEditingController;
  final Field field;

  const CustomTextField(
      {Key? key, required this.textEditingController, required this.field})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();

    _focusNode = FocusNode();

    _focusNode.addListener(() {
      setState(() {});
    });
  }

  String? error() {
    return widget.field.error?.call(widget.textEditingController) ?? null;
  }

  void _requestFocus() {
    FocusScope.of(context).requestFocus(_focusNode);
    setState(() {});
  }

  void updateField(String text) {
    //widget.callBack?.call(text);
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        if (!hasFocus) {
          setState(() {});
          //widget.customUnfocusCallback?.call();
        }
      },
      child: TextField(
        focusNode: _focusNode,
        onTap: _requestFocus,
        style: TextStyle(
            color: widget.field.readOnly ? Util.HeaderArrow : Util.TextColor,
            fontSize: 14),
        controller: widget.textEditingController,
        readOnly: widget.field.readOnly,
        inputFormatters: widget.field.formatters ?? [],
        keyboardType: widget.field.keyboardType,
        cursorColor: Util.SecondaryColor,
        decoration: InputDecoration(
            enabled: !widget.field.readOnly,
            contentPadding: EdgeInsets.all(16),
            hintText: widget.field.hintText ?? "",
            hintStyle: TextStyle(color: Util.HeaderArrow, fontSize: 15),
            errorText: error(),
            filled: true,
            fillColor:
                widget.field.readOnly ? Util.PrimaryColor : Colors.transparent,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Util.BorderColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Util.SecondaryColor)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Util.SecondaryColor)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Util.SecondaryColor)),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Util.BorderColor))),
        onChanged: updateField,
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}
