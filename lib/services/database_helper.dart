import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/quiz.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'quizzes.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE quizzes(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            quizName TEXT,
            score INTEGER,
            overallScore INTEGER,
            passed INTEGER
          )
        ''');
      },
    );
  }

  // Insert a quiz into the database
  Future<int> insertQuiz(Quiz quiz) async {
    final db = await database;
    try {
      return await db.insert(
        'quizzes',
        quiz.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print("Error inserting quiz: $e");
      return -1;
    }
  }

  // Fetch all quizzes from the database
  Future<List<Quiz>> getQuizzes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('quizzes');

    return List.generate(maps.length, (i) {
      return Quiz.fromMap(maps[i]);
    });
  }
}
