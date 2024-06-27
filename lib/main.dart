import 'package:flutter/material.dart';
import 'package:mocktest/bloc/bookdetail/book_detail_bloc.dart';
import 'package:mocktest/bloc/preview_audio/preview_audio_bloc.dart';
import 'package:mocktest/screens/book_detail_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mocktest/services/logger.dart';
// import 'package:mocktest/widgets/must_buy_dilog.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BookDetailBloc(),
        ),
        BlocProvider(
          create: (context) => PreviewAudioBloc(),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Mock Test',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const BookDetailScreen(id: 96  ,),
        // builder: ,
      ),
    );
  }
}
