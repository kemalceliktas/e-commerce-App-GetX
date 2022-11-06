import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_laravel/utils/utils.dart';


class BigText extends StatelessWidget {
  final String title;
  final Color? color;
  double size;
  TextOverflow overFlow;
  
  BigText({super.key, required this.title,this.size=16, this.color,this.overFlow=TextOverflow.ellipsis,});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,style: TextStyle(color: color,fontSize:size==0? PageSize.font20:size,overflow: overFlow,fontWeight: FontWeight.w400),
    );
  }
}