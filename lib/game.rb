class Game
  TOTAL_ERRORS_ALLOWED = 7

  def initialize(word)
    @letters = word.upcase.chars
    @user_guesses = []
  end

  def normalize_letter(letter)
    if letter == "Ё"
      "Е"
    elsif letter == "Й"
      "И"
    else
      letter
    end
  end

  def normalize_letters
    @letters.map do |letter|
      normalize_letter(letter)
    end
  end

  def errors
    @user_guesses - normalize_letters
  end

  def number_of_errors_made
    errors.length
  end

  def errors_allowed
    TOTAL_ERRORS_ALLOWED - number_of_errors_made
  end

  def letters_to_guess
    @letters.map do |letter|
      if @user_guesses.include?(normalize_letter(letter))
        letter
      end
    end
  end

  def lost?
    errors_allowed == 0
  end

  def over?
    won? || lost?
  end

  def play!(letter)
    letter_normal = normalize_letter(letter)
    if !over? && !@user_guesses.include?(letter_normal)
      @user_guesses << letter_normal
    end
  end

  def won?
    (normalize_letters - @user_guesses).empty?
  end

  def word
    @letters.join
  end
end
