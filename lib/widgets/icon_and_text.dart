import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_laravel/utils/utils.dart';
import 'package:flutter_ecommerce_laravel/widgets/small_text.dart';

class IconAndText extends StatelessWidget {
  final IconData icon;

  final String text;
  final Color iconColor;
  const IconAndText(
      {super.key,
      required this.icon,
      required this.text,
      required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: PageSize.iconSize24,
        ),
        SizedBox(
          width: 5,
        ),
        SmallText(title: text),
      ],
    );
  }
}
