import 'package:naggingnelly/app/app.dart';
import 'package:naggingnelly/bootstrap.dart';

Future<void> main() async {
  return bootstrap('naggingnelly-staging', () => const App());
}
