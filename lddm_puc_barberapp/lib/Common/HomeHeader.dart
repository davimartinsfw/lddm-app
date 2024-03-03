import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget HomeHeader() {
  return PreferredSize(
      preferredSize: Size.fromHeight(47),
      child: AppBar(
        centerTitle: true,
        title: FadeIn(
          child: Image.asset(
            "assets/img/nordus-logo.png",
            width: 120,
          ),
        ),
      ));
}
