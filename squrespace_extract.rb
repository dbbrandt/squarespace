require "logger"
require "csv"
require "dotenv"

Dotenv.load

require './options.rb'
require './book.rb'
require './quiz.rb'

# Get all the elements for a section of the book
book = Book.new @book_id, 3, @toc_file, @docbook_file

LOGGER.info "TOC chapters: #{book.chapters.count}"

quiz = Quiz.new("quiz.csv", book)
quiz.export


