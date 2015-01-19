class Exercise
  PROPERTIES = [:id, :name, :sets, :reps, :load, :rest,
    :status, :current_set, :routine, :pos]
  PROPERTIES.each { |p| attr_accessor p }

  def initialize(hash = {})
    hash.each do |k, v|
      if PROPERTIES.member?(k.to_sym)
        self.send("#{k.to_s}=", v)
      end
    end
    self.status = "not_started"
  end

  def to_s
    self.name
  end

  def start
    puts "[Exercise] start (#{self.status})"
    self.status = "started"
    self.current_set ||= 0
    self.current_set += 1

    if self.current_set > self.sets
      self.next
    else
      self
    end
  end

  def next
    puts "[Exercise] next"
    routine.next(self)
  end

  def finish
    puts "[Exercise] finish (#{self.status})"
    self.status = "not_started"
  end

  def started?
    self.status == 'started'
  end

  def reps_label
    label = "#{sets}x"

    if reps.is_a?(Array)
      label = "#{label}..."
    else
      label = "#{label}#{reps}"
    end

    label = "#{label} #{rest}\""
  end

  def label
    "#{name} (#{reps_label})"
  end
end
