import 'package:dartz/dartz.dart';
import 'package:doclib/core/errors/failure.dart';
import 'package:doclib/features/drugs/data/datasources/drug_remote_data_source.dart';
import 'package:doclib/features/drugs/domain/entities/Drug_common_entity.dart';
import 'package:doclib/features/drugs/domain/repositories/drug_repository.dart';

class DrugRepoImpl implements DrugsRepository {
  final DrugRemoteDataSource drugRemoteDataSource;
  const DrugRepoImpl(this.drugRemoteDataSource);
  @override
  Future<Either<Failure, List<DrugCommonEntity>>> getCommonDrugs() async {
    try {
      final res = await drugRemoteDataSource.getAllDrugs();

      return Right(res);
    } catch (e) {
      return left(ServerFailure());
    }
  }
}
