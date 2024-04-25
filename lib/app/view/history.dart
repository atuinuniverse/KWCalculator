import 'package:flutter/material.dart';
import 'package:kwcalculator/app/components/kwNavbar.dart';
import 'package:kwcalculator/app/components/kwRegistry.dart';
import 'package:kwcalculator/app/models/registry.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  final records = <Registry>[
    Registry('Lectura enero', DateTime.now(), 250, 800, 250 * 800),
    Registry('Lectura febrero', DateTime.now(), 210, 800, 210 * 800),
    Registry('Lectura marzo', DateTime.now(), 280, 800, 280 * 800),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: ListView.separated(
                          itemBuilder: (_, index) => KWRegistry(registry: records[index]),
                          separatorBuilder: (_, __) => const SizedBox(height: 10,),
                          itemCount: records.length,
                        ),
                      )
                  ),
                ],
              ),
              const Positioned(
                left: 0.0,
                right: 0.0,
                bottom: 0.0,
                child: KWNavbar(active: 3,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}