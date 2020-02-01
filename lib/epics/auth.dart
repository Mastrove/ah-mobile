import 'package:ah_mobile/models/models.dart';
import 'package:ah_mobile/actions/auth.dart';
import 'package:ah_mobile/api/auth.dart' as api;
import 'package:redux_epics/redux_epics.dart';

Stream<dynamic> _signUpEpic(Stream<SignUpAction> actions, EpicStore<AppState> store) {
  return actions
    .asyncMap((action) async {
      try {
        final response = await api.signUp(action.signUp);
        return AuthSuccessful(response);
      } catch (e) {
        print(e);
        return AuthFailed();
      }
    });
}

Stream<dynamic> _signInEpic(Stream<SignInAction> actions, EpicStore<AppState> store) {
  return actions
    .asyncMap((action) async {
      try {
        final response = await api.signIn(action.signIn);
        return AuthSuccessful(response);
      } catch (e) {
        return AuthFailed();
      }
    });
}

final authEpic = combineEpics<AppState>([
  TypedEpic<AppState, SignUpAction>(_signUpEpic),
  TypedEpic<AppState, SignInAction>(_signInEpic),
]);
