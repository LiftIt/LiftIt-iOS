class Routine
  PROPERTIES = [:id, :name, :rest, :exercises]
  PROPERTIES.each { |p| attr_accessor p }

  def initialize(hash = {})
    hash.each do |k, v|
      if PROPERTIES.member?(k.to_sym)
        self.send("#{k.to_s}=", v)
      end
    end

    reset
  end

  def reset
    @index = 0
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

  def next
    ret = exercises[@index]
    @index += 1
    ret
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
