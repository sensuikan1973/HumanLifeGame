import 'package:HumanLifeGame/i18n/i18n.dart';
import 'package:HumanLifeGame/models/common/human.dart';
import 'package:HumanLifeGame/models/common/human_life.dart';
import 'package:HumanLifeGame/models/common/life_road.dart';
import 'package:HumanLifeGame/models/common/user.dart';
import 'package:HumanLifeGame/models/play_room/play_room.dart';
import 'package:HumanLifeGame/models/play_room/player_action.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../mocks/mocks.dart';

void main() {
  test('Humans move', () {
    final humanLife = HumanLifeModel(
      title: 'dummy HumanLife',
      author: UserModel('dummyUserId', 'dummyUser', DateTime.now(), DateTime.now()),
      lifeRoad: LifeRoadModel.dummy(), // FIXME: 今はこれでいいけど、LifeRoadModel.dummy はいつか消すので要修正
    );
    final human1 = HumanModel('h1', 'foo');
    final human2 = HumanModel('h2', 'bar');

    final playRoomModel = PlayRoomModel(
      I18n('en'),
      humanLife: humanLife,
      orderedHumans: [human1, human2],
    );

    // 5しか出ないサイコロをセットする
    final dice = MockDice();
    const roll = 5;
    when(dice.roll()).thenReturn(roll);
    playRoomModel.playerAction = PlayerActionModel(dice)..rollDice();

    // 初期位置
    for (final human in playRoomModel.orderedHumans) {
      final position = playRoomModel.positionsByHumanId[human.id];
      expect(position.x, 0);
      expect(position.y, 0);
    }

    // human1 がサイコロを振って進む
    playRoomModel.playerAction = playRoomModel.playerAction; // この再代入がサイコロを振ったことを意味する
    expect(playRoomModel.positionsByHumanId[human1.id].x, roll);

    // human2 がサイコロを振って進む
    playRoomModel.playerAction = playRoomModel.playerAction;
    expect(playRoomModel.positionsByHumanId[human2.id].x, roll);

    // human1 がサイコロを振って進む
    playRoomModel.playerAction = playRoomModel.playerAction;
    expect(playRoomModel.positionsByHumanId[human1.id].x, LifeRoadModel.width - 1);

    // human2 がサイコロを振って進む
    playRoomModel.playerAction = playRoomModel.playerAction;
    expect(playRoomModel.positionsByHumanId[human2.id].x, LifeRoadModel.width - 1);
  });
}
