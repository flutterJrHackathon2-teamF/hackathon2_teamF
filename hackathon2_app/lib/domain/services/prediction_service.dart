import 'dart:convert';
import 'dart:developer';
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
  static const String _baseUrl = 'https://hackathon2-teamf.onrender.com';

  Future<List<VisitorPrediction>> fetchPredictionData() async {
    final url = '$_baseUrl/predict';
    print('[PredictionService] Fetching from: $url');

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          print('[PredictionService] Request timeout after 10 seconds');
          throw Exception('Request timeout');
        },
      );

      print('[PredictionService] Response status: ${response.statusCode}');
      print('[PredictionService] Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        log('[PredictionService] Parsed data: $data');

        final predictions = data.map((item) {
          try {
            return VisitorPrediction.fromJson(item);
          } catch (e) {
            print('[PredictionService] Error parsing item: $item, error: $e');
            rethrow;
          }
        }).toList();

        print('[PredictionService] Successfully parsed ${predictions.length} predictions');
        return predictions;
      } else {
        print('[PredictionService] API error - Status: ${response.statusCode}, Body: ${response.body}');
        throw Exception(
          'Failed to fetch prediction data: Status ${response.statusCode}',
        );
      }
    } catch (e) {
      print('[PredictionService] Exception caught: $e');
      throw Exception('Failed to fetch prediction data: $e');
    }
  }
}
