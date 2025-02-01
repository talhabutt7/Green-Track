# app/models/green_site.rb
class GreenSite < ApplicationRecord
  scope :within_radius, ->(lng, lat, radius_km) {
    where(
      "ST_DWithin(
        ST_SetSRID(coordinates::geometry, 4326)::geography,
        ST_SetSRID(ST_MakePoint(:lng, :lat), 4326)::geography,
        :radius
      )",
      lng: lng, lat: lat, radius: radius_km * 1000
    )
  }
end