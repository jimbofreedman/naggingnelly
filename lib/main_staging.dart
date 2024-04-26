import 'package:global_configuration/global_configuration.dart';
import 'package:naggingnelly/app/app.dart';
import 'package:naggingnelly/bootstrap.dart';

final Map<String, String> appSettings = {
  'googleClientId': '350365535909-13moocb1dk14nh76epsihct9lusvgrbd.apps.'
      'googleusercontent.com',
};

Future<void> main() async {
  GlobalConfiguration().loadFromMap(appSettings);
  return bootstrap('naggingnelly-staging', () => const App());
}
