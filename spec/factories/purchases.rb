FactoryBot.define do
  factory :purchase do
    name { 'Purchase 1' }
    amount { 100.00 }

    # Define a transient attribute to set the category
    transient do
      category { nil } # Default to nil
    end

    # Define a transient attribute to set the author (user)
    transient do
      author { nil } # Default to nil
    end

    # Use a callAback to associate the category and author
    after(:create) do |purchase, evaluator|
      # Assign the category if it's provided
      purchase.category = evaluator.category if evaluator.category
      # Assign the author if it's provided
      purchase.author = evaluator.author if evaluator.author
    end
  end
end
