import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

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
