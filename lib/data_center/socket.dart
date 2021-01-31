import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

const socketDataHeaderLength = 4;

class TCPSocket {
  final String ipAddress;
  final String port;
  final void Function(String response) onResponse;
  final void Function(Error error) onError;

  TCPSocket(this.ipAddress, this.port, this.onResponse, this.onError);

  Socket _socket;

  /// 缓存的网络数据，暂未处理（一般这里有数据，说明当前接收的数据不是一个完整的消息，需要等待其它数据的到来拼凑成一个完整的消息） */
  Uint8List _cacheData = Uint8List(0);

  Future initTCPSocket() async {
    try {
      _socket = await Socket.connect(
          this.ipAddress, int.tryParse(this.port) ?? 20090,
          timeout: const Duration(seconds: 5));
      _socket.listen(_decodeHandle,
          onError: _errorHandler, onDone: _doneHandler, cancelOnError: false);
    } catch (e) {
      onError?.call(StateError(e.toString()));
      _socket?.destroy();
      print("socket 初始化失败$e");
    }
  }

  Future dispose() async {
    _socket.destroy();
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
    } catch (e) {
      onError?.call(StateError(e.toString()));
    }
  }

  void _decodeHandle(newData) {
    _cacheData = Uint8List.fromList(_cacheData + newData);
    if (_cacheData.length >= socketDataHeaderLength) {
      final msgLen = _cacheData.buffer.asUint32List()[0];
      if (_cacheData.length < msgLen + socketDataHeaderLength) {
        return;
      }
      final messageBody = _cacheData.sublist(socketDataHeaderLength);
      onResponse(utf8.decode(messageBody));
    }
  }

  void _errorHandler(error, StackTrace trace) {
    onError?.call(StateError(error.toString()));
    _socket.close();
    print("捕获socket异常信息：error=$error，trace=${trace.toString()}");
  }

  void _doneHandler() {
    _socket.destroy();
    print("socket完成处理");
  }
}

class UDPSocket {
  final String port;
  final void Function(String response) onResponse;
  final void Function(Error error) onError;

  UDPSocket(this.port, this.onResponse, this.onError);

  RawDatagramSocket _socket;

  Future initUDPSocket() async {
    _socket = await RawDatagramSocket.bind(
        InternetAddress.anyIPv4, int.tryParse(port) ?? 18090);
    _socket.broadcastEnabled = true;
    _socket.readEventsEnabled = true;
    _socket.writeEventsEnabled = true;
    _socket.listen(_decodeHandle,
        onError: _errorHandler, onDone: _doneHandler, cancelOnError: false);
  }

  Future dispose() async {
    _socket.close();
    print("socket关闭处理");
  }

  void sendMsg(Uint8List messageBody) {
    final header = Uint8List(4);
    header.buffer.asUint32List()[0] = messageBody.length;

    final msg = messageBody == null
        ? header.buffer.asUint8List()
        : header.buffer.asUint8List() + messageBody.buffer.asUint8List();
    try {
      _socket.send(msg, InternetAddress.tryParse('255.255.255.255'),
          int.tryParse(port) ?? 18090);
    } catch (e) {
      onError?.call(StateError(e.toString()));
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
        onResponse(utf8.decode(messageBody));
      }
    }
  }

  void _errorHandler(error, StackTrace trace) {
    onError?.call(StateError(error.toString()));
    _socket.close();
    print("捕获socket异常信息：error=$error，trace=${trace.toString()}");
  }

  void _doneHandler() {
    _socket.close();
    print("socket完成处理");
  }
}

class MultiBroadCastSocket {
  final String ipAddress;
  final String port;
  final void Function(String response) onResponse;
  final void Function(Error error) onError;

  MultiBroadCastSocket(
      this.ipAddress, this.port, this.onResponse, this.onError);

  RawDatagramSocket socket;

  Future initUDPSocket() async {
    socket =
        await RawDatagramSocket.bind(ipAddress, int.tryParse(port) ?? 18090);
    // socket.m
    socket.listen(_decodeHandle,
        onError: _errorHandler, onDone: _doneHandler, cancelOnError: false);
  }

  void sendMsg(Uint8List messageBody) {
    final header = ByteData(socketDataHeaderLength);
    header.setInt64(0, socketDataHeaderLength);
    final msg = messageBody == null
        ? header.buffer.asUint8List()
        : header.buffer.asUint8List() + messageBody.buffer.asUint8List();
    try {
      socket.send(msg, InternetAddress.anyIPv4, int.tryParse(port) ?? 18090);
    } catch (e) {
      onError?.call(StateError(e.toString()));
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
      onResponse(utf8.decode(messageBody));
    }
  }

  void _errorHandler(error, StackTrace trace) {
    onError?.call(StateError(error.toString()));
    socket.close();
    print("捕获socket异常信息：error=$error，trace=${trace.toString()}");
  }

  void _doneHandler() {
    print("socket关闭处理");
  }
}
