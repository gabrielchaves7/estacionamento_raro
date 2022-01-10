import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  const FilterButton(
      {Key? key,
      required this.text,
      required this.onPressedCallback,
      required this.selected})
      : super(key: key);

  final String text;
  final VoidCallback onPressedCallback;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          selected ? Colors.blue : Colors.white,
        ),
      ),
      onPressed: () => onPressedCallback(),
      child: Text(
        text,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
