import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_laravel/utils/utils.dart';

import 'package:flutter_ecommerce_laravel/widgets/small_text.dart';

class ExandbleTextWidget extends StatefulWidget {
  final String text;
  const ExandbleTextWidget({super.key, required this.text});

  @override
  State<ExandbleTextWidget> createState() => _ExandbleTextWidgetState();
}

class _ExandbleTextWidgetState extends State<ExandbleTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText = true;

  double textHeight = PageSize.screenHeight / 5.63;
  //
  @override
  void initState() {
    super.initState();
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? SmallText(title: firstHalf)
          : Column(
              children: [
                SmallText(
                  title: hiddenText ? ("$firstHalf...") : widget.text,
                  size: PageSize.font26 / 1.8,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddenText = !hiddenText;
                    });
                  },
                  child: Row(
                    children: [
                      SmallText(
                        title: hiddenText ? "Show more" : "Show less",
                        color: Colors.blueAccent,
                      ),
                      Icon(
                        hiddenText
                            ? Icons.arrow_drop_down
                            : Icons.arrow_drop_up,
                        color: Colors.blueAccent,
                      ),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
