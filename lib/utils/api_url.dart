class ApiUrl {
  static const _baseUrl = "https://crud.teamrabbil.com/api/v1";
  static const createUrl = "$_baseUrl/CreateProduct";
  static const readUrl = "$_baseUrl/ReadProduct";

  static updateUrl(String? id) => "$_baseUrl/UpdateProduct/$id";
  static deleteUrl(String? id) => "$_baseUrl/DeleteProduct/$id";
}
