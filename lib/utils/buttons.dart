import 'package:flutter/material.dart';

class dialogButton extends StatelessWidget {
  final String text1;
  final Color? bgcolors;
  final Color outlinecolors;
  final TextStyle textstyle;

  final VoidCallback onpressed;
  dialogButton(
      {super.key,
      required this.text1,
      required this.onpressed,
      required this.textstyle,
      required this.outlinecolors,
      this.bgcolors});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: bgcolors,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: BorderSide(color: outlinecolors))),
      onPressed: onpressed,
      child: Text(
        text1,
        style: textstyle,
      ),
    );
  }
}
