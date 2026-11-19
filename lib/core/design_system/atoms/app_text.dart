import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

class AppText extends StatelessWidget {
  const AppText(
    this.text, {
    this.style,
    this.color,
    this.textAlign,
    this.maxLines,
    super.key,
  });
  final String text;
  final TextStyle? style;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: (style ?? context.typography.bodyM).copyWith(color: color),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: maxLines == null ? null : TextOverflow.ellipsis,
    );
  }
}
