class BookRating < ApplicationRecord
  belongs_to :book

  # 星評価の取りうる値の設定
  MIN_RATE = 0.0
  MAX_RATE = 5.0
  RATE_STEP = 1.0
  RATE = []
  MIN_RATE.step(MAX_RATE, RATE_STEP) { |x| RATE.push(x) }
  RATE.freeze

  validates :rate, inclusion: { in: RATE }
  validate :forbid_changing_rate, on: :update

  private

  def forbid_changing_rate
    errors.add :rate, "can not be changed!" if will_save_change_to_rate?
  end
end
