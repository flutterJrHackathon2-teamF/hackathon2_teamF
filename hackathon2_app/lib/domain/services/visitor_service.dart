import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data/models/visitor_data.dart';

part 'visitor_service.g.dart';

@Riverpod(keepAlive: true)
VisitorService visitorService(Ref ref) {
  return VisitorService(Supabase.instance.client);
}

class VisitorService {
  final SupabaseClient _client;

  VisitorService(this._client);

  Future<VisitorData?> fetchLatestVisitorDataFromSupabase() async {
    try {
      final response =
          await _client
              .from('visitors_5m')
              .select('visitors, slot_5m')
              .order('slot_5m', ascending: false)
              .limit(1)
              .single();

      return VisitorData.fromJson(response);
    } catch (e) {
      throw Exception('Failed to fetch visitor data from Supabase: $e');
    }
  }
}
