import 'package:flutter/foundation.dart';

import '../data/machine_data.dart';
import '../models/machine.dart';
import '../services/machine_service.dart';

class MachineRepository {
  final MachineService _machineService = MachineService();

  Future<List<Machine>> getMachines() async {
    if (kIsWeb) {
      return machines;
    }

    return await _machineService.getMachines();
  }

  Future<Machine?> getMachineByQrCode(String qrCode) async {
    final allMachines = await getMachines();

    try {
      return allMachines.firstWhere(
        (machine) => machine.qrCode == qrCode,
      );
    } catch (_) {
      return null;
    }
  }

  Future<Machine?> getMachineById(String id) async {
    final allMachines = await getMachines();

    try {
      return allMachines.firstWhere(
        (machine) => machine.id == id,
      );
    } catch (_) {
      return null;
    }
  }
}