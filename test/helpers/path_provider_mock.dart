import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class FakePathProvider extends PathProviderPlatform {
  @override
  Future<String?> getTemporaryPath() async => '/tmp';

  @override
  Future<String?> getApplicationSupportPath() async => '/tmp';

  @override
  Future<String?> getApplicationDocumentsPath() async => '/tmp';

  @override
  Future<String?> getApplicationCachePath() async => '/tmp';

  @override
  Future<String?> getLibraryPath() async => '/tmp';

  @override
  Future<String?> getExternalStoragePath() async => '/tmp';

  @override
  Future<List<String>?> getExternalCachePaths() async => ['/tmp'];

  @override
  Future<List<String>?> getExternalStoragePaths({
    StorageDirectory? type,
  }) async =>
      ['/tmp'];

  @override
  Future<String?> getDownloadsPath() async => '/tmp';
}

void setUpPathProviderMock() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  PathProviderPlatform.instance = FakePathProvider();
}