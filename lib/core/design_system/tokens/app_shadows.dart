import 'package:flutter/material.dart';

class AppShadow {
  AppShadow._();

  /// Extra small shadow.
  static const xs = [
    BoxShadow(
      blurRadius: 2,
      offset: Offset(0, 1),
      color: Color.fromRGBO(16, 24, 40, 0.05),
    ),
  ];

  /// Small shadow.
  static const sm = [
    BoxShadow(color: Color(0x0F101828), blurRadius: 2, offset: Offset(0, 1)),
    BoxShadow(color: Color(0x19101828), blurRadius: 3, offset: Offset(0, 1)),
  ];

  /// Floating toast (Figma `Courier/Toast`: 0 8 12, rgba(8,64,46,.18)).
  static const toast = [
    BoxShadow(color: Color(0x2E08402E), offset: Offset(0, 8), blurRadius: 12),
  ];

  /// In-app push banner (Figma `Courier/Push Banner`: 0 12 16,
  /// rgba(13,26,38,.18)).
  static const pushBanner = [
    BoxShadow(color: Color(0x2E0D1A26), offset: Offset(0, 12), blurRadius: 16),
  ];

  static const lg = [
    BoxShadow(color: Color(0x0D101828), offset: Offset(0, -6), blurRadius: 24),
  ];
}
