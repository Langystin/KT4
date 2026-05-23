import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CounterPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage>
    with SingleTickerProviderStateMixin {
  int _counter = 0;
  double _fontSize = 64;
  late final SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  Future<void> _loadCounter() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = _prefs.getInt('counter') ?? 0;
    });
  }

  Future<void> _incrementCounter() async {
    setState(() {
      _counter++;
      _fontSize = 90;
    });

    await _prefs.setInt('counter', _counter);

    // Вернуть размер через 150 мс
    Future.delayed(const Duration(milliseconds: 150), () {
      setState(() {
        _fontSize = 64;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: GestureDetector(
          onTap: _incrementCounter,
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeOut,
            style: TextStyle(
              fontSize: _fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
            child: Text('$_counter'),
          ),
        ),
      ),
    );
  }
}
