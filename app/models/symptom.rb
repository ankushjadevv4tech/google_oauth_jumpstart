class Symptom < ApplicationRecord
  belongs_to :beverage_entry
  
  validates :name, :severity, :onset_time, presence: true
  
  enum severity: { mild: 0, moderate: 1, severe: 2 }
  enum onset_time: { immediately: 0, within_30_min: 1, within_5_hours: 2, after_5_hours: 3 }
end
