import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../api/constants/api_constants.dart';
import 'dto/character_dto.dart';
import 'dto/episode_dto.dart';
import 'dto/location_dto.dart';
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
  Future<PageResponse<CharacterDto>> getCharacters(@Query('page') int page);

  @GET(ApiConstants.episodePath)
  Future<PageResponse<EpisodeDto>> getEpisodes(@Query('page') int page);

  @GET(ApiConstants.locationPath)
  Future<PageResponse<LocationDto>> getLocations(@Query('page') int page);
}
