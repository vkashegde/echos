// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_models.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPlaylistCollectionCollection on Isar {
  IsarCollection<PlaylistCollection> get playlistCollections =>
      this.collection();
}

const PlaylistCollectionSchema = CollectionSchema(
  name: r'PlaylistCollection',
  id: -4664293871526985282,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'isSystem': PropertySchema(
      id: 1,
      name: r'isSystem',
      type: IsarType.bool,
    ),
    r'name': PropertySchema(
      id: 2,
      name: r'name',
      type: IsarType.string,
    ),
    r'songIds': PropertySchema(
      id: 3,
      name: r'songIds',
      type: IsarType.longList,
    )
  },
  estimateSize: _playlistCollectionEstimateSize,
  serialize: _playlistCollectionSerialize,
  deserialize: _playlistCollectionDeserialize,
  deserializeProp: _playlistCollectionDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _playlistCollectionGetId,
  getLinks: _playlistCollectionGetLinks,
  attach: _playlistCollectionAttach,
  version: '3.1.0+1',
);

int _playlistCollectionEstimateSize(
  PlaylistCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.songIds.length * 8;
  return bytesCount;
}

void _playlistCollectionSerialize(
  PlaylistCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeBool(offsets[1], object.isSystem);
  writer.writeString(offsets[2], object.name);
  writer.writeLongList(offsets[3], object.songIds);
}

PlaylistCollection _playlistCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PlaylistCollection();
  object.createdAt = reader.readDateTimeOrNull(offsets[0]);
  object.id = id;
  object.isSystem = reader.readBool(offsets[1]);
  object.name = reader.readString(offsets[2]);
  object.songIds = reader.readLongList(offsets[3]) ?? [];
  return object;
}

P _playlistCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readLongList(offset) ?? []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _playlistCollectionGetId(PlaylistCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _playlistCollectionGetLinks(
    PlaylistCollection object) {
  return [];
}

void _playlistCollectionAttach(
    IsarCollection<dynamic> col, Id id, PlaylistCollection object) {
  object.id = id;
}

extension PlaylistCollectionQueryWhereSort
    on QueryBuilder<PlaylistCollection, PlaylistCollection, QWhere> {
  QueryBuilder<PlaylistCollection, PlaylistCollection, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PlaylistCollectionQueryWhere
    on QueryBuilder<PlaylistCollection, PlaylistCollection, QWhereClause> {
  QueryBuilder<PlaylistCollection, PlaylistCollection, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<PlaylistCollection, PlaylistCollection, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<PlaylistCollection, PlaylistCollection, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PlaylistCollection, PlaylistCollection, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PlaylistCollection, PlaylistCollection, QAfterWhereClause>
      idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension PlaylistCollectionQueryFilter
    on QueryBuilder<PlaylistCollection, PlaylistCollection, QFilterCondition> {
  QueryBuilder<PlaylistCollection, PlaylistCollection, QAfterFilterCondition>
      createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<PlaylistCollection, PlaylistCollection, QAfterFilterCondition>
      createdAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<PlaylistCollection, PlaylistCollection, QAfterFilterCondition>
      createdAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PlaylistCollection, PlaylistCollection, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PlaylistCollection, PlaylistCollection, QAfterFilterCondition>
      createdAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PlaylistCollection, PlaylistCollection, QAfterFilterCondition>
      createdAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PlaylistCollection, PlaylistCollection, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PlaylistCollection, PlaylistCollection, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PlaylistCollection, PlaylistCollection, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PlaylistCollection, PlaylistCollection, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PlaylistCollection, PlaylistCollection, QAfterFilterCondition>
      isSystemEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSystem',
        value: value,
      ));
    });
  }

  QueryBuilder<PlaylistCollection, PlaylistCollection, QAfterFilterCondition>
      nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlaylistCollection, PlaylistCollection, QAfterFilterCondition>
      nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlaylistCollection, PlaylistCollection, QAfterFilterCondition>
      nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlaylistCollection, PlaylistCollection, QAfterFilterCondition>
      nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlaylistCollection, PlaylistCollection, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlaylistCollection, PlaylistCollection, QAfterFilterCondition>
      nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlaylistCollection, PlaylistCollection, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlaylistCollection, PlaylistCollection, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlaylistCollection, PlaylistCollection, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<PlaylistCollection, PlaylistCollection, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<PlaylistCollection, PlaylistCollection, QAfterFilterCondition>
      songIdsElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'songIds',
        value: value,
      ));
    });
  }

  QueryBuilder<PlaylistCollection, PlaylistCollection, QAfterFilterCondition>
      songIdsElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'songIds',
        value: value,
      ));
    });
  }

  QueryBuilder<PlaylistCollection, PlaylistCollection, QAfterFilterCondition>
      songIdsElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'songIds',
        value: value,
      ));
    });
  }

  QueryBuilder<PlaylistCollection, PlaylistCollection, QAfterFilterCondition>
      songIdsElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'songIds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PlaylistCollection, PlaylistCollection, QAfterFilterCondition>
      songIdsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'songIds',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<PlaylistCollection, PlaylistCollection, QAfterFilterCondition>
      songIdsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'songIds',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<PlaylistCollection, PlaylistCollection, QAfterFilterCondition>
      songIdsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'songIds',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<PlaylistCollection, PlaylistCollection, QAfterFilterCondition>
      songIdsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'songIds',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<PlaylistCollection, PlaylistCollection, QAfterFilterCondition>
      songIdsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'songIds',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<PlaylistCollection, PlaylistCollection, QAfterFilterCondition>
      songIdsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'songIds',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension PlaylistCollectionQueryObject
    on QueryBuilder<PlaylistCollection, PlaylistCollection, QFilterCondition> {}

