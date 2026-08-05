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
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: machine.imagePath.isEmpty
                    ? Container(
                        width: 90,
                        height: 90,
                        color: Colors.grey.shade200,
                        child: const Icon(
                          Icons.precision_manufacturing,
                          size: 40,
                        ),
                      )
                    : Image.file(
                        File(machine.imagePath),
                        width: 90,
                        height: 90,
                        fit: BoxFit.cover,
                      ),
              ),

              const SizedBox(width: 18),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
  Text(
    machine.name,
    style: const TextStyle(
      fontSize: 21,
      fontWeight: FontWeight.bold,
    ),
  ),
const SizedBox(height: 6),

Row(
  children: [
    const Icon(
      Icons.qr_code,
      size: 16,
      color: Colors.grey,
    ),
    const SizedBox(width: 4),
    Text(
      machine.id,
      style: TextStyle(
        color: Colors.grey.shade700,
        fontWeight: FontWeight.w600,
      ),
    ),
  ],
),
  const SizedBox(height: 4),



  const SizedBox(height: 8),

  Text(
    "Kostenstelle ${machine.costCenter}",
    
  ),
const SizedBox(height: 10),

Wrap(
  spacing: 6,
  runSpacing: 6,
  children: [
    Chip(
      avatar: const Icon(
        Icons.oil_barrel,
        size: 16,
        color: Colors.blue,
      ),
      label: Text(machine.hydraulicOil),
    ),
    Chip(
      avatar: const Icon(
        Icons.settings,
        size: 16,
        color: Colors.orange,
      ),
      label: Text(machine.guidewayOil),
    ),
  ],
),

const SizedBox(height: 12),
  const SizedBox(height: 12),

                   
                  ],
                ),
              ),

              const Icon(
                Icons.chevron_right,
                size: 32,
              ),
            ],
          ),
        ),
      ),
    );
  }
}