import 'package:dartz/dartz.dart';
import 'package:reservas_app/core/errors/failure.dart';
import 'package:reservas_app/features/data/datasources/lista_precio_remote_data_source.dart';
import 'package:reservas_app/features/domain/entities/lista_precio.dart';
import 'package:reservas_app/features/domain/repositories/lista_precio_repository.dart';

class ListaPrecioRepositoryImpl implements ListaPrecioRepository {
  final ListaPrecioRemoteDataSource remoteDataSource;

  ListaPrecioRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<ListaPrecio>>> getAll() async {
    final resp = await remoteDataSource.getAll();
    return resp.fold(
      (failure) => Left(failure),
      (list) => Right(list),
    );
  }

  @override
  Future<Either<Failure, Unit>> create(ListaPrecio listaPrecio) async {
    return await remoteDataSource.createListaPrecio(
      listaPrecio.valor,
      listaPrecio.idTipoHospedaje,
      listaPrecio.idTipoPrecio,
    );
  }

  @override
  Future<Either<Failure, Unit>> update(ListaPrecio listaPrecio) async {
    return await remoteDataSource.updateListaPrecio(
      listaPrecio.idListaPrecio,
      listaPrecio.valor,
      listaPrecio.idTipoHospedaje,
      listaPrecio.idTipoPrecio,
    );
  }

  @override
  Future<Either<Failure, Unit>> delete(int id) async {
    return await remoteDataSource.deleteListaPrecio(id);
  }
}