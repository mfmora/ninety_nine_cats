# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string(1)        not null
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Cat < ActiveRecord::Base
  validates :birth_date, :color, :name, :sex, presence: true

  def age
    Time.now.year - birth_date.year
  end

  def age_string
    age == 1 ? "#{age} year" : "#{age} years"
  end

  def without_description?
    description.nil? || description.empty?
  end
end
