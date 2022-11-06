import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_laravel/widgets/small_text.dart';

import '../utils/utils.dart';
import 'big_text.dart';
import 'icon_and_text.dart';

class AppColumn extends StatelessWidget {
  final String text;
  final double? size;
  final int stars;
  const AppColumn({super.key, required this.text,this.size, required this.stars});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(
          title: text,size: PageSize.font26,
        ),
        SizedBox(
          height: PageSize.height10,
        ),
        Row(
          children: [
            Wrap(
              children: List.generate(
                  stars,
                  (stars) => Icon(
                        Icons.star,
                        color: Colors.blueAccent,
                        size: 15,
                      )),
            ),
            SizedBox(
              width: 10,
            ),
            SmallText(title: stars.toString()+"/5"),
            SizedBox(
              width: 10,
            ),
            SmallText(title: "1203   comments"),
          ],
        ),
        SizedBox(
          height: PageSize.height20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndText(
              icon: Icons.circle_sharp,
              text: "Normal",
              iconColor: Colors.amber,
            ),
            IconAndText(
              icon: Icons.location_on,
              text: "1.7km",
              iconColor: Colors.lightGreen,
            ),
            IconAndText(
              icon: Icons.access_time_rounded,
              text: "32min",
              iconColor: Colors.redAccent,
            ),
          ],
        ),
      ],
    );
  }
}
