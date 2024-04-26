import 'package:flutter/material.dart';
import 'package:kwcalculator/app/models/registry.dart';

class KWRegistry extends StatelessWidget {
  const KWRegistry({super.key, required this.registry, required this.onDeleteTap, required this.index});

  final Registry registry;
  final Function(int) onDeleteTap;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(registry.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,),
            ),
            Text(registry.formattedDate()),
            Row(
              children: [
                Text('\$${registry.total}',
                  style: const TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => onDeleteTap(index),
                  child: const SizedBox(
                    width: 42,
                    child: Icon(Icons.delete_outline, size: 42,),
                  ),
                )
              ],
            ),
            Text('${registry.kWh}kWh * \$${registry.kWhValue}'),
          ],
        ),
      ),
    );
  }

}