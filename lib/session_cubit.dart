import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test12021summer_jiyeyu/auth/auth_credentials.dart';
import 'package:test12021summer_jiyeyu/auth/auth_repository.dart';
import 'package:test12021summer_jiyeyu/session_state.dart';

import 'data_repository.dart';
import 'session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  final AuthRepository authRepo;
  final DataRepository dataRepo;

  SessionCubit({
    @required this.authRepo,
    @required this.dataRepo,
  }) : super(UnknownSessionState()) {
    attemptAutoLogin();
  }

  void attemptAutoLogin() async {
    try {
      final session = await Amplify.Auth.fetchAuthSession();
      if (userId == null) {
        throw Exception('User not logged in');
      }

      User user = await dataRepo.getUserById(userId);
      if (user == null) {
        user = await dataRepo.createUser(
          userId: userId,
          username: 'User-${UUID()}',
        );
      }
      emit(Authenticated(user: user));
    } on Exception {
      emit(Unauthenticated());
    }
  }

  void showAuth() => emit(Unauthenticated());
  void showSession(AuthCredentials credentials) async{
    // final user = dataRep.getUser(credentials.userId); --later
    try{
      User user await dataRepo.getUserById(credentials.userId);
      
      if (user ==null)
      {
        user = await dataRepo.createUser(
          userId: credentials.userId,
          name: credentials.username,
          email: credentials.email,
          );
      }
    emit(Authenticated(user: user));
  } catch (e)
  {
    emit (Unauthenticated());
    
    }
  }

  void signOut() {
    authRepo.signOut();
    emit(Unauthenticated());
  }
}
