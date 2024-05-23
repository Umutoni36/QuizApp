import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/components/auth_page.dart';
import 'package:my_app/components/bottom_nav.dart';
import 'package:my_app/components/drawer_items.dart';
import 'package:my_app/screens/calculator/about_screen.dart';
import 'package:my_app/screens/calculator/calculator_screen.dart';
import 'package:my_app/screens/home.dart/home_screen.dart';
import 'package:my_app/components/styles_data.dart';
import 'package:my_app/components/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'components/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings = Settings(
    persistenceEnabled: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeProvider themeChangeProvider = ThemeProvider();

  void getCurentTheme() async {
    themeChangeProvider.setDarkTheme = await themeChangeProvider.getTheme();
  }

  @override
  void initState() {
    getCurentTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return themeChangeProvider;
        })
      ],
      child: Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Calculator',
          theme: Styles.themeData(themeProvider.getDarkTheme, context),
          home: const AuthPage(),
        );
      }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key});
  final user = FirebaseAuth.instance.currentUser;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  late ConnectivityResult _connectionStatus;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  void initState() {
    super.initState();
    initConnectivity();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        _connectionStatus = result;
      });
      _showConnectionStatus();
    });
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result = await Connectivity().checkConnectivity();
    setState(() {
      _connectionStatus = result;
    });
  }

  void _showConnectionStatus() {
    String message;
    if (_connectionStatus == ConnectivityResult.none) {
      message = 'Loss of Connection';
    } else {
      message = 'Connection Restored';
    }
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    const CalculatorScreen(),
    const AboutScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: Color.fromARGB(150, 33, 149, 243),
        title: const Text('My Flutter App '),
      ),
      drawer: Drawer(
        child: DrawerItems(
          onItemSelected: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          selectedIndex: _selectedIndex,
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
