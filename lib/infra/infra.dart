import 'human_life_repository.dart';
import 'play_room_repository.dart';

class Infra {
  Infra(
    this._humanLifeRepository,
    this._playRoomRepository,
  );

  final HumanLifeRepository _humanLifeRepository;
  HumanLifeRepository get humanLifeRepository => _humanLifeRepository;

  final PlayRoomRepository _playRoomRepository;
  PlayRoomRepository get playRoomRepository => _playRoomRepository;
}
