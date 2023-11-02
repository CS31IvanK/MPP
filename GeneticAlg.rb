# frozen_string_literal: true
# Визначаємо відстані між містами
distances = [
  [0, 2, 9, 10],
  [1, 0, 6, 4],
  [15, 7, 0, 8],
  [6, 3, 12, 0]
]

# Функція придатності (менше відстань - краще)
def fitness(route, distances)
  total_distance = route.each_cons(2).sum { |a, b| distances[a][b] }
  total_distance += distances[route.last][route.first] # повернення до початкового міста
end

# Мутація (перестановка двох випадкових міст)
def mutate(route)
  a, b = route.sample(2)
  route[a], route[b] = route[b], route[a]
end

# Селекція (вибираємо найкращих)
def selection(routes, distances)
  routes.sort_by! { |route| fitness(route, distances) }
  routes.take(routes.size / 2) # залишаємо половину найкращих
end

# Схрещення (створюємо новий маршрут з двох батьківських)
def crossover(route1, route2)
  start = rand(route1.size) # випадковий початок
  finish = rand(start..route1.size) # випадковий кінець
  child_route = route1[start...finish] # частина першого маршруту
  child_route += route2.reject { |city| child_route.include?(city) } # додаємо решту від другого маршруту
end

# Генетичний алгоритм
def genetic_algorithm(distances)
  population_size = 100
  generations = 500

  # Створюємо початкову популяцію
  population = Array.new(population_size) { (0...distances.size).to_a.shuffle }

  generations.times do
    # Селекція
    population = selection(population, distances)

    # Схрещення та мутація
    while population.size < population_size do
      parent1 = population.sample
      parent2 = population.sample
      child = crossover(parent1, parent2)
      mutate(child)
      population << child
    end
  end

  # Повертаємо найкращий маршрут
  population.min_by { |route| fitness(route, distances) }
end

best_route = genetic_algorithm(distances)
puts "Найкращий маршрут: #{best_route}"

