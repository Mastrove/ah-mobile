import 'package:ah_mobile/models/models.dart';
import 'package:ah_mobile/reducers/reducer.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:ah_mobile/epics/epics.dart';

final store = Store<AppState>(
  reducers,
  initialState: AppState(),
  middleware: [EpicMiddleware(epics)]
);
