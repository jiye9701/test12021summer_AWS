import 'package:flutter/cupertino.dart';

import 'models/User2.dart';

abstract class SessionState {}

class UnknownSessionState extends SessionState {}

class Unauthenticated extends SessionState {}

class Authenticated extends SessionState {
  final User2 user;
  Authenticated({@required this.user});
}
