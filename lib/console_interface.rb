class ConsoleInterface
  FIGURES =
    Dir["#{__dir__}/../data/figures/*.txt"].sort.map do |file_name|
      File.read(file_name)
    end
  def initialize(game)
    @game = game
  end

  def print_out
    puts <<~END
      Слово: #{word_to_show}
      #{figure}
      Ошибки (#{@game.number_of_errors_made}): #{errors_letters_to_show}
      У вас осталось ошибок: #{@game.errors_allowed}

    END

    if @game.won?
      puts "Поздравляем, вы выиграли!"
    elsif @game.lost?
      puts "Вы проиграли, загаданное слово: #{@game.word}"
    end
  end

  def figure
    FIGURES[@game.number_of_errors_made]
  end

  def word_to_show
    result = @game.letters_to_guess.map { |letter| letter || "__" }.join(" ")
  end

  def errors_letters_to_show
    @game.errors.join(", ")
  end

  def get_input
    print "Введите следующую букву: "
    gets[0].upcase
  end
end
