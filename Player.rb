# frozen_string_literal: true
class Player_Context
  attr_accessor :current, :button_state
  attr_reader :songs

  def initialize
    @current = 0
    puts "PROBLEM"
    @songs = ["The Weekend - Save Your Tears", "ABBA - Dancing Queen", "John Lennon - Imagine", "Queen - Bohemian Rhapsody", "Michael Jackson - Thriller"]
    @button_state = Pause_State.new(self)
  end

  def press_play
    @button_state.play
  end

  def press_stop
    @button_state.stop
  end

  def press_next
    @button_state.next
  end

  def next_song
    @current += 1
    puts "SONG:" + @songs[current]
  end

  def press_previous
    @button_state.previous
  end

  def previous_song
    @current -= 1
    puts "SONG:" + @songs[current]
  end
end

class Button_State
  def initialize(context)
    @context = context
  end

  def play
    raise NotImplementedError
  end

  def stop
    raise NotImplementedError
  end

  def next
    @context.next_song
  end

  def previous
    @context.previous_song
  end
end

class Play_State < Button_State
  def initialize(context)
    super(context)
    puts "PLAYING:" + @context.songs[@context.current]
  end

  def play
    # do_nothing
  end

  def stop
    @context.button_state = Pause_State.new(@context)
  end
end

class Pause_State < Button_State
  def initialize(context)
    super(context)
    puts "STOPPED:" + @context.songs[@context.current]
  end

  def play
    @context.button_state = Play_State.new(@context)
  end

  def stop
    # do_nothing
  end
end

# let`s try
player = Player_Context.new
player.press_stop
player.press_play
player.previous_song
player.press_stop
player.press_play
player.next_song

