class CreateStudents < ActiveRecord::Migration
  def change
      create_table :students do |t|
        t.string :fname, null: false
        t.string :lname, null: false
        t.string :email, null: false, uniqueness: { case_sensitive: false }, index: true
        t.references :group, null: false, index: true
        t.string :password_digest, null: false
      end
  end
end
