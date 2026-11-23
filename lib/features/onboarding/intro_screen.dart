import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/app_assets.dart';
import '../../core/utils/app_strings.dart';
import '../auth/login_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;
  final int _count = 3;

  String _image(int index, bool isDark) {
    final light = [
      AppAssets.onBoardingLight1,
      AppAssets.onBoardingLight2,
      AppAssets.onBoardingLight3,
    ];
    final dark = [
      AppAssets.onBoardingDark1,
      AppAssets.onBoardingDark2,
      AppAssets.onBoardingDark3,
    ];
    return isDark ? dark[index] : light[index];
  }

  String _title(AppStrings s, int index) {
    switch (index) {
      case 0:
        return s.intro1Title;
      case 1:
        return s.intro2Title;
      default:
        return s.intro3Title;
    }
  }

  String _desc(AppStrings s, int index) {
    switch (index) {
      case 0:
        return s.intro1Desc;
      case 1:
        return s.intro2Desc;
      default:
        return s.intro3Desc;
    }
  }

  void _next() {
    if (_currentPage == _count - 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
      return;
    }
    _controller.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _back() {
    _controller.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _skip() {
    _controller.animateToPage(
      _count - 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final mainColor =
    isDark ? AppColors.mainDarkColor : AppColors.mainLightColor;
    final isLast = _currentPage == _count - 1;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 12),
              SizedBox(
                height: 36,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 60,
                      child: _currentPage > 0
                          ? Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: GestureDetector(
                          onTap: _back,
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
                      )
                          : null,
                    ),
                    Image.asset(
                      isDark ? AppAssets.logoDark : AppAssets.logoLight,
                      height: 28,
                    ),
                    SizedBox(
                      width: 60,
                      child: !isLast
                          ? Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: GestureDetector(
                          onTap: _skip,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? AppColors.darkInputColor
                                  : AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(s.skip,
                                style: TextStyle(
                                    fontSize: 12, color: mainColor)),
                          ),
                        ),
                      )
                          : null,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: _count,
                  onPageChanged: (i) => setState(() => _currentPage = i),
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Center(
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(vertical: 16),
                              child: Image.asset(
                                _image(index, isDark),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          _title(s, index),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: mainColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _desc(s, index),
                          style: TextStyle(
                            fontSize: 12,
                            height: 1.5,
                            color: isDark
                                ? AppColors.whiteDarkColor
                                : AppColors.greyColor,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_count, (i) {
                  final active = i == _currentPage;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: active ? 22 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: active ? mainColor : AppColors.lightGreyColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _next,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  child: Text(isLast ? s.getStarted : s.next,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500)),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}