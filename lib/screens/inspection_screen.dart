import 'package:flutter/material.dart';
import '../services/oil_stock_service.dart';
import '../models/machine.dart';
import '../models/inspection_entry.dart';
import '../services/inspection_service.dart';
import '../widgets/inspection_header.dart';
import '../widgets/inspection_info_card.dart';
import '../widgets/number_input_card.dart';
import '../widgets/primary_button.dart';
import '../widgets/quantity_selector.dart';
import '../widgets/remark_card.dart';

class InspectionScreen extends StatefulWidget {
  final Machine machine;

  const InspectionScreen({
    super.key,
    required this.machine,
  });

  @override
  State<InspectionScreen> createState() => _InspectionScreenState();
}

class _InspectionScreenState extends State<InspectionScreen> {
  final InspectionService _service = InspectionService();
  final OilStockService _stockService = OilStockService();

  bool _isSaving = false;

  final TextEditingController hydraulicController =
      TextEditingController(text: "0.0");

  final TextEditingController guidewayController =
      TextEditingController(text: "0.0");

  final TextEditingController waterController =
      TextEditingController();

  final TextEditingController concentrationController =
      TextEditingController();

  final TextEditingController commentController =
      TextEditingController();

  @override
  void dispose() {
    hydraulicController.dispose();
    guidewayController.dispose();
    waterController.dispose();
    concentrationController.dispose();
    commentController.dispose();
    super.dispose();
  }

  double get hydraulicValue =>
      double.tryParse(
            hydraulicController.text.replaceAll(",", "."),
          ) ??
      0;

  double get guidewayValue =>
      double.tryParse(
            guidewayController.text.replaceAll(",", "."),
          ) ??
      0;

  void _changeHydraulic(double value) {
    final newValue = (hydraulicValue + value).clamp(0.0, 9999.0);

    setState(() {
      hydraulicController.text =
          newValue.toStringAsFixed(1);
    });
  }

  void _changeGuideway(double value) {
    final newValue = (guidewayValue + value).clamp(0.0, 9999.0);

    setState(() {
      guidewayController.text =
          newValue.toStringAsFixed(1);
    });
  }

  Future<void> _saveEntry() async {
    setState(() {
      _isSaving = true;
    });

    final entry = InspectionEntry(
     machineId: widget.machine.id,
     hydraulicOil: hydraulicValue,
     guidewayOil: guidewayValue,
     waterMeter: double.tryParse(
        waterController.text.replaceAll(",", "."),
      ) ??
      0,
  concentration: double.tryParse(
        concentrationController.text.replaceAll(",", "."),
      ) ??
      0,
  comment: commentController.text.trim(),
  dateTime: DateTime.now(),
);

await _service.insertInspection(entry);
if (hydraulicValue > 0) {
  _stockService.removeOil(
    widget.machine.hydraulicOil,
    hydraulicValue,
  );
}

if (guidewayValue > 0) {
  _stockService.removeOil(
    widget.machine.guidewayOil,
    guidewayValue,
  );
}
    if (!mounted) return;

ScaffoldMessenger.of(context).showSnackBar(
  const SnackBar(
    content: Text("Kontrolle erfolgreich gespeichert"),
  ),
);

Navigator.pop(context, true);

if (mounted) {
  setState(() {
    _isSaving = false;
  });
}
    }

      @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Maschinenkontrolle"),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          InspectionHeader(
           machine: widget.machine,
           progress: 0.25,
          ),
        

          InspectionInfoCard(
            machine: widget.machine,
          ),

          QuantitySelector(
            title: "Hydrauliköl",
            controller: hydraulicController,
            onMinus: () => _changeHydraulic(-0.5),
            onPlus: () => _changeHydraulic(0.5),
          ),

          QuantitySelector(
            title: "Gleitbahnöl",
            controller: guidewayController,
            onMinus: () => _changeGuideway(-0.5),
            onPlus: () => _changeGuideway(0.5),
          ),

          NumberInputCard(
            title: "Wasserzähler",
            controller: waterController,
          ),

          NumberInputCard(
            title: "Konzentration",
            controller: concentrationController,
            suffix: "%",
          ),

                    RemarkCard(
            controller: commentController,
          ),

          PrimaryButton(
            text: _isSaving
                ? "Speichern..."
                : "Kontrolle abschließen",
            onPressed: _isSaving
                ? () {}
                : () async {
                await _saveEntry();
                  },
          ),
        ],
      ),
    );
  }
}