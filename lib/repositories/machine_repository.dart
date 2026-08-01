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
}