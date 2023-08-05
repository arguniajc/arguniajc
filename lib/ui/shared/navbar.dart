import 'package:control_actividades/providers/sidemenu_provider.dart';
import 'package:control_actividades/ui/shared/widgets/navbar_avatar.dart';
import 'package:control_actividades/ui/shared/widgets/notifications_indicator.dart';
import 'package:control_actividades/ui/shared/widgets/search_text.dart';
import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: 50,
      decoration: buildBoxDecoration(),
      child: Row(
        children: [
          if (size.width <= 700)
            IconButton(
                icon: const Icon(Icons.menu_outlined),
                onPressed: () => SideMenuProvider.openMenu()),

          const SizedBox(width: 5),

          // Search input
          if (size.width > 390)
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 250),
              child: SearchText(),
            ),

          Spacer(),

          NotificationsIndicator(),
          const SizedBox(width: 10),
          NavbarAvatar(),
          const SizedBox(width: 10)
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
      color: Colors.white,
      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]);
}
