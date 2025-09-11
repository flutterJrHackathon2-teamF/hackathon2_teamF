import '../models/stamp_data.dart';

abstract class StampRepository {
  Future<List<StampData>> getAllStamps();
  Future<void> saveStamp(StampData stamp);
  Future<void> deleteAllStamps();
}