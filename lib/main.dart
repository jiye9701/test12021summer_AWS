import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test12021summer_jiyeyu/app_navigator.dart';
import 'package:test12021summer_jiyeyu/auth/auth_repository.dart';
import 'package:test12021summer_jiyeyu/session_cubit.dart';

import 'auth/auth_repository.dart';
import 'data_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isAmplifyConfigured = false;

  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: _isAmplifyConfigured
            ? MultiRepositoryProvider(
                providers: [
                  RepositoryProvider(create: (context) => AuthRepository()),
                  RepositoeyProvider(create: (context) => DataRepository())
                ],
                child: BlocProvider(
                  create: (context) => SessionCubit(
                    authRepo: context.read<AuthRepository>(),
                    dataRepo: context.read<DataRepository>(),
                  ),
                  child: AppNavigator(),
                ),
              )
            : LoadingView());
  }

  Future<void> _configureAmplify() async {
    try {
      await Amplify.addPlugins([
        AmplifyAuthCognito(),
        AmplifyDataStore(modelProvider: ModelProvider.instance),
        AmplifyAPI(),
      ]);

      await Amplify.addPlugins([
        AmplifyAuthCognito(),
        AmplifyDataStore(modelProvider: ModelProvider.instance),
        AmplifyAPI()
      ]);

      await Amplify.configure(amplifyconfig);
      setState(() => _isAmplifyConfigured = true);
    } catch (e) {
      print(e);
    }
  }
}
