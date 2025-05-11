use "collections"
use "net/http"
use "json"

actor Main
  new create(env: Env) =>
    HTTPClient(env.root as AmbientAuth).get("http://ip-api.com/json", IPHandler)

class IPHandler is HTTPHandler
  fun ref apply(response: HTTPResponse ref) =>
    try
      let json = JsonDoc.parse(String.from_array(response.body))?.data as JsonObject
      let city = json.data("city") as JsonString
      let country = json.data("country") as JsonString
      @printf[I32]("Joylashuv: %s, %s\n".cstring(), city.string().cstring(), country.string().cstring())
    else
      @printf[I32]("Xatolik\n".cstring())
    end
