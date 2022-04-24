class BookTag < ApplicationRecord
  belongs_to :book

  validate :forbid_changing_name, on: :update

  private

  def forbid_changing_rate
    errors.add :name, "can not be changed!" if will_save_change_to_name?
  end
end
