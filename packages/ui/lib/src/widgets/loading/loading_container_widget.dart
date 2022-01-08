import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingContainerWidget extends StatelessWidget {
  LoadingContainerWidget({
    Key? key,
    required this.width,
    required this.height,
    this.borderRadius = 16,
    this.paddingBottom = 0,
    this.paddingTop = 0,
  }) : super(key: key);

  final double width;
  final double height;
  final double borderRadius;
  final double paddingBottom;
  final double paddingTop;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: paddingTop,
        ),
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              color: Colors.grey),
        ),
        SizedBox(
          height: paddingBottom,
        ),
      ],
    );
  }
}
