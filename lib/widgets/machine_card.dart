import 'dart:io';

import 'package:flutter/material.dart';

import '../models/machine.dart';

class MachineCard extends StatelessWidget {
  final Machine machine;
  final VoidCallback? onTap;

  const MachineCard({
    super.key,
    required this.machine,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [

              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: machine.imagePath.isEmpty
                    ? Container(
                        width: 80,
                        height: 80,
                        color: Colors.grey.shade300,
                        child: const Icon(
                          Icons.image,
                          size: 40,
                          color: Colors.grey,
                        ),
                      )
                    : Image.file(
                        File(machine.imagePath),
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      machine.name,
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      "Kostenstelle ${machine.costCenter}",
                    ),

                    const SizedBox(height: 8),

                    Text(
                      machine.hydraulicOil.isEmpty
                          ? "Hydrauliköl noch nicht festgelegt"
                          : machine.hydraulicOil,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}