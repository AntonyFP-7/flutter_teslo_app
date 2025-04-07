import 'package:formz/formz.dart';

enum NameError { empty, length }

class Name extends FormzInput<String, NameError> {
  const Name.pure() : super.pure('');
  const Name.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;
    if (displayError == NameError.empty) return 'El campo es requerido';
    if (displayError == NameError.length) return 'Mínimo 8 caracteres';

    return null;
  }

  @override
  NameError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return NameError.empty;
    if (value.length < 8) return NameError.length;
    return null;
  }
}
