class AddFileToArtifacts < ActiveRecord::Migration[5.0]
  def change
    add_column :artifacts, :file, :string
  end
end
