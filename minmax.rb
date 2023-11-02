# frozen_string_literal: true

def fitness(individual)
  individual.count(1)
end

def mutate(individual)
  index = rand(individual.length)
  individual[index] = 1 - individual[index]
end

def crossover(individual1, individual2)
  crossover_point = rand(individual1.length)
  individual1[0...crossover_point] + individual2[crossover_point..-1]
end

def genetic_algorithm
  population_size = 100
  generations = 100
  length = 10

  # Ініціалізація популяції
  population = Array.new(population_size) { Array.new(length) { rand(2) } }
  #puts population.inspect
  generations.times do
    # Селекція
    population.sort_by! { |individual| -fitness(individual) }
    population = population[0...population_size/2]

    # Схрещення та мутація
    while population.size < population_size
      parent1 = population.sample
      parent2 = population.sample
      child = crossover(parent1, parent2)
      mutate(child) if rand < 0.1 # Мутація з ймовірністю 10%
      population << child
      #puts population.inspect
    end
  end

  # Повертаємо найкращого особинця
  population.max_by { |individual| fitness(individual) }
end

puts genetic_algorithm.join

