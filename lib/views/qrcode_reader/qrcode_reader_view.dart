import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'dart:async';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

import 'package:flutter_app_demo/views/side_drawer.dart';
import 'package:flutter_app_demo/views/qrcode_reader/video_player.dart';

class QrCodeReaderView extends StatefulWidget {
  @override
  _QrCodeReaderViewState createState() => _QrCodeReaderViewState();
}

class _QrCodeReaderViewState extends State<QrCodeReaderView> {
  ScanResult scanResult;

  final _flashOnController = TextEditingController(text: "Flash on");
  final _flashOffController = TextEditingController(text: "Flash off");
  final _cancelController = TextEditingController(text: "Cancel");

  var _aspectTolerance = 0.00;
  var _numberOfCameras = 0;
  var _selectedCamera = -1;
  var _useAutoFocus = true;
  var _autoEnableFlash = false;

  static final _possibleFormats = BarcodeFormat.values.toList();

  List<BarcodeFormat> selectedFormats = [];
  _QrCodeReaderViewState() {
    _possibleFormats.removeWhere((e) => e == BarcodeFormat.unknown);
    selectedFormats.addAll(_possibleFormats);
  }

  @override
  // ignore: type_annotate_public_apis
  initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      _numberOfCameras = await BarcodeScanner.numberOfCameras;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(context),
        endDrawer: SideDrawer(),
        body: _buildBody(context)
    );
  }

  // QRコード リーダー ビューのappBar(画面上部)
  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset('images/logo.png', height: 42),
      ),
    );
  }

  // QRコード リーダー ビューのbody
  Widget _buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        Card(
          color: Theme.of(context).primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text("Scan start >> ",
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFFF4F4F4),
                )
              ),
              IconButton(
                icon: Icon(CupertinoIcons.photo_camera),
                tooltip: "Scan",
                onPressed: scan,
                color: Theme.of(context).accentColor,
              ),
            ],
          ),
        ),
        (scanResult == null)?
        Center(child: Text("ここに結果を表示します")):
        (RegExp(r"^http[s]?://.*(.mp4|.m3u8)$").hasMatch(scanResult.rawContent))?
          // URLの場合
          VideoPlayerComponent(VideoPlayerComponent.URL, scanResult.rawContent):
          // URL以外の場合
          Column(
            children: <Widget>[
              Card(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.all(10.0),
                  child: Text(scanResult.rawContent,
                      style: TextStyle(fontSize: 26.0)),
                ),
              ),
              Card(
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text("Result type : "),
                          Text(scanResult.type.toString()),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text("Barcode format : "),
                          Text(scanResult.format.toString()),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text("Barcode format note : "),
                          Text(scanResult.formatNote),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  // スキャン開始処理
  Future scan() async {
    try {
      var options = ScanOptions(
        strings: {
          "cancel": _cancelController.text,
          "flash_on": _flashOnController.text,
          "flash_off": _flashOffController.text,
        },
        restrictFormat: selectedFormats,
        useCamera: _selectedCamera,
        autoEnableFlash: _autoEnableFlash,
        android: AndroidOptions(
          aspectTolerance: _aspectTolerance,
          useAutoFocus: _useAutoFocus,
        ),
      );

      var result = await BarcodeScanner.scan(options: options);
      setState(() => scanResult = result);

    } on PlatformException catch (e) {
      var result = ScanResult(
        type: ResultType.Error,
        format: BarcodeFormat.unknown,
      );

      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          result.rawContent = 'The user did not grant the camera permission!';
        });
      } else {
        result.rawContent = 'Unknown error: $e';
      }
      setState(() {
        scanResult = result;
      });
    }
  }
}