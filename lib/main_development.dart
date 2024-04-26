import 'package:global_configuration/global_configuration.dart';
import 'package:naggingnelly/app/app.dart';
import 'package:naggingnelly/bootstrap.dart';

final Map<String, String> appSettings = {
  'googleClientId': '114263892494-jje4rupuh2qn2purcnl5255brr9b6lcr.apps.'
      'googleusercontent.com',
};

Future<void> main() async {
  GlobalConfiguration().loadFromMap(appSettings);
  return bootstrap('naggingnelly-dev', () => const App());
}
