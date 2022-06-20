import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habitos/screens/auth_screen.dart';
import 'package:habitos/screens/portafolio_screen.dart';
import 'package:habitos/screens/verify_email_screen.dart';
import 'package:habitos/services/alertas.dart';
import 'package:habitos/widgets/utils.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Alertas.initializeApp();

  runApp(Habitos());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Habitos extends StatefulWidget {
  @override
  State<Habitos> createState() => _HabitosState();
}

class _HabitosState extends State<Habitos> {
  @override
  void initState() {
    super.initState();
    Alertas.messageStream.listen((message) {
      navigatorKey.currentState
          ?.push(MaterialPageRoute(builder: (context) => PortafolioScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: Utils.messengerKey,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text('¡Algo ha salido mal! Intente de nuevo'),
              );
            } else if (snapshot.hasData) {
              return VerifyEmailScreen();
            } else {
              return AuthScreen();
            }
          },
        ),
      ),
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[300],
        appBarTheme: const AppBarTheme(elevation: 0, color: Colors.indigo),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.indigo, elevation: 0),
      ),
    );
  }
}
