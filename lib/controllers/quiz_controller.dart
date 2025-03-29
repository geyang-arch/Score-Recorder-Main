import '../models/quiz.dart';
import '../services/database_helper.dart';

class QuizController {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<void> addQuiz(String name, int score, int overallScore, int passed) async {
    Quiz newQuiz = Quiz(quizName: name, score: score, overallScore: overallScore, passed: passed);
    await _dbHelper.insertQuiz(newQuiz);
  }

  Future<List<Quiz>> fetchQuizzes() async {
    final quizzes = await _dbHelper.getQuizzes();
    print("Fetched quizzes: ${quizzes.length} items");
    return quizzes;
  }
}
