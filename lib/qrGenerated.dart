import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

var valueQr = '';

class QrGenPage extends StatefulWidget {
  QrGenPage({Key key}) : super(key: key);

  @override
  _QrGenPageState createState() => _QrGenPageState();
}

class _QrGenPageState extends State<QrGenPage> {
  TextEditingController urlController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('QR Code for URL', style: TextStyle(color: Colors.black)),
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Color(0xff3EC2C2)),
      body: Center(
        child: Column(
          
          children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 25),
            child: Container(
              child: QrImage(data: valueQr),
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 10,
                    )
                  ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: TextField(
              controller: urlController,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.link,
                  color: Color(0xff3EC2C2),
                ),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff3EC2C2))),
                hintText: 'Enter a URL',
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Color(0xff3EC2C2),
                  child: Text('Generate'),
                  onPressed: () {
                    setState(() {
                      valueQr = urlController.text.toString();
                    });
                  }),
              MaterialButton(
                minWidth: 50,
                
                child: Icon(Icons.share),
                onPressed: () {},
              )
            ],
          ),
        ]),
      ),
    );
  }

  Widget qrImage() {
    if (valueQr != '')
      return QrImage(data: valueQr);
    else
      return Text('Hi');
  }

  void _generateImage() {}
}
