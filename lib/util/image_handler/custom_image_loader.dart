import 'dart:async';
import 'dart:ui' as ui;

// ignore: depend_on_referenced_packages, implementation_imports
import 'package:file/src/interface/file.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

/// ImageLoader class to load images on IO platforms.
class CustomImageLoader {
  Stream<ui.Codec> loadImageAsync(
    String url,
    String? cacheKey,
    StreamController<ImageChunkEvent> chunkEvents,
    ImageDecoderCallback decode,
    BaseCacheManager cacheManager,
    int? maxHeight,
    int? maxWidth,
    Map<String, String>? headers,
    String? fallbackImage,
    // ignore: avoid_positional_boolean_parameters
    bool useFallback,
    bool hasError,
    int retryInterval,
    VoidCallback evictImage,
  ) {
    return _load(
      url,
      cacheKey,
      chunkEvents,
      (Uint8List bytes) async {
        final ui.ImmutableBuffer buffer =
            await ImmutableBuffer.fromUint8List(bytes);
        return decode(buffer);
      },
      cacheManager,
      maxHeight,
      maxWidth,
      headers,
      fallbackImage,
      useFallback,
      hasError,
      retryInterval,
      evictImage,
    );
  }

  Stream<ui.Codec> _load(
    String url,
    String? cacheKey,
    StreamController<ImageChunkEvent> chunkEvents,
    Future<ui.Codec> Function(Uint8List) decode,
    BaseCacheManager cacheManager,
    int? maxHeight,
    int? maxWidth,
    Map<String, String>? headers,
    String? fallbackImage,
    bool useFallback,
    bool hasError,
    int retryInterval,
    VoidCallback evictImage,
  ) async* {
    Stream<FileResponse> stream = const Stream<FileResponse>.empty();
    try {
      assert(
          cacheManager is ImageCacheManager ||
              (maxWidth == null && maxHeight == null),
          'To resize the image with a CacheManager the '
          'CacheManager needs to be an ImageCacheManager. maxWidth and '
          'maxHeight will be ignored when a normal CacheManager is used.');
      stream = cacheManager is ImageCacheManager
          ? cacheManager.getImageFile(
              url,
              maxHeight: maxHeight,
              maxWidth: maxWidth,
              withProgress: true,
              headers: headers,
              key: cacheKey,
            )
          : cacheManager.getFileStream(
              url,
              withProgress: true,
              headers: headers,
              key: cacheKey,
            );

      await for (final FileResponse result in stream) {
        if (result is DownloadProgress) {
          chunkEvents.add(
            ImageChunkEvent(
              cumulativeBytesLoaded: result.downloaded,
              expectedTotalBytes: result.totalSize,
            ),
          );
        }
        if (result is FileInfo) {
          final File file = result.file;
          final Uint8List bytes = await file.readAsBytes();
          final ui.Codec decoded = await decode(bytes);
          yield decoded;
        }
      }
    } on Object {
      // Depending on where the exception was thrown, the image cache may not
      // have had a chance to track the key in the cache at all.
      // Schedule a microtask to give the cache a chance to add the key.
      scheduleMicrotask(() {
        evictImage();
      });

      if (fallbackImage != null && useFallback && !hasError) {
        await Future<void>.delayed(Duration(milliseconds: retryInterval));
        yield await decode(
          (await rootBundle.load(fallbackImage)).buffer.asUint8List(),
        );

        rethrow;
      } else {
        rethrow;
      }
    } finally {
      await chunkEvents.close();
    }
  }
}
