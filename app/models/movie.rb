class Movie < ApplicationRecord
  include PgSearch
pg_search_scope :search_by_term, against: [:title, :content],
  using: {
    tsearch: {
      any_word: true,
      prefix: true
    }
  }
end
