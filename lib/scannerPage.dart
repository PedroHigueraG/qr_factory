import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

// ignore: camel_case_types
class scannerPage extends StatefulWidget {
  const scannerPage({Key key}) : super(key: key);

  @override
  _scannerPageState createState() => _scannerPageState();
}

// ignore: camel_case_types
class _scannerPageState extends State<scannerPage> {
  Barcode result;
  QRViewController controller;
  GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Expanded(flex: 3, child: _buildQrView(context)),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 200),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
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
                ]
                //(result != null) ? Text('Data: ${result.code}') : Text('Ola'),
                ),
          ),
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
    });
  }
}
