import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/visitor_prediction.dart';

part 'prediction_service.g.dart';

@Riverpod(keepAlive: true)
PredictionService predictionService(Ref ref) {
  return PredictionService();
}

class PredictionService {
  static const String _baseUrl = 'https://your-api-domain.com';

  Future<List<VisitorPrediction>> fetchPredictionData() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/predict'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((item) => VisitorPrediction.fromJson(item)).toList();
      } else {
        throw Exception(
          'Failed to fetch prediction data: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Failed to fetch prediction data: $e');
    }
  }
}
