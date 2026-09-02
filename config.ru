require_relative "./app"          

use Rack::Protection::HostAuthorization,
    permitted_hosts: [
      "rebecaaras.net",
      "www.rebecaaras.net",
      "143.244.149.47",
    ]

run Sinatra::Application
