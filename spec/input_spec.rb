require '../model/input'

RSpec.describe Input do
  context 'when string has no spaces' do
    let(:word) { 'thisisonelongword' }
    let(:input) { Input.new(word) }

    it 'initializes the Input class and .body' do
      expect(input).to be_an_instance_of(described_class)
      expect(input.body).to equal(word)
    end

    it 'returns default selection for empty command' do
      expect(input.body_with_selection).to eq('[t]hisisonelongword')
    end

    it 'selects first character' do
      expect(input.to_first_char).to eq('[t]hisisonelongword')
      expect(input.to_first_char).to eq('[t]hisisonelongword')
    end

    it 'moves to the last character' do
      expect(input.to_last_char).to eq('thisisonelongwor[d]')
      expect(input.to_last_char).to eq('thisisonelongwor[d]')
    end

    it 'moves to the end of the word' do
      input.to_first_char
      expect(input.to_end_of_word).to eq('thisisonelongwor[d]')
      expect(input.to_end_of_word).to eq('thisisonelongwor[d]')
    end

    it 'moves until the next matching character' do
      input.to_first_char

      expect(input.move_until('s')).to eq('th[i]sisonelongword')
      expect(input.move_until('s')).to eq('this[i]sonelongword')
      expect(input.move_until('s')).to eq('th[i]sisonelongword')
      expect(input.move_until('g')).to eq('thisisonelo[n]gword')
      expect(input.move_until('g')).to eq('thisisonelo[n]gword')
    end

    it 'does not moves until the next matching char when there is no such' do
      input.to_first_char
      expect(input.move_until('a')).to eq('[t]hisisonelongword')
    end

    it 'visually selects until the end of the word' do
      input.to_first_char
      expect(input.select_until_word_end).to eq('[thisisonelongword]')
    end

    it 'visually selects until the last character' do
      input.to_first_char
      expect(input.select_until_last_char).to eq('[thisisonelongword]')
    end

    it 'visually selects untils the next matching character' do
      input.to_first_char

      expect(input.select_until_char('s')).to eq('[thi]sisonelongword')
      expect(input.select_until_char('s')).to eq('[thisi]sonelongword')
      expect(input.select_until_char('s')).to eq('[thisi]sonelongword')
    end
  end

  context 'when string has spaces' do
    let(:word) { 'this is a sencence' }
    let(:input) { Input.new(word) }

    it 'initializes the Input class and .body' do
      expect(input).to be_an_instance_of(described_class)
      expect(input.body).to equal(word)
    end

    it 'returns default selection for empty command' do
      expect(input.body_with_selection).to eq('[t]his is a sencence')
    end

    it 'selects first character' do
      expect(input.to_first_char).to eq('[t]his is a sencence')
      expect(input.to_first_char).to eq('[t]his is a sencence')
    end

    it 'moves to the last character' do
      expect(input.to_last_char).to eq('this is a sencenc[e]')
      expect(input.to_last_char).to eq('this is a sencenc[e]')
    end

    it 'moves to the end of the word' do
      input.to_first_char
      expect(input.to_end_of_word).to eq('thi[s] is a sencence')
      expect(input.to_end_of_word).to eq('this i[s] a sencence')
    end

    it 'moves to the end of the previous word if whitespace selected' do
      input.move_until('a')
      expect(input.to_end_of_word).to eq('this is [a] sencence')
    end

    it 'moves until the next matching character' do
      input.to_first_char

      expect(input.move_until('s')).to eq('th[i]s is a sencence')
      expect(input.move_until('s')).to eq('this [i]s a sencence')
      expect(input.move_until('s')).to eq('this is a[ ]sencence')
      expect(input.move_until('g')).to eq('this is a[ ]sencence')
      expect(input.move_until(' ')).to eq('thi[s] is a sencence')
      expect(input.move_until(' ')).to eq('this i[s] a sencence')
    end

    it 'does not move until the next matching characterwhen there is no such' do
      input.to_first_char
      expect(input.move_until('a')).to eq('this is[ ]a sencence')
    end

    it 'visually selects until the end of the word' do
      input.to_first_char
      expect(input.select_until_word_end).to eq('[this] is a sencence')
    end

    it 'visually selects until the last character' do
      input.to_first_char
      expect(input.select_until_last_char).to eq('[this is a sencence]')
    end

    it 'visually selects untils the next matching character' do
      input.to_first_char
      expect(input.select_until_char('s')).to eq('[thi]s is a sencence')
      expect(input.select_until_char('s')).to eq('[this i]s a sencence')
      expect(input.select_until_char('s')).to eq('[this is a ]sencence')
    end
  end
end
