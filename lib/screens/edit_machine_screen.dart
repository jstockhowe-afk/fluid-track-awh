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

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.machine.name);
    costCenterController =
        TextEditingController(text: widget.machine.costCenter);

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
      name: nameController.text,
      costCenter: costCenterController.text,
      imagePath: _image?.path ?? "",
    );

    await _machineService.updateMachine(updatedMachine);

    if (!mounted) return;

    Navigator.pop(context, true);
  }

  @override
  void dispose() {
    nameController.dispose();
    costCenterController.dispose();
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