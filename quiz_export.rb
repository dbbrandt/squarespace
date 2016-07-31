require "./quiz_row.rb"

class QuizExport

  def initialize(output_file, book)
    @file = output_file
    @book = book
  end

  def export
    primary_external_id = 1
    CSV.open(@file, "wb", {:force_quotes=>true}) do |csv|
      quiz_row = QuizRow.new
      csv << quiz_row.header
      csv << quiz_row.row_data

      # Iterate through all chapters and sections and export quiz_rows
      @book.chapters.each_with_index do |c, cnum|
        chapter = @book.chapter(cnum)
        sections = @book.sections(cnum)
        sections.each_with_index do |s, snum|

          section = @book.section(cnum, snum)
          section_questions = @book.quiz_questions(section["id"])

          if section_questions
            LOGGER.info " Chapter: #{cnum+1}. #{chapter["title"]["content"]} , Section: #{snum+1}. . #{section["title"]["content"]}  questions: #{section_questions.count}"

            section_questions.each do |q|
              LOGGER.debug "Question: #{q.inspect}, element_id: #{q.element_id}"
              if @activity_lookup
                activity_number = @book.subsection_number(cnum, snum, q.element_id)
                activity_number += 1 if activity_number
                LOGGER.debug" activity_order: #{activity_number}"
              end
              csv << QuizRow.new(q, cnum+1, snum+1, 1, activity_number , primary_external_id ).row_data if q
              primary_external_id += 1
            end
          end
        end
      end
    end
  end
end
