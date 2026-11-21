import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';

/// Opens the phone dialer (no permission needed: the user still taps
/// "call" in the dialer).
@lazySingleton
class CallService {
  /// [phone] in international form, e.g. `+966501234567`. Returns false
  /// when no app could handle the call (e.g. a tablet without a SIM).
  Future<bool> call(String phone) =>
      launchUrl(Uri(scheme: 'tel', path: phone.replaceAll(' ', '')));
}
