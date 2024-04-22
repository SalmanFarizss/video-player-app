import 'package:fpdart/fpdart.dart';
import 'commons/failure.dart';

typedef FutureEither<T> = Future<Either<Failure,T>>;
typedef FutureVoid = Future<Either<Failure, void>>;
