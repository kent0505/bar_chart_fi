import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bottom/bottom_bloc.dart';
import 'bloc/inc/inc_bloc.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => IncBloc()..add(LoadInc())),
        BlocProvider(create: (context) => BottomBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            accentColor: Colors.greenAccent,
          ),
          useMaterial3: false,
        ),
        home: HomePage(),
      ),
    );
  }
}
