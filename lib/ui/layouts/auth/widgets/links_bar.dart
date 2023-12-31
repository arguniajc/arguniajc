import 'package:control_actividades/ui/buttons/link_text.dart';
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class LinksBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
        color: Colors.black,
        height: (size.width > 1000) ? size.height * 0.07 : null,
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            LinkText(text: 'About', onPressed: () => {}),
            const LinkText(text: 'Help Center'),
            const LinkText(text: 'Terms of Service'),
            const LinkText(text: 'Privacy Policy'),
            const LinkText(text: 'Cookie Policy'),
            const LinkText(text: 'Ads info'),
            const LinkText(text: 'Blog'),
            const LinkText(text: 'Status'),
            const LinkText(text: 'Careers'),
            const LinkText(text: 'Brand Resources'),
            const LinkText(text: 'Advertising'),
            const LinkText(text: 'Marketing'),
          ],
        ));
  }
}
