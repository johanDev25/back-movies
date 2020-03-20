class Movie < ApplicationRecord
 attributes :id_movie, :title, :overview, :vote, :poster, :release

  include PgSearch
pg_search_scope :search_by_term, against: [:title, :content],
  using: {
    tsearch: {
      any_word: true,
      prefix: true
    }
  }
end
