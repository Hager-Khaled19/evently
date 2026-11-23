import 'package:flutter/material.dart';
import '../../core/services/auth_service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/app_assets.dart';
import '../../core/utils/app_strings.dart';
import '../../core/widgets/custom_text_field.dart';
import '../home/home_screen.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  final _authService = AuthService();
  bool _loading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
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

  Future<void> _register() async {
    final s = AppStrings.of(context);
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirm = _confirmController.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      _show(s.fillAll);
      return;
    }
    if (password != confirm) {
      _show(s.passwordsNotMatch);
      return;
    }

    setState(() => _loading = true);
    final error = await _authService.register(name, email, password);
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
                s.registerTitle,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: mainColor,
                ),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                hint: s.enterName,
                icon: Icons.person_outline,
                controller: _nameController,
              ),
              const SizedBox(height: 12),
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
              const SizedBox(height: 12),
              CustomTextField(
                hint: s.confirmPassword,
                icon: Icons.lock_outline,
                isPassword: true,
                controller: _confirmController,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _loading ? null : _register,
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
                      : Text(s.signUpButton,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500)),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    s.haveAccount,
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
                            builder: (_) => const LoginScreen()),
                      );
                    },
                    child: Text(
                      s.login,
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
                      Text(s.signUpWithGoogle,
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