import 'package:flutter/cupertino.dart';

class AuthRepository {
  Future<String> _getUserIdFromAttributes() async {
    try {
      final attributes = await Amplify.Auth.fetchUserAttributes();
      final userId = attributes
          .firstWhere((element) => element.userAttributeKey == 'sub')
          .value;

      return userId;
    } catch (e) {
      throw e;
    }
  }

  Future<String> attemptAutoLogin() async {
    try {
      final session = await Amplify.Auth.fetchAuthSession();

      return session.isSignedIn ? (await _getUserIdFromAttributes()) : null;
    } catch (e) {
      throw e;
    }
  }

  Future login({
    @required String username,
    @required String password,
  }) async {
    try {
      final result =
          await Amplify.Auth.signIn(username: username, password: password);

      return result.isSignedIn ? (await _getUserIdFromAttributes()) : null;
    } catch (e) {
      throw e;
    }
  }

  //   print('attempting login');
  //
  //   //3초동안 동그라미 로그인중..이라는 느낌
  //   await Future.delayed(Duration(seconds: 3));
  //   return 'abc';
  //
  //   // print('logged in');
  //   // throw Exception('failed log in');
  // }
//1
  Future<bool> signUp({
    @required String username,
    @required String email,
    @required String password,
  }) async {
    final options =
        CognitoSignUpOptions(userAttributes: {'email': email.trim()});
    try {
      final result = await Amplify.Auth.signUp(
        username: username.trim(),
        password: password.trim(),
        options: options,
      );
      return result.isSignUpComplete;
    } catch (e) {
      throw e;
    }
    // await Future.delayed(Duration(seconds: 2));
  }

//2
  Future<bool> confirmSingUp({
    @required String username,
    @required String confirmationCode,
  }) async {
    try {
      final result = await Amplify.Auth.confirmSignUp(
        username: username.trim(),
        confirmationCode: confirmationCode.trim(),
      );
      return result.isSignUpComplete;
    } catch (e) {
      throw e;
    }
  }
  // await Future.delayed(Duration(seconds: 2));
  // return 'abc';

  // }

  Future<void> signOut() async {
    await Amplify.Auth.signOut();
  }
}
