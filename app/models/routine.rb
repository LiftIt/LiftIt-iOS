class Routine
  PROPERTIES = [:id, :name, :rest, :exercises]
  PROPERTIES.each { |p| attr_accessor p }

  def initialize(hash = {})
    hash.each do |k, v|
      if PROPERTIES.member?(k.to_sym)
        self.send("#{k.to_s}=", v)
      end
    end
  end

  def exercises
    @exercises ||= []
  end

  def exercises=(exercises)
    if exercises.first.is_a?(Hash)
      exercises = exercises.collect { |e| Exercise.new(e) }
    end

    @exercises = exercises
  end

  def self.all(&block)
    BW::HTTP.get("http://localhost:3000/") do |response|
      routines = BW::JSON.parse(response.body.to_str)
      p routines
      block.call(routines)
    end
  end
end
