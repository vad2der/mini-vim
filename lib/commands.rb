class Commands
  COMMANDS = {
    '0': { desc: 'Move to the first (1st) character', aliases: nil },
    '$': { desc: 'Move to the last character', aliases: nil },
    'e': { desc: 'Move to the end of the word', aliases: nil },
    'tw': { desc: 'Move until the next matching character', aliases: nil },
    've': { desc: 'Visually select until the end of the word', aliases: nil },
    'v$': { desc: 'Visually select until the last character', aliases: nil },
    'vt': {
      desc: "Visually select until the character (after 'vt' without space)",
      aliases: nil
    },
    'help': { desc: 'List of commands', aliases: %w[? h] },
    'TAB': {
      desc: %w[
        Autocomplete.
        Start typing a command and discover similar commands by pressing TAB
      ].join(' '),
      aliases: nil
    },
    'exit': { desc: 'Exit', aliases: %w[q quit] },
    'n': { desc: 'New input', aliases: ['new'] }
  }.freeze

  FORBIDDEN_CARS = ['[', ']'].freeze

  def self.unknow_command_message(command = '')
    format(
      '%<a>s %<b>s %<c>s',
      {
        a: 'Unknown command',
        b: command.colorize(:red),
        c: 'Type "h" command for help.'
      }
    )
  end

  def self.unacceptable_chars_message(character)
    format(
      '%<a>s %<b>s %<c>s',
      {
        a: 'Unacceptable char:',
        b: character.colorize(:red),
        c: 'is found in the input. Fix the input.'
      }
    )
  end

  def self.processed_output(input, command = '')
    if input.body.include?('[') || input.body.include?(']')
      unacceptable_chars_message
    elsif command.strip.start_with?('t')
      input.move_until(command.strip[1..-1])
    elsif command.strip.start_with?('vt')
      input.select_until_char(command.strip[2..-1])
    else
      case command&.strip
      when '?', 'help', 'h'
        Functions.return_help
      when 'q', 'exit', 'quit'
        Functions.exit_cli
      when 'n', 'new'
        Functions.start_anew
      when '0'
        input.to_first_char
      when '$'
        input.to_last_char
      when 'e'
        input.to_end_of_word
      when 've'
        input.select_until_word_end
      when 'v$'
        input.select_until_last_char
      else
        unknow_command_message(command)
      end
    end
  end
end
