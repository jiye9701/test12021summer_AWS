import 'package:amplify_flutter/amplify.dart';
import 'package:test12021summer_jiyeyu/models/ModelProvider.dart';

class DataRepository {
  Future<User> getUserById(String userId) async {
    try {
      final users = await Amplify.DataStore.query(
        User.classType,
        where: User.ID.eq(userId),
      );
      return users.isNotEmpty ? users.first : null;
    } catch (e) {
      throw e;
    }
  }

  Future<User> createUser(
    String userId,
    String name,
    String email,
  ) async {
    final newUser = User(id: userId, name: name, email: email);
    try {
      await Amplify.DataStore.save(newUser);
      return newUser;
    } catch (e) {
      throw e;
    }
  }
}
