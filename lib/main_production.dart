import 'package:global_configuration/global_configuration.dart';
import 'package:naggingnelly/app/app.dart';
import 'package:naggingnelly/bootstrap.dart';

final Map<String, String> appSettings = {
  'googleClientId': '52841464896-f09lnvit175mh90o8ctajevibh29kq9d.apps.'
      'googleusercontent.com',
};

Future<void> main() async {
  GlobalConfiguration().loadFromMap(appSettings);
  return bootstrap('naggingnelly-prod', () => const App());
}
