import '../constants/app_constants.dart';

class Validators {
  // 이메일 유효성 검사
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return '이메일을 입력해주세요';
    }
    
    if (!RegExp(AppConstants.emailPattern).hasMatch(value)) {
      return '올바른 이메일 형식이 아닙니다';
    }
    
    return null;
  }

  // 사용자명 유효성 검사
  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return '사용자명을 입력해주세요';
    }
    
    if (value.length < AppConstants.minUsernameLength) {
      return '사용자명은 ${AppConstants.minUsernameLength}자리 이상이어야 합니다';
    }
    
    if (value.length > AppConstants.maxUsernameLength) {
      return '사용자명은 ${AppConstants.maxUsernameLength}자리 이하여야 합니다';
    }
    
    if (!RegExp(AppConstants.usernamePattern).hasMatch(value)) {
      return '사용자명은 영문, 숫자, _만 사용할 수 있습니다';
    }
    
    return null;
  }

  // 비밀번호 유효성 검사
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return '비밀번호를 입력해주세요';
    }
    
    if (value.length < AppConstants.minPasswordLength) {
      return '비밀번호는 ${AppConstants.minPasswordLength}자리 이상이어야 합니다';
    }
    
    if (value.length > AppConstants.maxPasswordLength) {
      return '비밀번호는 ${AppConstants.maxPasswordLength}자리 이하여야 합니다';
    }
    
    return null;
  }

  // 비밀번호 확인 유효성 검사
  static String? validatePasswordConfirm(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return '비밀번호 확인을 입력해주세요';
    }
    
    if (value != password) {
      return '비밀번호가 일치하지 않습니다';
    }
    
    return null;
  }

  // 방 이름 유효성 검사
  static String? validateRoomName(String? value) {
    if (value == null || value.isEmpty) {
      return '방 이름을 입력해주세요';
    }
    
    if (value.length > AppConstants.maxRoomNameLength) {
      return '방 이름은 ${AppConstants.maxRoomNameLength}자리 이하여야 합니다';
    }
    
    // 특수문자 제한
    if (RegExp(r'[<>:"/\\|?*]').hasMatch(value)) {
      return '방 이름에 특수문자를 사용할 수 없습니다';
    }
    
    return null;
  }

  // 채팅 메시지 유효성 검사
  static String? validateChatMessage(String? value) {
    if (value == null || value.isEmpty) {
      return '메시지를 입력해주세요';
    }
    
    if (value.length > AppConstants.maxChatMessageLength) {
      return '메시지는 ${AppConstants.maxChatMessageLength}자리 이하여야 합니다';
    }
    
    // 스팸 방지를 위한 연속 문자 체크
    if (RegExp(r'(.)\1{4,}').hasMatch(value)) {
      return '동일한 문자를 5번 이상 연속으로 사용할 수 없습니다';
    }
    
    return null;
  }

  // 숫자 범위 유효성 검사
  static String? validateNumberRange(String? value, int min, int max, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName을 입력해주세요';
    }
    
    final number = int.tryParse(value);
    if (number == null) {
      return '올바른 숫자를 입력해주세요';
    }
    
    if (number < min || number > max) {
      return '$fieldName은 $min~$max 사이의 값이어야 합니다';
    }
    
    return null;
  }

  // 필수 필드 유효성 검사
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName을 입력해주세요';
    }
    return null;
  }

  // 최소 길이 유효성 검사
  static String? validateMinLength(String? value, int minLength, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName을 입력해주세요';
    }
    
    if (value.length < minLength) {
      return '$fieldName은 $minLength자리 이상이어야 합니다';
    }
    
    return null;
  }

  // 최대 길이 유효성 검사
  static String? validateMaxLength(String? value, int maxLength, String fieldName) {
    if (value != null && value.length > maxLength) {
      return '$fieldName은 $maxLength자리 이하여야 합니다';
    }
    
    return null;
  }

  // URL 유효성 검사
  static String? validateUrl(String? value) {
    if (value == null || value.isEmpty) {
      return null; // URL은 선택사항
    }
    
    try {
      final uri = Uri.parse(value);
      if (!uri.hasScheme || !uri.hasAuthority) {
        return '올바른 URL 형식이 아닙니다';
      }
    } catch (e) {
      return '올바른 URL 형식이 아닙니다';
    }
    
    return null;
  }

  // 게임 설정 유효성 검사
  static String? validateDAS(String? value) {
    return validateNumberRange(value, 50, 500, 'DAS');
  }

  static String? validateARR(String? value) {
    return validateNumberRange(value, 0, 100, 'ARR');
  }

  static String? validateVolume(double? value) {
    if (value == null) return '볼륨 값이 필요합니다';
    if (value < 0.0 || value > 1.0) return '볼륨은 0과 1 사이의 값이어야 합니다';
    return null;
  }

  // 조합 유효성 검사기
  static String? Function(String?) combine(List<String? Function(String?)> validators) {
    return (String? value) {
      for (final validator in validators) {
        final result = validator(value);
        if (result != null) {
          return result;
        }
      }
      return null;
    };
  }

  // 조건부 유효성 검사기
  static String? Function(String?) conditional(
    bool Function() condition,
    String? Function(String?) validator,
  ) {
    return (String? value) {
      if (condition()) {
        return validator(value);
      }
      return null;
    };
  }
}

// 실시간 유효성 검사를 위한 헬퍼 클래스
class FormValidator {
  final Map<String, String?> _errors = {};
  final Map<String, String? Function(String?)> _validators = {};

  void addValidator(String field, String? Function(String?) validator) {
    _validators[field] = validator;
  }

  String? validate(String field, String? value) {
    final validator = _validators[field];
    if (validator != null) {
      final error = validator(value);
      _errors[field] = error;
      return error;
    }
    return null;
  }

  bool isValid() {
    return _errors.values.every((error) => error == null);
  }

  String? getError(String field) {
    return _errors[field];
  }

  void clearError(String field) {
    _errors[field] = null;
  }

  void clearAllErrors() {
    _errors.clear();
  }

  Map<String, String?> get errors => Map.unmodifiable(_errors);
}
