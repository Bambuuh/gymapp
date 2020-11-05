class ExerciseHistory {
  final String exerciseId;
  final int reps;
  final double weight;

  ExerciseHistory(this.exerciseId, this.reps, this.weight);

  Map<String, dynamic> toJson() {
    return {
      'exerciseId': exerciseId,
      'reps': reps,
      'weight': weight,
    };
  }

  static ExerciseHistory fromJson(json) {
    return ExerciseHistory(json['exerciseId'], json['reps'], json['weight']);
  }
}
