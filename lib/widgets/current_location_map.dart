import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CurrentLocationMap extends StatefulWidget {
  final double height;
  final bool isWorkerMarker;
  const CurrentLocationMap({super.key, this.height = 260, this.isWorkerMarker = false});

  @override
  State<CurrentLocationMap> createState() => _CurrentLocationMapState();
}

class _CurrentLocationMapState extends State<CurrentLocationMap> {
  final Completer<GoogleMapController> _mapCtrl = Completer<GoogleMapController>();
  LatLng? _me;
  String? _error;
  BitmapDescriptor? _personIcon;
  bool _locating = false;

  static const LatLng _fallback = LatLng(4.7110, -74.0721); // Bogotá

  @override
  void initState() {
    super.initState();
    _prepareMarkerIcon();
    _initLocation();
  }

  Future<void> _prepareMarkerIcon() async {
    try {
      final icon = await _buildPersonIcon(isWorker: widget.isWorkerMarker);
      if (mounted) {
        setState(() => _personIcon = icon);
      }
    } catch (_) {
      // Si falla, se usará el marcador por defecto.
    }
  }

  Future<void> _initLocation() async {
    if (_locating) return;
    setState(() {
      _locating = true;
      _error = null;
    });
    try {
      LocationPermission perm = await Geolocator.checkPermission();
      if (perm == LocationPermission.denied) {
        perm = await Geolocator.requestPermission();
      }
      if (perm == LocationPermission.denied || perm == LocationPermission.deniedForever) {
        setState(() => _error = 'Permiso de ubicación denegado');
        return;
      }
      Position? pos;
      try {
        pos = await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
        );
      } catch (_) {
        pos = await Geolocator.getLastKnownPosition();
      }
      if (!mounted) return;
      if (pos == null) {
        setState(() => _error = 'No se pudo obtener tu ubicación');
        return;
      }
      final target = LatLng(pos.latitude, pos.longitude);
      setState(() {
        _me = target;
        _error = null;
      });
      final ctrl = await _mapCtrl.future;
      await ctrl.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: target, zoom: 15),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _error = 'No se pudo obtener la ubicación');
    } finally {
      if (mounted) {
        setState(() => _locating = false);
      }
    }
  }

  Set<Marker> _markers() {
    if (_me == null) return {};
    final icon = _personIcon ?? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure);
    return {
      Marker(
        markerId: const MarkerId('me'),
        position: _me!,
        icon: icon,
        anchor: const Offset(0.5, 0.5),
        infoWindow: const InfoWindow(title: 'Tu ubicación'),
      ),
    };
  }

  Future<BitmapDescriptor> _buildPersonIcon({required bool isWorker}) async {
    const double size = 64;
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final bgColor = isWorker ? const Color(0xFF6D4C41) : const Color(0xFF1E88E5);
    final paintBg = Paint()
      ..color = bgColor
      ..style = PaintingStyle.fill;
    final center = const Offset(size / 2, size / 2);
    canvas.drawCircle(center, size / 2, paintBg);

    final paintBorder = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    canvas.drawCircle(center, size / 2 - 3, paintBorder);

    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    final icon = isWorker ? Icons.engineering : Icons.person;
    textPainter.text = TextSpan(
      text: String.fromCharCode(icon.codePoint),
      style: TextStyle(
        fontSize: size * 0.48,
        fontFamily: icon.fontFamily,
        color: Colors.white,
        package: icon.fontPackage,
      ),
    );
    textPainter.layout();
    final offset = center - Offset(textPainter.width / 2, textPainter.height / 2);
    textPainter.paint(canvas, offset);

    final img = await recorder.endRecording().toImage(size.toInt(), size.toInt());
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());
  }

  @override
  Widget build(BuildContext context) {
    final initial = _me ?? _fallback;
    final markers = _markers();
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        height: widget.height,
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(target: initial, zoom: 12),
              onMapCreated: (c) {
                if (!_mapCtrl.isCompleted) _mapCtrl.complete(c);
              },
              zoomControlsEnabled: true,
              zoomGesturesEnabled: true,
              scrollGesturesEnabled: true,
              rotateGesturesEnabled: true,
              tiltGesturesEnabled: true,
              myLocationEnabled: _me != null,
              myLocationButtonEnabled: true,
              markers: markers,
              mapType: MapType.normal,
              compassEnabled: true,
            ),
            Positioned(
              right: 12,
              bottom: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  FloatingActionButton.small(
                    heroTag: 'recenter-map',
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blueGrey,
                    onPressed: _initLocation,
                    child: _locating
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.my_location),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            if (_error != null)
              Positioned(
                left: 8,
                right: 8,
                bottom: 8,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _error!,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
