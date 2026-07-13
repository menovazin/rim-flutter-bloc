import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../api/constants/api_constants.dart';
import 'dto/page_response.dart';

part 'rick_and_morty_api.g.dart';

@module
abstract class RickAndMortyApiModule {
  @lazySingleton
  RickAndMortyApi getInstance(Dio dio) =>
      RickAndMortyApi(dio, baseUrl: ApiConstants.baseUrl);
}

@RestApi()
abstract class RickAndMortyApi {
  factory RickAndMortyApi(Dio dio, {String baseUrl}) = _RickAndMortyApi;

  @GET(ApiConstants.characterPath)
  Future<PageResponse> getCharacters(@Query('page') int page);

  @GET(ApiConstants.episodePath)
  Future<PageResponse> getEpisodes(@Query('page') int page);

  @GET(ApiConstants.locationPath)
  Future<PageResponse> getLocations(@Query('page') int page);
}
