import 'package:get/get.dart';

import '../modules/athlete/account_options/bindings/account_options_binding.dart';
import '../modules/athlete/account_options/views/account_options_view.dart';
import '../modules/athlete/cart/bindings/cart_binding.dart';
import '../modules/athlete/cart/views/cart_view.dart';
import '../modules/shared/change_language/bindings/change_language_binding.dart';
import '../modules/shared/change_language/views/change_language_view.dart';
import '../modules/auth/change_password/bindings/change_password_binding.dart';
import '../modules/auth/change_password/views/change_password_view.dart';
import '../modules/athlete/class_detail/bindings/class_detail_binding.dart';
import '../modules/athlete/class_detail/views/class_detail_view.dart';
import '../modules/athlete/class_list/bindings/class_list_binding.dart';
import '../modules/athlete/class_list/views/class_list_view.dart';
import '../modules/shared/faq/bindings/faq_binding.dart';
import '../modules/shared/faq/views/faq_view.dart';
import '../modules/athlete/home/bindings/home_binding.dart';
import '../modules/athlete/home/views/home_view.dart';
import '../modules/judge/home_judge/bindings/home_judge_binding.dart';
import '../modules/judge/home_judge/views/home_judge_view.dart';
import '../modules/judge/profile_judge/bindings/profile_judge_binding.dart';
import '../modules/judge/profile_judge/views/profile_judge_view.dart';
import '../modules/judge/scoring/bindings/scoring_binding.dart';
import '../modules/judge/scoring/views/scoring_view.dart';
import '../modules/athlete/main/bindings/main_binding.dart';
import '../modules/athlete/main/views/main_view.dart';
import '../modules/athlete/notification/bindings/notification_binding.dart';
import '../modules/athlete/notification/views/notification_view.dart';
import '../modules/auth/onboarding/bindings/onboarding_binding.dart';
import '../modules/auth/onboarding/views/onboarding_view.dart';
import '../modules/athlete/profile/bindings/profile_binding.dart';
import '../modules/athlete/profile/views/profile_view.dart';
import '../modules/shared/reset_password/bindings/reset_password_binding.dart';
import '../modules/shared/reset_password/views/reset_password_view.dart';
import '../modules/auth/signin/bindings/signin_binding.dart';
import '../modules/auth/signin/views/signin_view.dart';
import '../modules/auth/signup/bindings/signup_binding.dart';
import '../modules/auth/signup/views/signup_step1_view.dart';
import '../modules/auth/signup/views/signup_step2_view.dart';
import '../modules/auth/splash/bindings/splash_binding.dart';
import '../modules/auth/splash/views/splash_view.dart';
import '../modules/shared/switch_theme/bindings/switch_theme_binding.dart';
import '../modules/shared/switch_theme/views/switch_theme_view.dart';
import '../modules/athlete/transaction/bindings/transaction_binding.dart';
import '../modules/athlete/transaction/views/transaction_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP_STEP1,
      page: () => const SignUpStep1View(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP_STEP2,
      page: () => const SignUpStep2View(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.SIGNIN,
      page: () => const SigninView(),
      binding: SigninBinding(),
    ),
    GetPage(
      name: Routes.MAIN,
      page: () => const MainView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: _Paths.TRANSACTION,
      page: () => const TransactionView(),
      binding: TransactionBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: Routes.CLASS_DETAIL,
      page: () => const ClassDetailView(),
      binding: ClassDetailBinding(),
    ),
    GetPage(
      name: Routes.CLASS_LIST,
      page: () => const ClassListView(),
      binding: ClassListBinding(),
    ),
    GetPage(
      name: Routes.NOTIFICATION,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: Routes.CART,
      page: () => const CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: _Paths.FAQ,
      page: () => const FaqView(),
      binding: FaqBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_PASSWORD,
      page: () => const ChangePasswordView(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => const ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.ACCOUNT_OPTIONS,
      page: () => const AccountOptionsView(),
      binding: AccountOptionsBinding(),
    ),
    GetPage(
      name: _Paths.SWITCH_THEME,
      page: () => const SwitchThemeView(),
      binding: SwitchThemeBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_LANGUAGE,
      page: () => const ChangeLanguageView(),
      binding: ChangeLanguageBinding(),
    ),
    GetPage(
      name: Routes.HOME_JUDGE,
      page: () => const HomeJudgeView(),
      binding: HomeJudgeBinding(),
    ),
    GetPage(
      name: Routes.SCORING,
      page: () => const ScoringView(),
      binding: ScoringBinding(),
    ),
    GetPage(
      name: Routes.PROFILE_JUDGE,
      page: () => const ProfileJudgeView(),
      binding: ProfileJudgeBinding(),
    ),
  ];
}
