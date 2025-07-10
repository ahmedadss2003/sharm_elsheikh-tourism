import 'package:flutter/material.dart';

class CustomNumberSelector extends StatelessWidget {
  final String label;
  final int value;
  final Function(int) onChanged;

  const CustomNumberSelector({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[50],
          ),
          child: Row(
            children: [
              Icon(Icons.group, color: Colors.blue[600], size: 16),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  value.toString(),
                  style: const TextStyle(fontSize: 14),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.remove_circle_outline),
                color: Colors.red[600],
                onPressed: value > 0 ? () => onChanged(value - 1) : null,
              ),
              IconButton(
                icon: const Icon(Icons.add_circle_outline),
                color: Colors.green[600],
                onPressed: () => onChanged(value + 1),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
