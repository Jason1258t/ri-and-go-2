///Кастомные ошибки, чтобы ловить их стало проще

class UnAuthorizedException implements Exception{}

class NotFoundException implements Exception{}

class BadGateWayException implements Exception{}

class ServerException implements Exception{}