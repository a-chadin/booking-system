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
    booking.from = DateTime.civil_from_format :utc, 2020, 10, 18, 12
    booking.to = DateTime.civil_from_format :utc, 2020, 10, 18, 13

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
    booking.from = DateTime.civil_from_format :utc, 2020, 10, 19, 13
    booking.to = DateTime.civil_from_format :utc, 2020, 10, 19, 14

    assert booking.save

    booking = Booking.new
    booking.venue = venue
    booking.user = user
    booking.from = DateTime.civil_from_format :utc, 2020, 10, 19, 14
    booking.to = DateTime.civil_from_format :utc, 2020, 10, 19, 15

    assert booking.save

    booking = Booking.new
    booking.venue = venue
    booking.user = user
    booking.from = DateTime.civil_from_format :utc, 2020, 10, 19, 12
    booking.to = DateTime.civil_from_format :utc, 2020, 10, 19, 13

    assert booking.save
  end

  test "should not be able to make a booking on top of existing booking 1" do
    venue = Venue.find_by(name: 'Meeting Room 1')
    user = User.find_by(username: 'one')
    booking = Booking.new
    booking.venue = venue
    booking.user = user
    booking.from = DateTime.civil_from_format :utc, 2020, 10, 17, 9, 0
    booking.to = DateTime.civil_from_format :utc, 2020, 10, 17, 9, 30

    assert_not booking.save
  end

  test "should not be able to make a booking on top of existing booking 2" do
    venue = Venue.find_by(name: 'Meeting Room 1')
    user = User.find_by(username: 'one')
    booking = Booking.new
    booking.venue = venue
    booking.user = user
    booking.from = DateTime.civil_from_format :utc, 2020, 10, 17, 8, 30
    booking.to = DateTime.civil_from_format :utc, 2020, 10, 17, 9, 1

    assert_not booking.save
  end

  test "should not be able to make a booking on top of existing booking 3" do
    venue = Venue.find_by(name: 'Meeting Room 1')
    user = User.find_by(username: 'one')
    booking = Booking.new
    booking.venue = venue
    booking.user = user
    booking.from = DateTime.civil_from_format :utc, 2020, 10, 17, 10, 59
    booking.to = DateTime.civil_from_format :utc, 2020, 10, 17, 11, 30

    assert_not booking.save
  end

  test "should not be able to make a booking on top of existing booking 4" do
    venue = Venue.find_by(name: 'Meeting Room 1')
    user = User.find_by(username: 'one')
    booking = Booking.new
    booking.venue = venue
    booking.user = user
    booking.from = DateTime.civil_from_format :utc, 2020, 10, 17, 10, 59
    booking.to = DateTime.civil_from_format :utc, 2020, 10, 17, 11, 0

    assert_not booking.save
  end

  test "should not be able to make a booking on top of existing booking 5" do
    venue = Venue.find_by(name: 'Meeting Room 1')
    user = User.find_by(username: 'one')
    booking = Booking.new
    booking.venue = venue
    booking.user = user
    booking.from = DateTime.civil_from_format :utc, 2020, 10, 17, 10, 10
    booking.to = DateTime.civil_from_format :utc, 2020, 10, 17, 10, 11

    assert_not booking.save
  end
end