extension PlaylistCollectionQueryLinks
    on QueryBuilder<PlaylistCollection, PlaylistCollection, QFilterCondition> {}

extension PlaylistCollectionQuerySortBy
    on QueryBuilder<PlaylistCollection, PlaylistCollection, QSortBy> {
  QueryBuilder<PlaylistCollection, PlaylistCollection, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<PlaylistCollection, PlaylistCollection, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<PlaylistCollection, PlaylistCollection, QAfterSortBy>
      sortByIsSystem() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSystem', Sort.asc);
    });
  }

  QueryBuilder<PlaylistCollection, PlaylistCollection, QAfterSortBy>
      sortByIsSystemDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSystem', Sort.desc);
    });
  }

  QueryBuilder<PlaylistCollection, PlaylistCollection, QAfterSortBy>
      sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<PlaylistCollection, PlaylistCollection, QAfterSortBy>
      sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension PlaylistCollectionQuerySortThenBy
    on QueryBuilder<PlaylistCollection, PlaylistCollection, QSortThenBy> {
  QueryBuilder<PlaylistCollection, PlaylistCollection, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<PlaylistCollection, PlaylistCollection, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<PlaylistCollection, PlaylistCollection, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PlaylistCollection, PlaylistCollection, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PlaylistCollection, PlaylistCollection, QAfterSortBy>
      thenByIsSystem() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSystem', Sort.asc);
    });
  }

  QueryBuilder<PlaylistCollection, PlaylistCollection, QAfterSortBy>
      thenByIsSystemDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSystem', Sort.desc);
    });
  }

  QueryBuilder<PlaylistCollection, PlaylistCollection, QAfterSortBy>
      thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<PlaylistCollection, PlaylistCollection, QAfterSortBy>
      thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension PlaylistCollectionQueryWhereDistinct
    on QueryBuilder<PlaylistCollection, PlaylistCollection, QDistinct> {
  QueryBuilder<PlaylistCollection, PlaylistCollection, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<PlaylistCollection, PlaylistCollection, QDistinct>
      distinctByIsSystem() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSystem');
    });
  }

  QueryBuilder<PlaylistCollection, PlaylistCollection, QDistinct>
      distinctByName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PlaylistCollection, PlaylistCollection, QDistinct>
      distinctBySongIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'songIds');
    });
  }
}

extension PlaylistCollectionQueryProperty
    on QueryBuilder<PlaylistCollection, PlaylistCollection, QQueryProperty> {
  QueryBuilder<PlaylistCollection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PlaylistCollection, DateTime?, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<PlaylistCollection, bool, QQueryOperations> isSystemProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSystem');
    });
  }

  QueryBuilder<PlaylistCollection, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<PlaylistCollection, List<int>, QQueryOperations>
      songIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'songIds');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFavoriteCollectionCollection on Isar {
  IsarCollection<FavoriteCollection> get favoriteCollections =>
      this.collection();
}

