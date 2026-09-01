require_relative "./app"          

use Rack::Protection::HostAuthorization,
    permitted_hosts: [
      "rebecaaras.net",
      "www.rebecaaras.net"
    ]

run Sinatra::Application
