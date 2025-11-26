import 'package:blog_app/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UseCase<SuccessType, Params> {
  const UseCase();

  Future<Either<Failure, SuccessType>> call(Params params);
}

class NoParams {}
