import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../models/machine.dart';
import '../services/machine_service.dart';

class EditMachineScreen extends StatefulWidget {
  final Machine machine;

  const EditMachineScreen({
    super.key,
    required this.machine,
  });

  @override
  State<EditMachineScreen> createState() => _EditMachineScreenState();
}

class _EditMachineScreenState extends State<EditMachineScreen> {
  final ImagePicker _picker = ImagePicker();
  final MachineService _machineService = MachineService();

  File? _image;

  late TextEditingController nameController;
  late TextEditingController costCenterController;
  late TextEditingController hydraulicOilController;
late TextEditingController guidewayOilController;
late TextEditingController coolantController;

late TextEditingController hydraulicTankController;
late TextEditingController coolantTankController;

late TextEditingController qrController;
late TextEditingController notesController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.machine.name);
    costCenterController =
        TextEditingController(text: widget.machine.costCenter);
        hydraulicOilController =
    TextEditingController(text: widget.machine.hydraulicOil);

guidewayOilController =
    TextEditingController(text: widget.machine.guidewayOil);

coolantController =
    TextEditingController(text: widget.machine.coolant);

hydraulicTankController =
    TextEditingController(
      text: widget.machine.hydraulicTank.toString(),
    );

coolantTankController =
    TextEditingController(
      text: widget.machine.coolantTank.toString(),
    );

qrController =
    TextEditingController(text: widget.machine.qrCode);

notesController =
    TextEditingController(text: widget.machine.notes);

    if (widget.machine.imagePath.isNotEmpty) {
      _image = File(widget.machine.imagePath);
    }
  }

  Future<void> _pickImage() async {
    final XFile? image =
        await _picker.pickImage(source: ImageSource.camera);

    if (image == null) return;

    setState(() {
      _image = File(image.path);
    });
  }

  Future<void> _saveMachine() async {
    final updatedMachine = widget.machine.copyWith(
  name: nameController.text.trim(),
  costCenter: costCenterController.text.trim(),
  imagePath: _image?.path ?? widget.machine.imagePath,
  hydraulicOil: hydraulicOilController.text.trim(),
  guidewayOil: guidewayOilController.text.trim(),
  coolant: coolantController.text.trim(),
  hydraulicTank:
      int.tryParse(hydraulicTankController.text) ?? 0,
  coolantTank:
      int.tryParse(coolantTankController.text) ?? 0,
  qrCode: qrController.text.trim(),
  notes: notesController.text.trim(),
);

    await _machineService.updateMachine(updatedMachine);

    if (!mounted) return;

    Navigator.pop(context, true);
  }

 @override
void dispose() {
  nameController.dispose();
  costCenterController.dispose();

  hydraulicOilController.dispose();
  guidewayOilController.dispose();
  coolantController.dispose();

  hydraulicTankController.dispose();
  coolantTankController.dispose();

  qrController.dispose();
  notesController.dispose();

  super.dispose();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Maschine bearbeiten"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          GestureDetector(
            onTap: _pickImage,
            child: Container(
              height: 220,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(18),
              ),
              child: _image == null
                  ? const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.camera_alt, size: 60),
                        SizedBox(height: 10),
                        Text("Foto aufnehmen"),
                      ],
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.file(
                        _image!,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 25),
          const SizedBox(height: 24),

const Text(
  "Stammdaten",
  style: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
  ),
),

const SizedBox(height: 16),
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: "Maschinenname",
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: costCenterController,
            decoration: const InputDecoration(
              labelText: "Kostenstelle",
            ),
          ),
          const SizedBox(height: 15),

TextField(
  controller: qrController,
  decoration: const InputDecoration(
    labelText: "QR-Code",
    prefixIcon: Icon(Icons.qr_code),
  ),
),

const SizedBox(height: 15),

const SizedBox(height: 24),

const Text(
  "Betriebsstoffe",
  style: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
  ),
),

const SizedBox(height: 16),

TextField(
  controller: hydraulicOilController,
  decoration: const InputDecoration(
    labelText: "Hydrauliköl",
    prefixIcon: Icon(Icons.oil_barrel),
  ),
),

const SizedBox(height: 15),

TextField(
  controller: guidewayOilController,
  decoration: const InputDecoration(
    labelText: "Gleitbahnöl",
    prefixIcon: Icon(Icons.settings),
  ),
),

const SizedBox(height: 15),

TextField(
  controller: coolantController,
  decoration: const InputDecoration(
    labelText: "Kühlschmierstoff",
    prefixIcon: Icon(Icons.water_drop),
  ),
),

const SizedBox(height: 15),

TextField(
  controller: hydraulicTankController,
  keyboardType: TextInputType.number,
  decoration: const InputDecoration(
    labelText: "Hydrauliktank (Liter)",
    prefixIcon: Icon(Icons.local_gas_station),
  ),
),

const SizedBox(height: 15),

TextField(
  controller: coolantTankController,
  keyboardType: TextInputType.number,
  decoration: const InputDecoration(
    labelText: "KSS-Tank (Liter)",
    prefixIcon: Icon(Icons.water),
  ),
),

const SizedBox(height: 15),

const SizedBox(height: 24),

const Text(
  "Zusätzliche Informationen",
  style: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
  ),
),

const SizedBox(height: 16),

TextField(
  controller: notesController,
  maxLines: 3,
  decoration: const InputDecoration(
    labelText: "Notizen",
    prefixIcon: Icon(Icons.note),
  ),
),
          const SizedBox(height: 25),
          SizedBox(
            height: 55,
            child: ElevatedButton.icon(
              onPressed: _saveMachine,
              icon: const Icon(Icons.save),
              label: const Text("Speichern"),
            ),
          ),
        ],
      ),
    );
  }
}