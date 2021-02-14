import 'dart:async';

import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:xj_music/broadcast/modify_delay_close_timer_notify.dart';
import 'package:xj_music/data_center/data_center.dart';
import 'package:xj_music/setting/alarm/data_model/alarm_api.dart';
import 'package:xj_music/setting/alarm/data_model/get_delay_close_timer_response_model.dart';

class RoomPlayerDelayTimerPage extends StatefulWidget {
  @override
  _RoomPlayerDelayTimerPageState createState() =>
      _RoomPlayerDelayTimerPageState();
}

class _RoomPlayerDelayTimerPageState extends State<RoomPlayerDelayTimerPage> {
  ValueNotifier<GetDelayCloseTimerResponseModel> _delayTimerResponseModel =
      ValueNotifier(GetDelayCloseTimerResponseModel({}));

  StreamSubscription _delayCloseTimerSubscription;
  TextEditingController _textFieldController =
      TextEditingController.fromValue(TextEditingValue(text: '10'));

  @override
  void initState() {
    _delayCloseTimerSubscription = DataCenter
        .instance.delayTimerNotifyStreamController.stream
        .listen(_delayTimerOnChanged);
    AlarmApi.getDelayCloseTimer(
      onError: (error) => showToast("获取延时定时器失败"),
      onResponse: (response) => _delayTimerResponseModel.value = response,
    );

    super.initState();
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    _delayCloseTimerSubscription?.cancel();
    super.dispose();
  }

  void _delayTimerOnChanged(
      ModifyDelayCloseTimerNotify modifyDelayCloseTimerNotify) {
    _delayTimerResponseModel.value =
        GetDelayCloseTimerResponseModel(modifyDelayCloseTimerNotify.json);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("延时关机列表"),
      ),
      body: ValueListenableBuilder(
        valueListenable: _delayTimerResponseModel,
        builder: (context, value, child) {
          final _timerEnable = value.timerEnable.toString() == "enable";
          final _timerRemain = value.remainTime;
          final _delayCloseAfterTimes = value.delayCloseAfterTimes;
          return ListView.builder(
            itemBuilder: (context, index) {
              bool checked = false;
              String title = "";
              if (index == 0) {
                checked = !_timerEnable;
                title = "无";
              } else if (index == 1) {
                checked = _timerEnable && _delayCloseAfterTimes == "10";
                title = checked ? "10分钟（剩余$_timerRemain分钟）" : "10分钟";
              } else if (index == 2) {
                checked = _timerEnable && _delayCloseAfterTimes == "20";
                title = checked ? "20分钟（剩余$_timerRemain分钟）" : "20分钟";
              } else if (index == 3) {
                checked = _timerEnable && _delayCloseAfterTimes == "30";
                title = checked ? "30分钟（剩余$_timerRemain分钟）" : "30分钟";
              } else if (index == 4) {
                checked = _timerEnable && _delayCloseAfterTimes == "60";
                title = checked ? "60分钟（剩余$_timerRemain分钟）" : "60分钟";
              } else if (index == 5) {
                checked = _timerEnable && _delayCloseAfterTimes == "90";
                title = checked ? "90分钟（剩余$_timerRemain分钟）" : "90分钟";
              } else if (index == 6) {
                checked = _timerEnable &&
                    !["10", "20", "30", "60", "90"]
                        .contains(_delayCloseAfterTimes);
                title = checked
                    ? "$_delayCloseAfterTimes分钟（剩余$_timerRemain分钟）"
                    : "自定义";
              }
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    tileColor: Theme.of(context).backgroundColor,
                    leading: checked
                        ? Icon(Icons.check_circle)
                        : Icon(Icons.radio_button_unchecked),
                    title: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    onTap: () async {
                      String delayColse = "";
                      switch (index) {
                        case 0:
                          delayColse = "0";
                          break;
                        case 1:
                          delayColse = "10";
                          break;
                        case 2:
                          delayColse = "20";
                          break;
                        case 3:
                          delayColse = "30";
                          break;
                        case 4:
                          delayColse = "60";
                          break;
                        case 5:
                          delayColse = "90";
                          break;
                        case 6:
                          delayColse = await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('请输入延时关机时间'),
                                  content: TextField(
                                    onChanged: (value) {},
                                    controller: _textFieldController,
                                    decoration: InputDecoration(
                                        hintText: "请输入整数(单位：分)"),
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "取消",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                        )),
                                    TextButton(
                                        onPressed: () {
                                          final reg = RegExp(r'^[0-9]+$');
                                          if (reg.hasMatch(
                                              _textFieldController.text)) {
                                            Navigator.of(context)
                                                .pop(_textFieldController.text);
                                          } else {
                                            showToast("仅支持整数");
                                          }
                                        },
                                        child: Text(
                                          "确定",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              .copyWith(
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                        )),
                                  ],
                                );
                              });
                          if (delayColse == null) return;
                          break;
                        default:
                          break;
                      }
                      AlarmApi.modifyDelayCloseTimer(
                        delayColse,
                        onError: (error) => showToast("修改延时关机失败"),
                        onResponse: (response) {
                          if (response.resultCode == "0") {
                            if (index == 0) {
                              showToast("已取消延时关机");
                            } else {
                              showToast("已设置延时关机");
                              Navigator.of(context).pop();
                            }
                          } else
                            showToast("修改延时关机失败");
                        },
                      );
                    },
                  ),
                  Divider(
                    height: 0.5,
                  )
                ],
              );
            },
            itemCount: 7,
          );
        },
      ),
    );
  }
}
