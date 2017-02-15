# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date
#  status     :string           not null
#

class CatRentalRequest < ActiveRecord::Base
  STATUS = %w(PENDING APPROVED DENIED)

  validates :cat_id, :start_date, :end_date, :status, presence: :true
  validates :status, inclusion: { in: STATUS,
    message: "%{value} is not a valid status" }
  validate :end_date_after_start_date, :cat_unavailable
  before_validation { |cat_rental_request| cat_rental_request.status ||= "PENDING" }

  belongs_to :cat

  def end_date_after_start_date
    unless end_date.nil? || end_date > start_date
      self.errors[:end_date] << "can't be before start_date"
    end
  end

  # TODO: Optimize this by querying SQL once
  def cat_available?
    self.cat.approved_requests.none? do |request|
      (start_date - request.end_date) * (request.start_date - end_date) >= 0
    end
  end

  def cat_unavailable
    unless cat_available?
      self.errors[:start_date] << "or end date is not valid, because cat is busy"
    end
  end


end
