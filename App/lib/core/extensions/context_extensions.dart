import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  // Theme 관련
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;
  
  // MediaQuery 관련
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get screenSize => mediaQuery.size;
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;
  EdgeInsets get padding => mediaQuery.padding;
  EdgeInsets get viewInsets => mediaQuery.viewInsets;
  double get devicePixelRatio => mediaQuery.devicePixelRatio;
  
  // Navigation 관련
  NavigatorState get navigator => Navigator.of(this);
  bool get canPop => navigator.canPop();
  
  void pop<T>([T? result]) => navigator.pop(result);
  
  Future<T?> push<T>(Route<T> route) => navigator.push(route);
  
  Future<T?> pushNamed<T>(String routeName, {Object? arguments}) =>
      navigator.pushNamed(routeName, arguments: arguments);
  
  Future<T?> pushReplacement<T, TO>(Route<T> newRoute, {TO? result}) =>
      navigator.pushReplacement(newRoute, result: result);
  
  Future<T?> pushReplacementNamed<T, TO>(String routeName, {TO? result, Object? arguments}) =>
      navigator.pushReplacementNamed(routeName, result: result, arguments: arguments);
  
  Future<T?> pushAndRemoveUntil<T>(Route<T> newRoute, bool Function(Route<dynamic>) predicate) =>
      navigator.pushAndRemoveUntil(newRoute, predicate);
  
  void popUntil(bool Function(Route<dynamic>) predicate) =>
      navigator.popUntil(predicate);

  // SnackBar 관련
  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);
  
  void showSnackBar(String message, {
    Duration duration = const Duration(seconds: 3),
    Color? backgroundColor,
    Color? textColor,
    SnackBarAction? action,
  }) {
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: textColor),
        ),
        duration: duration,
        backgroundColor: backgroundColor,
        action: action,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
  
  void showSuccessSnackBar(String message) {
    showSnackBar(
      message,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }
  
  void showErrorSnackBar(String message) {
    showSnackBar(
      message,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      duration: const Duration(seconds: 5),
    );
  }
  
  void showWarningSnackBar(String message) {
    showSnackBar(
      message,
      backgroundColor: Colors.orange,
      textColor: Colors.white,
    );
  }
  
  void showInfoSnackBar(String message) {
    showSnackBar(
      message,
      backgroundColor: colorScheme.primary,
      textColor: Colors.white,
    );
  }

  // Dialog 관련
  Future<T?> showCustomDialog<T>(Widget dialog) {
    return showDialog<T>(
      context: this,
      builder: (context) => dialog,
    );
  }
  
  Future<bool?> showConfirmDialog({
    required String title,
    required String content,
    String confirmText = '확인',
    String cancelText = '취소',
    Color? confirmColor,
  }) {
    return showDialog<bool>(
      context: this,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(cancelText),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: confirmColor != null
                ? ElevatedButton.styleFrom(backgroundColor: confirmColor)
                : null,
            child: Text(confirmText),
          ),
        ],
      ),
    );
  }
  
  Future<String?> showInputDialog({
    required String title,
    String? hintText,
    String? initialValue,
    String confirmText = '확인',
    String cancelText = '취소',
    String? Function(String?)? validator,
  }) {
    final controller = TextEditingController(text: initialValue);
    final formKey = GlobalKey<FormState>();
    
    return showDialog<String>(
      context: this,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Form(
          key: formKey,
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(hintText: hintText),
            validator: validator,
            autofocus: true,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(cancelText),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState?.validate() ?? false) {
                Navigator.of(context).pop(controller.text);
              }
            },
            child: Text(confirmText),
          ),
        ],
      ),
    );
  }

  // BottomSheet 관련
  Future<T?> showCustomBottomSheet<T>(Widget child, {
    bool isScrollControlled = false,
    bool enableDrag = true,
    bool isDismissible = true,
  }) {
    return showModalBottomSheet<T>(
      context: this,
      isScrollControlled: isScrollControlled,
      enableDrag: enableDrag,
      isDismissible: isDismissible,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: child,
      ),
    );
  }

  // FocusScope 관련
  FocusScopeNode get focusScope => FocusScope.of(this);
  
  void hideKeyboard() => focusScope.unfocus();
  
  void requestFocus(FocusNode focusNode) => focusScope.requestFocus(focusNode);

  // 반응형 디자인 헬퍼
  bool get isMobile => screenWidth < 600;
  bool get isTablet => screenWidth >= 600 && screenWidth < 1200;
  bool get isDesktop => screenWidth >= 1200;
  bool get isSmallScreen => screenHeight < 600;
  
  double get safeAreaHeight => screenHeight - padding.top - padding.bottom;
  double get safeAreaWidth => screenWidth - padding.left - padding.right;
  
  // 방향 확인
  bool get isPortrait => screenHeight > screenWidth;
  bool get isLandscape => screenWidth > screenHeight;
  
  // 시스템 바 높이
  double get statusBarHeight => padding.top;
  double get bottomBarHeight => padding.bottom;
  
  // 키보드 높이
  double get keyboardHeight => viewInsets.bottom;
  bool get isKeyboardVisible => keyboardHeight > 0;

  // 색상 헬퍼
  Color get primaryColor => colorScheme.primary;
  Color get secondaryColor => colorScheme.secondary;
  Color get backgroundColor => colorScheme.background;
  Color get surfaceColor => colorScheme.surface;
  Color get errorColor => colorScheme.error;
  
  // 텍스트 스타일 헬퍼
  TextStyle? get headlineLarge => textTheme.headlineLarge;
  TextStyle? get headlineMedium => textTheme.headlineMedium;
  TextStyle? get headlineSmall => textTheme.headlineSmall;
  TextStyle? get titleLarge => textTheme.titleLarge;
  TextStyle? get titleMedium => textTheme.titleMedium;
  TextStyle? get titleSmall => textTheme.titleSmall;
  TextStyle? get bodyLarge => textTheme.bodyLarge;
  TextStyle? get bodyMedium => textTheme.bodyMedium;
  TextStyle? get bodySmall => textTheme.bodySmall;
  TextStyle? get labelLarge => textTheme.labelLarge;
  TextStyle? get labelMedium => textTheme.labelMedium;
  TextStyle? get labelSmall => textTheme.labelSmall;

  // 로딩 오버레이
  void showLoadingOverlay() {
    showDialog(
      context: this,
      barrierDismissible: false,
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
  
  void hideLoadingOverlay() {
    if (Navigator.of(this).canPop()) {
      Navigator.of(this).pop();
    }
  }

  // 토스트 메시지 (간단한 스낵바)
  void showToast(String message) {
    showSnackBar(
      message,
      duration: const Duration(seconds: 2),
    );
  }

  // 네트워크 오류 처리
  void showNetworkError() {
    showErrorSnackBar('네트워크 연결을 확인해주세요');
  }
  
  void showServerError() {
    showErrorSnackBar('서버 오류가 발생했습니다');
  }
  
  void showUnknownError() {
    showErrorSnackBar('알 수 없는 오류가 발생했습니다');
  }

  // 진동
  void vibrate() {
    HapticFeedback.lightImpact();
  }
  
  void vibrateLight() {
    HapticFeedback.lightImpact();
  }
  
  void vibrateMedium() {
    HapticFeedback.mediumImpact();
  }
  
  void vibrateHeavy() {
    HapticFeedback.heavyImpact();
  }
  
  void vibrateSelection() {
    HapticFeedback.selectionClick();
  }
}
