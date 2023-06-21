import 'package:flutter/material.dart';

class CustomInconButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final Color color;
  final bool isFalled;
  final IconData icon;

  const CustomInconButton(
      {Key? key,
      required this.onPressed,
      required this.text,
      required this.icon,
      this.color = Colors.indigo,
      this.isFalled = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(const StadiumBorder()),
          backgroundColor: MaterialStateProperty.all(color.withOpacity(0.9)),
          overlayColor:
              MaterialStateProperty.all(Colors.indigo.withOpacity(0.3)),
        ),
        onPressed: () => onPressed(),
        child: Row(
          children: [
            Icon(icon, color: Colors.white),
            Text(
              text,
              style: const TextStyle(color: Colors.white),
            )
          ],
        ));
  }
}
