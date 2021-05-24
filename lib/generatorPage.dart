import 'package:flutter/material.dart';
import 'package:qr_factory/qrGenerated.dart';

var alto = 0.1;
var boton = 0;

class GeneratorPage extends StatelessWidget {
  const GeneratorPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> _botones = [
      urlButton(context),
      wifiButton(context),
      telButton(context),
      wpButton(context)
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Generate a QR Code',
            style: TextStyle(color: Colors.black, fontSize: 20)),
        backgroundColor: Color(0xff3EC2C2),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Text(
                'Select a option to generate a QR',
                style: TextStyle(fontSize: 20, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          _botones[0],
          _botones[1],
          _botones[2],
          _botones[3],
        ],
      ),
    );
  }

  Widget urlButton(context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        height: MediaQuery.of(context).size.height * alto,
        color: Color(0xff3EC2C2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.link),
            Text(
              '  URL',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ],
        ),
        onPressed: () {
          boton = 0;
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => QrGenPage()));
        },
      ),
    );
  }

  Widget wifiButton(context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        height: MediaQuery.of(context).size.height * alto,
        color: Color(0xff3EC2C2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.wifi_rounded),
            Text(
              '  WI-FI',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ],
        ),
        onPressed: () {
          boton = 1;
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => QrGenPage()));
        },
      ),
    );
  }

  Widget telButton(context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        height: MediaQuery.of(context).size.height * alto,
        color: Color(0xff3EC2C2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.call_end_outlined),
            Text(
              '  NUMBER PHONE',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ],
        ),
        onPressed: () {
          boton = 2;
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => QrGenPage()));
        },
      ),
    );
  }

  Widget wpButton(context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        height: MediaQuery.of(context).size.height * alto,
        color: Color(0xff3EC2C2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.call_outlined),
            Text(
              '  WHATSAPP',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ],
        ),
        onPressed: () {
          boton = 3;
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => QrGenPage()));
        },
      ),
    );
  }
}
