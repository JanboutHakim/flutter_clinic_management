import 'package:dartz/dartz.dart';
import 'package:doclib/core/errors/failure.dart';
import 'package:doclib/features/drugs/domain/entities/Drug_common_entity.dart';
import 'package:doclib/features/drugs/domain/repositories/drug_repository.dart';

class GetCommonDrugsUseCase {
  final DrugsRepository drugsRepository;
  const GetCommonDrugsUseCase(this.drugsRepository);
  Future<Either<Failure, List<DrugCommonEntity>>> call() async {
    return await drugsRepository.getCommonDrugs();
  }
}
