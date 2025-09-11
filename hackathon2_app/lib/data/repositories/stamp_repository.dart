import '../models/stamp_data.dart';

abstract class StampRepository {
  Future<List<StampData>> getAllStamps();
  Future<void> saveStamp(StampData stamp);
  Future<StampData?> getStampById(int id);
  Future<void> deleteAllStamps();
}