class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :access_token
      t.string :access_secret
      t.string :realmID

      t.timestamps
    end
  end
end
