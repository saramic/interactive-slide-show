class CreateViewingsAndPresentations < ActiveRecord::Migration[6.0]
  def change
    create_table :quizzes, id: :uuid do |t|
      t.references :quizzable, polymorphic: true, index: true, type: :uuid
      t.string :title
      t.integer :quiz_type, null: false, default: 0
    end

    create_table :quiz_options, id: :uuid do |t|
      t.references :quiz, index: true, null: false, type: :uuid
      t.string :text
    end

    create_table :presented_quizzes, id: :uuid do |t|
      t.references :quiz, index: true, null: false, type: :uuid
      t.references :quizzable, polymorphic: true, index: true, type: :uuid
    end

    create_table :presented_quiz_options, id: :uuid do |t|
      t.references :presented_quiz, index: true, null: false, type: :uuid
      t.string :text
    end

    create_table :votes, id: :uuid do |t|
      t.references :viewer, index: true, null: false, type: :uuid
      t.references :presented_quiz, index: true, null: false, type: :uuid
      t.references :presented_quiz_option, index: true, null: false, type: :uuid
      t.jsonb :data

      t.timestamps
    end

    create_table :viewings, id: :uuid do |t|
      t.references :user, index: true, null: false, type: :uuid
      t.references :presentation, index: true, null: true, type: :uuid

      t.timestamps
    end

    create_table :viewers, id: :uuid do |t|
      t.references :viewing, index: true, null: false, type: :uuid
      t.references :user, index: true, null: false, type: :uuid
    end

    create_table :presentations, id: :uuid do |t|
      t.references :viewing, index: true, null: false, type: :uuid
      t.references :slideshow, index: true, null: false, type: :uuid
      t.references :slide, index: true, null: true, type: :uuid

      t.timestamps
    end

    create_table :presented_slides, id: :uuid do |t|
      t.references :presentation, index: true, null: false, type: :uuid
      t.references :slide, index: true, null: false, type: :uuid
      t.integer :state, null: false, default: 0

      t.timestamps
    end
  end
end
