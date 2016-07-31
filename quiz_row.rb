require "./question.rb"

class QuizRow

  @@default_header = [ "row_type","competency_id","assessment_type","pass_percentage","summative_order","objective_order",
               "topic_order","subtopic_order","activity_order","text","figure_type","figure_value","stem_type","item_type",
               "answer_a","answer_b","answer_c","answer_d","answer_e","answer_key","difficulty","cog",
               "feedback","is_primary","primary_external_id","duration","is_summative","description","title"]

  @@default_header_data = ["assessment",nil,"quiz","0.8",nil,nil,
                  nil,nil,nil,nil,nil,nil,nil,nil,
                  nil,nil,nil,nil,nil,nil,nil,nil,
                  nil,nil,nil,nil,"NO",nil,nil]

  attr_accessor :question, :header, :header_data

  def initialize(question=nil, objective_order=nil, topic_order=nil, subtopic_order=nil, activity_order=nil, primary_external_id=nil,  is_summative = false)
    @header = @@default_header
    @header_data = @@default_header_data
    @question = question

    return if question.nil?

    LOGGER.debug "QUESTION: #{@question.text}"

    @row_type = "item"
    @assessment_type = "quiz"
    @summative_order = "1"
    @objective_order = objective_order
    @topic_order = topic_order
    @subtopic_order = subtopic_order
    @activity_order = activity_order
    @text = @question.text
    @figure_type = nil
    @figure_value = nil
    @stem_type = "Text"
    @item_type = "MC"

    keys = ('a'..'e').to_a

    LOGGER.debug "Answers: #{@question.answers.inspect}"

    return if @question.answers.nil?

    @question.answers.each_with_index do |a,i|
      instance_variable_set("@answer_#{keys[i]}", a.text)
      @answer_key = keys[i] if a.correct?
    end
    @answer_key ||= "a"

    @difficulty = "moderate"
    @cog = "recall"
    @feedback = question.feedback
    @is_primary = "Y"
    @primary_external_id = primary_external_id
    @is_summative = is_summative ? "YES" : "NO"
    @description = nil
    @title = nil
  end


  def row_data
    return @header_data if @question.nil?

    [ @row_type,@competency_id,@assessment_type,@pass_percentage,@summative_order,@objective_order,
      @topic_order,@subtopic_order,@activity_order,@text,@figure_type,@figure_value,@stem_type,@item_type,
      @answer_a,@answer_b,@answer_c,@answer_d,@answer_e,@answer_key,@difficulty,@cog,
      @feedback,@is_primary,@primary_external_id,@duration,@is_summative,@description,@title ]

  end
end