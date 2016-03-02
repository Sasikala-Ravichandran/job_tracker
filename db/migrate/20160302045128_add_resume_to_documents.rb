class AddResumeToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :resume, :string
  end
end
