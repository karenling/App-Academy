class Users < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_name, null: false

      t.timestamps
    end

    add_index :users, :user_name, unique: true

    create_table :polls do |t|
      t.string :title, null: false
      t.integer :author_id, null: false

      t.timestamps
    end

    create_table :questions do |t|
      t.text :question, null: false
      t.integer :poll_id, null: false

      t.timestamps
    end

    add_index :questions, :poll_id

    create_table :answer_choices do |t|
      t.text :answer_choice
      t.integer :question_id, null: false

      t.timestamps
    end

    add_index :answer_choices, :question_id

    create_table :responses do |t|
      t.integer :user_id, null: false
      t.integer :question_id, null: false
      t.integer :answer_choice_id, null: false

      t.timestamps
    end

    add_index :responses, :user_id
    add_index :responses, :question_id
  end
end
