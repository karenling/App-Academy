class CatRentalRequest < ActiveRecord::Base
  STATUSES = [ "PENDING", "APPROVED", "DENIED" ]
  after_initialize :default_status
  validates :cat_id, :start_date, :status, :end_date, presence: true
  validates :status, inclusion: STATUSES

  belongs_to(
    :cat,
    class_name: 'Cat',
    foreign_key: :cat_id,
    primary_key: :id
  )

  def default_status
    self.status ||= "PENDING"
  end

  def overlapping_requests
    other_rentals = self.cat.rentals.where("id != ?", self.id)
    other_rentals.where("(start_date <= ? AND end_date >= ?) OR
                         (? <= start_date AND ? >= start_date)",
      self.start_date, self.start_date, self.start_date, self.end_date)
  end

  def overlapping_approved_requests
    overlapping_requests.where(status: "APPROVED")
  end

  def overlapping_pending_requests
    overlapping_requests.where(status: "PENDING")
  end

  def approve!
    ActiveRecord::Base.transaction do
      if overlapping_approved_requests.empty?
        overlapping_pending_requests.each do |request|
          request.deny!
        end
        self.update!(status: "APPROVED")
      end
    end
  end

  def deny!
    self.update!(status: "DENIED")
  end

  def pending?
    self.status == "PENDING"
  end
end
