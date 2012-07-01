class Movie < ActiveRecord::Base
	def self.all_ratings()
		rat = []
		@movies = self.all
		@movies.each { |m| rat << m.rating }
		return rat.sort.uniq!
    end
end
