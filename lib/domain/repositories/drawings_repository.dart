import 'package:dartz/dartz.dart';
import 'package:paint_app/core/error/failures.dart';
import 'package:paint_app/domain/entities/drawing.dart';

abstract class DrawingsRepository {
  Future<Either<Failure, List<Drawing>>> getDrawings();
  Future<void> storeDrawing(Drawing drawing);
  Future<void> storeDrawings(List<Drawing> drawings);
}
