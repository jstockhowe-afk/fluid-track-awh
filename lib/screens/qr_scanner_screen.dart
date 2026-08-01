import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../models/machine.dart';
import '../services/machine_service.dart';
import 'machine_detail_screen.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key});

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  final MachineService _machineService = MachineService();

  bool _handled = false;

  Future<void> _handleQrCode(String qrCode) async {
    final Machine? machine =
        await _machineService.getMachineByQrCode(qrCode);

    if (!mounted) return;

    if (machine == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Keine Maschine für '$qrCode' gefunden."),
        ),
      );

      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _handled = false;
          });
        }
      });

      return;
    }

    await Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => MachineDetailScreen(
          machine: machine,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("QR-Code scannen"),
      ),
      body: MobileScanner(
        onDetect: (capture) async {
          if (_handled) return;

          final Barcode barcode = capture.barcodes.first;

          final String? value = barcode.rawValue;

          if (value == null || value.isEmpty) return;

          _handled = true;

          await _handleQrCode(value);
        },
      ),
    );
  }
}