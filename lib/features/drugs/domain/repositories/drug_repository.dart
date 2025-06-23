import 'package:dartz/dartz.dart';
import 'package:doclib/core/errors/failure.dart';
import 'package:doclib/features/drugs/domain/entities/Drug_common_entity.dart';
import 'package:doclib/features/drugs/domain/entities/drug_entity.dart';

abstract class DrugsRepository {
  Future<Either<Failure, List<DrugCommonEntity>>> getCommonDrugs();
}