const FavoriteCollectionSchema = CollectionSchema(
  name: r'FavoriteCollection',
  id: 1010039148232529629,
  properties: {
    r'songId': PropertySchema(
      id: 0,
      name: r'songId',
      type: IsarType.long,
    )
  },
  estimateSize: _favoriteCollectionEstimateSize,
  serialize: _favoriteCollectionSerialize,
  deserialize: _favoriteCollectionDeserialize,
  deserializeProp: _favoriteCollectionDeserializeProp,
  idName: r'id',
  indexes: {
    r'songId': IndexSchema(
      id: -4588889454650216128,
      name: r'songId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'songId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _favoriteCollectionGetId,
  getLinks: _favoriteCollectionGetLinks,
  attach: _favoriteCollectionAttach,
  version: '3.1.0+1',
);

int _favoriteCollectionEstimateSize(
  FavoriteCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _favoriteCollectionSerialize(
  FavoriteCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.songId);
}

FavoriteCollection _favoriteCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FavoriteCollection();
  object.id = id;
  object.songId = reader.readLong(offsets[0]);
  return object;
}

P _favoriteCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _favoriteCollectionGetId(FavoriteCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _favoriteCollectionGetLinks(
    FavoriteCollection object) {
  return [];
}

void _favoriteCollectionAttach(
    IsarCollection<dynamic> col, Id id, FavoriteCollection object) {
  object.id = id;
}

extension FavoriteCollectionByIndex on IsarCollection<FavoriteCollection> {
  Future<FavoriteCollection?> getBySongId(int songId) {
    return getByIndex(r'songId', [songId]);
  }

  FavoriteCollection? getBySongIdSync(int songId) {
    return getByIndexSync(r'songId', [songId]);
  }

  Future<bool> deleteBySongId(int songId) {
    return deleteByIndex(r'songId', [songId]);
  }

  bool deleteBySongIdSync(int songId) {
    return deleteByIndexSync(r'songId', [songId]);
  }

  Future<List<FavoriteCollection?>> getAllBySongId(List<int> songIdValues) {
    final values = songIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'songId', values);
  }

  List<FavoriteCollection?> getAllBySongIdSync(List<int> songIdValues) {
    final values = songIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'songId', values);
  }

  Future<int> deleteAllBySongId(List<int> songIdValues) {
    final values = songIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'songId', values);
  }

  int deleteAllBySongIdSync(List<int> songIdValues) {
    final values = songIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'songId', values);
  }

  Future<Id> putBySongId(FavoriteCollection object) {
    return putByIndex(r'songId', object);
  }

  Id putBySongIdSync(FavoriteCollection object, {bool saveLinks = true}) {
    return putByIndexSync(r'songId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllBySongId(List<FavoriteCollection> objects) {
    return putAllByIndex(r'songId', objects);
  }

  List<Id> putAllBySongIdSync(List<FavoriteCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'songId', objects, saveLinks: saveLinks);
  }
}

extension FavoriteCollectionQueryWhereSort
    on QueryBuilder<FavoriteCollection, FavoriteCollection, QWhere> {
  QueryBuilder<FavoriteCollection, FavoriteCollection, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<FavoriteCollection, FavoriteCollection, QAfterWhere>
      anySongId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'songId'),
      );
    });
  }
}

extension FavoriteCollectionQueryWhere
    on QueryBuilder<FavoriteCollection, FavoriteCollection, QWhereClause> {
  QueryBuilder<FavoriteCollection, FavoriteCollection, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<FavoriteCollection, FavoriteCollection, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<FavoriteCollection, FavoriteCollection, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<FavoriteCollection, FavoriteCollection, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<FavoriteCollection, FavoriteCollection, QAfterWhereClause>
      idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FavoriteCollection, FavoriteCollection, QAfterWhereClause>
      songIdEqualTo(int songId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'songId',
        value: [songId],
      ));
    });
  }

  QueryBuilder<FavoriteCollection, FavoriteCollection, QAfterWhereClause>
      songIdNotEqualTo(int songId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'songId',
              lower: [],
              upper: [songId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'songId',
              lower: [songId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'songId',
              lower: [songId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'songId',
              lower: [],
              upper: [songId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<FavoriteCollection, FavoriteCollection, QAfterWhereClause>
      songIdGreaterThan(
    int songId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'songId',
        lower: [songId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<FavoriteCollection, FavoriteCollection, QAfterWhereClause>
      songIdLessThan(
    int songId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'songId',
        lower: [],
        upper: [songId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<FavoriteCollection, FavoriteCollection, QAfterWhereClause>
      songIdBetween(
    int lowerSongId,
    int upperSongId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'songId',
        lower: [lowerSongId],
        includeLower: includeLower,
        upper: [upperSongId],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension FavoriteCollectionQueryFilter
    on QueryBuilder<FavoriteCollection, FavoriteCollection, QFilterCondition> {
  QueryBuilder<FavoriteCollection, FavoriteCollection, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FavoriteCollection, FavoriteCollection, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FavoriteCollection, FavoriteCollection, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FavoriteCollection, FavoriteCollection, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FavoriteCollection, FavoriteCollection, QAfterFilterCondition>
      songIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'songId',
        value: value,
      ));
    });
  }

  QueryBuilder<FavoriteCollection, FavoriteCollection, QAfterFilterCondition>
      songIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'songId',
        value: value,
      ));
    });
  }

  QueryBuilder<FavoriteCollection, FavoriteCollection, QAfterFilterCondition>
      songIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'songId',
        value: value,
      ));
    });
  }

  QueryBuilder<FavoriteCollection, FavoriteCollection, QAfterFilterCondition>
      songIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'songId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension FavoriteCollectionQueryObject
    on QueryBuilder<FavoriteCollection, FavoriteCollection, QFilterCondition> {}

