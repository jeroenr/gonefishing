class Search < ActiveForm
  attr_accessor :occupancy, :departure_date, :return_date, :page, :num_results_per_page

  validates :occupancy, :departure_date, :return_date, :presence => true
  validates_numericality_of :page, :num_results_per_page
  
  validates_each :departure_date, :return_date do |record, attr, value|
    record.errors.add attr, 'is before today' if value < Date.today
  end

  validate :return_date_is_after_departure_date

  def return_date_is_after_departure_date
    errors.add(:return_date, "should be after departure date") if :return_date <= :departure_date
  end
end