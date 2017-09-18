class Game < ApplicationRecord
  belongs_to :user
  
  serialize :questions, Array

  validates :score, :mode, presence: true, numericality: { only_integer: true }

  before_validation :load_defaults

  MODES = ['Country to Flag', 'Country to Map', 'Flag to Country',
           'Flag to Map',     'Map to Country', 'Map to Flag']

  def mode_path
    MODES[mode - 1].to_snake
  end

  def mode_name
    MODES[mode - 1]
  end

  def self.next_question(questions)
    questions.find { |question| !question['answered'] }
  end

  def generate_questions(num_questions = 15, num_choices = 12, options = {})
    answer_countries = sample_countries(num_questions, options)
    self.questions = answer_countries.map.with_index do |answer_country, i|  
      { 
        question: i, 
        answered: false, 
        attempt: nil, 
        answer: answer_country.id, 
        choices: generate_choices(answer_country, num_choices, options)
      }
    end
    self.save!
  end

  def self.retrieve_country_objects(question)
    { 
      question: question['question'], 
      answered: question['answered'], 
      attempt:  Country.where(id: question['attempt']).first, 
      answer:   Country.find(question['answer']), 
      choices:  question['choices'].map { |choice| Country.find(choice) }
    }
  end

  private

  def sample_countries(n = 12, options = {})
    countries = Country.where.not(id: options[:exclude].try(:id))
    if options[:for_map]
      countries.where(id: Country.available_on_map.ids.sample(n))
    else
      countries.where(id: Country.ids.sample(n))
    end
  end

  def generate_choices(answer_country, n = 12, options = {})
    options[:exclude] = answer_country
    countries = sample_countries(n - 1, options) + [answer_country]
    countries.map(&:id)
  end

  def retrieve_country_objects(question)
    { 
      question: question[:question], 
      answered: question[:answered], 
      attempt:  Country.where(id: question[:attempt]).first, 
      answer:   Country.find(question[:answer]), 
      choices:  question[:choices].map { |choice| Country.find(choice) }
    }
  end

  def load_defaults
    self.score = 0 if self.score.nil?
  end
end
