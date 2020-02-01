import 'package:ah_mobile/models/models.dart';
import 'auth.dart';


AppState reducers(AppState state, action) => AppState(
  auth: authReducer(state.auth, action),
);
