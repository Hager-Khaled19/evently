import 'package:flutter/material.dart';
import '../../core/services/auth_service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/app_assets.dart';
import '../../core/utils/app_strings.dart';
import '../../core/widgets/custom_text_field.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _emailController = TextEditingController();
  final _authService = AuthService();
  bool _loading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _reset() async {
    final s = AppStrings.of(context);
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      _show(s.enterEmailFirst);
      return;
    }
    setState(() => _loading = true);
    final error = await _authService.resetPassword(email);
    if (!mounted) return;
    setState(() => _loading = false);
    _show(error == null ? s.resetSent : s.authError(error));
  }

  void _show(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final mainColor =
    isDark ? AppColors.mainDarkColor : AppColors.mainLightColor;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 12),
              SizedBox(
                height: 36,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            border: Border.all(color: mainColor),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(Icons.arrow_back_ios_new,
                              size: 16, color: mainColor),
                        ),
                      ),
                    ),
                    Text(
                      s.forgetPasswordTitle,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isDark
                            ? AppColors.whiteColor
                            : AppColors.blackColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Image.asset(
                isDark
                    ? AppAssets.forgetPasswordDark
                    : AppAssets.forgetPasswordLight,
                width: double.infinity,
                fit: BoxFit.fitWidth,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                hint: s.enterEmail,
                icon: Icons.email_outlined,
                controller: _emailController,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _loading ? null : _reset,
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
                      : Text(s.resetPassword,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500)),
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