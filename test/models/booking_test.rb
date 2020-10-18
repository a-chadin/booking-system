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
    booking.from = DateTime.civil_from_format :utc, 2020, 10, 17, 12
    booking.to = DateTime.civil_from_format :utc, 2020, 10, 17, 13

    assert booking.save

    venue.reload
    assert venue.bookings.length > 2
  end

  test "should be able to make a booking timing next to each other" do
    venue = Venue.find_by(name: 'Meeting Room 1')
    user = User.find_by(username: 'one')
    booking = Booking.new
    booking.venue = venue
    booking.user = user
    #there is already a booking 12-1pm, but 12-1pm + 1-2pm should be OK
    booking.from = DateTime.civil_from_format :utc, 2020, 10, 17, 13
    booking.to = DateTime.civil_from_format :utc, 2020, 10, 17, 14

    assert booking.save
  end

  test "should not be able to make a booking on top of existing booking" do
    venue = Venue.find_by(name: 'Meeting Room 1')
    user = User.find_by(username: 'one')
    booking = Booking.new
    booking.venue = venue
    booking.user = user
    booking.from = DateTime.civil_from_format :utc, 2020, 10, 17, 9
    booking.to = DateTime.civil_from_format :utc, 2020, 10, 17, 10

    assert_not booking.save
  end
end
