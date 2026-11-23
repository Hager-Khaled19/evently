import 'package:flutter/material.dart';

class AppStrings {
  final String code;

  AppStrings(this.code);

  static AppStrings of(BuildContext context) {
    final locale = Localizations.localeOf(context);
    return AppStrings(locale.languageCode);
  }

  String _t(String en, String ar) => code == 'ar' ? ar : en;

  String get personalizeTitle =>
      _t('Personalize Your Experience', 'خصص تجربتك');
  String get personalizeDesc => _t(
    'Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.',
    'اختر الثيم واللغة المفضلين لديك لتبدأ تجربة مريحة ومصممة لتناسب أسلوبك.',
  );
  String get language => _t('Language', 'اللغة');
  String get theme => _t('Theme', 'المظهر');
  String get english => _t('English', 'English');
  String get arabic => _t('Arabic', 'العربية');
  String get letsStart => _t("Let's start", 'هيا نبدأ');

  String get skip => _t('Skip', 'تخطي');
  String get next => _t('Next', 'التالي');
  String get getStarted => _t('Get started', 'ابدأ الآن');

  String get intro1Title =>
      _t('Find Events That Inspire You', 'اكتشف فعاليات تلهمك');
  String get intro1Desc => _t(
    'Dive into a world of events crafted to fit your unique interests. Whether you\'re into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.',
    'انغمس في عالم من الفعاليات المصممة لتناسب اهتماماتك الخاصة. سواء كنت تحب الموسيقى الحية أو ورش الفن أو التواصل المهني أو اكتشاف تجارب جديدة، لدينا ما يناسب الجميع. توصياتنا المختارة ستساعدك على الاستكشاف والتواصل والاستفادة من كل فرصة حولك.',
  );

  String get intro2Title =>
      _t('Effortless Event Planning', 'تخطيط الفعاليات بكل سهولة');
  String get intro2Desc => _t(
    'Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we\'ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.',
    'تخلص من عناء تنظيم الفعاليات مع أدوات التخطيط المتكاملة لدينا. من إعداد الدعوات وإدارة الردود إلى جدولة التذكيرات وتنسيق التفاصيل، نحن نوفر لك كل ما تحتاجه. خطط بسهولة وركز على ما يهم، وهو صنع تجربة لا تُنسى لك ولضيوفك.',
  );

  String get intro3Title => _t(
    'Connect with Friends & Share Moments',
    'تواصل مع الأصدقاء وشارك اللحظات',
  );
  String get intro3Desc => _t(
    'Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.',
    'اجعل كل فعالية لا تُنسى بمشاركة التجربة مع الآخرين. تتيح لك منصتنا دعوة الأصدقاء وإبقاء الجميع على اطلاع والاحتفال باللحظات معاً. التقط وشارك الحماس مع شبكتك لتعيش أبرز اللحظات وتحتفظ بالذكريات.',
  );

  String get loginTitle => _t('Login to your account', 'سجل الدخول إلى حسابك');
  String get enterEmail => _t('Enter your email', 'أدخل بريدك الإلكتروني');
  String get enterPassword => _t('Enter your password', 'أدخل كلمة المرور');
  String get forgetPassword => _t('Forget Password?', 'نسيت كلمة المرور؟');
  String get login => _t('Login', 'تسجيل الدخول');
  String get noAccount => _t("Don't have an account ? ", 'ليس لديك حساب؟ ');
  String get signup => _t('Signup', 'إنشاء حساب');
  String get or => _t('Or', 'أو');
  String get loginWithGoogle =>
      _t('Login with Google', 'تسجيل الدخول عبر جوجل');

  String get registerTitle => _t('Create your account', 'أنشئ حسابك');
  String get enterName => _t('Enter your name', 'أدخل اسمك');
  String get confirmPassword =>
      _t('Confirm your password', 'أكد كلمة المرور');
  String get signUpButton => _t('Sign up', 'إنشاء حساب');
  String get haveAccount =>
      _t('Already have an account? ', 'لديك حساب بالفعل؟ ');
  String get signUpWithGoogle =>
      _t('Sign up with Google', 'التسجيل عبر جوجل');

  String get forgetPasswordTitle => _t('Forget Password', 'نسيت كلمة المرور');
  String get resetPassword => _t('Reset password', 'إعادة تعيين كلمة المرور');

