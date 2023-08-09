import 'package:control_actividades/router/admin_handlers.dart';
import 'package:control_actividades/router/dashboard_handlers.dart';
import 'package:control_actividades/router/no_page_found_handlers.dart';
import 'package:fluro/fluro.dart';

class Flurorouter {
  static final FluroRouter router = FluroRouter();

  static String rootRoute = '/';

  // Auth Router
  static String loginRoute = '/auth/login';
  static String registerRoute = '/auth/register';

  // Dashboard
  static String dashboardRoute = '/dashboard';
  static String iconsRoute = '/dashboard/icons';
  static String blankRoute = '/dashboard/blank';
  static String userRoute = '/dashboard/users';
  static String edituserRoute = '/dashboard/users/:uid';
  static String activitiesRoute = '/dashboard/activities';
  static String activitiesArgRoute = '/dashboard/activitiesArgRoute';
  static String infArgRoute = '/dashboard/infarg';
  static String timeLineRoute = '/dashboard/timeline';
  static String medioRoute = '/dashboard/medio';
  static String estudiantesRoute = '/dashboard/estudiantes';
  static String notasRoute = '/dashboard/notas';

  static void configureRoutes() {
    // Auth Routes
    router.define(rootRoute,
        handler: AdminHandlers.login, transitionType: TransitionType.none);
    router.define(loginRoute,
        handler: AdminHandlers.login, transitionType: TransitionType.none);
    router.define(registerRoute,
        handler: AdminHandlers.register, transitionType: TransitionType.none);

    // Dashboard
    router.define(dashboardRoute,
        handler: DashboardHandlers.dashboard,
        transitionType: TransitionType.fadeIn);
    router.define(iconsRoute,
        handler: DashboardHandlers.icons,
        transitionType: TransitionType.fadeIn);
    router.define(blankRoute,
        handler: DashboardHandlers.blank,
        transitionType: TransitionType.fadeIn);
    router.define(userRoute,
        handler: DashboardHandlers.user, transitionType: TransitionType.fadeIn);
    router.define(edituserRoute,
        handler: DashboardHandlers.edituser,
        transitionType: TransitionType.fadeIn);
    router.define(activitiesRoute,
        handler: DashboardHandlers.activities,
        transitionType: TransitionType.fadeIn);
    router.define(activitiesArgRoute,
        handler: DashboardHandlers.activitiesArg,
        transitionType: TransitionType.fadeIn);
    router.define(infArgRoute,
        handler: DashboardHandlers.infArgRoute,
        transitionType: TransitionType.fadeIn);
    router.define(timeLineRoute,
        handler: DashboardHandlers.timeline,
        transitionType: TransitionType.fadeIn);
    router.define(medioRoute,
        handler: DashboardHandlers.medio,
        transitionType: TransitionType.fadeIn);
    router.define(estudiantesRoute,
        handler: DashboardHandlers.estudiantes,
        transitionType: TransitionType.fadeIn);
    router.define(notasRoute,
        handler: DashboardHandlers.notas,
        transitionType: TransitionType.fadeIn);

    // 404
    router.notFoundHandler = NoPageFoundHandlers.noPageFound;
  }
}
