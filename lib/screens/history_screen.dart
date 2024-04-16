import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  final Stream<List<Map<String, dynamic>>> historyDataStream;

  HistoryScreen({required this.historyDataStream});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculation History'),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: historyDataStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('No history available'),
            );
          }
          List<Map<String, dynamic>> historyDataList = snapshot.data!;
          return ListView.builder(
            itemCount: historyDataList.length,
            itemBuilder: (context, index) {
              String timestampString = historyDataList[index]['timestamp']?.toString() ?? '';
              return ListTile(
                title: Text(historyDataList[index]['calculation'] ?? ''),
                subtitle: Text(timestampString),
              );
            },
          );
        },
      ),
    );
  }
}
