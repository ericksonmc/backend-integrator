# == Schema Information
#
# Table name: products
#
#  id           :bigint           not null, primary key
#  name         :string
#  reglamento   :string
#  url          :string
#  type_product :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Product < ApplicationRecord
  enum type_product: { animalitos: 0, triples: 1, terminales: 2 }
end
