import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui show Codec;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_image_platform_interface/cached_network_image_platform_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';

import '../../page/lost_connection/lost_connection_page.dart';
import 'custom_image_loader.dart';

// ignore: must_be_immutable
class ImageHandler extends CachedNetworkImageProvider {
  ImageHandler(
    super.url, {
    this.fallbackImage = 'assets/images/image_unavailable.png',
    this.maxRetries = 3,
    this.retryInterval = 200,
    this.useFallback = true,
  });

  @override
  ErrorListener? get errorListener => (Object o) {
        if (!useFallback) {
          if (o is SocketException || o is HttpException) {
            Get.offAll<void>(() => const LostConnectionPage());
          } else {
            throw Exception('Error loading image: $o');
          }
        }
        if (retryCounter < maxRetries) {
          retryCounter++;
        } else {
          hasError = true;
        }
      };
  final String fallbackImage;
  //Number of times to retry loading the image
  final int maxRetries;

  //Interval between retries
  final int retryInterval;

  //useFallback is true if the fallback image should be used
  final bool useFallback;

  late AssetBundleImageKey fallbackImageKey;

  bool hasError = false;

  int retryCounter = 0;

  @override
  ImageStreamCompleter loadImage(
    CachedNetworkImageProvider key,
    ImageDecoderCallback decode,
  ) {
    final StreamController<ImageChunkEvent> chunkEvents =
        StreamController<ImageChunkEvent>();
    final MultiImageStreamCompleter imageStreamCompleter =
        MultiImageStreamCompleter(
      codec: _loadImageAsync(key, chunkEvents, decode),
      chunkEvents: chunkEvents.stream,
      scale: key.scale,
      informationCollector: () sync* {
        yield DiagnosticsProperty<ImageProvider>(
          'Image provider: $this \n Image key: $key',
          this,
          style: DiagnosticsTreeStyle.errorProperty,
        );
      },
    );

    if (errorListener != null) {
      imageStreamCompleter.addListener(
        ImageStreamListener(
          (ImageInfo image, bool synchronousCall) {},
          onError: (Object error, StackTrace? trace) {
            errorListener?.call(error);
          },
        ),
      );
    }

    return imageStreamCompleter;
  }

  Stream<ui.Codec> _loadImageAsync(
    CachedNetworkImageProvider key,
    StreamController<ImageChunkEvent> chunkEvents,
    ImageDecoderCallback decode,
  ) {
    assert(key == this, 'The key for the image stream should be this');
    return CustomImageLoader().loadImageAsync(
      url,
      cacheKey,
      chunkEvents,
      decode,
      cacheManager ?? DefaultCacheManager(),
      maxHeight,
      maxWidth,
      headers,
      fallbackImage,
      useFallback,
      hasError,
      retryInterval,
      () => PaintingBinding.instance.imageCache.evict(key),
    );
  }
}

class ErrorImageStreamCompleter extends ImageStreamCompleter {
  void setError(Object error, StackTrace stackTrace) {
    reportError(
      context: ErrorDescription('Error in ImageStreamCompleter'),
      exception: error,
      stack: stackTrace,
    );
  }
}
