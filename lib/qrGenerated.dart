import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_factory/generatorPage.dart';

var valueQr = '';

class QrGenPage extends StatefulWidget {
  QrGenPage({Key key}) : super(key: key);

  @override
  _QrGenPageState createState() => _QrGenPageState();
}

class _QrGenPageState extends State<QrGenPage> {
  TextEditingController urlController = new TextEditingController();
  TextEditingController nameNetController = new TextEditingController();
  TextEditingController passNetController = new TextEditingController();
  TextEditingController countryControler = new TextEditingController();
  TextEditingController numController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('QR Code', style: TextStyle(color: Colors.black)),
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Color(0xff3EC2C2)),
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
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
            widgetQr(),
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
                        if (boton == 0) {
                          valueQr = urlController.text.toString();
                        } else if (boton == 1) {
                          String red = 'WIFI:S:' +
                              nameNetController.text.toString() +
                              ';T:' +
                              dropValue +
                              ';P:' +
                              passNetController.text.toString() +
                              ';H:True;;';
                          valueQr = red;
                        } else if (boton == 2) {
                          String num = 'tel: +' +
                              countryControler.text.toString()+
                              numController.text.toString();
                          valueQr = num;
                        }
                        else if (boton == 3) {
                          String num = 'https://wa.me/' +
                              countryControler.text.toString()+
                              numController.text.toString();
                          valueQr = num;
                        }
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
      ),
    );
  }

  Widget qrImage() {
    if (valueQr != '')
      return QrImage(data: valueQr);
    else
      return Text('Hi');
  }

  Widget widgetQr() {
    if (boton == 0) {
      return qrURL();
    } else if (boton == 1) {
      return wifiURL();
    } else if (boton == 2 || boton == 3) {
      return telURL();
    }
  }

  Widget qrURL() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: TextField(
        controller: urlController,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.link,
            color: Color(0xff3EC2C2),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff3EC2C2))),
          hintText: 'Enter a URL',
        ),
      ),
    );
  }

  String dropValue = 'WPA';
  Widget wifiURL() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: TextField(
            controller: nameNetController,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.link,
                color: Color(0xff3EC2C2),
              ),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff3EC2C2))),
              hintText: 'Name of network',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: TextField(
            controller: passNetController,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.link,
                color: Color(0xff3EC2C2),
              ),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff3EC2C2))),
              hintText: 'Password of network',
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Type of security: '),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: DropdownButton<String>(
                  value: dropValue,
                  underline: Container(
                    height: 2,
                    color: Color(0xff3EC2C2),
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      dropValue = newValue;
                    });
                  },
                  items: <String>['WPA', 'WEP']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )),
          ],
        )
      ],
    );
  }

  Widget telURL() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
              width: 100,
              child: TextField(
                controller: countryControler,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.add_circle_outline_sharp,
                      color: Color(0xff3EC2C2)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff3EC2C2))),
                  hintText: '+',
                ),
              ),
            ),
          ),
          Flexible(
            child: TextField(
              controller: numController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.phone, color: Color(0xff3EC2C2)),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff3EC2C2))),
                hintText: 'Number phone',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
