import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'spectator_landing_session_event.dart';
part 'spectator_landing_session_state.dart';

class SpectatorLandingSessionBloc extends Bloc<SpectatorLandingSessionEvent, SpectatorLandingSessionState> {
  SpectatorLandingSessionBloc() : super(SpectatorLandingSessionInitial()) {
    on<SpectatorLandingSessionEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
