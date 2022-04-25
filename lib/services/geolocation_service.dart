import 'package:geolocator/geolocator.dart';

abstract class GeolocationServiceInterface {
  // ignore: unused_element
  Future<bool> _enabledService();
  // ignore: unused_element
  Future<void> _requestPermission();
  bool isPermissionEnabled();
  Future<Position> getPosition();
  Future<bool> start();
}

class GeolocationService implements GeolocationServiceInterface {
  bool _serviceEnabled = false;
  LocationPermission _permission = LocationPermission.denied;

  @override
  Future<bool> _enabledService() async {
    // Test if location services are enabled.
    _serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!_serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    return Future.sync(() => true);
  }

  @override
  Future<void> _requestPermission() async {
    _permission = await Geolocator.checkPermission();
    if (_permission == LocationPermission.denied) {
      _permission = await Geolocator.requestPermission();
    }
    return Future.sync(() => null);
  }

  @override
  bool isPermissionEnabled() {
    if (_permission == LocationPermission.denied ||
        _permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }

  @override
  Future<Position> getPosition() async {
    if (!isPermissionEnabled()) {
      return Future.error('Permissão negada');
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  Future<bool> start() async {
    bool enabled = await _enabledService();

    if (enabled) {
      await _requestPermission();
      return Future.sync(() => true);
    }
    return Future.sync(() => false);
  }
}
