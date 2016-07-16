class CreateCritics < ActiveRecord::Migration
  def change
    create_table :critics do |t|
      t.string :username
      t.string :password_digest
    end
  end
end
