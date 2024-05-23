import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _questionsCollection =
      FirebaseFirestore.instance.collection('questions');

  Future<void> addQuestion(
      String title, Map<String, bool> options, String categoryName) async {
    try {
      await _questionsCollection.add({
        'title': title,
        'options': options,
        'category': categoryName,
      });
    } catch (error) {
      throw error;
    }
  }

  Future<void> deleteQuestion(String questionId) async {
    try {
      await _questionsCollection.doc(questionId).delete();
    } catch (error) {
      throw error;
    }
  }

  Future<List<Map<String, dynamic>>> getAllQuestions() async {
    try {
      QuerySnapshot querySnapshot = await _questionsCollection.get();
      List<Map<String, dynamic>> questions = [];
      querySnapshot.docs.forEach((doc) {
        questions.add({
          'id': doc.id,
          ...doc.data() as Map<String, dynamic>,
        });
      });
      return questions;
    } catch (error) {
      throw error;
    }
  }

  Future<List<Map<String, dynamic>>> getQuestionsByCategory(
      String category) async {
    try {
      QuerySnapshot querySnapshot = await _questionsCollection
          .where('category', isEqualTo: category)
          .get();
      List<Map<String, dynamic>> questions = [];
      querySnapshot.docs.forEach((doc) {
        questions.add({
          'id': doc.id,
          ...doc.data() as Map<String, dynamic>,
        });
      });
      return questions;
    } catch (error) {
      throw error;
    }
  }

  Future<List<String>> getCategories() async {
    try {
      QuerySnapshot querySnapshot = await _questionsCollection.get();
      Set<String> categories = Set();
      querySnapshot.docs.forEach((doc) {
        categories.add(doc['category']);
      });
      return categories.toList();
    } catch (error) {
      throw error;
    }
  }
}
