import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseHelper {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> insertCalculation(String calculation, String timestamp) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('calculation_history').add({
          'calculation': calculation,
          'timestamp': timestamp,
          'authorUid': user.uid,
        });
      } else {
        throw Exception('No current user found.');
      }
    } catch (e) {
      print('Error adding calculation to Firestore: $e');
    }
  }

  Stream<List<Map<String, dynamic>>> getCalculations() {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        return _firestore
            .collection('calculation_history')
            .where('authorUid', isEqualTo: user.uid)
            .orderBy('timestamp', descending: true)
            .snapshots()
            .map((snapshot) => snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList());
      } else {
        throw Exception('No current user found.');
      }
    } catch (e) {
      print('Error getting calculation history stream: $e');
      return Stream.value([]);
    }
  }
}
