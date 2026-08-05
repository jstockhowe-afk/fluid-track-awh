import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../repositories/machine_repository.dart';
import '../models/machine.dart';
import 'inspection_screen.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key});

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  final MobileScannerController controller = MobileScannerController();

  final MachineRepository repository = MachineRepository();

  bool _busy = false;

  Future<void> _onDetect(BarcodeCapture capture) async {
    if (_busy) return;

    final barcode = capture.barcodes.firstOrNull;

    if (barcode == null) return;

    final code = barcode.rawValue;

    if (code == null) return;

    _busy = true;

    final Machine? machine =
        await repository.getMachineByQrCode(code);

    if (!mounted) return;

    if (machine == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Maschine nicht gefunden\n$code"),
        ),
      );

      _busy = false;
      return;
    }

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => InspectionScreen(
          machine: machine,
        ),
      ),
    );

    _busy = false;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("QR-Code scannen"),
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: controller,
            onDetect: _onDetect,
          ),

          Center(
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 4,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),

          const Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  "QR-Code der Maschine scannen",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}