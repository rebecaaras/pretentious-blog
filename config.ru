require_relative "./app"          

set :host_authorization, {
    permitted_hosts: [
      "rebecaaras.org",
      "www.rebecaaras.org",
      "143.244.149.47",
    ]
}

run Sinatra::Application
