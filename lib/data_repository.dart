import 'package:amplify_flutter/amplify.dart';
import 'package:test12021summer_jiyeyu/models/ModelProvider.dart';

class DataRepository {
  Future<User2> getUserById(String userId) async {
    try {
      final users = await Amplify.DataStore.query(
        User2.classType,
        where: User2.ID.eq(userId),
      );
      return users.isNotEmpty ? users.first : null;
    } catch (e) {
      throw e;
    }
  }

  Future<User2> createUser(
    String userId,
    String username,
    String email,
  ) async {
    final newUser = User2(
        id: userId,
        username: username,
        email: email);
    try {
      await Amplify.DataStore.save(newUser);
      return newUser;
    } catch (e) {
      throw e;
    }
  }
}
