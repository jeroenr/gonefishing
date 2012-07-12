class Search < ActiveForm
  attr_accessor :occupancy, :departure, :return

  validates :occupancy, :departure, :return, :presence => true
  
  validates_each :departure, :return do |record, attr, value|
    record.errors.add attr, 'is before today' if value < Date.today
  end

  validate :return_date_is_after_departure_date

  def return_date_is_after_departure_date
    errors.add(:return, "should be after departure date") if :return <= :departure
  end

end