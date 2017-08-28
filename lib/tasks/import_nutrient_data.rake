require 'csv'

namespace :import_nutrient_data do
  desc "Import Nutrient Data from downloaded CSV"
  task :run => :environment do
    # loop for all files inside data folder
    data_directory = File.join(Rails.root,
"lib",
"data",
"*.csv")
    Dir.glob(data_directory) do |item|
      parse_csv_file(item)
    end
  end
end

INGREDIENTS_MAP = [

  {
    name: 'Energy',#
    column_prefix: 'energy'
  },
  {
    name: 'Protein',#
    column_prefix: 'protein'
  },
  {
    name: 'Total lipid (fat)',#
    column_prefix: 'fat'
  },
    {
    name: 'Fiber, total dietary',#
    column_prefix: 'fiber'
  },
    {
    name: 'Calcium, Ca',#
    column_prefix: 'calcium'
  },
    {
    name: 'Iron, Fe',#
    column_prefix: 'iron'
  },
    {
    name: 'Magnesium, Mg',#
    column_prefix: 'magnesium'
  },
    {
    name: 'Phosphorus, P',#
    column_prefix: 'phosphorus'
  },
    {
    name: 'Potassium, K',#
    column_prefix: 'potassium'
  },
    {
    name: 'Sodium, Na',#
    column_prefix: 'sodium'
  },
    {
    name: 'Zinc, Zn',#
    column_prefix: 'zinc'
  },
    {
    name: 'Niacin',#
    column_prefix: 'niacin'
  },
    {
    name: 'Pyridoxine',#
    column_prefix: 'pyridoxin'
  },
  {
    name: 'Folate, DFE',#
    column_prefix: 'folate'
  },
  {
    name: 'Vitamin B-12',#
    column_prefix: 'vitamin_b12'
  },
  {
    name: 'Vitamin A, IU',#
    column_prefix: 'vitamin_a_iu'
  },
  {
    name: 'Vitamin E (alpha-tocopherol)',#
    column_prefix: 'vitamin_e'
  },
  {
    name: 'Vitamin D',#
    column_prefix: 'vitamin_d'
  },
  {
    name: 'Riboflavin',#
    column_prefix: 'riboflavin'
  },
  {
    name: 'Thiamin',#
    column_prefix: 'thiamin'
  },
]

INGREDIENT_NAMES = INGREDIENTS_MAP.map { |ingredient_item| ingredient_item[:name] }

def parse_csv_file(path)
  content_lines = CSV.read(path, :encoding => 'windows-1251:utf-8')
  # drop all header lines
  content_lines = content_lines.drop(3)
  # get the ingredient name
  ingredient_name = content_lines[0][0].split(',')[1..-1].join()
  # drop other headers
  content_lines = content_lines.drop(3)

  values_in_hash = content_lines.each_with_object({}) do |content_line, result|
    if INGREDIENT_NAMES.include?(content_line[0])
      hash_key = format_hash_key(content_line[0], content_line[1])
      hash_value = content_line[2].to_f / 100
      result[hash_key] = hash_value
    end
  end

  #{
  #  :name =>
  #  :energy => 123.45,
  #  :energy_kcal => 123.45,
  #  :protein_g => 345.45,
  #  ....
  #}

  values_in_hash[:name] = ingredient_name

  create_ingredient(values_in_hash)
end

def format_hash_key(nutrient_name, unit)
  ingredient_item = INGREDIENTS_MAP.find { |ingredient_item| ingredient_item[:name] == nutrient_name }
  unit = 'ug' if unit == 'µg'

  [ingredient_item[:column_prefix], unit].join('_').to_sym
end

def create_ingredient(values_in_hash)
  puts "values_in_hash #{values_in_hash}"
  # print into another file
  #
  #Ingredient.create(values_in_hash)
end
