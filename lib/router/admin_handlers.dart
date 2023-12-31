import 'package:control_actividades/providers/auth_provider.dart';
import 'package:control_actividades/ui/views/dashboard_view.dart';
import 'package:control_actividades/ui/views/login_view.dart';
import 'package:control_actividades/ui/views/register_view.dart';
import 'package:control_actividades/ui/views/rol_view.dart';
import 'package:control_actividades/router/router.dart';
import 'package:control_actividades/providers/sidemenu_provider.dart';
import 'package:control_actividades/ui/views/registerConArg_view.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

class AdminHandlers {
  static Handler login = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.loginRoute);

    if (authProvider.authStatus == AuthStatus.notAuthenticated) {
      return const LoginView();
    } else {
      return const DashboardView();
    }
  });

  static Handler register = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.registerRoute);

    if (authProvider.authStatus == AuthStatus.notAuthenticated) {
      return const RegisterView();
    } else {
      return const DashboardView();
    }
  });

  static Handler register2 = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.registerRoute2);

    if (authProvider.authStatus == AuthStatus.notAuthenticated) {
      return RegisterView(idgrupo: params['idGrupo']?.first,tokenTUsuario: params['tokenTUsuario']?.first, tokenUser: params['tokenUser']?.first);
    } else {
      return const DashboardView();
    }
  });

  static Handler register3 = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.registerRoute3);

    if (authProvider.authStatus == AuthStatus.notAuthenticated) {
      return RegisterView(tokenUser: params['tokenUser']?.first);
    } else {
      return const DashboardView();
    }
  });

  static Handler role = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.roleCardRoute);

    if (authProvider.authStatus == AuthStatus.notAuthenticated) {
      return const RoleCardView();
    } else {
      return const DashboardView();
    }
  });

  static Handler registerToken = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.registerTokenRoute);

    if (authProvider.authStatus == AuthStatus.notAuthenticated) {
      return RegisterTokenView(token: params['token']?.first);
    } else {
      return const DashboardView();
    }
  });

  static Handler registerToken2 = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.registerTokenRoute);

    if (authProvider.authStatus == AuthStatus.notAuthenticated) {
      return const RegisterTokenView();
    } else {
      return const DashboardView();
    }
  });
}
