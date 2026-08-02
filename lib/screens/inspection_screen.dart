import 'package:flutter/material.dart';
import '../widgets/inspection_header.dart';
import '../widgets/inspection_info_card.dart';
import '../models/machine.dart';
import '../models/oil_entry.dart';
import '../services/oil_entry_service.dart';
import '../widgets/quantity_selector.dart';
import '../widgets/number_input_card.dart';
import '../widgets/remark_card.dart';
import '../widgets/primary_button.dart';

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

  String medium = "Hydrauliköl";

  bool _isSaving = false;

  final TextEditingController literController = TextEditingController();
  final TextEditingController commentController = TextEditingController();

  @override
  void dispose() {
    literController.dispose();
    commentController.dispose();
    super.dispose();
  }

  Future<void> _saveEntry() async {
    FocusScope.of(context).unfocus();

    final double? liters =
        double.tryParse(literController.text.replaceAll(",", "."));

    if (liters == null || liters <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Bitte eine gültige Literzahl eingeben."),
        ),
      );
      return;
    }

    setState(() {
      _isSaving = true;
    });

    final entry = OilEntry(
      machineId: widget.machine.id,
      medium: medium,
      liters: liters,
      comment: commentController.text.trim(),
      dateTime: DateTime.now(),
    );

    await _service.insertEntry(entry);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Buchung erfolgreich gespeichert."),
      ),
    );

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Öl nachfüllen"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
Column(
children: [

  InspectionHeader(
    machineName: widget.machine.name,
    costCenter: widget.machine.costCenter,
    progress: 0.25,
  ),

  InspectionInfoCard(
    machine: widget.machine,
  ),

  QuantitySelector(
    title: "Hydrauliköl",
    controller: literController,
    onMinus: () {},
    onPlus: () {},
  ),

  QuantitySelector(
    title: "Gleitbahnöl",
    controller: TextEditingController(),
    onMinus: () {},
    onPlus: () {},
  ),

  NumberInputCard(
    title: "Wasserzähler",
    controller: TextEditingController(),
  ),

  NumberInputCard(
    title: "Konzentration",
    controller: TextEditingController(),
    suffix: "%",
  ),

  RemarkCard(
    controller: commentController,
  ),

  PrimaryButton(
    text: "Kontrolle abschließen",
    onPressed: _saveEntry,
  ),
],
),

          DropdownButtonFormField<String>(
            initialValue: medium,
            decoration: const InputDecoration(
              labelText: "Medium",
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(
                value: "Hydrauliköl",
                child: Text("Hydrauliköl"),
              ),
              DropdownMenuItem(
                value: "Gleitbahnöl",
                child: Text("Gleitbahnöl"),
              ),
              DropdownMenuItem(
                value: "Kühlschmierstoff",
                child: Text("Kühlschmierstoff"),
              ),
            ],
            onChanged: (value) {
              if (value == null) return;
              setState(() {
                medium = value;
              });
            },
          ),

          const SizedBox(height: 20),

          TextField(
            controller: literController,
            keyboardType: const TextInputType.numberWithOptions(
              decimal: true,
            ),
            decoration: const InputDecoration(
              labelText: "Liter",
              border: OutlineInputBorder(),
              hintText: "z. B. 5,0",
            ),
          ),

          const SizedBox(height: 20),

          TextField(
            controller: commentController,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: "Kommentar (optional)",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 30),

          SizedBox(
            height: 55,
            child: ElevatedButton.icon(
              onPressed: _isSaving ? null : _saveEntry,
              icon: _isSaving
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.save),
              label: Text(
                _isSaving
                    ? "Speichern..."
                    : "Buchung speichern",
              ),
            ),
          ),
        ],
      ),
    );
  }
}