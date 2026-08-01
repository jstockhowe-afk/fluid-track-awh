import '../data/machine_data.dart';
import '../models/machine.dart';
import 'machine_service.dart';

class DatabaseInitializer {
  static final MachineService _machineService = MachineService();

  static Future<void> initialize() async {
    final List<Machine> existingMachines =
        await _machineService.getMachines();

    if (existingMachines.isNotEmpty) {
      return;
    }

    for (final machine in machines) {
      await _machineService.insertMachine(machine);
    }
  }
}