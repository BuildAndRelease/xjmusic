import 'package:flutter/material.dart';
import 'package:xj_music/util/utils.dart';

class AudioProgressIndicator extends StatefulWidget {
  final ValueNotifier<double> progress;
  final ValueNotifier<Duration> duration;
  final double progressHeight;
  final double height;
  final double width;
  final Color inactiveColor;
  final Color activeColor;
  final Function(double progress) progressOnChanged;

  const AudioProgressIndicator(this.progress,
      {this.height = 6,
      this.width = double.infinity,
      this.progressHeight = 2.5,
      this.duration,
      this.inactiveColor = Colors.white,
      this.activeColor = Colors.blue,
      this.progressOnChanged});

  @override
  _AudioProgressIndicatorState createState() => _AudioProgressIndicatorState();
}

class _AudioProgressIndicatorState extends State<AudioProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(color: Colors.white, fontSize: 12);
    final windowWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      height: widget.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ValueListenableBuilder(
            valueListenable: widget.progress,
            builder: (context, value, child) {
              return Text(
                formatCountdownTime(
                    (value * widget.duration.value.inSeconds).toInt()),
                style: textStyle,
              );
            },
          ),
          SizedBox(
            width: windowWidth - 100,
            child: ValueListenableBuilder(
                valueListenable: widget.progress,
                builder: (context, value, child) {
                  return SliderTheme(
                      data: const SliderThemeData(
                          trackHeight: 1,
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 4)),
                      child: Slider(
                        value: value,
                        onChanged: (value) {
                          widget.progressOnChanged?.call(value);
                        },
                        activeColor: widget.activeColor,
                        inactiveColor: widget.inactiveColor,
                      ));
                }),
          ),
          ValueListenableBuilder(
            valueListenable: widget.duration,
            builder: (context, value, child) {
              return Text(
                formatCountdownTime(value.inSeconds),
                style: textStyle,
              );
            },
          ),
        ],
      ),
    );
  }
}
