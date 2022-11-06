import 'package:flutter/material.dart';


class SmallText extends StatelessWidget {
  final String title;
  final Color? color;
  double size;
  TextOverflow overFlow;
  double height;
  
  SmallText({super.key, required this.title,this.height=1.2, this.color=Colors.blueGrey,this.size =12,this.overFlow=TextOverflow.ellipsis,});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,style: TextStyle(color: color,fontSize: size,height: height),
    );
  }
}