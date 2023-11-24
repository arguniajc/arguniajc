import 'package:control_actividades/providers/sidemenu_provider.dart';
import 'package:control_actividades/router/router.dart';
import 'package:control_actividades/services/navigation_service.dart';
import 'package:control_actividades/ui/shared/widgets/logo.dart';
import 'package:control_actividades/ui/shared/widgets/menu_item.dart';
import 'package:control_actividades/ui/shared/widgets/text_separator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class Sidebar extends StatelessWidget {
  void navigateTo(String routeName) {
    NavigationService.replaceTo(routeName);
    SideMenuProvider.closeMenu();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).usuario!;
    final sideMenuProvider = Provider.of<SideMenuProvider>(context);

    return Container(
      width: 220,
      height: double.infinity,
      decoration: buildBoxDecoration(),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Logo(),
          const SizedBox(height: 50),
          const TextSeparator(text: 'Main'),
          MenuItem(
            text: 'Dashboard',
            icon: Icons.compass_calibration_outlined,
            onPressed: () => navigateTo(Flurorouter.dashboardRoute),
            isActive:
                sideMenuProvider.currentPage == Flurorouter.dashboardRoute,
          ),
          const SizedBox(height: 10),
          Visibility(
            visible: user.idTipoUsuario == 5 ||
                user.idTipoUsuario == 3 ||
                user.idTipoUsuario == 4,
            child: const TextSeparator(text: 'ARG'),
          ),
          Visibility(
              visible: user.idTipoUsuario == 5 || user.idTipoUsuario == 3,
              child: MenuItem(
                text: 'ARGs',
                icon: Icons.book,
                onPressed: () => navigateTo(Flurorouter.argRoute),
              )),
          Visibility(
              visible: user.idTipoUsuario == 5 ||
                  user.idTipoUsuario == 3 ||
                  user.idTipoUsuario == 4,
              child: MenuItem(
                text: 'Actividades',
                icon: Icons.menu_book,
                onPressed: () =>
                    navigateTo(Flurorouter.activitiesTableArgRoute),
              )),
          Visibility(
              visible: user.idTipoUsuario == 5 ||
                  user.idTipoUsuario == 3 ||
                  user.idTipoUsuario == 4,
              child: MenuItem(
                text: 'Medios',
                icon: Icons.apps,
                onPressed: () => navigateTo(Flurorouter.medio),
              )),
          Visibility(
              visible: user.idTipoUsuario == 5 ||
                  user.idTipoUsuario == 3 ||
                  user.idTipoUsuario == 4,
              child: MenuItem(
                text: 'Timeline',
                icon: Icons.timeline_sharp,
                onPressed: () => navigateTo(Flurorouter.timeLineRoute),
              )),
          Visibility(
            visible: user.idTipoUsuario == 5,
            child: const TextSeparator(text: 'Account'),
          ),
          Visibility(
              visible: user.idTipoUsuario == 5,
              child: MenuItem(
                text: 'Usuarios',
                icon: Icons.people_alt_outlined,
                onPressed: () => navigateTo(Flurorouter.userRoute),
              )),
          Visibility(
              visible: user.idTipoUsuario == 5,
              child: MenuItem(
                text: 'Tipo de usuarios',
                icon: Icons.supervised_user_circle,
                onPressed: () => navigateTo(Flurorouter.typeuserRoute),
              )),
          // Visibility(
          //   child: MenuItem(
          //   text: 'Activities',
          //   icon: Icons.note_alt,
          //   onPressed: () => navigateTo(Flurorouter.activitiesRoute),

          // )),
          const TextSeparator(text: 'Notas'),
          Visibility(
              visible: user.idTipoUsuario == 5 || user.idTipoUsuario == 2,
              child: MenuItem(
                text: 'Estudiantes',
                icon: Icons.school,
                onPressed: () => navigateTo(Flurorouter.estudiantesRoute),
              )),
          Visibility(
              visible: user.idTipoUsuario == 5 ||
                  user.idTipoUsuario == 3 ||
                  user.idTipoUsuario == 4,
              child: MenuItem(
                text: 'Grupos',
                icon: Icons.group_add_rounded,
                onPressed: () => navigateTo(Flurorouter.gruposTablaRoute),
              )),
          Visibility(
              visible: user.idTipoUsuario == 5 ||
                  user.idTipoUsuario == 3 ||
                  user.idTipoUsuario == 4,
              child: MenuItem(
                text: 'IE',
                icon: Icons.business,
                onPressed: () => navigateTo(Flurorouter.sedeRoute),
              )),
          Visibility(
              visible: user.idTipoUsuario == 5 || user.idTipoUsuario == 2,
              child: MenuItem(
                text: 'Notas',
                icon: Icons.note_alt,
                onPressed: () => navigateTo(Flurorouter.notasRoute),
              )),
          // const SizedBox(height: 30),
          // const TextSeparator(text: 'UI Elements'),
          // MenuItem(
          //   text: 'Icons',
          //   icon: Icons.list_alt_outlined,
          //   onPressed: () => navigateTo(Flurorouter.iconsRoute),

          // ),
          // MenuItem(
          //     text: 'Marketing',
          //     icon: Icons.mark_email_read_outlined,
          //     onPressed: () {}),
          // MenuItem(
          //     text: 'Campaign',
          //     icon: Icons.note_add_outlined,
          //     onPressed: () {}),
          // MenuItem(
          //   text: 'Black',
          //   icon: Icons.post_add_outlined,
          //   onPressed: () => navigateTo(Flurorouter.blankRoute),
          //   isActive: sideMenuProvider.currentPage == Flurorouter.blankRoute,
          // ),
          const SizedBox(height: 30),
          const TextSeparator(text: 'Exit'),
          MenuItem(
              text: 'Logout',
              icon: Icons.exit_to_app_outlined,
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false).logout();
              }),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
      gradient: LinearGradient(colors: [
        Color(0xff092044),
        Color(0xff092042),
      ]),
      boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)]);
}
