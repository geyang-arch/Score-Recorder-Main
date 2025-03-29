class Quiz {
  int? id;
  String quizName;
  int score;
  int overallScore;
  int passed; // 1 = Passed, 0 = Failed

  Quiz({
    this.id,
    required this.quizName,
    required this.score,
    required this.overallScore,
    required this.passed,
  });

  // Convert to Map for database storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'quizName': quizName,
      'score': score,
      'overallScore': overallScore,
      'passed': passed,
    };
  }

  // Convert from Map (when retrieving from database)
  factory Quiz.fromMap(Map<String, dynamic> map) {
    return Quiz(
      id: map['id'],
      quizName: map['quizName'],
      score: map['score'],
      overallScore: map['overallScore'],
      passed: map['passed'],
    );
  }
}
