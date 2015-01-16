class Exercise
  PROPERTIES = [:name, :sets, :reps, :load, :rest]
  PROPERTIES.each { |p| attr_accessor p }

  def initialize(hash = {})
    hash.each do |k, v|
      if PROPERTIES.member?(k.to_sym)
        self.send("#{k.to_s}=", v)
      end
    end
  end
end
