import 'package:flutter/material.dart';

class CustomRoute {
  Widget Function(dynamic argument) render;

  CustomRoute({
    required this.render,
  });
}