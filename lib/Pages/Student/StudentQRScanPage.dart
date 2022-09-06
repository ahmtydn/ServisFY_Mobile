import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:servisfy_mobile/Pages/Student/StudentCreatPage.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'dart:async';

import 'package:top_snackbar_flutter/top_snack_bar.dart';

class StudentQRScanPage extends StatefulWidget {
  const StudentQRScanPage({Key? key}) : super(key: key);

  @override
  State<StudentQRScanPage> createState() => _StudentQRScanPageState();
}

class _StudentQRScanPageState extends State<StudentQRScanPage> {
  String _scanBarcode = 'Unknown';
 bool isAuthQR=false;
  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform mesajları başarısız olabilir, bu nedenle bir try/catch PlatformException kullanıyoruz.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'İptal', true, ScanMode.QR);


      if (barcodeScanRes.toString() == "-1") {
        showTopSnackBar(
            context,
            CustomSnackBar.info(
              message: "Tarama İptal Edildi",
            ));
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => StudentCreatPage(0)));
      }
      if(barcodeScanRes.toString()=="mosk.bilisim.servisfy.com") {
        isAuthQR=true;
        showTopSnackBar(
            context,
            CustomSnackBar.success(
              message: "${barcodeScanRes}",
            ));
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => StudentCreatPage(0)));
      }
      else{
        showTopSnackBar(
            context,
            CustomSnackBar.error(
              message: "Doğrulama Başarısız",
            ));
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => StudentCreatPage(0)));
      }
    } on PlatformException {
      barcodeScanRes = 'Platform sürümü alınamadı.';
    }

    //Widget, asenkron platformdayken ağaçtan kaldırıldıysa
    // mesaj uçuştaydı, aramak yerine cevabı silmek istiyoruz
    // setState var olmayan görünümümüzü güncellemek için.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  void initState() {
    scanQR();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      return Container(
          alignment: Alignment.center,
          child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator()
              ]));
    });
  }
}