  String get welcomeBack => _t('Welcome Back ✨', 'مرحباً بعودتك ✨');
  String get noEvents => _t('No events', 'لا توجد فعاليات');
  String get noFavourites =>
      _t('No favourite events', 'لا توجد فعاليات مفضلة');
  String get searchEvent => _t('Search for event', 'ابحث عن فعالية');

  String get navHome => _t('Home', 'الرئيسية');
  String get navFavourite => _t('Favorite', 'المفضلة');
  String get navProfile => _t('profile', 'الملف الشخصي');

  String get darkMode => _t('Dark mode', 'الوضع الداكن');
  String get logout => _t('Logout', 'تسجيل الخروج');
  String get user => _t('User', 'مستخدم');

  String get addEvent => _t('Add event', 'إضافة فعالية');
  String get editEvent => _t('Edit event', 'تعديل الفعالية');
  String get updateEvent => _t('Update event', 'تحديث الفعالية');
  String get eventDetails => _t('Event details', 'تفاصيل الفعالية');
  String get title => _t('Title', 'العنوان');
  String get eventTitle => _t('Event Title', 'عنوان الفعالية');
  String get description => _t('Description', 'الوصف');
  String get eventDescription =>
      _t('Event Description...', 'وصف الفعالية...');
  String get eventDate => _t('Event Date', 'تاريخ الفعالية');
  String get eventTime => _t('Event Time', 'وقت الفعالية');
  String get chooseDate => _t('Choose date', 'اختر التاريخ');
  String get chooseTime => _t('Choose time', 'اختر الوقت');

  String get pleaseEnterTitle =>
      _t('Please enter event title', 'من فضلك أدخل عنوان الفعالية');
  String get pleaseEnterDesc =>
      _t('Please enter event description', 'من فضلك أدخل وصف الفعالية');
  String get pleaseChooseDate =>
      _t('Please choose event date', 'من فضلك اختر تاريخ الفعالية');
  String get pleaseChooseTime =>
      _t('Please choose event time', 'من فضلك اختر وقت الفعالية');

  String get catAll => _t('All', 'الكل');
  String get catSport => _t('Sport', 'رياضة');
  String get catBirthday => _t('Birthday', 'عيد ميلاد');
  String get catMeeting => _t('Meeting', 'اجتماع');
  String get catExhibition => _t('Exhibition', 'معرض');
  String get catBookClub => _t('Book Club', 'نادي الكتاب');

  String category(String key) {
    switch (key) {
      case 'All':
        return catAll;
      case 'Sport':
        return catSport;
      case 'Birthday':
        return catBirthday;
      case 'Meeting':
        return catMeeting;
      case 'Exhibition':
        return catExhibition;
      case 'Book Club':
        return catBookClub;
      default:
        return key;
    }
  }

  List<String> get months => code == 'ar'
      ? [
    'يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو',
    'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر'
  ]
      : [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];

  List<String> get monthsFull => code == 'ar'
      ? months
      : [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  String get fillAll => _t('Please fill all fields', 'من فضلك املأ كل الحقول');
  String get passwordsNotMatch =>
      _t('Passwords do not match', 'كلمتا المرور غير متطابقتين');
  String get enterEmailFirst =>
      _t('Enter your email first', 'أدخل بريدك الإلكتروني أولاً');
  String get resetSent => _t('Password reset email sent. Check your inbox.',
      'تم إرسال رابط إعادة تعيين كلمة المرور. تحقق من بريدك.');

  String authError(String code) {
    switch (code) {
      case 'email-already-in-use':
        return _t('This email is already registered',
            'هذا البريد مسجل بالفعل');
      case 'invalid-email':
        return _t('Invalid email', 'بريد إلكتروني غير صحيح');
      case 'weak-password':
        return _t('Password must be at least 6 characters',
            'كلمة المرور يجب ألا تقل عن 6 أحرف');
      case 'wrong-credentials':
        return _t('Wrong email or password',
            'البريد أو كلمة المرور غير صحيحة');
      case 'network-request-failed':
        return _t('No internet connection', 'لا يوجد اتصال بالإنترنت');
      case 'cancelled':
        return _t('Sign in cancelled', 'تم إلغاء تسجيل الدخول');
      default:
        return _t('Something went wrong', 'حدث خطأ ما');
    }
  }
}