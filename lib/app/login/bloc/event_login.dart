abstract class LoginEvent {}

class UsernameChanged extends LoginEvent {
  UsernameChanged({required this.username});
  String username;
}

class PasswordChanged extends LoginEvent {
  PasswordChanged({required this.password});
  String password;
}

class FormSubmitted extends LoginEvent {
  FormSubmitted({required this.status});
  String status;
}
