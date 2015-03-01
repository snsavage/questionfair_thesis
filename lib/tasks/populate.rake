# Baesd on this tutorial: http://www.jacoulter.com/2011/12/21/rails-using-faker-to-populate-a-development-database/

namespace :db do
  desc "Erase and fill database."
  task :populate => :environment do

    require 'faker'

    Rake::Task['db:reset'].invoke

    # Create test user accounts
    25.times do |a|
      password = "password"
      test_user = User.create!( :nickname => Faker::Internet.user_name[0,12],
                                :first_name => Faker::Name.first_name,
                                :last_name => Faker::Name.last_name,
                                :email => Faker::Internet.email,
                                :password => password,
                                :password_confirmation => password)    

      rand(20).times do |b|
        Question.create!(:question => Faker::Lorem.sentence(rand(20), true),
                         :category => Question::CATEGORIES.fetch(rand(Question::CATEGORIES.length)),
                         :user_id => test_user.id)
      end
    end

    Question.all.each do |question|
      rand(30).times do |c|
        test_user = User.find(rand(1..User.count))
        Answer.create!(:answer => Faker::Lorem.sentence(rand(20), true),
                       :user_id => test_user.id,
                       :question_id => question.id)
      end
    end
  end
end



# lib/tasks/populate.rake
#
# Rake task to populate development database with test data
# Run it with "rake db:populate"
# See Railscast 126 and the faker website for more information

# namespace :db do
#   desc "Erase and fill database"
#   task :populate => :environment do
#     require 'faker'

#     Rake::Task['db:reset'].invoke

#     # Create admin_user account
#     admin_user = User.create!(:email => "test@test.org",
#       :displayName => "test",
#       :password => "password",
#       :password_confirmation => "password",
#       :location => Faker::Address.city, 
#       :miles => true,
#       :administrator => true)
    
#     # Create admin_user's courses
#     5.times do |c|
#       course = Course.create!(:name => Faker::Company.name,
#         :distance => (rand(25-1) + 1) + ((rand(9-1) + 1) *0.1),
#         :note => Faker::Lorem.paragraph(sentence_count = 3),
#         :user_id => admin_user.id)

#       # Create entries for admin_user's courses
#       5.times do |e|
#         Entry.create!(:entryDate => (rand(10-1)+1).days.ago.to_date,
#           :hours => 0,
#           :minutes => rand(59-1) + 1,
#           :seconds => rand(59-1) + 1,
#           :note => Faker::Lorem.paragraph(sentence_count = 3),
#           :course_id => course.id,
#           :user_id => admin_user.id)
#       end
#     end

#     # Create weights for admin_user
#     base_weight = rand(300-100) + 100
#     5.times do |w|
#       Weight.create!(:entry_date => (w+1).days.ago.to_date,
#         :weight_entry => (base_weight + (rand(9-1) + 1) * 1.1),
#         :note => Faker::Lorem.paragraph(sentence_count = 3),
#         :user_id => admin_user.id)
#     end
      
#     # Create test user accounts
#     10.times do |n|
#       displayName = Faker::Name.name
#       email = "test-#{n+1}@test.org"
#       password = "password"
#       test_user = User.create!(:displayName => displayName,
#         :email => email,
#         :password => password,
#         :password_confirmation => password,
#         :location => Faker::Address.city,
#         :miles => false,
#         :administrator => false)

#       # Create courses for test user
#       5.times do |c|
#         course = Course.create!(:name => Faker::Company.name,
#           :distance => (rand(25-1) + 1) + ((rand(9-1) + 1) *0.1),
#           :note => Faker::Lorem.paragraph(sentence_count = 3),
#           :user_id => test_user.id)

#         # Create entries for test_user's course
#         5.times do |e|
#           Entry.create!(:entryDate => (rand(10-1)+1).days.ago.to_date,
#             :hours => 0,
#             :minutes => rand(59-1) + 1,
#             :seconds => rand(59-1) + 1,
#             :course_id => course.id,
#             :note => Faker::Lorem.paragraph(sentence_count = 3),
#             :user_id => test_user.id)
#         end
#       end

#       # Create weights for test_user
#       base_weight = rand(300-100) + 100
#       5.times do |w|        
#         Weight.create!(:entry_date => (w+1).days.ago.to_date,
#           :weight_entry => (base_weight + (rand(9-1) + 1) * 1.1),
#           :note => Faker::Lorem.paragraph(sentence_count = 3),
#           :user_id => test_user.id)
#       end
#     end
#   end
# end