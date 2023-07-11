namespace :update_challenge do
  
  desc "Update theme in challenge"
  task challenges: :environment do
    Challenge.all.each do |challenge|
      random_word = [
        Faker::Color.color_name, 
        Faker::Adjective.positive, 
        Faker::Adjective.negative, 
        Faker::Emotion.adjective, 
        Faker::Commerce.material
      ].sample

      challenge.theme = random_word
      challenge.save!
    end
  end
end
