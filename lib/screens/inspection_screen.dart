import 'package:flutter/material.dart';

import '../models/machine.dart';
import '../models/oil_entry.dart';
import '../services/oil_entry_service.dart';

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
  final OilEntryService _service = OilEntryService();

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

    final entry = OilEntry(
      machineId: widget.machine.id,
      medium: "Kontrolle",
      liters: hydraulicValue,
      comment: commentController.text,
      dateTime: DateTime.now(),
    );

    await _service.insertEntry(entry);

    if (!mounted) return;

    Navigator.pop(context, true);
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
            onPressed: _isSaving ? () {} : _saveEntry,
          ),
        ],
      ),
    );
  }
}