extension FavoriteCollectionQueryLinks
    on QueryBuilder<FavoriteCollection, FavoriteCollection, QFilterCondition> {}

extension FavoriteCollectionQuerySortBy
    on QueryBuilder<FavoriteCollection, FavoriteCollection, QSortBy> {
  QueryBuilder<FavoriteCollection, FavoriteCollection, QAfterSortBy>
      sortBySongId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songId', Sort.asc);
    });
  }

  QueryBuilder<FavoriteCollection, FavoriteCollection, QAfterSortBy>
      sortBySongIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songId', Sort.desc);
    });
  }
}

extension FavoriteCollectionQuerySortThenBy
    on QueryBuilder<FavoriteCollection, FavoriteCollection, QSortThenBy> {
  QueryBuilder<FavoriteCollection, FavoriteCollection, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<FavoriteCollection, FavoriteCollection, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<FavoriteCollection, FavoriteCollection, QAfterSortBy>
      thenBySongId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songId', Sort.asc);
    });
  }

  QueryBuilder<FavoriteCollection, FavoriteCollection, QAfterSortBy>
      thenBySongIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songId', Sort.desc);
    });
  }
}

extension FavoriteCollectionQueryWhereDistinct
    on QueryBuilder<FavoriteCollection, FavoriteCollection, QDistinct> {
  QueryBuilder<FavoriteCollection, FavoriteCollection, QDistinct>
      distinctBySongId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'songId');
    });
  }
}

extension FavoriteCollectionQueryProperty
    on QueryBuilder<FavoriteCollection, FavoriteCollection, QQueryProperty> {
  QueryBuilder<FavoriteCollection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<FavoriteCollection, int, QQueryOperations> songIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'songId');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPlayHistoryCollectionCollection on Isar {
  IsarCollection<PlayHistoryCollection> get playHistoryCollections =>
      this.collection();
}

const PlayHistoryCollectionSchema = CollectionSchema(
  name: r'PlayHistoryCollection',
  id: -6983479662405353399,
  properties: {
    r'lastPlayedAt': PropertySchema(
      id: 0,
      name: r'lastPlayedAt',
      type: IsarType.dateTime,
    ),
    r'playCount': PropertySchema(
      id: 1,
      name: r'playCount',
      type: IsarType.long,
    ),
    r'songId': PropertySchema(
      id: 2,
      name: r'songId',
      type: IsarType.long,
    )
  },
  estimateSize: _playHistoryCollectionEstimateSize,
  serialize: _playHistoryCollectionSerialize,
  deserialize: _playHistoryCollectionDeserialize,
  deserializeProp: _playHistoryCollectionDeserializeProp,
  idName: r'id',
  indexes: {
    r'songId': IndexSchema(
      id: -4588889454650216128,
      name: r'songId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'songId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _playHistoryCollectionGetId,
  getLinks: _playHistoryCollectionGetLinks,
  attach: _playHistoryCollectionAttach,
  version: '3.1.0+1',
);

int _playHistoryCollectionEstimateSize(
  PlayHistoryCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _playHistoryCollectionSerialize(
  PlayHistoryCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.lastPlayedAt);
  writer.writeLong(offsets[1], object.playCount);
  writer.writeLong(offsets[2], object.songId);
}

PlayHistoryCollection _playHistoryCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PlayHistoryCollection();
  object.id = id;
  object.lastPlayedAt = reader.readDateTimeOrNull(offsets[0]);
  object.playCount = reader.readLong(offsets[1]);
  object.songId = reader.readLong(offsets[2]);
  return object;
}

P _playHistoryCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _playHistoryCollectionGetId(PlayHistoryCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _playHistoryCollectionGetLinks(
    PlayHistoryCollection object) {
  return [];
}

void _playHistoryCollectionAttach(
    IsarCollection<dynamic> col, Id id, PlayHistoryCollection object) {
  object.id = id;
}

extension PlayHistoryCollectionByIndex
    on IsarCollection<PlayHistoryCollection> {
  Future<PlayHistoryCollection?> getBySongId(int songId) {
    return getByIndex(r'songId', [songId]);
  }

  PlayHistoryCollection? getBySongIdSync(int songId) {
    return getByIndexSync(r'songId', [songId]);
  }

  Future<bool> deleteBySongId(int songId) {
    return deleteByIndex(r'songId', [songId]);
  }

  bool deleteBySongIdSync(int songId) {
    return deleteByIndexSync(r'songId', [songId]);
  }

  Future<List<PlayHistoryCollection?>> getAllBySongId(List<int> songIdValues) {
    final values = songIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'songId', values);
  }

  List<PlayHistoryCollection?> getAllBySongIdSync(List<int> songIdValues) {
    final values = songIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'songId', values);
  }

  Future<int> deleteAllBySongId(List<int> songIdValues) {
    final values = songIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'songId', values);
  }

  int deleteAllBySongIdSync(List<int> songIdValues) {
    final values = songIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'songId', values);
  }

  Future<Id> putBySongId(PlayHistoryCollection object) {
    return putByIndex(r'songId', object);
  }

  Id putBySongIdSync(PlayHistoryCollection object, {bool saveLinks = true}) {
    return putByIndexSync(r'songId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllBySongId(List<PlayHistoryCollection> objects) {
    return putAllByIndex(r'songId', objects);
  }

  List<Id> putAllBySongIdSync(List<PlayHistoryCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'songId', objects, saveLinks: saveLinks);
  }
}

