import 'package:flutter/material.dart';
import 'package:kwcalculator/app/components/kwNavbar.dart';
import 'package:kwcalculator/app/components/kwRegistry.dart';
import 'package:kwcalculator/app/models/registry.dart';
import 'package:kwcalculator/app/repository/repository.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final Repository repository = Repository();
  List<Registry> records = <Registry>[];

  void removeRecord(int index) {
    setState(() {
      repository.removeRegistry(index);
      loadRecords();
    });
  }

  Future<List<Registry>> loadRecords() async {
    records = await repository.getRecords();
    return records;
  }

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
                        child: FutureBuilder<List<Registry>>(
                          builder: (context, snapshot) {
                            if(snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if(!snapshot.hasData || snapshot.data!.isEmpty) {
                              return const Center(
                                child: Text('No hay datos'),
                              );
                            }
                            return ListView.separated(
                              itemBuilder: (_, index) => KWRegistry(registry: records[index], index: index, onDeleteTap: removeRecord,),
                              separatorBuilder: (_, __) => const SizedBox(height: 10,),
                              itemCount: records.length,
                            );
                          }, future: loadRecords(),
                        )
                      )
                  ),
                ],
              ),
              const KWNavbar(active: 4,),
            ],
          ),
        ),
      ),
    );
  }
}