# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(email: 'user_one@wut.com')
User.create!(email: 'user_two@wut.com')
User.create!(email: 'user_three@wut.com')
User.create!(email: 'user_four@wut.com')
User.create!(email: 'user_five@wut.com')
User.create!(email: 'user_six@wut.com')

ShortenedUrl.create_for_user_and_long_url!(User.first, 'ksjbfkwriwakfiweuhfkasf.com')
ShortenedUrl.create_for_user_and_long_url!(User.last, 'ksjbfk584743464846464684f.com')


Visit.record_visit!(User.first, ShortenedUrl.first)
Visit.record_visit!(User.last, ShortenedUrl.first)
