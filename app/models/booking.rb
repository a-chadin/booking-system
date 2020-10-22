class Booking < ApplicationRecord
  belongs_to :venue
  belongs_to :user

  validate :booking_cannot_be_on_top_of_another

  def booking_cannot_be_on_top_of_another
    # find bookings of same venue
    # end date in between current booking interval
    # start date in between current booking interval
    # start is before start, end is after end
    conflicting_bookings = Booking.where("venue_id = :venue_id and ((\"from\" >= :from and \"from\" < :to) or (\"to\" > :from and \"to\" <= :to) or (\"from\" <= :from and \"to\" >= :to))", 
    {venue_id: venue.id, from: from, to: to})
    if conflicting_bookings.length > 0
      errors.add(:from, "The booking timing conflicts with an existing booking")
    end
  end
end
