import 'package:flutter/material.dart';
import '../../core/services/auth_service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/app_assets.dart';
import '../../core/utils/app_strings.dart';
import '../../core/widgets/custom_text_field.dart';
import '../home/home_screen.dart';
import 'forget_password_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();
  bool _loading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _show(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  void _goHome() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
          (route) => false,
    );
  }

  Future<void> _login() async {
    final s = AppStrings.of(context);
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      _show(s.fillAll);
      return;
    }

    setState(() => _loading = true);
    final error = await _authService.login(email, password);
    if (!mounted) return;
    setState(() => _loading = false);

    if (error != null) {
      _show(s.authError(error));
      return;
    }
    _goHome();
  }

  Future<void> _google() async {
    final s = AppStrings.of(context);
    setState(() => _loading = true);
    final error = await _authService.signInWithGoogle();
    if (!mounted) return;
    setState(() => _loading = false);

    if (error != null) {
      _show(s.authError(error));
      return;
    }
    _goHome();
  }

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final mainColor =
    isDark ? AppColors.mainDarkColor : AppColors.mainLightColor;
    final strokeColor =
    isDark ? AppColors.strokeDarkColor : AppColors.strokeWhiteColor;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Center(
                child: Image.asset(
                  isDark ? AppAssets.logoDark : AppAssets.logoLight,
                  height: 32,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                s.loginTitle,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: mainColor,
                ),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                hint: s.enterEmail,
                icon: Icons.email_outlined,
                controller: _emailController,
              ),
              const SizedBox(height: 12),
              CustomTextField(
                hint: s.enterPassword,
                icon: Icons.lock_outline,
                isPassword: true,
                controller: _passwordController,
              ),
              const SizedBox(height: 8),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const ForgetPasswordScreen()),
                    );
                  },
                  child: Text(
                    s.forgetPassword,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: mainColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _loading ? null : _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  child: _loading
                      ? const SizedBox(
                    height: 22,
                    width: 22,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: Colors.white),
                  )
                      : Text(s.login,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500)),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    s.noAccount,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark
                          ? AppColors.whiteDarkColor
                          : AppColors.greyColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const RegisterScreen()),
                      );
                    },
                    child: Text(
                      s.signup,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: mainColor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: Divider(color: strokeColor)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(s.or,
                        style: TextStyle(fontSize: 12, color: mainColor)),
                  ),
                  Expanded(child: Divider(color: strokeColor)),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton(
                  onPressed: _loading ? null : _google,
                  style: OutlinedButton.styleFrom(
                    backgroundColor:
                    isDark ? AppColors.darkInputColor : AppColors.whiteColor,
                    side: BorderSide(color: strokeColor),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(AppAssets.iconGoogle, height: 22),
                      const SizedBox(width: 10),
                      Text(s.loginWithGoogle,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: mainColor)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}