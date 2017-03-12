class VideoProcessors < ActiveRecord::Migration[5.0]
  def change
    create_table :video_processors do |t|
      t.string :name
      t.string :url

      t.timestamps
    end
  end
end
