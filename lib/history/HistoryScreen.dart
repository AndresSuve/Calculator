import 'package:flutter/material.dart';
import 'database_helper.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  DatabaseHelper dbHelper = DatabaseHelper();
  late List<Map<String, dynamic>> _historyList;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    List<Map<String, dynamic>> history = await dbHelper.getCalculations();
    setState(() {
      _historyList = history;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        backgroundColor: Colors.orange,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: _historyList.length,
        itemBuilder: (context, index) {
          String calculation = _historyList[index]['calculation'];
          String timestamp = _historyList[index]['timestamp'];

          return ListTile(
            title: Text('$calculation = $timestamp'),
          );
        },
      ),
    );
  }
}
