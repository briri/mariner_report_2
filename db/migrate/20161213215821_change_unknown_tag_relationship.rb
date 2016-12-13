class ChangeUnknownTagRelationship < ActiveRecord::Migration[5.0]
  def change
    remove_reference :unknown_tags, :article, foreign_key: true
    add_reference :unknown_tags, :publisher, foreign_key: true
  end
end
