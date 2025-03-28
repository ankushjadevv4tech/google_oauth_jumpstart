class Symptom < ApplicationRecord
  belongs_to :beverage_entry
  
  ALLOWED_NAMES = [
      'Bloating', 'Discomfort', 'Nausea', 'Acid Reflux / Heartburn', 'Burping / Excess Gas', 
      'Diarrhea / Loose Stools', 'Constipation', 'Cramping / Abdominal Pain', 'Urgency to Poop', 
      'Mucus in Stool', 'Fatty / Oily Stools (Steatorrhea)', 'Undigested Food in Stool', 
      'Feeling Full / Heavy Stomach', 'Dizziness / Lightheadedness', 'Headache', 'Dry Mouth / Sticky Saliva', 'Other'
    ]
  
  validates :name, :severity, :onset_time, presence: true
  validate :name_inclusion
  
  def name_inclusion
    if name.is_a?(Array)
      name.each do |n|
        unless ALLOWED_NAMES.include?(n) || n == 'Other'
          errors.add(:name, "#{n} is not a valid symptom")
        end
      end
    else
      unless ALLOWED_NAMES.include?(name) || name == 'Other'
        errors.add(:name, "#{name} is not a valid symptom")
      end
    end
  end

  enum severity: { mild: 0, moderate: 1, severe: 2 }
  enum onset_time: { immediately: 0, within_30_min: 1, within_5_hours: 2, after_5_hours: 3 }
end