extension PlayHistoryCollectionQueryWhereSort
    on QueryBuilder<PlayHistoryCollection, PlayHistoryCollection, QWhere> {
  QueryBuilder<PlayHistoryCollection, PlayHistoryCollection, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<PlayHistoryCollection, PlayHistoryCollection, QAfterWhere>
      anySongId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'songId'),
      );
    });
  }
}

extension PlayHistoryCollectionQueryWhere on QueryBuilder<PlayHistoryCollection,
    PlayHistoryCollection, QWhereClause> {
  QueryBuilder<PlayHistoryCollection, PlayHistoryCollection, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<PlayHistoryCollection, PlayHistoryCollection, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<PlayHistoryCollection, PlayHistoryCollection, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PlayHistoryCollection, PlayHistoryCollection, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PlayHistoryCollection, PlayHistoryCollection, QAfterWhereClause>
      idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PlayHistoryCollection, PlayHistoryCollection, QAfterWhereClause>
      songIdEqualTo(int songId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'songId',
        value: [songId],
      ));
    });
  }

  QueryBuilder<PlayHistoryCollection, PlayHistoryCollection, QAfterWhereClause>
      songIdNotEqualTo(int songId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'songId',
              lower: [],
              upper: [songId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'songId',
              lower: [songId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'songId',
              lower: [songId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'songId',
              lower: [],
              upper: [songId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<PlayHistoryCollection, PlayHistoryCollection, QAfterWhereClause>
      songIdGreaterThan(
    int songId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'songId',
        lower: [songId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<PlayHistoryCollection, PlayHistoryCollection, QAfterWhereClause>
      songIdLessThan(
    int songId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'songId',
        lower: [],
        upper: [songId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<PlayHistoryCollection, PlayHistoryCollection, QAfterWhereClause>
      songIdBetween(
    int lowerSongId,
    int upperSongId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'songId',
        lower: [lowerSongId],
        includeLower: includeLower,
        upper: [upperSongId],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension PlayHistoryCollectionQueryFilter on QueryBuilder<
    PlayHistoryCollection, PlayHistoryCollection, QFilterCondition> {
  QueryBuilder<PlayHistoryCollection, PlayHistoryCollection,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PlayHistoryCollection, PlayHistoryCollection,
      QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PlayHistoryCollection, PlayHistoryCollection,
      QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PlayHistoryCollection, PlayHistoryCollection,
      QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PlayHistoryCollection, PlayHistoryCollection,
      QAfterFilterCondition> lastPlayedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastPlayedAt',
      ));
    });
  }

  QueryBuilder<PlayHistoryCollection, PlayHistoryCollection,
      QAfterFilterCondition> lastPlayedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastPlayedAt',
      ));
    });
  }

  QueryBuilder<PlayHistoryCollection, PlayHistoryCollection,
      QAfterFilterCondition> lastPlayedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastPlayedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PlayHistoryCollection, PlayHistoryCollection,
      QAfterFilterCondition> lastPlayedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastPlayedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PlayHistoryCollection, PlayHistoryCollection,
      QAfterFilterCondition> lastPlayedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastPlayedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PlayHistoryCollection, PlayHistoryCollection,
      QAfterFilterCondition> lastPlayedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastPlayedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PlayHistoryCollection, PlayHistoryCollection,
      QAfterFilterCondition> playCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'playCount',
        value: value,
      ));
    });
  }

  QueryBuilder<PlayHistoryCollection, PlayHistoryCollection,
      QAfterFilterCondition> playCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'playCount',
        value: value,
      ));
    });
  }

  QueryBuilder<PlayHistoryCollection, PlayHistoryCollection,
      QAfterFilterCondition> playCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'playCount',
        value: value,
      ));
    });
  }

  QueryBuilder<PlayHistoryCollection, PlayHistoryCollection,
      QAfterFilterCondition> playCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'playCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PlayHistoryCollection, PlayHistoryCollection,
      QAfterFilterCondition> songIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'songId',
        value: value,
      ));
    });
  }

  QueryBuilder<PlayHistoryCollection, PlayHistoryCollection,
      QAfterFilterCondition> songIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'songId',
        value: value,
      ));
    });
  }

  QueryBuilder<PlayHistoryCollection, PlayHistoryCollection,
      QAfterFilterCondition> songIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'songId',
        value: value,
      ));
    });
  }

  QueryBuilder<PlayHistoryCollection, PlayHistoryCollection,
      QAfterFilterCondition> songIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'songId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension PlayHistoryCollectionQueryObject on QueryBuilder<
    PlayHistoryCollection, PlayHistoryCollection, QFilterCondition> {}

