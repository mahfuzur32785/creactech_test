import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tests/core/data/remote_data_source.dart';
import 'package:tests/core/error/remote_name.dart';
import 'package:tests/screen/home/controller/home_controller_cubit.dart';
import 'package:tests/screen/home/home_screen.dart';
import 'package:http/http.dart';
import 'package:tests/screen/home/repository/home_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        ///network client
        RepositoryProvider<Client>(
          create: (context) => Client(),
        ),

        ///data source repository
        RepositoryProvider<RemoteDataSource>(
          create: (context) => RemoteDataSourceImpl(client: context.read()),
        ),

        ///Main Functionality
        RepositoryProvider<HomeRepository>(
          create: (context) => HomeRepositoryImp(
              remoteDataSource: context.read()
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<HomeControllerCubit>(
            create: (BuildContext context) => HomeControllerCubit(context.read()),
          ),
        ],
        child: BlocBuilder<HomeControllerCubit, HomeControllerState> (
            builder: (context, localeState) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                onGenerateRoute: RouteNames.generateRoute,
                initialRoute: RouteNames.splashScreen,
                onUnknownRoute: (RouteSettings settings) {
                  return MaterialPageRoute(
                    builder: (_) => Scaffold(
                      body: Center(
                        child: Text('No route defined for ${settings.name}'),
                      ),
                    ),
                  );
                },
                builder: (context, child) {
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                    child: child!,
                  );
                },
              );
            }
        ),
      ),
    );
  }
}