class CreateTranscripts < ActiveRecord::Migration[5.0]
  def change
    create_table :transcripts do |t|
      t.string :name
      t.string :content
      t.string :language
      t.timestamps
    end
  end
end