extension PlayHistoryCollectionQueryLinks on QueryBuilder<PlayHistoryCollection,
    PlayHistoryCollection, QFilterCondition> {}

extension PlayHistoryCollectionQuerySortBy
    on QueryBuilder<PlayHistoryCollection, PlayHistoryCollection, QSortBy> {
  QueryBuilder<PlayHistoryCollection, PlayHistoryCollection, QAfterSortBy>
      sortByLastPlayedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastPlayedAt', Sort.asc);
    });
  }

  QueryBuilder<PlayHistoryCollection, PlayHistoryCollection, QAfterSortBy>
      sortByLastPlayedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastPlayedAt', Sort.desc);
    });
  }

  QueryBuilder<PlayHistoryCollection, PlayHistoryCollection, QAfterSortBy>
      sortByPlayCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playCount', Sort.asc);
    });
  }

  QueryBuilder<PlayHistoryCollection, PlayHistoryCollection, QAfterSortBy>
      sortByPlayCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playCount', Sort.desc);
    });
  }

  QueryBuilder<PlayHistoryCollection, PlayHistoryCollection, QAfterSortBy>
      sortBySongId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songId', Sort.asc);
    });
  }

  QueryBuilder<PlayHistoryCollection, PlayHistoryCollection, QAfterSortBy>
      sortBySongIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songId', Sort.desc);
    });
  }
}

extension PlayHistoryCollectionQuerySortThenBy
    on QueryBuilder<PlayHistoryCollection, PlayHistoryCollection, QSortThenBy> {
  QueryBuilder<PlayHistoryCollection, PlayHistoryCollection, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PlayHistoryCollection, PlayHistoryCollection, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PlayHistoryCollection, PlayHistoryCollection, QAfterSortBy>
      thenByLastPlayedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastPlayedAt', Sort.asc);
    });
  }

  QueryBuilder<PlayHistoryCollection, PlayHistoryCollection, QAfterSortBy>
      thenByLastPlayedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastPlayedAt', Sort.desc);
    });
  }

  QueryBuilder<PlayHistoryCollection, PlayHistoryCollection, QAfterSortBy>
      thenByPlayCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playCount', Sort.asc);
    });
  }

  QueryBuilder<PlayHistoryCollection, PlayHistoryCollection, QAfterSortBy>
      thenByPlayCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playCount', Sort.desc);
    });
  }

  QueryBuilder<PlayHistoryCollection, PlayHistoryCollection, QAfterSortBy>
      thenBySongId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songId', Sort.asc);
    });
  }

  QueryBuilder<PlayHistoryCollection, PlayHistoryCollection, QAfterSortBy>
      thenBySongIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songId', Sort.desc);
    });
  }
}

