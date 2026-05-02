import 'package:equatable/equatable.dart';

class VolumeConfig extends Equatable {
  final double volume;
  final bool isMuted;

  const VolumeConfig({required this.volume, required this.isMuted});

  @override
  List<Object> get props => [volume, isMuted];

  VolumeConfig copyWith({double? volume, bool? isMuted}) {
    return VolumeConfig(
      volume: volume ?? this.volume,
      isMuted: isMuted ?? this.isMuted,
    );
  }
}
