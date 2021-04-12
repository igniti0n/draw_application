import 'package:paint_app/domain/entities/drawing.dart';
import 'package:paint_app/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:paint_app/domain/repositories/drawings_repository.dart';

class DrawingsRepositoryImpl extends DrawingsRepository {
  @override
  Future<Either<Failure, List<Drawing>>> getDrawings() {
    // TODO: implement getDrawings
    throw UnimplementedError();
  }

  @override
  Future<void> storeDrawings(List<Drawing> drawings) {
    // TODO: implement storeDrawings
    throw UnimplementedError();
  }

  @override
  Future<void> storeDrawing(Drawing drawing) {
    // TODO: implement storeDrawings
    throw UnimplementedError();
  }
}
