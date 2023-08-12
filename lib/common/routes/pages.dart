
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:nchat/common/pages/message/index.dart';
import 'package:nchat/common/routes/names.dart';
import '../middlewares/route_auth.dart';
import '../middlewares/route_welcome.dart';
import '../pages/application/bindings.dart';
import '../pages/application/view.dart';
import '../pages/contact/bindings.dart';
import '../pages/contact/view.dart';
import '../pages/message/chat/bindings.dart';
import '../pages/message/chat/view.dart';
import '../pages/welcome/index.dart';
import '../pages/sign_in/index.dart';

class AppPages {
  static const Initial = AppRoutes.Initial;

  static final List<GetPage> routes = [

    // Intro page
    GetPage(
        name: AppRoutes.Initial,
        page: () => const WelcomePage(),
        binding: WelcomeBinding(),
        middlewares: [
          RouteWelcomeMiddleware(priority: 1),
        ],
    ),

    // Sign In screen
    GetPage(
      name: AppRoutes.SignIn,
      page: () => const SignInPage(),
      binding: SignInBinding(),
    ),

    // check if needed to login or not
    GetPage(
      name: AppRoutes.Application,
      page: () => const ApplicationPage(),
      binding: ApplicationBinding(),
      middlewares: [
        RouteAuthMiddleware(priority: 1),
      ],
    ),

    // Contact
    GetPage(
      name: AppRoutes.Contact,
      page: () => const ContactPage(),
      binding: ContactBinding(),
    ),

    // Chat
    GetPage(
      name: AppRoutes.Chat,
      page: () => const ChatPage(),
      binding: ChatBinding(),
    ),

    // Message
    GetPage(
      name: AppRoutes.Message,
      page: () => const MessagePage(),
      binding: MessageBinding(),
    ),
  ];
}
