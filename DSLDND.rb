# frozen_string_literal: true
require 'securerandom'

class Game
  RACES = ["Орк", "Людина", "Ельф", "Гном", "Драконородний"]
  CLASSES = ["Воїн", "Маг", "Шахрай", "Паладін", "Бард"]
  attr_reader :characters

  def initialize
    @characters = []
  end

  def self.define(&block)
    game = new
    game.instance_eval(&block)
    game
  end

  def character(name, &block)
    character ||= Character.new(name)
    character.instance_eval(&block) if block_given?
    @characters << character
  end

  def scene(name, &block)
    @scenes ||= {}
    @scenes[name] = Scene.new(&block)
  end

  def play(scene_name)
    scene = @scenes[scene_name]
    raise "Scene not found: #{scene_name}" unless scene
    puts "Scene: #{scene_name}"
    puts "Description: #{scene.description}"
  end

  def npc(&block)
    @npc ||= Character.new("NPC_#{SecureRandom.hex(4)}")
    @npc.instance_eval(&block)
  end

  def event(params, border)
    @event ||= Event.new(params, border)
    #@event.instance_eval(&block)
    puts @event.description
  end

end

class Character
  attr_accessor :level, :class, :race, :power, :intelligence
  # better not but now have to
  attr_reader :name

  def initialize (name)
    @name = name
  end

  def level (lvl = 1)
    @level ||= lvl
  end

  def cclass (cls)
    # raise "Невідомий клас" unless CLASSES.include?(cls)
    @cclass ||= cls
  end

  def race (rc)
    # raise "Невідома раса" unless RACES.include?(rc)
    @race ||= rc
  end

  def power (pwr = 1)
    @power ||= pwr
  end

  def intelligence (intl = 1)
    @intelligence ||= intl
  end

  def agility (agl = 1)
    @agility ||= agl
  end

  def health (hp = 1)
    @health ||= hp
  end

  def weapon(name, &block)
    @weapon ||= Weapon.new(name)
    @weapon.instance_eval(&block) if block_given?
  end

  def print
    puts "Персонаж: #{@name}"
    puts "\tРівень: #{@level}"
    puts "\tКлас: #{@cclass}"
    puts "\tРаса: #{@race}"
    puts "\tЗдоров'я: #{@health}"
    puts "\tСила: #{@power}"
    puts "\tІнтелект: #{@intelligence}"
    puts "\tСпритність: #{@agility}"
    @weapon.print
  end
end

class Event
  def initialize (params, border)
    @params = params
    @border = border
  end

  def description
    roll = rand(1..20)
    result = roll > @border ? "успіх" : "провал"
    "Кидок d20 по #{@params}: #{roll} - #{result}"
  end
end

class Scene
  def initialize(&block)
    instance_eval(&block) if block_given?
  end

  def description(text = nil)
    @description = text if text
    @description
  end
end

class Weapon
  attr_reader :name, :damage

  def initialize(name)
    @name = name
  end

  def damage(dmg = 0)
    @damage = dmg
  end
  def print
    puts "\tЗброя: #{@name}"
    puts "\tШкода: #{@damage}"
  end
end

game = Game.define do
  character "Дракс" do
    level 5
    cclass "Воїн"
    race "Орк"
    health 100
    power 15
    intelligence 7
    agility 10
    weapon "Меч" do
      damage 10
    end
    self.print
  end
  character "Леголас" do
    level 5
    cclass "Рейнджер"
    race "Ельф"
    health 80
    power 10
    intelligence 12
    agility 18
    weapon "Лук" do
      damage 8
    end
    self.print
  end
  scene :forest do
    description "Ви опинилися в таємничому лісі."
  end
  npc do
    level 3
    cclass "Маг"
    race "Ельф"
    health 50
    power 8
    intelligence 15
    agility 12
    weapon "Посох" do
      damage 5
    end
    self.print
  end
  scene :forest do
    description "Ви опинилися в таємничому лісі."
  end
end
game.play(:forest)
game.event "сила", game.characters[0].power