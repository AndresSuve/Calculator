import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addCalculationHistory(String calculation, String result) async {
    try {
      await _firestore.collection('calculation_history').add({
        'calculation': calculation,
        'result': result,
        'timestamp': DateTime.now(),
      });
      print('Calculation history added successfully');
    } catch (e) {
      print('Error adding calculation history: $e');
    }
  }

  Stream<List<Map<String, dynamic>>> getCalculationHistoryStream() {
    try {
      return _firestore
          .collection('calculation_history')
          .orderBy('timestamp', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList());
    } catch (e) {
      print('Error getting calculation history stream: $e');
      return Stream.value([]);
    }
  }
}
