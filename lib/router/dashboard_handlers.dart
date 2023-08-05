import 'package:control_actividades/providers/auth_provider.dart';
import 'package:control_actividades/providers/sidemenu_provider.dart';
import 'package:control_actividades/router/router.dart';
import 'package:control_actividades/ui/views/blank_view.dart';
import 'package:control_actividades/ui/views/dashboard_view.dart';
import 'package:control_actividades/ui/views/edit_user_view.dart';
import 'package:control_actividades/ui/views/icons_view.dart';
import 'package:control_actividades/ui/views/login_view.dart';
import 'package:control_actividades/ui/views/user_view.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';
import '../ui/views/activities_arg_view.dart';
import '../ui/views/activities_view.dart';
import '../ui/views/inf_arg.dart';
import '../ui/views/time_line_view.dart';

class DashboardHandlers {
  static Handler dashboard = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.dashboardRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const DashboardView();
    } else {
      return const LoginView();
    }
  });

  static Handler icons = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.iconsRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const IconsView();
    } else {
      return const LoginView();
    }
  });

  static Handler blank = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.blankRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const BlankView();
    } else {
      return const LoginView();
    }
  });

  static Handler user = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.userRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const UserView();
    } else {
      return const LoginView();
    }
  });

  static Handler edituser = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.edituserRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      if (params['uid']!.first.isNotEmpty) {
        return EditUserView(document: params['uid']!.first);
      } else {
        return const UserView();
      }
    } else {
      return const LoginView();
    }
  });

  static Handler activities = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.activitiesRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const ActivitiesView();
    } else {
      return const LoginView();
    }
  });

  static Handler activitiesArg = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.activitiesArgRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return activitiesArgView();
    } else {
      return const LoginView();
    }
  });

  static Handler infArgRoute = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.infArgRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const InfArgView();
    } else {
      return const LoginView();
    }
  });

  static Handler timeline = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.timeLineRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const TimeLineView();
    } else {
      return const LoginView();
    }
  });
}
