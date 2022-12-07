class HandOption
  OUTCOME_SCORES = { win: 6, draw: 3, lose: 0 }

  def initialize(type:, score:)
    @type = type
    @score = score
  end

  attr_reader :type, :score
  
  def beats(options)
    @beats = options
  end

  def loses_to(options)
    @loses_to = options
  end

  def plays(other)
    if type == other.type
      calculate_score(:draw)
    elsif @beats == other
      calculate_score(:win)
    elsif @loses_to == other
      calculate_score(:lose)
    else
      raise 'Error calculating outcome'
    end
  end

  def option_needed_for_outcome(outcome)
    case outcome
    when :draw
      self
    when :win
      @loses_to
    when :lose
      @beats
    end
  end

  private

  def calculate_score(outcome)
    score + OUTCOME_SCORES[outcome] 
  end
  
end
