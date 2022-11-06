import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_laravel/utils/utils.dart';




class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double size;


  const AppIcon({super.key, required this.icon,this.backgroundColor=Colors.white70,this.iconColor=Colors.black54,this.size=40});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size/2),
        color: backgroundColor,
      ),
      child: Icon(icon,color: iconColor,size: PageSize.iconSize16,),
    );
  }
}