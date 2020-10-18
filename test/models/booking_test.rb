require 'test_helper'

class BookingTest < ActiveSupport::TestCase
  test "should be able to retrive current bookings" do
    venue = Venue.find_by(name: 'Meeting Room 1')
    assert venue.bookings.length == 2
  end

  test "should be able to make a booking" do
    venue = Venue.find_by(name: 'Meeting Room 1')
    user = User.find_by(username: 'one')
    booking = Booking.new
    booking.venue = venue
    booking.user = user
    booking.from = DateTime.civil_from_format :utc, 2020, 10, 17, 11
    booking.to = DateTime.civil_from_format :utc, 2020, 10, 17, 12

    assert venue.save
  end

  test "should not be able to make a booking on top of existing booking" do
    venue = Venue.find_by(name: 'Meeting Room 1')
    user = User.find_by(username: 'one')
    booking = Booking.new
    booking.venue = venue
    booking.user = user
    booking.from = DateTime.civil_from_format :utc, 2020, 10, 17, 9
    booking.to = DateTime.civil_from_format :utc, 2020, 10, 17, 10

    assert_not venue.save
  end
end
