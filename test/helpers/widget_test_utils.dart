import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

/// Ejecuta [body] ignorando los errores derivados de `Image.network`,
/// evitando que las excepciones por carga de recursos remotos rompan las pruebas.
Future<void> runWithNetworkImageMocks(Future<void> Function() body) async {
  final FlutterExceptionHandler? originalHandler = FlutterError.onError;

  FlutterError.onError = (FlutterErrorDetails details) {
    if (details.exception is NetworkImageLoadException) {
      return;
    }
    originalHandler?.call(details);
  };

  try {
    await body();
  } finally {
    FlutterError.onError = originalHandler;
  }
}

/// Registra handlers sobre el BinaryMessenger para responder
/// peticiones de assets con una imagen transparente.
void registerMockAssets() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const StringCodec stringCodec = StringCodec();
  const StandardMessageCodec standardCodec = StandardMessageCodec();
  final Uint8List transparentBytes = base64Decode(
    'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/x8AAwMB/er3xR0AAAAASUVORK5CYII=',
  );
  final ByteData transparentByteData = ByteData.view(transparentBytes.buffer);
  final ByteData emptyManifest = standardCodec.encodeMessage(<Object?, Object?>{
    'info': const <Object?>[],
    'assets': const <Object?>[],
  })!;

  ServicesBinding.instance.defaultBinaryMessenger.setMockMessageHandler(
    'flutter/assets',
    (ByteData? message) async {
      final String? key = stringCodec.decodeMessage(message);
      if (key == null) return null;
      if (key == 'AssetManifest.json') {
        return stringCodec.encodeMessage('{}');
      }
      if (key == 'AssetManifest.bin') {
        return emptyManifest;
      }
      if (key.endsWith('.svg')) {
        const String svg = '<svg xmlns="http://www.w3.org/2000/svg" width="1" height="1"></svg>';
        final Uint8List bytes = Uint8List.fromList(svg.codeUnits);
        return ByteData.view(bytes.buffer);
      }
      return transparentByteData;
    },
  );
}

/// Genera un árbol de prueba estándar para widgets que requieren assets.
Widget wrapWithFakeAssetBundle(Widget child) {
  registerMockAssets();
  return MaterialApp(home: Scaffold(body: child));
}
