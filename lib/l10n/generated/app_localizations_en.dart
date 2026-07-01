// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get flag => '🇬🇧';

  @override
  String get languageName => 'English';

  @override
  String get theme => 'Theme';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get system => 'Use device settings';

  @override
  String get fieldMustNotEmpty => 'Field must not be empty';

  @override
  String get incorrectEmail => 'Incorrect email';

  @override
  String get confirm => 'Confirm';

  @override
  String get cancel => 'Cancel';

  @override
  String get tabCharacters => 'Characters';

  @override
  String get tabEpisodes => 'Episodes';

  @override
  String get tabLocations => 'Locations';

  @override
  String get menuSignOut => 'Sign Out';

  @override
  String get loginTitle => 'Rick & Morty';

  @override
  String get loginSubtitle => 'Sign in to open the portal';

  @override
  String get loginNameLabel => 'Name';

  @override
  String get loginSignInButton => 'Sign In';

  @override
  String get detailSpecies => 'Species';

  @override
  String get detailType => 'Type';

  @override
  String get detailGender => 'Gender';

  @override
  String get detailOrigin => 'Origin';

  @override
  String get detailLocation => 'Location';

  @override
  String sectionEpisodesCount(int count) {
    return 'Episodes ($count)';
  }

  @override
  String sectionResidentsCount(int count) {
    return 'Residents ($count)';
  }

  @override
  String sectionCharactersCount(int count) {
    return 'Characters ($count)';
  }

  @override
  String get noResidentsMessage => 'No residents';

  @override
  String get errorLoadDataMessage => 'Failed to load data';

  @override
  String get retryButton => 'Retry';
}
