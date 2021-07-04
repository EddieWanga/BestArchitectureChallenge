import 'package:best_architecture_challenge/core/failures.dart';

class AnyFailure extends Failure {}

final anyFailure = AnyFailure();

final anyException = Exception('any exception');