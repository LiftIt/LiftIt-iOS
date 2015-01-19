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
      i = 0
      exercises = exercises.collect do |e|
        ex = Exercise.new(e)
        ex.routine = self
        ex.pos = i
        i += 1
        ex
      end
    end

    @exercises = exercises
  end

  def next(ex)
    puts "[Routine] next for #{ex}"
    pos = exercises.index(ex) + 1
    puts "[Routine] next -- pos = #{pos} ==> #{exercises[pos]}"
    return self.exercises[pos] if pos <= self.exercises.size
  end

  def self.url
    if Device.simulator?
      "http://localhost:3000/"
    else
      "http://liftit-dev.herokuapp.com/"
    end
  end

  def self.all(&block)
    puts "URL: #{url}"
    BW::HTTP.get(url) do |response|
      if response.ok?
        data = BW::JSON.parse(response.body.to_str)
        routines = data["routines"].collect { |r| Routine.new(r) }
        block.call(routines)
      else
        App.alert("Couldn't load your routines")
      end
    end
  end
end
