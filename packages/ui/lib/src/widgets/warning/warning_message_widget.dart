import 'package:flutter/material.dart';

class WarningMessageWidget extends StatelessWidget {
  const WarningMessageWidget({Key? key, required this.title, this.subtitle})
      : super(key: key);

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      color: const Color.fromRGBO(255, 247, 229, 1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          if (subtitle != null)
            Text(
              subtitle!,
              style: Theme.of(context).textTheme.bodyText2,
            ),
        ],
      ),
    );
  }
}
