require 'io/console'

class Player
	@@count = 1
	attr_accessor :name, :health, :power
	def initialize(name, health, power)
		@name = name
		@health = health
		@power = power
		@@count += 1
	end

	def self.count
		@@count
	end

	def hasHealth
		@health > 0
	end

	def hit(opponent)
		opponent.health -= self.power
	end

	def to_s
		"#{name}: Health: #{health}, Power: #{power}"
	end
end

class Cpu < Player
end

def start_game
	puts "Welcome to The Fight!"
	puts "press any key to continue..."
	STDIN.getch
	print "          \r"
	welcome_player
end

def welcome_player
	puts "Welcome Player #{Player.count}! Please enter your name:"
	name = gets.chomp
	p1 = Player.new(name, 200, 1+rand(20))
	puts "#{p1}"
	if Player.count >= 3
		puts "Let's fight!"
	else
		add_player(p1)
	end
end

ANSWERS = ["1. Yes!", "2. No!"]

def add_player(p1)
	puts "Hi #{p1.name}, would you like to add a 2nd player?"
	puts ANSWERS
	second = gets.chomp
	if second.to_i == 1 && Player.count < 3
		puts "Welcome Player #{Player.count}! Please enter your name:"
		name = gets.chomp
		p2 = Player.new(name, 200, 1+rand(20))
		puts "#{p1}"
		puts "#{p2}"
		fight_player(p1, p2)
	else
		#puts "Go!"
		cpu_fight(p1)
	end
end

def fight_player(p1, p2)
	while p1.hasHealth && p2.hasHealth
		p1.hit(p2)
		p2.hit(p1)
		player_status(p1, p2)
	end

	if p1.hasHealth
		puts "#{p1.name} has WON!"
	elsif p2.hasHealth
		puts "#{p2.name} has WON!"
	else
		puts "It's a DRAW!"
	end
end

def player_status(*p)
	p.each { |x| puts x}
end

def cpu_fight(p1)
	cpu = Cpu.new("CPU", 200, 1+rand(20))
	while p1.hasHealth && cpu.hasHealth
		p1.hit(cpu)
		cpu.hit(p1)
		player_status(p1, cpu)
	end

	if p1.hasHealth
		puts "#{p1.name} has WON!"
	elsif cpu.hasHealth
		puts "#{cpu.name} has WON!"
	else
		puts "It's a DRAW!"
	end
end

start_game