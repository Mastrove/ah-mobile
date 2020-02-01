import 'package:redux_epics/redux_epics.dart';
import 'auth.dart';

final epics = combineEpics([
  authEpic,
]);
