import 'package:control_actividades/router/admin_handlers.dart';
import 'package:control_actividades/router/dashboard_handlers.dart';
import 'package:control_actividades/router/no_page_found_handlers.dart';
import 'package:fluro/fluro.dart';

class Flurorouter {
  static final FluroRouter router = FluroRouter();

  static rutasIguales(String path) {
    return router.match(path);
  }

  static String rootRoute = '/';

  // Auth Router
  static String loginRoute = '/auth/login';
  static String registerRoute = '/auth/register';
  static String registerRoute2 = '/auth/register/:idGrupo/:tokenTUsuario/:tokenUser';
  static String roleCardRoute = '/auth/role';
  static String registerTokenRoute = '/auth/registerToken/:token';
  static String registerTokenRoute2 = '/auth/registerToken';

  // Dashboard
  static String dashboardRoute = '/dashboard';
  static String iconsRoute = '/dashboard/icons';
  static String blankRoute = '/dashboard/blank';
  static String userRoute = '/dashboard/users';
  static String typeuserRoute = '/dashboard/typeUsers';
  static String edituserRoute = '/dashboard/users/:uid';
  static String activitiesRoute = '/dashboard/activities';
  static String activitiesArgRoute = '/dashboard/activitiesArg';
  static String activitiesTableArgRoute = '/dashboard/actividades/';
  static String argRoute = '/dashboard/arg/';
  static String infArgRoute = '/dashboard/editarg';
  static String timeLineRoute = '/dashboard/timeline';
  static String medioRoute = '/dashboard/Editmedio';
  static String medio = '/dashboard/medio/';
  static String estudiantesRoute = '/dashboard/estudiantes';
  static String notasRoute = '/dashboard/notas';
  static String gruposRoute = '/dashboard/grupos';
  static String gruposTablaRoute = '/dashboard/gruposTabla';
  static String sedeRoute = '/dashboard/sede';
  static String sedeTalaRoute = '/dashboard/sedeTabla';

  static void configureRoutes() {
    // Auth Routes
    router.define(rootRoute,
        handler: AdminHandlers.login, transitionType: TransitionType.none);
    router.define(loginRoute,
        handler: AdminHandlers.login, transitionType: TransitionType.none);
    router.define(registerRoute,
        handler: AdminHandlers.register, transitionType: TransitionType.none);
    router.define(registerRoute2,
        handler: AdminHandlers.register2, transitionType: TransitionType.none);
    router.define(roleCardRoute,
        handler: AdminHandlers.role, transitionType: TransitionType.none);
    router.define(registerTokenRoute,
        handler: AdminHandlers.registerToken, transitionType: TransitionType.none);
    router.define(registerTokenRoute2,
        handler: AdminHandlers.registerToken2, transitionType: TransitionType.none);

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
    router.define(activitiesTableArgRoute,
        handler: DashboardHandlers.activitiesTable,
        transitionType: TransitionType.fadeIn);
    router.define(argRoute,
        handler: DashboardHandlers.argRoute,
        transitionType: TransitionType.fadeIn);
    router.define(infArgRoute,
        handler: DashboardHandlers.infArgRoute,
        transitionType: TransitionType.fadeIn);
    router.define(timeLineRoute,
        handler: DashboardHandlers.timeline,
        transitionType: TransitionType.fadeIn);
    router.define(medioRoute,
        handler: DashboardHandlers.medioForm,
        transitionType: TransitionType.fadeIn);
    router.define(medio,
        handler: DashboardHandlers.medio,
        transitionType: TransitionType.fadeIn);
    router.define(estudiantesRoute,
        handler: DashboardHandlers.estudiantes,
        transitionType: TransitionType.fadeIn);
    router.define(notasRoute,
        handler: DashboardHandlers.notas,
        transitionType: TransitionType.fadeIn);
    router.define(typeuserRoute,
        handler: DashboardHandlers.typeUser,
        transitionType: TransitionType.fadeIn);
    router.define(gruposRoute,
        handler: DashboardHandlers.grupos,
        transitionType: TransitionType.fadeIn);
    router.define(gruposTablaRoute,
        handler: DashboardHandlers.gruposTabla,
        transitionType: TransitionType.fadeIn);
    router.define(sedeRoute,
        handler: DashboardHandlers.sedes,
        transitionType: TransitionType.fadeIn);
    router.define(sedeTalaRoute,
        handler: DashboardHandlers.sedeTabla,
        transitionType: TransitionType.fadeIn);

    // 404
    router.notFoundHandler = NoPageFoundHandlers.noPageFound;
  }
}
