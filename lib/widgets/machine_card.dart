import 'dart:io';

import 'package:flutter/foundation.dart';
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
        horizontal: 14,
        vertical: 8,
      ),
      elevation: 5,
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
                child: _buildImage(),
              ),

              const SizedBox(width: 18),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      children: [

                        Expanded(
                          child: Text(
                            machine.name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        Container(
                          width: 14,
                          height: 14,
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    Row(
                      children: [

                        const Icon(
                          Icons.numbers,
                          size: 18,
                          color: Colors.grey,
                        ),

                        const SizedBox(width: 6),

                        Text(
                          "Kostenstelle ${machine.costCenter}",
                          style: TextStyle(
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [

                        _chip(
                          Icons.oil_barrel,
                          machine.hydraulicOil.isEmpty
                              ? "Hydraulik"
                              : machine.hydraulicOil,
                          Colors.orange,
                        ),

                        _chip(
                          Icons.opacity,
                          machine.guidewayOil.isEmpty
                              ? "Gleitbahn"
                              : machine.guidewayOil,
                          Colors.blue,
                        ),

                        _chip(
                          Icons.water_drop,
                          machine.coolant.isEmpty
                              ? "KSS"
                              : machine.coolant,
                          Colors.teal,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 10),

              const Icon(
                Icons.chevron_right,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {

    if (machine.imagePath.isEmpty) {
      return Container(
        width: 95,
        height: 95,
        color: Colors.grey.shade300,
        child: const Icon(
          Icons.precision_manufacturing,
          size: 46,
          color: Colors.grey,
        ),
      );
    }

    if (kIsWeb) {
      return Container(
        width: 95,
        height: 95,
        color: Colors.grey.shade300,
        child: const Icon(
          Icons.image,
          size: 46,
        ),
      );
    }

    return Image.file(
      File(machine.imagePath),
      width: 95,
      height: 95,
      fit: BoxFit.cover,
    );
  }

  Widget _chip(
      IconData icon,
      String text,
      Color color,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [

          Icon(
            icon,
            size: 16,
            color: color,
          ),

          const SizedBox(width: 4),

          Text(
            text,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}