extension PlayHistoryCollectionQueryWhereDistinct
    on QueryBuilder<PlayHistoryCollection, PlayHistoryCollection, QDistinct> {
  QueryBuilder<PlayHistoryCollection, PlayHistoryCollection, QDistinct>
      distinctByLastPlayedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastPlayedAt');
    });
  }

  QueryBuilder<PlayHistoryCollection, PlayHistoryCollection, QDistinct>
      distinctByPlayCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'playCount');
    });
  }

  QueryBuilder<PlayHistoryCollection, PlayHistoryCollection, QDistinct>
      distinctBySongId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'songId');
    });
  }
}

extension PlayHistoryCollectionQueryProperty on QueryBuilder<
    PlayHistoryCollection, PlayHistoryCollection, QQueryProperty> {
  QueryBuilder<PlayHistoryCollection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PlayHistoryCollection, DateTime?, QQueryOperations>
      lastPlayedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastPlayedAt');
    });
  }

  QueryBuilder<PlayHistoryCollection, int, QQueryOperations>
      playCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'playCount');
    });
  }

  QueryBuilder<PlayHistoryCollection, int, QQueryOperations> songIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'songId');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAppSettingsCollectionCollection on Isar {
  IsarCollection<AppSettingsCollection> get appSettingsCollections =>
      this.collection();
}

const AppSettingsCollectionSchema = CollectionSchema(
  name: r'AppSettingsCollection',
  id: -1201272823460988305,
  properties: {
    r'customBandGains': PropertySchema(
      id: 0,
      name: r'customBandGains',
      type: IsarType.doubleList,
    ),
    r'equalizerEnabled': PropertySchema(
      id: 1,
      name: r'equalizerEnabled',
      type: IsarType.bool,
    ),
    r'equalizerPreset': PropertySchema(
      id: 2,
      name: r'equalizerPreset',
      type: IsarType.string,
    ),
    r'loudnessBoostDb': PropertySchema(
      id: 3,
      name: r'loudnessBoostDb',
      type: IsarType.double,
    ),
    r'loudnessBoostEnabled': PropertySchema(
      id: 4,
      name: r'loudnessBoostEnabled',
      type: IsarType.bool,
    )
  },
  estimateSize: _appSettingsCollectionEstimateSize,
  serialize: _appSettingsCollectionSerialize,
  deserialize: _appSettingsCollectionDeserialize,
  deserializeProp: _appSettingsCollectionDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _appSettingsCollectionGetId,
  getLinks: _appSettingsCollectionGetLinks,
  attach: _appSettingsCollectionAttach,
  version: '3.1.0+1',
);

int _appSettingsCollectionEstimateSize(
  AppSettingsCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.customBandGains.length * 8;
  bytesCount += 3 + object.equalizerPreset.length * 3;
  return bytesCount;
}

void _appSettingsCollectionSerialize(
  AppSettingsCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDoubleList(offsets[0], object.customBandGains);
  writer.writeBool(offsets[1], object.equalizerEnabled);
  writer.writeString(offsets[2], object.equalizerPreset);
  writer.writeDouble(offsets[3], object.loudnessBoostDb);
  writer.writeBool(offsets[4], object.loudnessBoostEnabled);
}

AppSettingsCollection _appSettingsCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AppSettingsCollection();
  object.customBandGains = reader.readDoubleList(offsets[0]) ?? [];
  object.equalizerEnabled = reader.readBool(offsets[1]);
  object.equalizerPreset = reader.readString(offsets[2]);
  object.id = id;
  object.loudnessBoostDb = reader.readDouble(offsets[3]);
  object.loudnessBoostEnabled = reader.readBool(offsets[4]);
  return object;
}

