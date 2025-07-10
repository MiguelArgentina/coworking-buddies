Geocoder.configure(
  lookup: :nominatim,
  http_headers: { "User-Agent" => "coworking-buddies-app (miguelgomez66@gmail.com)" },
  timeout: 5,
  units: :km,
  language: :en,
  use_https: true
)
