class PredictionResponse {
  final String message;
  final String userId;
  final double prediction;

  PredictionResponse({
    required this.message,
    required this.userId,
    required this.prediction,
  });

  Map<String, dynamic> toMap() => {
    "message": message,
    "user_id": userId,
    "prediction": prediction,
  };

  factory PredictionResponse.fromMap(Map<String, dynamic> json) => PredictionResponse(
    message: json["message"] ?? "",
    userId: json["user_id"] ?? "",
    prediction: json["prediction"] ?? 0
  );
}


