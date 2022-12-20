import 'package:formz/formz.dart';

enum PasswordError { empty, shortEntry }

class Password extends FormzInput<String, PasswordError> {
  const Password.pure() : super.pure('');

  const Password.dirty({String value = ''}) : super.dirty(value);

  @override
  PasswordError? validator(String value) {
    if (value.isEmpty) return PasswordError.empty;
    if (value.length < 3) return PasswordError.shortEntry;

    return null;
  }
}
