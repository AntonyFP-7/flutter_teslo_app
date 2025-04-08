import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:teslo_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:teslo_app/features/shared/shared.dart';

final registerFormProvider =
    StateNotifierProvider.autoDispose<RegisterFormNotifier, RegisterFormState>(
        (ref) {
  final registerUserCallback = ref.watch(authProvider.notifier).registerUser;
  return RegisterFormNotifier(registerUserCallback: registerUserCallback);
});

class RegisterFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Name name;
  final Email email;
  final Password password;
  final Password confirmPassword;

  RegisterFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.name = const Name.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmPassword = const Password.pure(),
  });

  RegisterFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    Name? name,
    Email? email,
    Password? password,
    Password? confirmPassword,
  }) =>
      RegisterFormState(
          isPosting: isPosting ?? this.isPosting,
          isFormPosted: isFormPosted ?? this.isFormPosted,
          isValid: isValid ?? this.isValid,
          name: name ?? this.name,
          email: email ?? this.email,
          password: password ?? this.password,
          confirmPassword: confirmPassword ?? this.confirmPassword);
}

class RegisterFormNotifier extends StateNotifier<RegisterFormState> {
  final Function(String, String, String) registerUserCallback;
  RegisterFormNotifier({
    required this.registerUserCallback,
  }) : super(RegisterFormState());

  onNameChange(String value) {
    final newName = Name.dirty(value);
    state = state.copyWith(
        name: newName,
        isValid: Formz.validate([
          newName,
          state.email,
          state.password,
          state.confirmPassword,
        ]));
  }

  onEmailChange(String value) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
        email: newEmail,
        isValid: Formz.validate([
          state.name,
          newEmail,
          state.password,
          state.confirmPassword,
        ]));
  }

  onPasswordChange(String value) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(
        password: newPassword,
        isValid: Formz.validate([
          state.name,
          state.email,
          newPassword,
          state.confirmPassword,
        ]));
  }

  onconfirmPasswordChange(String value) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(
        confirmPassword: newPassword,
        isValid: Formz.validate([
          state.name,
          state.email,
          state.password,
          newPassword,
        ]));
  }

  onFormSubmit() async {
    _touchEveryField();
    if (!state.isValid) return;
    //print(state);
    await registerUserCallback(
      state.email.value,
      state.password.value,
      state.name.value,
    );
  }

  _touchEveryField() {
    final name = Name.dirty(state.name.value);
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    final confirmPassword = Password.dirty(state.confirmPassword.value);
    state = state.copyWith(
      isFormPosted: true,
      name: name,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      isValid: Formz.validate([
        name,
        email,
        password,
        confirmPassword,
      ]),
    );
  }
}
