import 'package:control_actividades/api/endpointApi.dart';
import 'package:control_actividades/providers/ativities_provider.dart';
import 'package:control_actividades/providers/auth_provider.dart';
import 'package:control_actividades/providers/sidemenu_provider.dart';
import 'package:control_actividades/providers/user_form_provider.dart';
import 'package:control_actividades/providers/users_provider.dart';
import 'package:control_actividades/router/router.dart';
import 'package:control_actividades/services/local_storage.dart';
import 'package:control_actividades/services/navigation_service.dart';
import 'package:control_actividades/services/notifications_service.dart';
import 'package:control_actividades/ui/layouts/auth/auth_layout.dart';
import 'package:control_actividades/ui/layouts/dashboard/dashboard_layout.dart';
import 'package:control_actividades/ui/layouts/splash/splash_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  await LocalStorage.configurePrefs();
  EndPointApi.configureDio();
  Flurorouter.configureRoutes();
  runApp(AppState());
}

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(lazy: false, create: (_) => AuthProvider()),
        ChangeNotifierProvider(lazy: false, create: (_) => SideMenuProvider()),
        ChangeNotifierProvider(create: (_) => UsersProvider()),
        ChangeNotifierProvider(create: (_) => UserFormProvider()),
        ChangeNotifierProvider(create: (_) => ActivitiesProvider())
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin Dashboard',
      initialRoute: '/',
      onGenerateRoute: Flurorouter.router.generator,
      navigatorKey: NavigationService.navigatorKey,
      scaffoldMessengerKey: NotificationsService.messengerKey,
      builder: (_, child) {
        final authProvider = Provider.of<AuthProvider>(context);

        if (authProvider.authStatus == AuthStatus.checking) {
          return SplashLayout();
        }

        if (authProvider.authStatus == AuthStatus.authenticated) {
          return DashboardLayout(child: child!);
        } else {
          return AuthLayout(child: child!);
        }
      },
      theme: ThemeData.light().copyWith(
          scrollbarTheme: ScrollbarThemeData().copyWith(
              thumbColor:
                  MaterialStateProperty.all(Colors.grey.withOpacity(0.5)))),
    );
  }
}
