class Profile < ActiveRecord::Base
  belongs_to :user
  validates_inclusion_of :gender, in: %w( male female )
  validate :my_happy_fname_lname_null_validator
  validate :no_sue
  default_scope {order birth_year: :asc}


=begin
 Add a class method to the Profile class, called get_all_profiles, which:
accepts a min and max for the birth year
issues a BETWEEN SQL clause in a where clause to locate Profiles with birth years that are between min
year and max year
defends itself against SQL injection when applying the parameters to the SQL clauses
returns a collection of Profiles in ASC birth year order
=end

def self.get_all_profiles (min,max)

  Profile.where(:birth_year =>  min..max).to_a


end

def  my_happy_fname_lname_null_validator

  if first_name.nil? && last_name.nil?
    then
  errors.add(:first_name, "Only one of either first name or last name may be empty")
  errors.add(:last_name, "Only one of either first name or last name may be empty")
  end

  end
def no_sue
  if gender == "male" && first_name== "Sue"
  then
    errors.add(:gender, "The man in black has a quarrel with you.")
  end

end




end
