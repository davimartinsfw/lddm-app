import 'package:flutter/material.dart';
import '../../Common/Util.dart';
import '../../Models/Profile/Field.dart';

class CustomTextField extends StatefulWidget {
  final Field field;
  final String? name;
  final TextEditingController? controller;
  final Function? callBack;
  final bool shouldShowValidateButton;
  final bool obscureText;
  final String? hintText;
  final Function? customFocusCallback;
  final Function? customUnfocusCallback;
  final bool? autoCorrectActive;
  final IconButton? sufixIcon;

  const CustomTextField(
      {Key? key,
        required this.controller,
        this.name,
        required this.field,
        this.callBack,
        this.shouldShowValidateButton = false,
        this.hintText,
        this.obscureText = false,
        this.customFocusCallback,
        this.customUnfocusCallback,
        this.autoCorrectActive,
        this.sufixIcon})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  //late UserController userController;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();

    //userController = context.read<UserController>();
    _focusNode = FocusNode();

    _focusNode.addListener(() {
      setState(() {});
    });
  }

  String? error() {
    return widget.field.error?.call(widget.controller) ?? null;
  }

  void _requestFocus() {
    FocusScope.of(context).requestFocus(_focusNode);
    widget.customFocusCallback?.call();
    setState(() {});
  }

  void updateField(String text) {
    widget.callBack?.call(text);
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        if (!hasFocus) {
          widget.customUnfocusCallback?.call();
        }
      },
      child: TextField(
        focusNode: _focusNode,
        onTap: _requestFocus,
        style: TextStyle(
            color: widget.field.readOnly ? Util.InputColor : Util.TextColor,
            fontSize: 14),
        controller: widget.controller,
        readOnly: widget.field.readOnly,
        inputFormatters: widget.field.formatters ?? [],
        keyboardType: widget.field.keyboardType,
        obscureText: widget.obscureText,
        cursorColor: Util.SecondaryColor,
        decoration: InputDecoration(
            enabled: !widget.field.readOnly,
            contentPadding: EdgeInsets.all(16),
            hintText: widget.field.hintText ?? "",
            hintStyle: TextStyle(color: Util.BorderColor, fontSize: 15),
            errorText: error(),
            suffixIcon: widget.sufixIcon ?? null,
            filled: true,
            fillColor: widget.field.readOnly
                ? Util.DisableCalendar
                : Colors.white,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Util.BorderColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Util.BorderColor)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Util.DangerColor)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Util.DangerColor)),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.transparent))),
        onChanged: updateField,
        autocorrect: widget.autoCorrectActive ?? true,
        enableSuggestions: widget.autoCorrectActive ?? true,
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}
