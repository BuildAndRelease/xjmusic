import 'dart:convert' as convert;

import 'package:xj_music/data_center/data_center.dart';

import 'audio_source_response_model.dart';

class AudioSourceApi {
  //4.15.8切换音源
  static setAudioSource(String audioSource, String id,
      {void Function(AudioSourceResponseModel response) onResponse,
      void Function(Error error) onError}) async {
    final arg = {"audioSource": audioSource, "id": id};
    await DataCenter.instance.sendMsgToDevice("SetAudioSource", arg,
        onResponse: (String reponse) {
      try {
        final json = convert.jsonDecode(reponse);
        if (json != null && json is Map)
          onResponse?.call(AudioSourceResponseModel(json));
        else
          onError?.call(StateError("json parse failed"));
      } catch (e) {
        onError?.call(e);
      }
    }, onError: onError);
  }
}
