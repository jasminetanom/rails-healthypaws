module DogHelper
  def all_sizes
    [
      ["Toy breed (e.g. Miniature Schnauzer)", 'small'],
      ["Medium breed (e.g. Standard Schnauzer)", "medium"],
      ["Large breed (e.g. Giant Schnauzer)", "large"]
    ]
  end

  def all_life_stages
    [
      ["Puppy (Age < 1)", "puppy"],
      ["Adult Dog (1 < Age < 7)", "adult"],
      ["Senior Dog (Age > 7)", "senior"]
    ]
  end

  def all_activity_levels
    [
      ["Low (Outdoor exercise <1 hour)", "low"],
      ["Medium (Outdoor exercise 1 < hours < 3)", "medium"],
      ["high (Outdoor exercise >3 hours)", "high"]
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
