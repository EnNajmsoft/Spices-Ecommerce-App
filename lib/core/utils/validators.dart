import 'package:form_field_validator/form_field_validator.dart';

class Validators {
  /// Email Validator
  static final email =
      EmailValidator(errorText: 'أدخل بريدًا إلكترونيًا صالحًا');

  /// Password Validator
  static final password = MultiValidator([
    RequiredValidator(errorText: 'كلمة المرور مطلوبة'),
    MinLengthValidator(8,
        errorText: 'يجب أن تتكون كلمة المرور من 8 أرقام على الأقل'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'يجب أن تحتوي كلمات المرور على حرف خاص واحد على الأقل')
  ]);

  /// Required Validator with Optional Field Name
  static RequiredValidator requiredWithFieldName(String? fieldName) =>
      RequiredValidator(errorText: '${fieldName ?? 'الحقل'} مطلوب');

  /// Plain Required Validator
  static final required = RequiredValidator(errorText: 'الحقل مطلوب');

  /// Yemeni Phone Number Validator
  static final yemeniPhoneNumber = PatternValidator(
      r'^(77|78|70|71|73)\d{7}$',
      errorText:
          'أدخل رقم هاتف يمني صحيح (9 أرقام ويبدأ بـ 77، 78، 70، 71، 73، )');
}
