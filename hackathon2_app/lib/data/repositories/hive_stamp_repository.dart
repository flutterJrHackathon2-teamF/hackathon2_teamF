import 'package:hive/hive.dart';
import '../models/stamp_data.dart';
import 'stamp_repository.dart';

class HiveStampRepository implements StampRepository {
  static const String _boxName = 'stamps';
  late Box<StampData> _box;

  Future<void> init() async {
    _box = await Hive.openBox<StampData>(_boxName);
  }

  @override
  Future<List<StampData>> getAllStamps() async {
    return _box.values.toList();
  }

  @override
  Future<void> saveStamp(StampData stamp) async {
    await _box.put(stamp.id, stamp);
  }

  @override
  Future<StampData?> getStampById(int id) async {
    return _box.get(id);
  }

  @override
  Future<void> deleteAllStamps() async {
    await _box.clear();
  }
}