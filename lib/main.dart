import 'package:flutter/material.dart';
import 'scannerPage.dart';
import 'generatorPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentPage = 0;

  List<Widget> _pages = [
    ScannerPage(),
    GeneratorPage()
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Factory',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _pages[_currentPage],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black54,
                blurRadius: 15.0,
                offset: Offset(0.0, 0.75)
            )
          ],
        ),
          child: BottomNavigationBar(
            onTap: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            currentIndex: _currentPage,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.qr_code_scanner), label: 'Scan'),
              BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: 'Create'),
            ],
            
            backgroundColor: Color(0xff3EC2C2),
            selectedItemColor: Colors.black,
            iconSize: 30,
          ),
        ),
      ),
    );
  }
}
