
import 'package:crypto_app/modules/chain_refer/chain_refer_bindings.dart';
import 'package:crypto_app/modules/chain_refer/chain_refer_screen.dart';
import 'package:crypto_app/modules/cryptx_wallet/wallet_info_bindings.dart';
import 'package:crypto_app/modules/cryptx_wallet/wallet_info_screen.dart';
import 'package:crypto_app/modules/dashboard/dashboard_bindings.dart';
import 'package:crypto_app/modules/dashboard/dashboard_screen.dart';
import 'package:crypto_app/modules/forgot_password/forgot_password_bindings.dart';
import 'package:crypto_app/modules/forgot_password/forgot_password_screen.dart';
import 'package:crypto_app/modules/home/home_bindings.dart';
import 'package:crypto_app/modules/home/home_screen.dart';
import 'package:crypto_app/modules/login/login_bindings.dart';
import 'package:crypto_app/modules/login/login_screen.dart';
import 'package:crypto_app/modules/onboard/onboard_bindings.dart';
import 'package:crypto_app/modules/onboard/onboard_screen.dart';
import 'package:crypto_app/modules/otp_auth/otp_auth_bindings.dart';
import 'package:crypto_app/modules/otp_auth/otp_auth_screen.dart';
import 'package:crypto_app/modules/profile/profile_bindings.dart';
import 'package:crypto_app/modules/profile/profile_screen.dart';
import 'package:crypto_app/modules/sign_up/sign_up_bindings.dart';
import 'package:crypto_app/modules/sign_up/sign_up_screen.dart';
import 'package:crypto_app/modules/task/task_bindings.dart';
import 'package:crypto_app/modules/task/task_screen.dart';
import 'package:crypto_app/modules/terms_policy/terms_policy_bindings.dart';
import 'package:crypto_app/modules/terms_policy/terms_policy_screen.dart';
import 'package:crypto_app/modules/update_password/update_password_bindings.dart';
import 'package:crypto_app/modules/update_password/update_password_screen.dart';
import 'package:crypto_app/modules/wallet/wallet_bindings.dart';
import 'package:crypto_app/modules/wallet/wallet_screen.dart';
import 'package:crypto_app/modules/x_chain/x_chain_bindings.dart';
import 'package:crypto_app/modules/x_chain/x_chain_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';


part 'app_routes.dart';

abstract class AppPages {
  const AppPages._();

  static const initial =  Routes.onboard;
  static const logged =  Routes.dashboard; //  late add home screen there

  static final routes = [

    GetPage(
      name: _Paths.onboard,
      page: () => const OnboardingScreen(),
      binding: OnboardingBindings(),
    ),
    GetPage(
      name: _Paths.login,
      page: () => const LoginScreen(),
      binding: LoginBindings(),
    ),
    GetPage(
      name: _Paths.forgotPassword,
      page: () => const ForgotPasswordScreen(),
      binding: ForgotPasswordBindings(),
    ),
    GetPage(
      name: _Paths.otp,
      page: () => const OtpAuthScreen(),
      binding: OtpAuthBindings(),
    ),
    GetPage(
      name: _Paths.register,
      page: () => const SignUpScreen(),
      binding: SignUPBindings(),
    ),
    GetPage(
      name: _Paths.dashboard,
      page: () => const DashboardScreen(),
      binding: DashboardBindings(),
    ),
    GetPage(
      name: _Paths.home,
      page: () => const HomeScreen(),
      binding: HomeBindings(),
    ),
    GetPage(
      name: _Paths.task,
      page: () => const TaskScreen(),
      binding: TaskBindings(),
    ),
    GetPage(
      name: _Paths.xChain,
      page: () => const XChainScreen(),
      binding: XChainBindings(),
    ),
    GetPage(
      name: _Paths.chainFactor,
      page: () => const ChainReferScreen(),
      binding: ChainReferBindings(),
    ),
    GetPage(
      name: _Paths.wallet,
      page: () => const WalletScreen(),
      binding: WalletBindings(),
    ),
    GetPage(
      name: _Paths.updatePassword,
      page: () => const UpdatePasswordScreen(),
      binding: UpdatePasswordBindings(),
    ),
    GetPage(
      name: _Paths.walletInfo,
      page: () => const WalletInfoScreen(),
      binding: WalletInfoBindings(),
    ),
    GetPage(
      name: _Paths.profile,
      page: () => const ProfileScreen(),
      binding: ProfileBindings(),
    ),
    GetPage(
      name: _Paths.termsPolicy,
      page: () => const TermsPolicyScreen(),
      binding: TermsPolicyBindings(),
    ),
  ];
}
