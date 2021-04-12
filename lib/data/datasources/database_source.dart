import 'package:paint_app/data/models/drawing_model.dart';

abstract class DatabaseSource {
  Future<void> storeInDatabase(DrawingModel model);
  Future<void> storeDrawingsInDatabase(List<DrawingModel> model);
  Future<List<DrawingModel>> getDrawingsFromDatabase();
}
