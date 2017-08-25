module DogHelper
  def all_sizes
    [
      ["Small/Toy breed (e.g. Miniature Schnauzer)", 'small'],
      ["Medium breed (e.g. Standard Schnauzer)", "medium"],
      ["Large breed (e.g. Giant Schnauzer)", "large"]
    ]
  end

  def all_life_stages
    [
      ["Puppy (Age < 1 year)", "puppy"],
      ["Adult Dog (Age: 1 - 7 years)", "adult"],
      ["Senior Dog (Age > 7 years)", "senior"]
    ]
  end

  def all_activity_levels
    [
      ["Low (Outdoor exercise < 1 hour)", "low"],
      ["Medium (Outdoor exercise: 1 - 3 hours)", "medium"],
      ["High (Outdoor exercise > 3 hours)", "high"]
    ]
  end

  def all_body_condition_scores
    [
      ["1 (Underweight)", "1"],
      ["2 (Lean)", "2"],
      ["3 (Ideal)", "3"],
      ["4 (Overweight)", "4"],
      ["5 (Obese)", "5"]
    ]
  end
end
