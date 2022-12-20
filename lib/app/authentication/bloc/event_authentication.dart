abstract class AuthenticationEvent {}

class StatusChanged extends AuthenticationEvent {
  StatusChanged({required this.status});
  String status;
}

class LogoutRequest extends AuthenticationEvent {}
