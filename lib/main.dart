import 'package:flutter/material.dart';
import 'helpers/user_info.dart';
import 'ui/login_page.dart';
import 'ui/inventaris_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsi 2 Mobile Paket 2 - H1D023069',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: MaterialColor(
          0xFF8da750,
          <int, Color>{
            50: const Color(0xFFf5f8f2),
            100: const Color(0xFFe6f0dc),
            200: const Color(0xFFcde1b9),
            300: const Color(0xFFb4d296),
            400: const Color(0xFFa0c773),
            500: const Color(0xFF8da750),
            600: const Color(0xFF7a9240),
            700: const Color(0xFF677d30),
            800: const Color(0xFF546820),
            900: const Color(0xFF415310),
          },
        ),
        scaffoldBackgroundColor: const Color(0xFFf5f8f2),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF8da750),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF537b2f),
          foregroundColor: Colors.white,
        ),
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF8da750), width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      home: const SplashCheck(),
    );
  }
}

class SplashCheck extends StatefulWidget {
  const SplashCheck({Key? key}) : super(key: key);

  @override
  State<SplashCheck> createState() => _SplashCheckState();
}

class _SplashCheckState extends State<SplashCheck> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 2));
    
    final token = await UserInfo.getToken();
    
    if (!mounted) return;
    
    if (token != null && token.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const InventarisPage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8da750),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Icon(
                Icons.shopping_basket,
                size: 80,
                color: Color(0xFF8da750),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Inventaris Bahan Makanan',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Khonsaa',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 40),
            const CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}