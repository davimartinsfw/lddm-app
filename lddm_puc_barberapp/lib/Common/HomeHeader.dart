import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

PreferredSizeWidget HomeHeader() {
  return PreferredSize(
      preferredSize: Size.fromHeight(47),
      child: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: FadeIn(
          child: SvgPicture.asset("assets/img/nordus-logo.svg"),
        ),
      ));
}
