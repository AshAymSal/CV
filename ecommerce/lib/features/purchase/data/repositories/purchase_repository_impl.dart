import 'package:ecommernce/core/errors/exceptions.dart';
import 'package:ecommernce/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommernce/core/network/network_info.dart';
import 'package:ecommernce/features/purchase/data/datasourcses/purchase_remote_datasource.dart';
import 'package:ecommernce/features/purchase/domain/entites/purchase.dart';
import 'package:ecommernce/features/purchase/domain/repositories/purchase_repository.dart';

class PurchaseRepositoryImpl implements PurchaseRepository {
  final PurchaseRemoteDataSourceImpl remoteDataSource;
  //final ProductsLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  PurchaseRepositoryImpl({
    required this.remoteDataSource,
    //required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Purchase>>> getSales(
      {required String userId}) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteSales = await remoteDataSource.getSales(userId: userId);
        //print('getFavorites remote' + remoteFavorites.length.toString());
        // localDataSource.cacheFavorites(remotePosts);
        return Right(remoteSales);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Right([]);
    }
  }
}
