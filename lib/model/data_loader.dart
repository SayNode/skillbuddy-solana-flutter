import 'dart:async';

import 'package:get/get.dart';

/// A generic data loader class that handles loading and reloading of data.
///
/// The [DataLoader] class is designed to manage the state of data loading
/// operations. It ensures that data is loaded and stored in a reactive manner.
///
/// Type parameter:
/// - [T]: The type of data being loaded.
///
/// [_initialDataLoaded] indicates whether the initial data has been loaded.
///
/// [isLoading] indicates whether a loading operation is currently in progress.
///
/// Example usage:
/// ```dart
/// final dataLoader = DataLoader<String>(
///   data: 'Initial Data',
///   loaderCallback: functionToLoadData(),
/// );
/// print(dataLoader.data); // Outputs: 'Initial Data'
/// await dataLoader.reload();
/// print(dataLoader.data); // Outputs: 'Loaded Data'
/// ```
class DataLoader<T> {
  /// Creates a [DataLoader] with the given initial [data] and [loaderCallback].
  ///
  /// The [data] parameter must not be of type [Rx].
  DataLoader({
    required T data,
    required this.loaderCallback,
  })  : assert(data is! Rx, 'Data must not be a Rx type'),
        _data = data.obs;

  /// The reactive data being managed by this loader.
  final Rx<T> _data;

  /// Indicates whether the initial data has been loaded.
  final RxBool _initialDataLoaded = false.obs;

  /// Indicates whether a loading operation is currently in progress.
  RxBool isLoading = false.obs;

  /// The callback function that loads the data.
  FutureOr<T> Function() loaderCallback;

  ///Automaticall fetch data if initialData hasnt been loaded yet and is not currently loading.
  Future<void> _autoFetchData() async {
    if (!_initialDataLoaded.value && !isLoading.value) {
      await _loadData();
    }
  }

  //Gets _initialDataLoaded. If the initial data has not been loaded, it triggers the loading process.
  RxBool get initialDataLoaded {
    _autoFetchData();
    return _initialDataLoaded;
  }

  /// Gets the current data. If the initial data has not been loaded, it triggers the loading process.
  Rx<T> get data {
    _autoFetchData();
    return _data;
  }

  /// Reloads the data by invoking the [loaderCallback].
  Future<void> reload() async {
    isLoading.value = false;
    await _loadData();
  }

  /// Loads the data by invoking the [loaderCallback] and updates the reactive data.
  Future<void> _loadData() async {
    if (isLoading.value) {
      return;
    }
    isLoading.value = true;
    final FutureOr<T> result = loaderCallback();
    if (result is Future<T>) {
      _data.value = await result;
    } else {
      _data.value = result;
    }
    _refreshList();
    isLoading.value = false;
    _initialDataLoaded.value = true;
  }

  /// Refreshes the data if the data is a list.
  void _refreshList() {
    if (T is List) {
      _data.refresh();
    }
  }
}
