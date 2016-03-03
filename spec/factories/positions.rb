FactoryGirl.define do
  factory :position do
    employer "MyString"
    reg_id 1
    open_date "2016-03-02"
    close_date "2016-03-02"
    applied_date "2016-03-02"
    interview_date "2016-03-02"
    notes "MyText"
    user nil
  end
end
