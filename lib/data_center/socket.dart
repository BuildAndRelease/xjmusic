import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

const socketDataHeaderLength = 4;
const UDPPort = 18090;
const TCPPort = 20090;
const TCPWAITRESPONSETIME = 5;

class TCPSocket {
  final String _ipAddress;
  final String _port;
  final void Function(String response) _onResponse;
  final void Function(Error error) _onError;

  TCPSocket(this._ipAddress, this._port, this._onResponse, this._onError);

  Socket _socket;

  Timer _timeOutTimer;

  /// 缓存的网络数据，暂未处理（一般这里有数据，说明当前接收的数据不是一个完整的消息，需要等待其它数据的到来拼凑成一个完整的消息） */
  Uint8List _cacheData = Uint8List(0);

  Future initTCPSocket() async {
    try {
      _socket = await Socket.connect(
          this._ipAddress, int.tryParse(this._port) ?? TCPPort,
          timeout: const Duration(seconds: 5));
      _socket.listen(_decodeHandle,
          onError: _errorHandler, onDone: _doneHandler, cancelOnError: false);
    } catch (e) {
      _onError?.call(StateError(e.toString()));
      _socket?.destroy();
      print(e);
    }
  }

  Future dispose() async {
    _socket?.destroy();
    print("socket关闭处理");
  }

  void sendMsg(Uint8List messageBody) {
    final header = Uint8List(4);
    header.buffer.asUint32List()[0] = messageBody.length;

    var msg = messageBody == null
        ? header.buffer.asUint8List()
        : header.buffer.asUint8List() + messageBody.buffer.asUint8List();
    try {
      _socket.add(msg);
      if (_timeOutTimer != null) _timeOutTimer.cancel();
      _timeOutTimer =
          Timer(const Duration(seconds: TCPWAITRESPONSETIME), _responseTimeOut);
    } catch (e) {
      _onError?.call(StateError(e.toString()));
      _socket?.destroy();
    }
  }

  void _responseTimeOut() {
    _onError?.call(StateError("reponse time out"));
    _socket?.destroy();
    _timeOutTimer?.cancel();
  }

  void _decodeHandle(newData) {
    _cacheData = Uint8List.fromList(_cacheData + newData);
    if (_cacheData.length >= socketDataHeaderLength) {
      final msgLen = _cacheData.buffer.asUint32List()[0];
      if (_cacheData.length < msgLen + socketDataHeaderLength) {
        return;
      }
      final messageBody = _cacheData.sublist(socketDataHeaderLength);
      _onResponse?.call(utf8.decode(messageBody));
      _timeOutTimer?.cancel();
      _socket?.destroy();
    }
  }

  void _errorHandler(error, StackTrace trace) {
    _onError?.call(StateError(error.toString()));
    _socket?.destroy();
    print("捕获socket异常信息：error=$error，trace=${trace.toString()}");
  }

  void _doneHandler() {
    _socket?.destroy();
    print("socket完成处理");
  }
}

class UDPSocket {
  final String _port;
  final void Function(String response) _onResponse;
  final void Function(Error error) _onError;

  UDPSocket(this._port, this._onResponse, this._onError);

  RawDatagramSocket _socket;

  Future initUDPSocket() async {
    _socket = await RawDatagramSocket.bind(
        InternetAddress.anyIPv4, int.tryParse(_port) ?? UDPPort);
    _socket.broadcastEnabled = true;
    _socket.readEventsEnabled = true;
    _socket.writeEventsEnabled = true;
    _socket.listen(_decodeHandle,
        onError: _errorHandler, onDone: _doneHandler, cancelOnError: false);
  }

  Future dispose() async {
    _socket?.close();
    print("socket关闭处理");
  }

  void sendMsg(Uint8List messageBody) {
    final header = Uint8List(4);
    header.buffer.asUint32List()[0] = messageBody.length;

    final msg = messageBody == null
        ? header.buffer.asUint8List()
        : header.buffer.asUint8List() + messageBody.buffer.asUint8List();
    try {
      _socket?.send(msg, InternetAddress.tryParse('255.255.255.255'),
          int.tryParse(_port) ?? UDPPort);
    } catch (e) {
      _onError?.call(StateError(e.toString()));
    }
  }

  void _decodeHandle(newData) {
    if (newData == RawSocketEvent.read) {
      Datagram dg = _socket.receive();
      final cacheData = Uint8List.fromList(dg.data);
      if (cacheData.length >= socketDataHeaderLength) {
        final msgLen = cacheData.buffer.asUint32List()[0];
        if (cacheData.length < msgLen + socketDataHeaderLength) {
          return;
        }
        final messageBody = cacheData.sublist(
            socketDataHeaderLength, msgLen + socketDataHeaderLength);
        _onResponse?.call(utf8.decode(messageBody));
      }
    }
  }

  void _errorHandler(error, StackTrace trace) {
    _onError?.call(StateError(error.toString()));
    _socket?.close();
    print("捕获socket异常信息：error=$error，trace=${trace.toString()}");
  }

  void _doneHandler() {
    _socket?.close();
    print("socket完成处理");
  }
}

class MultiBroadCastSocket {
  final String _ipAddress;
  final String _port;
  final void Function(String response) _onResponse;
  final void Function(Error error) _onError;

  MultiBroadCastSocket(
      this._ipAddress, this._port, this._onResponse, this._onError);

  RawDatagramSocket _socket;

  Future initUDPSocket() async {
    _socket = await RawDatagramSocket.bind(
        _ipAddress, int.tryParse(_port) ?? UDPPort);
    _socket?.listen(_decodeHandle,
        onError: _errorHandler, onDone: _doneHandler, cancelOnError: false);
  }

  void sendMsg(Uint8List messageBody) {
    final header = ByteData(socketDataHeaderLength);
    header.setInt64(0, socketDataHeaderLength);
    final msg = messageBody == null
        ? header.buffer.asUint8List()
        : header.buffer.asUint8List() + messageBody.buffer.asUint8List();
    try {
      _socket?.send(
          msg, InternetAddress.anyIPv4, int.tryParse(_port) ?? UDPPort);
    } catch (e) {
      _onError?.call(StateError(e.toString()));
    }
  }

  void _decodeHandle(newData) {
    final cacheData = Int8List.fromList(newData);
    if (cacheData.length >= socketDataHeaderLength) {
      var msgLen = cacheData.buffer.asByteData().getInt64(0);
      if (cacheData.length < msgLen + socketDataHeaderLength) {
        return;
      }
      Int8List messageBody = cacheData.sublist(socketDataHeaderLength, msgLen);
      _onResponse?.call(utf8.decode(messageBody));
    }
  }

  void _errorHandler(error, StackTrace trace) {
    _onError?.call(StateError(error.toString()));
    _socket?.close();
    print("捕获socket异常信息：error=$error，trace=${trace.toString()}");
  }

  void _doneHandler() {
    _socket?.close();
    print("socket关闭处理");
  }
}
