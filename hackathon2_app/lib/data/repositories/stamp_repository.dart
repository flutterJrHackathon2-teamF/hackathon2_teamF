import 'package:hive_flutter/hive_flutter.dart';
import '../models/stamp_data.dart';

abstract class StampRepository {
  Future<StampData?> getStampData();
  Future<void> saveStampData(StampData data);
  Future<void> updateStampStatus(int index, bool isStamped);
  Future<void> clearAllData();
}

class HiveStampRepository implements StampRepository {
  static const String _boxName = 'stamp_box';
  static const String _dataKey = 'stamp_data';
  
  Box<StampData>? _box;

  Future<Box<StampData>> get box async {
    _box ??= await Hive.openBox<StampData>(_boxName);
    return _box!;
  }

  @override
  Future<StampData?> getStampData() async {
    final stampBox = await box;
    return stampBox.get(_dataKey);
  }

  @override
  Future<void> saveStampData(StampData data) async {
    final stampBox = await box;
    await stampBox.put(_dataKey, data);
  }

  @override
  Future<void> updateStampStatus(int index, bool isStamped) async {
    final currentData = await getStampData();
    if (currentData == null) return;

    final updatedStatus = List<bool>.from(currentData.stampStatus);
    if (index >= 0 && index < updatedStatus.length) {
      updatedStatus[index] = isStamped;
      
      final updatedData = currentData.copyWith(
        stampStatus: updatedStatus,
        lastUpdated: DateTime.now(),
      );
      
      await saveStampData(updatedData);
    }
  }

  @override
  Future<void> clearAllData() async {
    final stampBox = await box;
    await stampBox.clear();
  }
}