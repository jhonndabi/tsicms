namespace :db do
  desc 'Erase and Fill database'
  task populate: :environment do
    [CategoryRecommendation, Recommendation, Professor, ProfessorCategory,
     ProfessorTitle].each(&:destroy_all)

    categories = %w(Documentário Filme Livro Seriado)
    categories.each do |category|
      CategoryRecommendation.create!(name: category)
    end

    CategoryRecommendation.all.each do |category|
      5.times do
        category.recommendations.create! title: Faker::Name.name,
                                         description: Faker::Lorem.paragraph(2),
                                         image: File.open(Dir["#{Rails.root}/spec/samples/images/*"].sample)
      end
    end

    categories = %w[Efetivo Temporário]

    categories.each do |category|
      ProfessorCategory.create!(name: category)
    end

    titles = [
      {name: 'Especialista', abbrev: 'Esp.'},
      {name: 'Mestre', abbrev: 'Me.'},
      {name: 'Doutor', abbrev: 'Dr.'}
    ]

    titles.each do |title|
      ProfessorTitle.create!(name: title[:name], abbrev: title[:abbrev])
    end

    10.times do
      Professor.create!(name: Faker::Name.name, lattes: Faker::Internet.url,
                       occupation_area: Faker::Job.title, email: Faker::Internet.email,
                       professor_title: ProfessorTitle.all.sample,
                       professor_category: ProfessorCategory.all.sample)
    end
  end
end