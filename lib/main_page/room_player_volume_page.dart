import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:xj_music/host_list/data_model/host_api.dart';

class RoomPlayerVolumePage extends StatefulWidget {
  @override
  _RoomPlayerVolumePageState createState() => _RoomPlayerVolumePageState();
}

class _RoomPlayerVolumePageState extends State<RoomPlayerVolumePage> {
  ValueNotifier<double> _volume = ValueNotifier(31.0);

  @override
  void initState() {
    HostApi.getVolume(
      onResponse: (response) {
        _volume.value = double.tryParse(response.volume) ?? 31;
      },
      onError: (error) {
        showToast("音量获取失败");
        print(error);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("音量"),
          SliderTheme(
              data: const SliderThemeData(
                  trackHeight: 1,
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 4)),
              child: ValueListenableBuilder(
                valueListenable: _volume,
                builder: (context, value, child) {
                  return SizedBox(
                    width: 200,
                    child: Slider(
                      value: value / 31,
                      onChanged: (value) {
                        _volume.value = value * 31;
                      },
                      onChangeEnd: (value) {
                        final volume = num.tryParse("${value * 31}").toInt();
                        HostApi.setVolume("$volume");
                      },
                      activeColor: Theme.of(context).primaryColor,
                      inactiveColor: Theme.of(context).disabledColor,
                    ),
                  );
                },
              )),
          ValueListenableBuilder(
            valueListenable: _volume,
            builder: (context, value, child) {
              return Text("${num.tryParse("$value").toInt()}");
            },
          )
        ],
      ),
    );
  }
}
