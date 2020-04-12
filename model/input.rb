class Input
  attr_reader :body

  def initialize(body = '')
    @body = body
    @start_select = 0
    @end_select = 0
    @curernt_word = 0
  end

  def to_first_char
    @start_select = 0
    @end_select = 0
    body_with_selection
  end

  def to_last_char
    @start_select = @body.size - 1
    @end_select = @body.size - 1
    body_with_selection
  end

  def to_end_of_word
    if @body[(@start_select.zero? ? 1 : @start_select + 2)..-1]&.include?(' ')
      start = if (
        @body[(@start_select.zero? ? 1 : @start_select + 2)..-1][0] == ' '
      ) && (@start_select == @end_select)
                @start_select.zero? ? 2 : @start_select + 2
              else
                @start_select.zero? ? 1 : @start_select + 2
              end
      ind = @body[start..-1].index(' ') - 1 + start
      assign_selection(ind)
      body_with_selection
    else
      to_last_char
    end
  end

  def move_until(character = ' ')
    character = ' ' if character.empty?
    ind = if @body[
                (@start_select.zero? ? 0 : @start_select + 2)..-1
            ]&.include?(character)

            start = @start_select.zero? ? 0 : @start_select + 1
            @body[(start + 1)..-1].index(character) + start
          elsif @body[1..@start_select]&.include?(character)
            @body[1..@start_select]&.index(character)
          end

    assign_selection(ind) if ind
    body_with_selection
  end

  def select_until_word_end
    @end_select = if @body[@end_select..-1]&.include?(' ')
                    @body[@end_select..-1].index(' ') - 1 + @end_select
                  else
                    @body.size - 1
                  end
    body_with_selection
  end

  def select_until_char(character = ' ')
    character = ' ' if character.empty?
    if @body[(@end_select + 2)..-1]&.include?(character)
      @end_select =
        @body[(@end_select + 2)..-1].index(character) + 1 + @end_select
    end
    body_with_selection
  end

  def select_until_last_char
    @end_select = @body.size - 1
    body_with_selection
  end

  private

  def body_with_selection
    slice_start = (@start_select.zero? ? -1 : 0)
    slice_end = (@start_select.zero? ? 0 : @start_select - 1)
    @body[slice_start..slice_end] +
      '[' + @body[@start_select..@end_select] + ']' +
      @body[(@end_select + 1)..-1]
  end

  def assign_selection(ind)
    @start_select = ind
    @end_select = ind
  end
end