P _appSettingsCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDoubleList(offset) ?? []) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readDouble(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _appSettingsCollectionGetId(AppSettingsCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _appSettingsCollectionGetLinks(
    AppSettingsCollection object) {
  return [];
}

void _appSettingsCollectionAttach(
    IsarCollection<dynamic> col, Id id, AppSettingsCollection object) {
  object.id = id;
}

extension AppSettingsCollectionQueryWhereSort
    on QueryBuilder<AppSettingsCollection, AppSettingsCollection, QWhere> {
  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AppSettingsCollectionQueryWhere on QueryBuilder<AppSettingsCollection,
    AppSettingsCollection, QWhereClause> {
  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterWhereClause>
      idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AppSettingsCollectionQueryFilter on QueryBuilder<
    AppSettingsCollection, AppSettingsCollection, QFilterCondition> {
  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> customBandGainsElementEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customBandGains',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> customBandGainsElementGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'customBandGains',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> customBandGainsElementLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'customBandGains',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> customBandGainsElementBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'customBandGains',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> customBandGainsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'customBandGains',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> customBandGainsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'customBandGains',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> customBandGainsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'customBandGains',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> customBandGainsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'customBandGains',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> customBandGainsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'customBandGains',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> customBandGainsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'customBandGains',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> equalizerEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'equalizerEnabled',
        value: value,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> equalizerPresetEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'equalizerPreset',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> equalizerPresetGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'equalizerPreset',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> equalizerPresetLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'equalizerPreset',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> equalizerPresetBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'equalizerPreset',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> equalizerPresetStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'equalizerPreset',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> equalizerPresetEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'equalizerPreset',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
          QAfterFilterCondition>
      equalizerPresetContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'equalizerPreset',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
          QAfterFilterCondition>
      equalizerPresetMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'equalizerPreset',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> equalizerPresetIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'equalizerPreset',
        value: '',
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> equalizerPresetIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'equalizerPreset',
        value: '',
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> loudnessBoostDbEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'loudnessBoostDb',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> loudnessBoostDbGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'loudnessBoostDb',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> loudnessBoostDbLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'loudnessBoostDb',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> loudnessBoostDbBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'loudnessBoostDb',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection,
      QAfterFilterCondition> loudnessBoostEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'loudnessBoostEnabled',
        value: value,
      ));
    });
  }
}

extension AppSettingsCollectionQueryObject on QueryBuilder<
    AppSettingsCollection, AppSettingsCollection, QFilterCondition> {}

extension AppSettingsCollectionQueryLinks on QueryBuilder<AppSettingsCollection,
    AppSettingsCollection, QFilterCondition> {}

extension AppSettingsCollectionQuerySortBy
    on QueryBuilder<AppSettingsCollection, AppSettingsCollection, QSortBy> {
  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      sortByEqualizerEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'equalizerEnabled', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      sortByEqualizerEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'equalizerEnabled', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      sortByEqualizerPreset() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'equalizerPreset', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      sortByEqualizerPresetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'equalizerPreset', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      sortByLoudnessBoostDb() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loudnessBoostDb', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      sortByLoudnessBoostDbDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loudnessBoostDb', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      sortByLoudnessBoostEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loudnessBoostEnabled', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      sortByLoudnessBoostEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loudnessBoostEnabled', Sort.desc);
    });
  }
}

extension AppSettingsCollectionQuerySortThenBy
    on QueryBuilder<AppSettingsCollection, AppSettingsCollection, QSortThenBy> {
  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      thenByEqualizerEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'equalizerEnabled', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      thenByEqualizerEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'equalizerEnabled', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      thenByEqualizerPreset() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'equalizerPreset', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      thenByEqualizerPresetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'equalizerPreset', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      thenByLoudnessBoostDb() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loudnessBoostDb', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      thenByLoudnessBoostDbDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loudnessBoostDb', Sort.desc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      thenByLoudnessBoostEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loudnessBoostEnabled', Sort.asc);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QAfterSortBy>
      thenByLoudnessBoostEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loudnessBoostEnabled', Sort.desc);
    });
  }
}

extension AppSettingsCollectionQueryWhereDistinct
    on QueryBuilder<AppSettingsCollection, AppSettingsCollection, QDistinct> {
  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QDistinct>
      distinctByCustomBandGains() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'customBandGains');
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QDistinct>
      distinctByEqualizerEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'equalizerEnabled');
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QDistinct>
      distinctByEqualizerPreset({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'equalizerPreset',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QDistinct>
      distinctByLoudnessBoostDb() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'loudnessBoostDb');
    });
  }

  QueryBuilder<AppSettingsCollection, AppSettingsCollection, QDistinct>
      distinctByLoudnessBoostEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'loudnessBoostEnabled');
    });
  }
}

extension AppSettingsCollectionQueryProperty on QueryBuilder<
    AppSettingsCollection, AppSettingsCollection, QQueryProperty> {
  QueryBuilder<AppSettingsCollection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AppSettingsCollection, List<double>, QQueryOperations>
      customBandGainsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'customBandGains');
    });
  }

  QueryBuilder<AppSettingsCollection, bool, QQueryOperations>
      equalizerEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'equalizerEnabled');
    });
  }

  QueryBuilder<AppSettingsCollection, String, QQueryOperations>
      equalizerPresetProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'equalizerPreset');
    });
  }

  QueryBuilder<AppSettingsCollection, double, QQueryOperations>
      loudnessBoostDbProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'loudnessBoostDb');
    });
  }

  QueryBuilder<AppSettingsCollection, bool, QQueryOperations>
      loudnessBoostEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'loudnessBoostEnabled');
    });
  }
}
