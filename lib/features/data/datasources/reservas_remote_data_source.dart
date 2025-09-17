import 'package:dartz/dartz.dart';
import 'package:reservas_app/core/errors/failure.dart';
import 'package:reservas_app/core/network/dio_client.dart';
import 'package:reservas_app/features/data/models/reservas_model.dart';

abstract class ReservasRemoteDataSource {
  Future<Either<Failure, List<ReservasModel>>> getReservas();
}

class ReservasRemoteDataSourceImpl implements ReservasRemoteDataSource {
  // Assuming dioClient is already defined and initialized
  final DioClient dioClient;
  static const String _reservasEndpoint = '/reserva/advance';

  ReservasRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<Either<Failure, List<ReservasModel>>> getReservas() async {
    try {
      final response = await dioClient.dio.post(_reservasEndpoint);
      if (response.statusCode == 200) {
        final List<ReservasModel> data = (response.data['data'] as List)
            .map((jsonItem) => ReservasModel.fromJson(jsonItem))
            .toList();

        return Right(data);
      } else {
        return Left(ServerFailure(message: 'Error fetching reservas'));
      }
    } catch (e) {
      return Left(
        ServerFailure(message: 'Error fetching reservas: ${e.toString()}'),
      );
    }
  }
}
