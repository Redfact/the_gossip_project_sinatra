class Gossip
	attr_accessor :author,:content

	def initialize(_author,_content)
		@author = _author
		@content = _content
	end

	#Retourne un array contenant les Gossip crées
	def self.all
		array = []
		data = CSV.read("data/gossip.csv") 
		data.each{|obj|
			array<< Gossip.new(obj[0],obj[1])
		}
		return array
	end

	def to_s
		return "#{@author},#{@content}"
	end

	def self.delete(index)
		self.all.delete_at(index)
	end

	#Mets à jours la base de donne avec le tableau data
	def self.update(data)
		file = File.open("data/gossip.csv","w+")
		data.each { |e|
			file.puts e.to_s
		}
		file.close
	end

	def self.find(index)
		return self.all.at(index)
	end

	def save
		savefile = File.open("data/gossip.csv", "a")
		savefile.puts self.to_s
		#Il faut fermer sinon les changements dans le fichier ne se
		#feront qu'à la fin du programme
		savefile.close
	end
end 