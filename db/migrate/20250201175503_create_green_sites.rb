class CreateGreenSites < ActiveRecord::Migration[7.1]
  def change
    enable_extension 'postgis'

    create_table :conservation_sites do |t|
      t.string :name, null: false
      t.st_point :coordinates, geographic: true
      t.string :taxonomy_code
      t.timestamps
    end
  end
end
