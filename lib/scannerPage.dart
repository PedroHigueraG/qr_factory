import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({Key key}) : super(key: key);
  
  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  Barcode result;
  QRViewController controller;
  GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  List dominios = ['.com','.co','.ca','.cl','.org','.io','.net','.blogspot','.uk','.ru','.de','.cn','.site','.xyz','es'];
  @override
  Widget build(BuildContext context) {
   
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Container(
            height: Size.infinite.height,
            width: Size.infinite.width,
            child: _buildQrView(context)),
        Padding(
          padding: const EdgeInsets.only(top: 120),
          child: Text(
            'Scan the QR Code',
            style: TextStyle(color: Color(0xff3EC2C2), fontSize: 25),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 500),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                minWidth: 120,
                height: 40,
                color: Color(0xff3EC2C2),
                child: Row(
                  children: [
                    Icon(Icons.flash_on),
                    Text(
                      'Flashlight',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                onPressed: () async {
                  await controller?.toggleFlash();
                  setState(() {});
                }),
            MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                minWidth: 120,
                height: 40,
                color: Color(0xff3EC2C2),
                child: Row(
                  children: [
                    Icon(Icons.flip_camera_ios),
                    Text(
                      'Flip camera',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                onPressed: () async {
                  await controller?.flipCamera();
                  setState(() {});
                })
          ]),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 600),
          child: (result != null)
              ? Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(result.code,
                            style: TextStyle(
                                color: Color(0xff3EC2C2), fontSize: 20)),
                      )),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: GestureDetector(
                          child: Icon(Icons.copy, color: Color(0xff3EC2C2)),
                          onTap: () => Clipboard.setData(
                                  ClipboardData(text: result.code))
                              .then((result) => {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content:
                                                Text("Copied to clipboard")))
                                  }),
                        ),
                      )
                    ],
                  ),
                )
              : Text('Scan',
                  style: TextStyle(color: Color(0xff3EC2C2), fontSize: 20)),
        ),
      ],
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreate,
      overlay: QrScannerOverlayShape(
          borderRadius: 15,
          borderColor: Color(0xff3EC2C2),
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea,
          cutOutBottomOffset: 50),
    );
  }

  void _onQRViewCreate(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      _openLink();
    });
  }

  void _openLink() async {
    if (await canLaunch(result.code)) {
      launch(result.code);
    } else if (result.code.startsWith('www.')) {
      launch('https://${result.code}');
    } 
    for(var dom in dominios){
      if(result.code.contains(dom)){
        launch('https://${result.code}');
      }
    }
  }
}
