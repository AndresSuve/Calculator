import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addCalculation(String calculation, String timestamp) async {
    try {
      await _firestore.collection('calculation_history').add({
        'calculation': calculation,
        'timestamp': timestamp,
      });
    } catch (e) {
      print('Error adding calculation to Firestore: $e');
    }
  }

  Stream<List<Map<String, dynamic>>> getCalculations() {
    try {
      return _firestore
          .collection('calculation_history')
          .orderBy('timestamp', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList());
    } catch (e) {
      // Print error message if there's an error getting the calculation history from Firestore
      print('Error getting calculation history stream: $e');
      return Stream.value([]);
    }
  }
}
