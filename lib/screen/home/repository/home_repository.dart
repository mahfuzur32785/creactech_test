import 'package:dartz/dartz.dart';
import 'package:tests/core/data/remote_data_source.dart';

import 'package:tests/core/error/exception.dart';
import 'package:tests/core/error/failure.dart';
import 'package:tests/model/home_model.dart';

abstract class HomeRepository {
  Future<Either<Failure, HomeModel>> getHomeData();
}

class HomeRepositoryImp extends HomeRepository {
  final RemoteDataSource remoteDataSource;
  HomeRepositoryImp({required this.remoteDataSource});

  @override
  Future<Either<Failure, HomeModel>> getHomeData() async {
    try {
      final result = await remoteDataSource.getHomeData();
      return right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}